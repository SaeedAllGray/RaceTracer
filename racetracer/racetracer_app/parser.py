import re
import json

class Parser:

    def parse_diff_to_json(self,diff_text):
        changes = []
        diff_lines = diff_text.split("\n")
        
        for line in diff_lines:
            if line.startswith("-") and not line.startswith("---"):
                old_value_line = line[1:].strip()
                attribute, old_value = self.parse_attribute_value(old_value_line)
                changes.append({
                    "attribute": attribute,
                    "old_value": self.convert_value(old_value),
                    "new_value": None
                })
            elif line.startswith("+") and not line.startswith("+++"):
                new_value_line = line[1:].strip()
                attribute, new_value = self.parse_attribute_value(new_value_line)
                existing_change = next((change for change in changes if change["attribute"] == attribute), None)
                if existing_change:
                    existing_change["new_value"] = self.convert_value(new_value)
                else:
                    changes.append({
                        "attribute": attribute,
                        "old_value": None,
                        "new_value": self.convert_value(new_value)
                    })
        
        print(json.dumps({"changes": changes}, indent=4))
        return  changes

    def parse_attribute_value(self,line):
        match = re.match(r"(\w+)\s*:\s*(.+)", line)
        if match:
            return match.groups()
        return line, None

    def convert_value(self,value):
        try:
            return float(value)
        except ValueError:
            try:
                return int(value)
            except ValueError:
                return value.strip('"')

        