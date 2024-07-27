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
            

    def extract_changes(self,diff_text, target_file):
       
        changes = {}
        current_file = None
        in_target_file = False
        
        lines = diff_text.split('\n')
        
        for line in lines:
            if line.startswith('diff --git'):
                in_target_file = False
                current_file = line.split(' ')[2][2:]
                if current_file == target_file:
                    in_target_file = True
                continue
            
            if in_target_file:
                if line.startswith('-') and not line.startswith('---'):
                    key, value = line[1:].strip().split(': ', 1)
                    changes[key] = (value, None)
                elif line.startswith('+') and not line.startswith('+++'):
                    key, value = line[1:].strip().split(': ', 1)
                    if key in changes:
                        changes[key] = (changes[key][0], value)
                    else:
                        changes[key] = (None, value)

        formatted_changes = []
        for key, (old_value, new_value) in changes.items():
            if old_value is None:
                old_value = 'N/A'
            if new_value is None:
                new_value = 'N/A'
            formatted_changes.append(f"{key}: {old_value} -> {new_value}")
        
      

        return ', '.join(formatted_changes)


    def generate_commit_message(self,m):    
        return self.parse_diff_to_json(m)
    

