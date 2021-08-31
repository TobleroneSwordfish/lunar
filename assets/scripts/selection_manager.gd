extends Node
#export var selectables = []
#var selected = []
export (Material) var highlight_material
var deselect_attempt : = false
# array of nodes and their z-index values
var select_requests = []

func _unhandled_input(event):
	# if we click anywhere, attempt to deselect all
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		deselect_attempt = true

func clear_selection():
	# note that call_group by default activates on the next frame, we need it in call order here
	get_tree().call_group_flags(SceneTree.GROUP_CALL_REALTIME, "selected", "set_selected", false)

# each node clicked must lodge a request to be selected
func request_select(node):
	# if we're holding shift, then don't clear the selection at the end of the frame
	if Input.is_action_pressed("multi_select"):
		deselect_attempt = false
	select_requests.append([node.z_index, node])

func _process(delta):
	# same single node being selected again
	if len(select_requests) == 1 and get_tree().get_nodes_in_group("selected") == [select_requests[0][1]]:
#		print("reselecting " + str(select_requests))
		select_requests = []
		deselect_attempt = false
		return
	if deselect_attempt:
		clear_selection()
		deselect_attempt = false
	# toggle selection on node with lowest z-value (ie node that was selected first)	
	if len(select_requests) > 0:
		select_requests.sort_custom(ZSorter, "sort_by_z_index")
		# get the pair with the lowest z value, then get the node from that
		var chosen = select_requests[0][1]
		chosen.selected = !chosen.selected
		select_requests = []
	
class ZSorter:
	static func sort_by_z_index(a, b):
		return a[0] < b[0]
