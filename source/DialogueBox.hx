package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;


	//15 portraits lol
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var gfportrait:FlxSprite;
	var gf2Portrait:FlxSprite;
	var bfportrait:FlxSprite;
	var dadPortrait:FlxSprite;
	var pumpPortrait:FlxSprite;
	var skidPortrait:FlxSprite;
	var picoPortrait:FlxSprite;
	var pico2Portrait:FlxSprite;
	var momPortrait:FlxSprite;
	var parentsMomPortrait:FlxSprite;
	var parentsDadPortrait:FlxSprite;
	var parentsPortrait:FlxSprite;
	var monsterPortrait:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 100;
				box.x = -100;	 
				box.y = 375;
				box.flipX = true;				
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		gfportrait = new FlxSprite(-20, 40);
		gfportrait.frames = Paths.getSparrowAtlas('Portraits/gfPortrait', 'shared');
		gfportrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//gfportrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		gfportrait.updateHitbox();
		gfportrait.scrollFactor.set();
		add(gfportrait);
		gfportrait.visible = false;	

		bfportrait = new FlxSprite(-20, 40);
		bfportrait.frames = Paths.getSparrowAtlas('Portraits/boyfriendPortrait', 'shared');
		bfportrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//bfportrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		bfportrait.updateHitbox();
		bfportrait.scrollFactor.set();
		add(bfportrait);
		bfportrait.visible = false;		

		dadPortrait = new FlxSprite(-20, 40);
		dadPortrait.frames = Paths.getSparrowAtlas('Portraits/dadPortrait', 'shared');
		dadPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//dadPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		dadPortrait.updateHitbox();
		dadPortrait.scrollFactor.set();
		add(dadPortrait);
		dadPortrait.visible = false;
		
		pumpPortrait = new FlxSprite(-20, 40);
		pumpPortrait.frames = Paths.getSparrowAtlas('Portraits/pumpPortrait', 'shared');
		pumpPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//pumpPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		pumpPortrait.updateHitbox();
		pumpPortrait.scrollFactor.set();
		add(pumpPortrait);
		pumpPortrait.visible = false;

		skidPortrait = new FlxSprite(-20, 40);
		skidPortrait.frames = Paths.getSparrowAtlas('Portraits/skidPortrait', 'shared');
		skidPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//skidPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		skidPortrait.updateHitbox();
		skidPortrait.scrollFactor.set();
		add(skidPortrait);
		skidPortrait.visible = false;

		picoPortrait = new FlxSprite(-20, 40);
		picoPortrait.frames = Paths.getSparrowAtlas('Portraits/picoPortrait', 'shared');
		picoPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//picoPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		picoPortrait.updateHitbox();
		picoPortrait.scrollFactor.set();
		add(picoPortrait);
		picoPortrait.visible = false;

		pico2Portrait = new FlxSprite(-20, 40);
		pico2Portrait.frames = Paths.getSparrowAtlas('Portraits/picoAngryPortrait', 'shared');
		pico2Portrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//pico2Portrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		pico2Portrait.updateHitbox();
		pico2Portrait.scrollFactor.set();
		add(pico2Portrait);
		pico2Portrait.visible = false;

		gf2Portrait = new FlxSprite(-20, 40);
		gf2Portrait.frames = Paths.getSparrowAtlas('Portraits/gfCheerPortrait', 'shared');
		gf2Portrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//gf2Portrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		gf2Portrait.updateHitbox();
		gf2Portrait.scrollFactor.set();
		add(gf2Portrait);
		gf2Portrait.visible = false;
		
		momPortrait = new FlxSprite(-20, 40);
		momPortrait.frames = Paths.getSparrowAtlas('Portraits/momPortrait', 'shared');
		momPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//momPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		momPortrait.updateHitbox();
		momPortrait.scrollFactor.set();
		add(momPortrait);
		momPortrait.visible = false;	

		parentsMomPortrait = new FlxSprite(-20, 40);
		parentsMomPortrait.frames = Paths.getSparrowAtlas('Portraits/parentsMomPortrait', 'shared');
		parentsMomPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//parentsMomPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		parentsMomPortrait.updateHitbox();
		parentsMomPortrait.scrollFactor.set();
		add(parentsMomPortrait);
		parentsMomPortrait.visible = false;	

		parentsDadPortrait = new FlxSprite(-20, 40);
		parentsDadPortrait.frames = Paths.getSparrowAtlas('Portraits/parentsDadPortrait', 'shared');
		parentsDadPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//parentsDadPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		parentsDadPortrait.updateHitbox();
		parentsDadPortrait.scrollFactor.set();
		add(parentsDadPortrait);
		parentsDadPortrait.visible = false;	

		parentsPortrait = new FlxSprite(-20, 40);
		parentsPortrait.frames = Paths.getSparrowAtlas('Portraits/parentsPortrait', 'shared');
		parentsPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//parentsPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		parentsPortrait.updateHitbox();
		parentsPortrait.scrollFactor.set();
		add(parentsPortrait);
		parentsPortrait.visible = false;

		monsterPortrait = new FlxSprite(-20, 40);
		monsterPortrait.frames = Paths.getSparrowAtlas('Portraits/christmasLemonPortrait', 'shared');
		monsterPortrait.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		//monsterPortrait.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		monsterPortrait.updateHitbox();
		monsterPortrait.scrollFactor.set();
		add(monsterPortrait);
		monsterPortrait.visible = false;																								
		

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!gfportrait.visible)
				{
					gfportrait.visible = true;
					gfportrait.animation.play('enter');
				}
			case 'boyfriend':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!bfportrait.visible)
				{
					bfportrait.visible = true;
					bfportrait.animation.play('enter');
				}
			case 'dearest':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!dadPortrait.visible)
				{
					dadPortrait.visible = true;
					dadPortrait.animation.play('enter');
				}
			case 'skid':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!skidPortrait.visible)
				{
					skidPortrait.visible = true;
					skidPortrait.animation.play('enter');
				}	
			case 'pump':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!pumpPortrait.visible)
				{
					pumpPortrait.visible = true;
					pumpPortrait.animation.play('enter');
				}
			case 'pico':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!picoPortrait.visible)
				{
					picoPortrait.visible = true;
					picoPortrait.animation.play('enter');
				}
			case 'pico-angry':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!pico2Portrait.visible)
				{
					pico2Portrait.visible = true;
					pico2Portrait.animation.play('enter');
				}	
			case 'gf-cheer':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!gf2Portrait.visible)
				{
					gf2Portrait.visible = true;
					gf2Portrait.animation.play('enter');
				}																
			case 'mom':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!momPortrait.visible)
				{
					momPortrait.visible = true;
					momPortrait.animation.play('enter');
				}
			case 'parentsDad':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!parentsDadPortrait.visible)
				{
					parentsDadPortrait.visible = true;
					parentsDadPortrait.animation.play('enter');
				}
			case 'parentsMom':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!parentsMomPortrait.visible)
				{
					parentsMomPortrait.visible = true;
					parentsMomPortrait.animation.play('enter');
				}
			case 'parents':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!parentsPortrait.visible)
				{
					parentsPortrait.visible = true;
					parentsPortrait.animation.play('enter');
				}
			case 'christmasLemon':
				monsterPortrait.visible = false;
				parentsPortrait.visible = false;
				parentsMomPortrait.visible = false;
				parentsDadPortrait.visible = false;
				momPortrait.visible = false;
				gf2Portrait.visible = false;
				pico2Portrait.visible = false;
				picoPortrait.visible = false;
				pumpPortrait.visible = false;
				skidPortrait.visible = false;
				dadPortrait.visible = false;
				gfportrait.visible = false;
				bfportrait.visible = false;
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!monsterPortrait.visible)
				{
					monsterPortrait.visible = true;
					monsterPortrait.animation.play('enter');
				}																						
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
