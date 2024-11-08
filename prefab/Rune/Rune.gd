extends Area2D
class_name Rune

@export var points_parent:Node2D
@onready var line:Line2D = $Line2D
@onready var prevent_new_point_timer = $PreventNewPointTimer

var rune_points:Dictionary
var rune_points_in_line:Array[RunePoint]

func _ready():
	# Fetch and cast rune points from scene
	var points:Array[Node] = points_parent.get_children()
	for point in points:
		if not point is RunePoint:
			continue
		rune_points[point.id] = point
	
	# Hook up signals
	for rune_point in rune_points:
		rune_points[rune_point].mouse_over.connect(rune_point_mouse_over)
		rune_points[rune_point].left_mouse_button_clicked.connect(rune_point_clicked)

func rune_point_mouse_over(rune_point:RunePoint):
	if line_has_points():
		add_point(rune_point)

func rune_point_clicked(rune_point:RunePoint):
	if not line_has_points() and prevent_new_point_timer.is_stopped():
		add_first_point(rune_point)


func _process(_delta):
	if line_has_points():
		line.points[-1] = self.get_local_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if line_has_points():
			if event.button_index == MOUSE_BUTTON_LEFT and len(rune_points_in_line) > 1:
				prevent_new_point_timer.start()
				var spell = SpellManager.get_spell(normalize_points_sequence(rune_points_in_line))
				print(spell)
				reset_line()
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				prevent_new_point_timer.start()
				reset_line()

# Helpers
func line_has_points() -> bool:
	return line.get_point_count() > 0

func add_first_point(rune_point:RunePoint):
	line.add_point(rune_point.position)
	line.add_point(self.get_local_mouse_position())
	rune_points_in_line.append(rune_point)
	rune_point.emit_particles()

func add_point(rune_point:RunePoint):
	if not rune_points_in_line.has(rune_point):
		line.add_point(self.get_local_mouse_position())
		line.points[-2] = rune_point.position
		rune_points_in_line.append(rune_point)
		rune_point.emit_particles()

func reset_line():
	rune_points_in_line.clear()
	while line.get_point_count() > 0:
		line.remove_point(0)

func normalize_points_sequence(points:Array[RunePoint]) -> Array[int]:
	var points_ids:Array[int] = []
	for point in points:
		points_ids.append(point.id)
	
	if points_ids[0] > points_ids[-1]:
		points_ids.reverse()
	return points_ids
