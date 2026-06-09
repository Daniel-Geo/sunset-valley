extends Node

var selected_tool: DataTypes.Tools = DataTypes.Tools.None
var tools_enabled: bool = false

signal tool_selected(tool: DataTypes.Tools)
signal enable_tool(tool: DataTypes.Tools)
signal disable_tools
signal tools_state_changed

func _ready() -> void:
	tools_state_changed.connect(on_tools_state_changed)

func select_tool(tool: DataTypes.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool

func enable_tool_buttons() -> void:
	for tool_value in DataTypes.Tools.values():
		enable_tool.emit(tool_value)
	tools_enabled = true

func on_tools_state_changed() -> void:
	if tools_enabled:
		for tool_value in DataTypes.Tools.values():
			enable_tool.emit(tool_value)
	else:
		disable_tools.emit()
