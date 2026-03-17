extends Node

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato

func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	
	tool_tilling.disabled = true
	tool_tilling.focus_mode = Control.FOCUS_NONE
	
	tool_watering.disabled = true
	tool_watering.focus_mode = Control.FOCUS_NONE
	
	tool_corn.disabled = true
	tool_corn.focus_mode = Control.FOCUS_NONE
	
	tool_tomato.disabled = true
	tool_tomato.focus_mode = Control.FOCUS_NONE


func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)
	tool_axe.grab_focus()

func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGround)
	tool_tilling.grab_focus()

func _on_tool_watering_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)
	tool_watering.grab_focus()

func _on_tool_corn_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantCorn)
	tool_corn.grab_focus()

func _on_tool_tomato_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantTomato)
	tool_tomato.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
		tool_tilling.release_focus()
		tool_watering.release_focus()
		tool_corn.release_focus()
		tool_tomato.release_focus()

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
