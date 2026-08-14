"""
Routine, Routine Group, and Test Suite Manager for py-web-tester.
Handles disk persistence, metadata management, search, and tag filtering
for routines (routines/*.json), groups (groups/*.json), and suites (suites/*.json).
"""

import json
import os
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional

def format_datetime_de(val: Any) -> str:
    """Formats an ISO timestamp or datetime into '14.08.2026, 19:08 Uhr' German format."""
    if not val:
        return "-"
    try:
        if isinstance(val, (int, float)):
            dt = datetime.fromtimestamp(val)
        else:
            dt = datetime.fromisoformat(str(val))
        return dt.strftime("%d.%m.%Y, %H:%M Uhr")
    except Exception:
        return str(val)[:16]

class RoutineManager:
    def __init__(
        self,
        routines_dir: str = "routines",
        groups_dir: str = "groups",
        suites_dir: str = "suites"
    ):
        self.routines_dir = Path(routines_dir).resolve()
        self.groups_dir = Path(groups_dir).resolve()
        self.suites_dir = Path(suites_dir).resolve()

        self.routines_dir.mkdir(parents=True, exist_ok=True)
        self.groups_dir.mkdir(parents=True, exist_ok=True)
        self.suites_dir.mkdir(parents=True, exist_ok=True)

    # -------------------------------------------------------------------------
    # ROUTINE OPERATIONS
    # -------------------------------------------------------------------------

    def list_routines(self) -> List[Dict[str, Any]]:
        """Scans routines/ directory and returns metadata for all JSON routine files."""
        routines = []
        for file in self.routines_dir.glob("*.json"):
            try:
                data = self.get_routine(file.name)
                if data:
                    routines.append(data)
            except Exception as e:
                print(f"[WARN] Failed to load routine file {file}: {e}")

        # Sort by creation date (newest first)
        routines.sort(key=lambda r: r.get("recorded_at", ""), reverse=True)
        return routines

    def get_routine(self, filename_or_name: str) -> Optional[Dict[str, Any]]:
        """Loads routine json file by filename or routine name."""
        file_path = self._resolve_path(self.routines_dir, filename_or_name)
        if not file_path or not file_path.exists():
            return None

        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        # Standardize metadata fields
        data["filename"] = file_path.name
        if "routine_name" not in data:
            data["routine_name"] = file_path.stem
        if "description" not in data:
            data["description"] = ""
        if "tags" not in data or not isinstance(data["tags"], list):
            data["tags"] = []
        if "recorded_at" not in data:
            data["recorded_at"] = datetime.fromtimestamp(file_path.stat().st_mtime).isoformat()

        # Format creation date cleanly for UI display (e.g., "14.08.2026, 19:08 Uhr")
        data["formatted_date"] = format_datetime_de(data["recorded_at"])

        if "last_execution" in data and isinstance(data["last_execution"], dict):
            data["last_execution"]["formatted_date"] = format_datetime_de(data["last_execution"].get("timestamp"))

        return data

    def save_routine(
        self,
        routine_name: str,
        actions: List[Dict[str, Any]],
        start_url: str = "${BASE_URL}",
        description: str = "",
        tags: Optional[List[str]] = None,
        duration_ms: int = 0
    ) -> Path:
        """Saves a routine JSON file with complete metadata."""
        clean_name = routine_name.strip()
        tags_list = [t.strip() for t in (tags or []) if t.strip()]

        file_path = self.routines_dir / f"{clean_name}.json"
        
        routine_data = {
            "routine_name": clean_name,
            "recorded_at": datetime.now().isoformat(),
            "start_url": start_url or "https://dr.data-al.cloud",
            "description": description or "",
            "tags": tags_list,
            "duration_ms": duration_ms,
            "total_actions": len(actions),
            "actions": actions
        }

        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(routine_data, f, indent=2, ensure_ascii=False)

        return file_path

    def update_routine_metadata(
        self,
        routine_name: str,
        description: str,
        tags: List[str]
    ) -> bool:
        """Updates description and tags of an existing routine JSON."""
        data = self.get_routine(routine_name)
        if not data:
            return False

        data["description"] = description
        data["tags"] = [t.strip() for t in tags if t.strip()]
        
        filename = data["filename"]
        file_path = self.routines_dir / filename
        
        # Remove helper keys before saving
        save_data = dict(data)
        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(save_data, f, indent=2, ensure_ascii=False)

        return True

    def update_routine_execution_stats(
        self,
        routine_name: str,
        auto_duration_ms: int,
        status: str = "PASS"
    ) -> Optional[Dict[str, Any]]:
        """Updates last execution time stats and benchmark comparisons for a routine."""
        data = self.get_routine(routine_name)
        if not data:
            return None

        recorded_ms = data.get("duration_ms", 0)
        speedup = round(recorded_ms / auto_duration_ms, 2) if (auto_duration_ms > 0 and recorded_ms > 0) else 1.0
        savings_pct = round((1.0 - (auto_duration_ms / recorded_ms)) * 100, 1) if (recorded_ms > 0 and auto_duration_ms > 0) else 0.0

        last_exec = {
            "timestamp": datetime.now().isoformat(),
            "auto_duration_ms": auto_duration_ms,
            "recorded_duration_ms": recorded_ms,
            "speedup_factor": speedup,
            "savings_pct": savings_pct,
            "status": status
        }

        data["last_execution"] = last_exec
        
        filename = data.get("filename")
        if filename:
            file_path = self.routines_dir / filename
            save_data = dict(data)
            save_data.pop("filename", None)
            save_data.pop("formatted_date", None)

            with open(file_path, "w", encoding="utf-8") as f:
                json.dump(save_data, f, indent=2, ensure_ascii=False)

        return last_exec


    def delete_routine(self, filename_or_name: str) -> bool:
        """Deletes a routine JSON file."""
        file_path = self._resolve_path(self.routines_dir, filename_or_name)
        if file_path and file_path.exists():
            file_path.unlink()
            return True
        return False

    def get_all_tags(self) -> List[str]:
        """Returns a list of all unique tags used across all routines."""
        tags = set()
        for routine in self.list_routines():
            for tag in routine.get("tags", []):
                if tag:
                    tags.add(tag.lower())
        return sorted(list(tags))

    def filter_routines(
        self,
        search_text: str = "",
        tag_filter: str = ""
    ) -> List[Dict[str, Any]]:
        """Filters routines by search query string and/or tag filter."""
        all_routines = self.list_routines()
        filtered = []

        query = search_text.strip().lower()
        target_tag = tag_filter.strip().lower()

        for r in all_routines:
            name = r.get("routine_name", "").lower()
            url = r.get("start_url", "").lower()
            desc = r.get("description", "").lower()
            rtags = [t.lower() for t in r.get("tags", [])]

            matches_search = not query or (
                query in name or query in url or query in desc or any(query in t for t in rtags)
            )
            matches_tag = not target_tag or (target_tag == "all") or (target_tag in rtags)

            if matches_search and matches_tag:
                filtered.append(r)

        return filtered

    # -------------------------------------------------------------------------
    # ROUTINE GROUP OPERATIONS
    # -------------------------------------------------------------------------

    def list_groups(self) -> List[Dict[str, Any]]:
        """Scans groups/ directory and returns metadata for all routine groups."""
        groups = []
        for file in self.groups_dir.glob("*.json"):
            try:
                data = self.get_group(file.name)
                if data:
                    groups.append(data)
            except Exception as e:
                print(f"[WARN] Failed to load group file {file}: {e}")

        groups.sort(key=lambda g: g.get("created_at", ""), reverse=True)
        return groups

    def get_group(self, filename_or_name: str) -> Optional[Dict[str, Any]]:
        """Loads a routine group json file."""
        file_path = self._resolve_path(self.groups_dir, filename_or_name)
        if not file_path or not file_path.exists():
            return None

        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        data["filename"] = file_path.name
        if "group_name" not in data:
            data["group_name"] = file_path.stem
        if "description" not in data:
            data["description"] = ""
        if "routine_names" not in data:
            data["routine_names"] = []

        return data

    def save_group(
        self,
        group_name: str,
        routine_names: List[str],
        description: str = ""
    ) -> Path:
        """Saves a Routine Group JSON file."""
        clean_name = group_name.strip()
        file_path = self.groups_dir / f"{clean_name}.json"

        group_data = {
            "group_name": clean_name,
            "created_at": datetime.now().isoformat(),
            "description": description or "",
            "routine_count": len(routine_names),
            "routine_names": routine_names
        }

        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(group_data, f, indent=2, ensure_ascii=False)

        return file_path

    def delete_group(self, filename_or_name: str) -> bool:
        """Deletes a routine group JSON file."""
        file_path = self._resolve_path(self.groups_dir, filename_or_name)
        if file_path and file_path.exists():
            file_path.unlink()
            return True
        return False

    # -------------------------------------------------------------------------
    # MASTER TEST SUITE OPERATIONS
    # -------------------------------------------------------------------------

    def list_suites(self) -> List[Dict[str, Any]]:
        """Scans suites/ directory and returns metadata for all master test suites."""
        suites = []
        for file in self.suites_dir.glob("*.json"):
            try:
                data = self.get_suite(file.name)
                if data:
                    suites.append(data)
            except Exception as e:
                print(f"[WARN] Failed to load suite file {file}: {e}")

        suites.sort(key=lambda s: s.get("created_at", ""), reverse=True)
        return suites

    def get_suite(self, filename_or_name: str) -> Optional[Dict[str, Any]]:
        """Loads a master test suite json file."""
        file_path = self._resolve_path(self.suites_dir, filename_or_name)
        if not file_path or not file_path.exists():
            return None

        with open(file_path, "r", encoding="utf-8") as f:
            data = json.load(f)

        data["filename"] = file_path.name
        if "suite_name" not in data:
            data["suite_name"] = file_path.stem
        if "description" not in data:
            data["description"] = ""
        if "items" not in data:
            data["items"] = []

        return data

    def save_suite(
        self,
        suite_name: str,
        items: List[Dict[str, str]],  # List of {"type": "routine"|"group", "name": "..."}
        description: str = ""
    ) -> Path:
        """Saves a Master Test Suite JSON file."""
        clean_name = suite_name.strip()
        file_path = self.suites_dir / f"{clean_name}.json"

        suite_data = {
            "suite_name": clean_name,
            "created_at": datetime.now().isoformat(),
            "description": description or "",
            "total_items": len(items),
            "items": items
        }

        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(suite_data, f, indent=2, ensure_ascii=False)

        return file_path

    def delete_suite(self, filename_or_name: str) -> bool:
        """Deletes a master test suite JSON file."""
        file_path = self._resolve_path(self.suites_dir, filename_or_name)
        if file_path and file_path.exists():
            file_path.unlink()
            return True
        return False

    # -------------------------------------------------------------------------
    # INTERNAL HELPERS
    # -------------------------------------------------------------------------

    def _resolve_path(self, directory: Path, filename_or_name: str) -> Optional[Path]:
        if not filename_or_name:
            return None
        
        path = directory / filename_or_name
        if path.exists():
            return path
        
        path_json = directory / f"{filename_or_name}.json"
        if path_json.exists():
            return path_json

        return None
