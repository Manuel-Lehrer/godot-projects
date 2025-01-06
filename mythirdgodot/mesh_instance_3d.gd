extends MeshInstance3D

@export var segments = 12
@export var height = 2
@export var radius = 1
@export var curve_factor = 0.2
@export var vertical_divisions = 6

func _ready():
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, generate_cap(Vector3(0, 0, 0), Vector3(0, -1, 0), radius, false))
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, generate_cap(Vector3(0, height, 0), Vector3(0, 1, 0), radius, true))
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, generate_curved_sides())
	self.mesh = mesh

	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.4, 0.28, 0.2)
	material.metallic = 0.1
	material.roughness = 0.8
	self.material_override = material

func generate_cap(center: Vector3, normal: Vector3, radius: float, is_top: bool) -> Array:
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	var verts = PackedVector3Array()
	var norms = PackedVector3Array()
	var indices = PackedInt32Array()
	var alpha = 2 * PI / segments
	verts.push_back(center)
	norms.push_back(normal)
	for n in range(segments):
		var x = radius * cos(n * alpha)
		var z = radius * sin(n * alpha)
		verts.push_back(center + Vector3(x, 0, z))
		norms.push_back(normal)
		if n > 0:
			if is_top:
				indices.push_back(0)
				indices.push_back(n)
				indices.push_back(n + 1)
			else:
				indices.push_back(0)
				indices.push_back(n + 1)
				indices.push_back(n)

	if is_top:
		indices.push_back(0)
		indices.push_back(segments)
		indices.push_back(1)
	else:
		indices.push_back(0)
		indices.push_back(1)
		indices.push_back(segments)
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_NORMAL] = norms
	surface_array[Mesh.ARRAY_INDEX] = indices
	return surface_array

func generate_curved_sides() -> Array:
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)
	var verts = PackedVector3Array()
	var norms = PackedVector3Array()
	var indices = PackedInt32Array()
	var alpha = 2 * PI / segments
	for i in range(vertical_divisions + 1):
		var y = height * (i / float(vertical_divisions))
		var radius_factor = 1 + curve_factor * sin(PI * (i / float(vertical_divisions)))
		var current_radius = radius * radius_factor
		for n in range(segments):
			var x = current_radius * cos(n * alpha)
			var z = current_radius * sin(n * alpha)
			verts.push_back(Vector3(x, y, z))
	for i in range(vertical_divisions):
		for n in range(segments):
			var idx = i * segments + n
			indices.push_back(idx)
			indices.push_back(idx + 1 if (n + 1) < segments else idx + 1 - segments)
			indices.push_back(idx + segments)

			indices.push_back(idx + segments)
			indices.push_back(idx + 1 if (n + 1) < segments else idx + 1 - segments)
			indices.push_back(idx + segments + 1 if (n + 1) < segments else idx + segments + 1 - segments)
	for i in range(verts.size()):
		var vertex = verts[i]
		var next_ring = vertex * Vector3(1,0,1)
		var normal = (vertex - next_ring).normalized()
		norms.push_back(normal)
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_NORMAL] = norms
	surface_array[Mesh.ARRAY_INDEX] = indices
	return surface_array

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation.y += PI * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= PI * delta
	if Input.is_action_pressed("ui_up"):
		rotation.x += PI * delta
	if Input.is_action_pressed("ui_down"):
		rotation.x -= PI * delta
