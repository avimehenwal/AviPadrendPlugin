var clipSphere = fn(rootNode){
    var numSegments = 20; //number of segments in horizontal and vertical direction
    var sphere_mesh = Rendering.MeshBuilder.createSphere(numSegments, numSegments);
    // Half sphere
    Rendering.eliminateTrianglesBehindPlane(sphere_mesh, new Geometry.Vec3(0.0, 0.0, 0.0), new Geometry.Vec3(-1.0, 0.0, 0.0));
	var node1 = new MinSG.GeometryNode(sphere_mesh);
	rootNode += node1;
};

var createThreeConesWithDifferentDrawState = fn(rootNode){
	var numSegments = 20;

	var mesh1 = Rendering.MeshBuilder.createSphere(numSegments, numSegments);
	var mesh2 = Rendering.MeshBuilder.createSphere(numSegments, numSegments);
	var mesh3 = Rendering.MeshBuilder.createSphere(numSegments, numSegments);
	var mesh4 = Rendering.MeshBuilder.createSphere(numSegments, numSegments);

	//Setting draw modes
	mesh1.setDrawTriangles(); //inital setting
	mesh2.setDrawLines(); //draw lines only, rectangular shaped
	mesh3.setDrawLineStrip(); //draw lines only, triangular shaped
	mesh4.setDrawPoints(); //draw only points (positions of vertices)

	var node1 = new MinSG.GeometryNode(mesh1);
	var node2 = new MinSG.GeometryNode(mesh2);
	var node3 = new MinSG.GeometryNode(mesh3);
	var node4 = new MinSG.GeometryNode(mesh4);

	//Setting positions
	node1.setRelPosition(new Geometry.Vec3(-2, 0, 0));
	node2.setRelPosition(new Geometry.Vec3( 2, 0, 0));
	node3.setRelPosition(new Geometry.Vec3(-8, 0, 0));
	node4.setRelPosition(new Geometry.Vec3( 8, 0, 0));

	rootNode += node1;
	rootNode += node2;
	rootNode += node3;
	rootNode += node4;
};


// PADREND Register
var sceneNode = new MinSG.ListNode();

createThreeConesWithDifferentDrawState(sceneNode);
clipSphere(sceneNode);

//Register the scene
PADrend.registerScene(sceneNode);
//Selecting the scene to make it active
PADrend.selectScene(sceneNode);
