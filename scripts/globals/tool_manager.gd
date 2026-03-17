extends Node

var selected_tool: DataTypes.Tools = DataTypes.Tools.None

signal tool_selected(tool: DataTypes.Tools)
signal enable_tool(tool: DataTypes.Tools)

func select_tool(tool: DataTypes.Tools) -> void:
	tool_selected.emit(tool)
	selected_tool = tool

func enable_tool_button(tool: DataTypes.Tools) -> void:
	enable_tool.emit(tool)
