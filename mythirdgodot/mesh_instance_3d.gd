extends MeshInstance3D

@export var segments = 6
@export var height = 2
@export var radius = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh = ArrayMesh.new()
	var surface_array_cap = []
	surface_array_cap.resize(Mesh.ARRAY_MAX)
	var verts_cap = PackedVector3Array()
	var norms_cap = PackedVector3Array()
	var index_cap = PackedInt32Array()
	
	var alpha = PI * 2 / segments
	
	verts_cap.push_back(Vector3(radius,0,0))
	norms_cap.push_back(Vector3(0,-1,0))
	#bottom plate
	for i in range(1,segments):
		var x = radius * cos(i * alpha)
		var z = radius * sin(i * alpha)
		verts_cap.push_back(Vector3(x,0,z))
		norms_cap.push_back(Vector3(0,-1,0))
		index_cap.push_back(i-1)
		index_cap.push_back(segments)
		index_cap.push_back(i)
		
		
	verts_cap.push_back(Vector3(0,0,0))
	norms_cap.push_back(Vector3(0,-1,0))
	
	
	index_cap.push_back(segments-1)
	index_cap.push_back(segments)
	index_cap.push_back(0)
	
	#upper plate
	verts_cap.push_back(Vector3(radius,height,0))
	norms_cap.push_back(Vector3(0,1,0))
	for i in range(1, segments)	:
		var x = radius * cos(i * alpha)
		var z = radius * sin(i * alpha)
		verts_cap.push_back(Vector3(x,height,z))
		norms_cap.push_back(Vector3(0,1,0))
		index_cap.push_back(segments+i)
		index_cap.push_back(segments+i+1)
		index_cap.push_back(2*segments+1)
		
		
	verts_cap.push_back(Vector3(0,height,0))
	norms_cap.push_back(Vector3(0,1,0))
	
	index_cap.push_back(2*segments)
	index_cap.push_back(13)
	index_cap.push_back(2*segments+1)
	
	
	for i in range(1,segments):
		index_cap.push_back(i-1)
		index_cap.push_back(i)
		index_cap.push_back(i+segments)
		
	index_cap.push_back(segments-1)
	index_cap.push_back(0)
	index_cap.push_back(segments*2)
		
	for i in range(1,segments):
		index_cap.push_back(i)
		index_cap.push_back(segments+i+1)
		index_cap.push_back(segments+i)
		
	index_cap.push_back(2*segments)
	index_cap.push_back(0)
	index_cap.push_back(segments+1)
		
	
	surface_array_cap[Mesh.ARRAY_VERTEX] = verts_cap
	surface_array_cap[Mesh.ARRAY_INDEX] = index_cap
	surface_array_cap[Mesh.ARRAY_NORMAL] = norms_cap
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array_cap)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		rotation.y -= PI * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y += PI * delta
	if Input.is_action_pressed("ui_up"):
		rotation.x -= PI * delta
	if Input.is_action_pressed("ui_down"):
		rotation.x += PI * delta
		
