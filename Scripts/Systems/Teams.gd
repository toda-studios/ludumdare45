extends Node

# List containing all team objects
var teams = []

# Used to verify IDs
func string_to_id(value):
    return value


# Add a new team to the list
func add_team(name, color = null):

    # Create/Validate parameters
    if color == null:
        color = Color(randf(),randf(),randf())
    var id = string_to_id(name)

    # Team Object Template
    var team = {
        'id' : id,
        'name' : name,
        'color' : color
    }
    teams.append(team)
    return id

# Move teams to an empty list
func clear_teams():
    teams = []

# Very basic loop through list for an id
func get_team_by_id(id):
    for i in range(len(teams)):
        if(teams[i]['id'] == id):
            return teams[i]
    return 'null'