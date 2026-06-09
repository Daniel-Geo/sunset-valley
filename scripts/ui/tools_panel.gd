extends Node

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato
@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer

func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)

	for button: Button in h_box_container.get_children():
		button.disabled = true
		button.focus_mode = Control.FOCUS_NONE

func on_enable_tool_button(tool: DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.TillGround:
		tool_tilling.disabled = false
		tool_tilling.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.WaterCrops:
		tool_watering.disabled = false
		tool_watering.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.PlantCorn:
		tool_corn.disabled = false
		tool_corn.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.PlantTomato:
		tool_tomato.disabled = false
		tool_tomato.focus_mode = Control.FOCUS_ALL


func _on_tool_axe_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.AxeWood)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)

func _on_tool_tilling_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.TillGround)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)


func _on_tool_watering_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.WaterCrops)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)


func _on_tool_corn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.PlantCorn)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)


func _on_tool_tomato_toggled(toggled_on: bool) -> void:
	if toggled_on:
		ToolManager.select_tool(DataTypes.Tools.PlantTomato)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)
