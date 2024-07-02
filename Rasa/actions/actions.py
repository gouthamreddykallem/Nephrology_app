# actions/actions.py
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import json

class ActionSearchDatabase(Action):
    def name(self):
        return "action_search_database"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain):
        keyword = None

        # Extract keyword from regex entities
        for entity in tracker.latest_message['entities']:
            if entity['entity'] in ['information_type', 'service_name']:
                keyword = entity['value']
                break
        
        if keyword:
            # Load the database (JSON file)
            file_path = "data/organization_info.json"
            with open(file_path, 'r') as json_file:
                database = json.load(json_file)

            # Initialize the response
            response = self.search_database(database, keyword)

            # Respond with the result
            dispatcher.utter_message(text=response)
        else:
            dispatcher.utter_message(text="I couldn't find any keyword to search for.")

        return []

    def search_database(self, database, keyword):
        for category, content in database.items():
            if isinstance(content, dict):
                for subcategory, subcontent in content.items():
                    if keyword.lower() in subcategory.lower():
                        return self.format_response(subcontent)
                    if isinstance(subcontent, list):
                        for item in subcontent:
                            if keyword.lower() in item.lower():
                                return self.format_response(", ".join(subcontent))
                    elif isinstance(subcontent, dict):
                        for key, value in subcontent.items():
                            if keyword.lower() in key.lower() or keyword.lower() in str(value).lower():
                                return self.format_response(value)
            elif isinstance(content, list):
                if keyword.lower() in category.lower():
                    return self.format_response(", ".join(content))
            elif keyword.lower() in category.lower():
                return self.format_response(content)
        return "Sorry, I don't have information on that."

    
    def format_response(self, content):
        if isinstance(content, dict):
            formatted_text = ""
            for key, value in content.items():
                if key.lower() == "description":
                    formatted_text += f"{value}\n\n"
                elif isinstance(value, list):
                    formatted_text += f"{key.replace('_', ' ').title()}:\n" + "\n".join(f"- {item}" for item in value) + "\n\n"
                else:
                    formatted_text += f"{key.replace('_', ' ').title()}:\n{value}\n\n"
            return formatted_text.strip()
        elif isinstance(content, list):
            return "\n".join(f"- {item}" for item in content)
        else:
            return content
