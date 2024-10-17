class_name json
var json_dic : Dictionary;
var load_path: String


func _init(path: String):
	load_path = path

# TODO : Handle errors
func read_file(file_name) -> bool:
	
	var file_path = load_path + file_name + ".json"
	#print(file_path)
	if (!FileAccess.file_exists(file_path)):
		return false;
	
	# Search for any variations of the json file
	var file_variations:Array[String] = [];
	var file_variation = file_path;
	var extension_loc = file_variation.findn(".json");
	file_variation = file_variation.erase(extension_loc, 5)
	var file_variation_no := 1
	var found_variation := true
	file_variations.append(file_path)
	while found_variation:
		var file_variation_str = file_variation + "_" + str(file_variation_no) + ".json";
		found_variation = false;
		if (FileAccess.file_exists(file_variation_str)):
			found_variation = true
			file_variation_no += 1;
			file_variations.append(file_variation_str)
	
	var num_variations_found = file_variations.size();
	var rand_file_load = randi() % num_variations_found
	file_path = file_variations[rand_file_load]
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return false;
		
	var content_as_text = file.get_as_text()
	var parsed = JSON.parse_string(content_as_text)
	if parsed == null:
		return false;
		
	json_dic = parsed;
	return true;	# SUCCESS!


func set_dictionary(dic):
	json_dic = dic

func getKey(key,val):
	if json_dic.has(key):
		return json_dic[key]
	return val;	

func get_texture2D(key:String)->Texture2D:
	print(key)
	var filename:String = getKey(key, "");	
	if filename == "":
		return;
	var tex:Texture2D = load(filename)
	return tex;
