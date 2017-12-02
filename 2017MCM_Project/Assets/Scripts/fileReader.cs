using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class fileReader : MonoBehaviour {
	struct tagFeature{
		public int top_level;
		public int sec_level;
		public float times;
	}

    public GameObject cubeObject;

    public List<Color> colorList = new List<Color> ();
	List<string> authorList = new List<string> ();
	List<List<tagFeature>> tagList = new List<List<tagFeature>>();
	List<GameObject> authorObjList = new List<GameObject>();
	List<List<GameObject>> objectList = new List<List<GameObject>>();
    public float scale = 0;
    public int tagNum = 0;
	// Use this for initialization
	void Awake(){
		
	}
	void Start () {
        initAxis();
        authorAttribueView();
    }
	
	// Update is called once per frame
	void Update () {
	}
	void getFiles() {
		DirectoryInfo tag_Dir = new DirectoryInfo("C:\\Users\\mySab\\Documents\\!!!SabreHawk_PublicFolder\\2017MCM\\workspace\\1\\");
		FileInfo[] txt_files_info = tag_Dir.GetFiles("*.txt");
		string temp_line;
		string temp_name;
		StreamReader temp_strReader;
		StreamReader temp_headReader;
		//Read Txt Files One by One
		foreach (FileInfo temp in txt_files_info) {
			temp_headReader = temp.OpenText();
			//Find Author
			int temp_index = -1;
			while ((temp_line = temp_headReader.ReadLine()) != null) {
				//Debug.Log (temp_line);
				if (temp_line.Contains("From: ")) {
					string temp_author = temp_line;
					temp_index = authorList.IndexOf(temp_author.Substring(6));
					if (temp_index == -1) {
						authorList.Add(temp_author.Substring(6));
					}
					break;
				}
			}
			//Find Tag	
			temp_name = temp.Name;
			temp_name = temp_name.Replace(".txt", ".cats");
			//Read Txt File
			temp_strReader = new StreamReader(tag_Dir.ToString()+"\\"+temp_name);
			while ((temp_line = temp_strReader.ReadLine()) != null) {
				string[] sArray = temp_line.Split(',');
				if (sArray.Length > 3) {
					 Debug.LogError("larger than 3");
				}   
				if (temp_index == -1) {//Add New Array List
					tagFeature temp_tagFeature = new tagFeature();
					temp_tagFeature.top_level = int.Parse(sArray[0]);
					temp_tagFeature.sec_level = int.Parse(sArray[1]);
					temp_tagFeature.times = 1;
					List<tagFeature> temp_arrayList = new List<tagFeature>();
					temp_arrayList.Add(temp_tagFeature);
					tagList.Add(temp_arrayList);
				} else {//Add To Old Array List
					tagFeature temp_tagFeature = new tagFeature();
					temp_tagFeature.top_level = int.Parse(sArray[0]);
					temp_tagFeature.sec_level = int.Parse(sArray[1]);
					temp_tagFeature.times = 1;
				//	Debug.Log (temp_index);
				//	Debug.Log (tagList.Count);
					List<tagFeature> temp_Al = tagList[temp_index];

					//Detect If Exist The Same Tag
					int isFound = 0;
					for (int i = 0; i < tagList[temp_index].Count; ++i) {
						if (temp_Al[i].top_level == temp_tagFeature.top_level && temp_Al[i].sec_level == temp_tagFeature.sec_level) {
							tagFeature temp_mod_tag = temp_Al[i];
							temp_mod_tag.times += 1;
							tagList[temp_index][i] = temp_mod_tag;
							isFound = 1;
							break;
						}
					}
					if(isFound == 0) {
						tagList[temp_index].Add(temp_tagFeature);
					}
				}
			}
		}

	}
	void initCubes(){
		Color temp_color = new Color ();
		for (int i = 0; i < authorList.Count; ++i) {
			temp_color = new Color (Random.Range (0f, 1f), Random.Range (0f, 1f), Random.Range (0f, 1f));
			colorList.Add (temp_color);
		}
		for (int i = 0; i < authorList.Count; ++i) {
			List<GameObject> temp_list = new List<GameObject> ();
			GameObject father_obj = GameObject.CreatePrimitive (PrimitiveType.Cube);
			father_obj.GetComponent<MeshRenderer> ().enabled = false;

			for (int j = 0; j < tagList [i].Count; ++j) {
				Vector3 temp_vec3 = new Vector3 (tagList [i] [j].top_level, tagList [i] [j].sec_level, i);
				GameObject obj = GameObject.Instantiate (cubeObject, temp_vec3, Quaternion.identity) as GameObject;
				obj.GetComponent<Renderer> ().material.color = colorList [i];
				Vector3 temp_scale = new Vector3 (1f, 1f, 1f);
				if (true) {
					temp_scale.x = Mathf.Log (temp_scale.x * tagList [i] [j].times * scale);
					temp_scale.y = Mathf.Log (temp_scale.y * tagList [i] [j].times * scale);
					temp_scale.z = Mathf.Log (temp_scale.z * tagList [i] [j].times * scale);
				} else {
					temp_scale.x = Mathf.Log (temp_scale.x *  scale);
					temp_scale.y = Mathf.Log (temp_scale.y *  scale);
					temp_scale.z = Mathf.Log (temp_scale.z *  scale);
				}

				obj.transform.localScale = temp_scale;
				obj.transform.SetParent (father_obj.transform);
				authorObjList.Add (father_obj);
				temp_list.Add (obj);
			}
			objectList.Add (temp_list);
		}
	}
    void authorAttribueView() {
        getFiles();
        initCubes();
    }
	void initAxis(){
		Vector3 vec3 = new Vector3 (0.1f, 0.1f, 0.1f);
		GameObject xAxis = GameObject.CreatePrimitive (PrimitiveType.Cube);
		xAxis.GetComponent<MeshRenderer> ().material.color = Color.black;
		vec3.x = 1000;
		xAxis.transform.localScale = vec3;
		GameObject yAxis = GameObject.CreatePrimitive (PrimitiveType.Cube);
		yAxis.GetComponent<MeshRenderer> ().material.color = Color.black;
		vec3 = new Vector3 (0.1f, 1000, 0.1f);
		yAxis.transform.localScale = vec3;
		GameObject zAxis = GameObject.CreatePrimitive (PrimitiveType.Cube);
		zAxis.GetComponent<MeshRenderer> ().material.color = Color.black;
		vec3 = new Vector3 (0.1f, 0.1f, 1000);
		zAxis.transform.localScale = vec3;
	}
    void classifiyEmail() {

    }
}
