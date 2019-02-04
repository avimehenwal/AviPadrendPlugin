// output as console logs
outln("from aviPlugin.escript file! yayyy");

var color = new Util.Color4f(1, 0, 0, 1);
//building nodes
var rootNode = new MinSG.ListNode();
var listNode = new MinSG.ListNode();

var mesh1 = Rendering.MeshBuilder.createBox(new Geometry.Box(2, 0.05, 0, 4, 1.8, 2));
var numSegments = 10;
var mesh2 = Rendering.MeshBuilder.createSphere(numSegments, numSegments);
Rendering.eliminateTrianglesBehindPlane(mesh2, new Geometry.Vec3(0.0, 0.0, 0.0), new Geometry.Vec3(0.0, 0.0, 0.0));
var mesh3 = Rendering.MeshBuilder.createBox(new Geometry.Box(5, 0.65, 0, 2.5, 3, 2));

//create a material state and setting its properties
var materialState = new MinSG.MaterialState();
materialState.setAmbient(new Util.Color4f(0.2125, 0.1275, 0.054, 1.0));
materialState.setDiffuse(new Util.Color4f(0.714, 0.4284, 0.18144, 1.0));
materialState.setSpecular(new Util.Color4f(0.393548, 0.271906, 0.166721, 1.0));
materialState.setShininess(25);

//creating a new light node having a white light color
var pointLightNode = new MinSG.LightNode(MinSG.LightNode.POINT);
pointLightNode.setAmbientLightColor(new Util.Color4f(1.0, 1.0, 1.0, 1.0));
pointLightNode.setSpecularLightColor(new Util.Color4f(1.0, 1.0, 1.0, 1.0));
pointLightNode.setDiffuseLightColor(new Util.Color4f(1.0, 1.0, 1.0, 1.0));
//pointLightNode.moveLocal(new Geometry.Vec3(xMovement, 5, 5));
pointLightNode.moveLocal(new Geometry.Vec3(1, 5, 5));

//creating a light state so that only the geometry node ist illuminated by the light source
var lightingState = new MinSG.LightingState(pointLightNode);
lightingState.setEnableLight(true);

// frustum drawing
//var frus = Rendering.createConicalFrustum(new Geometry.Frustum());
//var frus = Rendering.MeshBuilder.createArrow(0.5, 8);
//var frus = Rendering.createArrow(0.5, 8); //too few parameters
var frus = Rendering.MeshBuilder.createConicalFrustum(1, 1.5, 3.8, 20);


var geometryNode1 = new MinSG.GeometryNode(mesh1);
var geometryNode2 = new MinSG.GeometryNode(mesh2);
var geometryNode3 = new MinSG.GeometryNode(mesh3);
var geometryNode4 = new MinSG.GeometryNode(frus);

//apply SRT transformation to node
var transformation = new Geometry.SRT();
transformation.applyRotation(new Geometry.Vec3(7,1,0));
//Number radiusBottom, Number radiusTop, Number height, Number segments)
//geometryNode4.setWorldTransformation(transformation);
frus.setWorldTransformation(transformation);
//
//adding the states to the node
geometryNode2.addState(materialState);
geometryNode2.addState(lightingState);
geometryNode1.addState(materialState);
//geometryNode3.addState(lightingState);
geometryNode3.addState(materialState);

//giving nodes a unique id
PADrend.getSceneManager().registerNode("root", rootNode);
PADrend.getSceneManager().registerNode("some_list_node", listNode);
PADrend.getSceneManager().registerNode("geometry_node_1", geometryNode1);

//Building the scene graph
rootNode.addChild(geometryNode1);
rootNode.addChild(listNode);
rootNode.addChild(geometryNode2);
rootNode.addChild(geometryNode3);
rootNode.addChild(geometryNode4);



//Setting some meta data
var NodeMetaInfo = Std.module('LibMinSGExt/NodeMetaInfo');
var date = getDate();

//NodeMetaInfo.accessMetaInfo_CreationDate(rootNode)("" + date["year"] + "-"+ date["mon"] + "-" + date["mday"] );
//NodeMetaInfo.accessMetaInfo_Title(rootNode)("Test Scene");
//NodeMetaInfo.accessMetaInfo_Author(rootNode)("Max Mustermann");
//NodeMetaInfo.accessMetaInfo_License(rootNode)("free");
//NodeMetaInfo.accessMetaInfo_Note(rootNode)("Some info about the scene.");

//Register the root node of the scene graph
PADrend.registerScene(rootNode);
//Selecting the root node to be the active scene
PADrend.selectScene(rootNode);


var cam = frameContext.getCamera();
var frustum = cam.getFrustum();
outln("freustru"+frustum);


