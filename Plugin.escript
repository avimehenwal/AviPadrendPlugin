static plugin = new Plugin({
		Plugin.NAME : 'AviProject',
		Plugin.DESCRIPTION : 'Project for AHCVS',
		Plugin.VERSION : 0.1,
		Plugin.AUTHORS : "Avi Mehenwal",
		Plugin.OWNER : "Avi Mehenwal",
		Plugin.LICENSE : "Some License",
		Plugin.REQUIRES : [
            'PADrend/GUI',
            'Physics',
            'Tools',
            'GUITools',
            'NodeEditor'
        ],
		Plugin.EXTENSION_POINTS : [
			/* [ext:AviPlugin_OnRedButtonPressed]
			 * Called whenever the red button is pressed.
			 * @param   empty
			 * @result  void
			 */
			'AviPlugin_OnRedButtonPressed',

        ] //with an event based system
});

plugin.init @(override) := fn() {
	declareNamespace($AviNamespace);   // Plugin Namespace
	AviNamespace.someValue := 42;
    // avoid presenting GUI after ever reload instead call initGUI when PADrend/gui is ready.
	module.on('PADrend/gui', initGUI);
	return true;
};
static initGUI = fn(_gui){
	static gui = _gui;
	outln("AviProject: Init GUI...");

	// init menu entries
	gui.register('PADrend_PluginsMenu.examplePlugin',[
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "AviProject",
			GUI.ON_CLICK : fn(){
				// for openDialog documentation, see LibGUIExt/Factory_Dialogs.escript
				gui.openDialog({
					GUI.TYPE : GUI.TYPE_POPUP_DIALOG,
					GUI.LABEL : "AviProject-Window",
					GUI.SIZE : [300,400],
					GUI.ACTIONS : [
						[ "Cancel",fn(){	PADrend.message("Bye!"); }, "Tooltip: Run away!" ]
					],
					GUI.OPTIONS : 'AviProject_WindowEntries'
				});
			}
		}
	]);

	gui.register('AviProject_WindowEntries.cash',[
		{// for gui component documentation, see LibGUIExt/Factory_Components.escript
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Load aviplugin.escript",
			GUI.COLOR : GUI.RED,
			//GUI.FONT : GUI.FONT_ID_LARGE,
			GUI.TOOLTIP : "Dangerous button! Do not press!",
			GUI.ON_CLICK : fn(){
                // load escript
                load(__DIR__ + "/scripts/aviplugin.escript");
            }
		},
		{   GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Load MeshBuilderExample.escript",
			GUI.COLOR : GUI.BLUE,
			//GUI.FONT : GUI.FONT_ID_LARGE,
			GUI.TOOLTIP : "Dangerous button! Do not press!",
			GUI.ON_CLICK : fn(){load(__DIR__ + "/MeshBuilderExample.escript");}
		},
		{   GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Load toy.escript",
			GUI.COLOR : GUI.GREEN,
			//GUI.FONT : GUI.FONT_ID_LARGE,
			GUI.TOOLTIP : "Dangerous button! Do not press!",
			GUI.ON_CLICK : fn(){load(__DIR__ + "/scripts/toy.escript");}
		},
		{
			GUI.TYPE : GUI.TYPE_NUMBER,
			GUI.LABEL : "Cash",
			GUI.DATA_WRAPPER : cash,
			GUI.TOOLTIP : "Your current amount of gold.",
		}
	]);

};

return plugin;
