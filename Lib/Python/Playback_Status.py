import re
from datetime import datetime

def parse_time(line):
    line = line.strip()  # Remove leading/trailing whitespace
    match = re.match(r"^\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d+", line)
    if match:
        try:
            return datetime.strptime(match.group(0), "%m-%d %H:%M:%S.%f")
        except ValueError as e:
            print(f"[DEBUG] Timestamp parse error: {e} in line: {line}")
    else:
        print(f"[DEBUG] No timestamp match in: {line}")
    return None


def detect_player_actions(log_lines):
    states = []
    last_fragment = None
    last_state = None
    match_count = 0

    for line in log_lines:
        ts = parse_time(line)
        if not ts:
            continue

        if "onInformation" in line:
            match_count += 1
            print(f"[DEBUG] Found onInformation line: {line.strip()}")

            i1_match = re.search(r"i1=(\d+)", line)
            i1_value = i1_match.group(1) if i1_match else None

            if "onInformation:1000" in line:
                if i1_value == "1013":
                    if last_state != "PLAYING":
                        print(f"[DEBUG] Detected PLAYING at {ts} (i1={i1_value})")
                        states.append((ts, "PLAYING"))
                        last_state = "PLAYING"
                elif i1_value == "1001":
                    if last_state != "PAUSED":
                        print(f"[DEBUG] Detected PAUSED at {ts} (i1={i1_value})")
                        states.append((ts, "PAUSED"))
                        last_state = "PAUSED"
                else:
                    print(f"[DEBUG] onInformation:1000 with unhandled i1={i1_value}")

            elif "onInformation:1500" in line or "onInformation:1600" in line:
                if last_fragment is None or (ts - last_fragment).total_seconds() > 2:
                    print(f"[DEBUG] Detected SEEK at {ts}")
                    states.append((ts, "SEEK"))
                    last_state = "SEEK"
                last_fragment = ts

    print(f"[DEBUG] Total matching 'onInformation' lines: {match_count}")
    return states

def main():
    log_path = "C:/D_Drive/Etisalatautomation/Lib/Python/adb_log.txt"
    try:
        with open(log_path, "r", encoding="utf-8", errors="ignore") as f:
            logs = f.readlines()
    except FileNotFoundError:
        print(f"[ERROR] File not found: {log_path}")
        return

    print(f"[DEBUG] Total lines read: {len(logs)}")
    actions = detect_player_actions(logs)

    print("\n=== Inferred Player Actions ===")
    if not actions:
        print("No actions detected — check timestamp format or log content")
    else:
        for ts, action in actions:
            print(f"[{ts}] → {action}")

if __name__ == "__main__":
    main()
