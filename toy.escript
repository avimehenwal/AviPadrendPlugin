//building nodes
var rootNode = new MinSG.ListNode();
var listNode = new MinSG.ListNode();

var mesh1 = Rendering.MeshBuilder.createBox(new Geometry.Box(-2, 0, 0, 1, 1, 1));
var mesh2 = Rendering.MeshBuilder.createBox(new Geometry.Box(2, 0, 0, 1, 1, 1));
var mesh3 = Rendering.MeshBuilder.createBox(new Geometry.Box(0, 0, -2, 1, 1, 1));

var geometryNode1 = new MinSG.GeometryNode(mesh1);
var geometryNode2 = new MinSG.GeometryNode(mesh2);
var geometryNode3 = new MinSG.GeometryNode(mesh3);
//
//Building the scene graph
rootNode.addChild(geometryNode1);
rootNode.addChild(listNode);

listNode += geometryNode2;
listNode += geometryNode3;

//giving nodes a unique id
PADrend.getSceneManager().registerNode("root", rootNode);
PADrend.getSceneManager().registerNode("some_list_node", listNode);

PADrend.getSceneManager().registerNode("geometry_node_1", geometryNode1);
PADrend.getSceneManager().registerNode("geometry_node_2", geometryNode2);
PADrend.getSceneManager().registerNode("geometry_node_3", geometryNode3);

//Register the root node of the scene graph
PADrend.registerScene(rootNode);
//Selecting the root node to be the active scene
PADrend.selectScene(rootNode);
