import 'dart:core';

import 'dart:ui';

class Herojourney extends Object{

	Color background;
	String herojourney_title, herojourney_act, herojourney_desc;

	Herojourney(Color background, String herojourney_title, String herojourney_act, String herojourney_desc) {
		this.background = background;
		this.herojourney_title = herojourney_title;
		this.herojourney_act = herojourney_act;
		this.herojourney_desc = herojourney_desc;
	}
}
