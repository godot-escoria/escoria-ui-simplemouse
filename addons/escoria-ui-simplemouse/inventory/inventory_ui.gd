extends ESCInventory


# Whether the inventory is visible currently
var inventory_visible: bool = false


func _ready() -> void:
	# Hide inventory by default
	$FloatingInventory/panel.position.x = \
		ProjectSettings.get_setting("display/window/size/viewport_width")

func _on_inventory_button_pressed():
	if $FloatingInventory/InventoryTween.is_active():
		return
	if inventory_visible:
		hide_inventory()
	else:
		show_inventory()


func show_inventory():
	$FloatingInventory/InventoryTween.stop_all()
	$FloatingInventory/InventoryTween.remove_all()
	$FloatingInventory/InventoryTween.interpolate_property(
		$FloatingInventory/panel,
		"position:x",
		$FloatingInventory/panel.position.x,
		$FloatingInventory/panel.position.x - \
				$FloatingInventory/panel.size.x - \
				$HBoxContainer/inventory_button.size.x,
		0.6
	)
	$FloatingInventory/InventoryTween.start()
	await $FloatingInventory/InventoryTween.tween_all_completed
	$FloatingInventory/InventoryTween.stop_all()
	inventory_visible = true


func hide_inventory():
	$FloatingInventory/InventoryTween.stop_all()
	$FloatingInventory/InventoryTween.remove_all()
	$FloatingInventory/InventoryTween.interpolate_property(
		$FloatingInventory/panel,
		"position:x",
		$FloatingInventory/panel.position.x,
		$FloatingInventory/panel.position.x + \
				$FloatingInventory/panel.size.x + \
				$HBoxContainer/inventory_button.size.x,
		0.6
	)
	$FloatingInventory/InventoryTween.start()
	await $FloatingInventory/InventoryTween.tween_all_completed
	$FloatingInventory/InventoryTween.stop_all()
	inventory_visible = false
