import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plotgenerator/engine/common.dart';
import 'package:plotgenerator/model/Project.dart';
import 'package:plotgenerator/engine/database/databaseHelper.dart';
import 'package:plotgenerator/engine/helper.dart';
import 'package:plotgenerator/engine/imagePicker.dart';
import 'package:plotgenerator/engine/resource.dart';
import 'package:plotgenerator/engine/utility.dart';
import 'package:plotgenerator/generated/i18n.dart';
import 'package:plotgenerator/model/Character.dart';
import 'package:plotgenerator/ui/screen/characterListScreen.dart';

import '../../engine/tutorialManager.dart';
import '../../main.dart';
import 'challengeScreen.dart';
import 'discoverScreen.dart';
import 'premiumScreen.dart';
import 'profileScreen.dart';
import 'promptsScreen.dart';

class AddCharacterScreen extends StatefulWidget {
	AddCharacterScreen({Key key}) : super(key: key);

	@override
	AddCharacterScreenState createState() => AddCharacterScreenState();
}

class AddCharacterScreenState extends State<AddCharacterScreen> {

	AddCharacterScreenState();
	final nameCtrl = TextEditingController();
	final ageCtrl = TextEditingController();
	final heightCtrl = TextEditingController();
	final hairCtrl = TextEditingController();
	final eyeCtrl = TextEditingController();
	final bodyCtrl = TextEditingController();
	final professionCtrl = TextEditingController();
	final placeOfBirthCtrl = TextEditingController();
	final birthCtrl = TextEditingController();
	final phraseCtrl = TextEditingController();
	final trait1Ctrl = TextEditingController();
	final trait1Ctr2 = TextEditingController();
	final trait1Ctr3 = TextEditingController();
	final momnetCtrl = TextEditingController();
	final wantCtrl = TextEditingController();
	final needCtrl = TextEditingController();
	final noteCtrl = TextEditingController();

	List<String> bio = [];
	String imgString = '';
	String gender = "";
	String role = "";


	@override
	void initState() {
		super.initState();
		Future.delayed(Duration.zero, this.checkTutorial);

	}



	@override
	void dispose() {
		nameCtrl.dispose();
		ageCtrl.dispose();
		heightCtrl.dispose();
		hairCtrl.dispose();
		eyeCtrl.dispose();
		bodyCtrl.dispose();
		professionCtrl.dispose();
		placeOfBirthCtrl.dispose();
		phraseCtrl.dispose();
		trait1Ctrl.dispose();
		trait1Ctr2.dispose();
		trait1Ctr3.dispose();
		momnetCtrl.dispose();
		wantCtrl.dispose();
		needCtrl.dispose();
		noteCtrl.dispose();
		birthCtrl.dispose();
		super.dispose();
	}

	checkTutorial() {
		TutorialManager.check(context);
	}

	onPhoto(BuildContext context) {
		CustomImagePicker.show(context, (imageFile) {
			setState(() {
				if (imageFile == null)
					this.imgString = '';
				else
					this.imgString = Utility.base64String(imageFile.readAsBytesSync());
			});
		});
	}

	onSave(BuildContext context) {
		if (nameCtrl.text == "") { Helper.showErrorToast(S.of(context).char_empty); return; }

		Character character = new Character(
			name: nameCtrl.text,
			age: ageCtrl.text,
			height: heightCtrl.text,
			hairColor: hairCtrl.text,
			eyeColor: eyeCtrl.text,
			bodyBuild: bodyCtrl.text,
			profession: professionCtrl.text,
			placeBirth: placeOfBirthCtrl.text,
			phrase: phraseCtrl.text,
			trait1: trait1Ctrl.text,
			trait2: trait1Ctr2.text,
			trait3: trait1Ctr3.text,
			defmoment: momnetCtrl.text,
			desire: wantCtrl.text,
			birthdate: birthCtrl.text,
			need: needCtrl.text,
			project_id: Common.currentProject.id.toString() ,
			gender: gender,
			role: role,
			image: imgString
		);

		DatabaseHelper().createCharacter(character).then((value) {
			Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterListScreen()));
		});
	}

	onRandom(BuildContext context) {
		bio = generateBIO(context);
		nameCtrl.text = bio[0];
		ageCtrl.text = bio[2];
		heightCtrl.text = bio[5];
		hairCtrl.text = bio[6];
		eyeCtrl.text = bio[7];
		bodyCtrl.text = bio[8];
		professionCtrl.text = bio[4];
		placeOfBirthCtrl.text = bio[1];
		phraseCtrl.text = bio[15];
		trait1Ctrl.text = bio[11];
		trait1Ctr2.text = bio[12];
		trait1Ctr3.text = bio[13];
		momnetCtrl.text = bio[10];
		wantCtrl.text = bio[9];
		needCtrl.text = bio[14];
		if (bio[3] == "1")
			gender = "Male";
		else
			gender = "Female";

		birthCtrl.text = bio[16];
	}

	List<String> generateBIO(BuildContext context) {
		List<String> male_names = [];
		List<String> female_names = [];
		List<String> last_name = [];
		List<String> placeOfBirth = [];
		List<String> profession = [];
		List<String> height = [];
		List<String> haircolor = [];
		List<String> eyecolor = [];
		List<String> bodybuild = [];
		List<String> desire = [];
		List<String> moment = [];
		List<String> traits = [];
		List<String> phrases_array = [];
		List<String> needs = [];
		List<String> bio = [];
		String selectedName;
		
		male_names.addAll(["Sylvain","James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", "Andrew", "Kenneth", "George", "Joshua", "Kevin", "Brian", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Stephen", "Jonathan", "Larry", "Justin", "Scott", "Brandon", "Frank", "Benjamin", "Gregory", "Raymond", "Samuel", "Patrick", "Alexander", "Jack", "Santiago", "Sebastián", "Matías", "Mateo", "Nicolás", "Alejandro", "Diego", "Samuel", "Benjamín", "Daniel", "Joaquín", "Lucas", "Tomas", "Gabriel", "Martín", "David", "Emiliano", "Jerónimo", "Emmanuel", "Agustín", "Juan Pablo", "Juan José", "Andrés", "Thiago", "Leonardo", "Felipe", "Ángel", "Maximiliano", "Christopher", "Juan Diego", "Adrián", "Pablo", "Miguel Ángel", "Rodrigo", "Alexander", "Ignacio", "Emilio", "Dylan", "Bruno", "Carlos", "Vicente", "Valentino", "Santino", "Julián", "Juan Sebastián", "Aarón", "Lautaro", "Axel", "Fernando", "Ian", "Christian", "Javier", "Manuel", "Luciano", "Francisco", "Juan David", "Iker", "Facundo", "Rafael", "Alex", "Franco", "Antonio", "Luis", "Isaac", "Máximo", "Pedro", "Ricardo", "Sergio", "Eduardo", "Bautista"]);
		female_names.addAll(["Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Margaret", "Karen", "Nancy", "Lisa", "Betty", "Dorothy", "Sandra", "Ashley", "Kimberly", "Donna", "Emily", "Carol", "Michelle", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Helen", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Anna", "Ruth", "Brenda", "Pamela", "Nicole", "Katherine", "Samantha", "Christine", "Catherine", "Virginia", "Debra", "Rachel", "Janet", "Emma", "Carolyn", "Maria", "Heather", "Diane", "Julie", "Joyce", "Evelyn", "Joan", "Victoria", "Kelly", "Christina", "Lauren", "Frances", "Martha", "Judith", "Cheryl", "Megan", "Andrea", "Olivia", "Ann", "Jean", "Alice", "Jacqueline", "Hannah", "Doris", "Kathryn", "Gloria", "Teresa", "Sara", "Janice", "Marie", "Julia", "Grace", "Judy", "Theresa", "Beverly", "Denise", "Marilyn", "Amber", "Danielle", "Rose", "Brittany", "Diana", "Abigail", "Natalie", "Jane", "Lori", "Alexis", "Tiffany", "Kayla", "Sofia", "Isabella", "Camila", "Valentina", "Valeria", "Mariana", "Luciana", "Daniela", "Gabriela", "Victoria", "Martina", "Lucia", "Ximena/Jimena", "Sara", "Samantha", "Maria José", "Emma", "Catalina", "Julieta", "Mía", "Antonella", "Renata", "Emilia", "Natalia", "Zoe", "Nicole", "Paula", "Amanda", "María Fernanda", "Emily", "Antonia", "Alejandra", "Juana", "Andrea", "Manuela", "Ana Sofia", "Guadalupe", "Agustina", "Elena", "María", "Bianca", "Ariana", "Ivanna", "Abril", "Florencia", "Carolina", "Maite", "Rafaela"]);
		last_name.addAll(["Paccihiani","SMITH", "JOHNSON", "WILLIAMS", "JONES", "BROWN", "DAVIS", "MILLER", "WILSON", "MOORE", "TAYLOR", "ANDERSON", "THOMAS", "JACKSON", "WHITE", "HARRIS", "MARTIN", "THOMPSON", "GARCIA", "MARTINEZ", "ROBINSON", "CLARK", "RODRIGUEZ", "LEWIS", "LEE", "WALKER", "HALL", "ALLEN", "YOUNG", "HERNANDEZ", "KING", "WRIGHT", "LOPEZ", "HILL", "SCOTT", "GREEN", "ADAMS", "BAKER", "GONZALEZ", "NELSON", "CARTER", "MITCHELL", "PEREZ", "ROBERTS", "TURNER", "PHILLIPS", "CAMPBELL", "PARKER", "EVANS", "EDWARDS", "COLLINS", "STEWART", "SANCHEZ", "MORRIS", "ROGERS", "REED", "COOK", "MORGAN", "BELL", "MURPHY", "BAILEY", "RIVERA", "COOPER", "RICHARDSON", "Garcia", "Fernandez", "Lopez", "Martinez", "Gonzalez", "Rodriguez", "Sanchez", "Perez", "Martin", "Gomez", "Ruiz", "Diaz", "Hernandez", "Alvarez", "Jimenez", "Moreno", "Munoz", "Alonso", "Romero", "Navarro", "Gutierrez", "Torres", "Dominguez", "Gil", "Vazquez", "Blanco", "Serrano", "Ramos", "Castro", "Suarez", "Sanz", "Rubio", "Ortega", "Molina", "Delgado", "Ortiz", "Morales", "Ramirez", "Marin", "Iglesias", "Santos", "Castillo", "Garrido"]);
		placeOfBirth.addAll([
			S.of(context).placebirth_array_0,
			S.of(context).placebirth_array_1,
			S.of(context).placebirth_array_2,
			S.of(context).placebirth_array_3,
			S.of(context).placebirth_array_4,
			S.of(context).placebirth_array_5,
			S.of(context).placebirth_array_6,
			S.of(context).placebirth_array_7,
			S.of(context).placebirth_array_8,
			S.of(context).placebirth_array_9,
			S.of(context).placebirth_array_10,
			S.of(context).placebirth_array_11,
			S.of(context).placebirth_array_12,
			S.of(context).placebirth_array_13,
			S.of(context).placebirth_array_14,
			S.of(context).placebirth_array_15,
			S.of(context).placebirth_array_16,
			S.of(context).placebirth_array_17,
			S.of(context).placebirth_array_18,
			S.of(context).placebirth_array_19,
			S.of(context).placebirth_array_20,
			S.of(context).placebirth_array_21,
			S.of(context).placebirth_array_22,
			S.of(context).placebirth_array_23,
			S.of(context).placebirth_array_24,
			S.of(context).placebirth_array_25,
			S.of(context).placebirth_array_26,
			S.of(context).placebirth_array_27,
			S.of(context).placebirth_array_28,
			S.of(context).placebirth_array_29,
			S.of(context).placebirth_array_30,
			S.of(context).placebirth_array_31,
			S.of(context).placebirth_array_32,
			S.of(context).placebirth_array_33,
			S.of(context).placebirth_array_34,
			S.of(context).placebirth_array_35,
			S.of(context).placebirth_array_36,
			S.of(context).placebirth_array_37,
			S.of(context).placebirth_array_38,
			S.of(context).placebirth_array_39,
			S.of(context).placebirth_array_40,
			S.of(context).placebirth_array_41,
			S.of(context).placebirth_array_42,
			S.of(context).placebirth_array_43,
			S.of(context).placebirth_array_44,
			S.of(context).placebirth_array_45,
			S.of(context).placebirth_array_46,
			S.of(context).placebirth_array_47,
			S.of(context).placebirth_array_48,
			S.of(context).placebirth_array_49,
			S.of(context).placebirth_array_50,
			S.of(context).placebirth_array_51,
			S.of(context).placebirth_array_52,
			S.of(context).placebirth_array_53,
			S.of(context).placebirth_array_54,
			S.of(context).placebirth_array_55,
			S.of(context).placebirth_array_56,
			S.of(context).placebirth_array_57,
			S.of(context).placebirth_array_58,
			S.of(context).placebirth_array_59,
			S.of(context).placebirth_array_60,
			S.of(context).placebirth_array_61,
			S.of(context).placebirth_array_62,
			S.of(context).placebirth_array_63,
			S.of(context).placebirth_array_64,
			S.of(context).placebirth_array_65,
			S.of(context).placebirth_array_66,
			S.of(context).placebirth_array_67,
			S.of(context).placebirth_array_68,
			S.of(context).placebirth_array_69,
			S.of(context).placebirth_array_70,
			S.of(context).placebirth_array_71,
			S.of(context).placebirth_array_72,
			S.of(context).placebirth_array_73,
			S.of(context).placebirth_array_74,
			S.of(context).placebirth_array_75,
			S.of(context).placebirth_array_76,
			S.of(context).placebirth_array_77,
			S.of(context).placebirth_array_78,
			S.of(context).placebirth_array_79,
			S.of(context).placebirth_array_80,
			S.of(context).placebirth_array_81,
			S.of(context).placebirth_array_82,
			S.of(context).placebirth_array_83,
			S.of(context).placebirth_array_84,
			S.of(context).placebirth_array_85,
			S.of(context).placebirth_array_86,
			S.of(context).placebirth_array_87,
			S.of(context).placebirth_array_88,
		]);
		profession.addAll([
			S.of(context).profession_array_0,
			S.of(context).profession_array_1,
			S.of(context).profession_array_2,
			S.of(context).profession_array_3,
			S.of(context).profession_array_4,
			S.of(context).profession_array_5,
			S.of(context).profession_array_6,
			S.of(context).profession_array_7,
			S.of(context).profession_array_8,
			S.of(context).profession_array_9,
			S.of(context).profession_array_10,
			S.of(context).profession_array_11,
			S.of(context).profession_array_12,
			S.of(context).profession_array_13,
			S.of(context).profession_array_14,
			S.of(context).profession_array_15,
			S.of(context).profession_array_16,
			S.of(context).profession_array_17,
			S.of(context).profession_array_18,
			S.of(context).profession_array_19,
			S.of(context).profession_array_20,
			S.of(context).profession_array_21,
			S.of(context).profession_array_22,
			S.of(context).profession_array_23,
			S.of(context).profession_array_24,
			S.of(context).profession_array_25,
			S.of(context).profession_array_26,
			S.of(context).profession_array_27,
			S.of(context).profession_array_28,
			S.of(context).profession_array_29,
			S.of(context).profession_array_30,
			S.of(context).profession_array_31,
			S.of(context).profession_array_32,
			S.of(context).profession_array_33,
			S.of(context).profession_array_34,
			S.of(context).profession_array_35,
			S.of(context).profession_array_36,
			S.of(context).profession_array_37,
			S.of(context).profession_array_38,
			S.of(context).profession_array_39,
			S.of(context).profession_array_40,
			S.of(context).profession_array_41,
			S.of(context).profession_array_42,
			S.of(context).profession_array_43,
			S.of(context).profession_array_44,
			S.of(context).profession_array_45,
			S.of(context).profession_array_46,
			S.of(context).profession_array_47,
			S.of(context).profession_array_48,
			S.of(context).profession_array_49
		]);
		height.addAll([
			S.of(context).heights_0,
			S.of(context).heights_1,
			S.of(context).heights_2,
			S.of(context).heights_3,
			S.of(context).heights_4,
			S.of(context).heights_5,
			S.of(context).heights_6,
			S.of(context).heights_7,
			S.of(context).heights_8
		]);
		haircolor.addAll([
			S.of(context).haircolors_0,
			S.of(context).haircolors_1,
			S.of(context).haircolors_2,
			S.of(context).haircolors_3,
			S.of(context).haircolors_4,
			S.of(context).haircolors_5,
			S.of(context).haircolors_6,
			S.of(context).haircolors_7
		]);
		eyecolor.addAll([
			S.of(context).eyecolors_0,
			S.of(context).eyecolors_1,
			S.of(context).eyecolors_2,
			S.of(context).eyecolors_3,
			S.of(context).eyecolors_4,
			S.of(context).eyecolors_5,
			S.of(context).eyecolors_6,
		]);
		bodybuild.addAll([
			S.of(context).bodytypes_0,
			S.of(context).bodytypes_1,
			S.of(context).bodytypes_2,
			S.of(context).bodytypes_3,
			S.of(context).bodytypes_4,
		]);
		desire.addAll([
			S.of(context).desire_array_0,
			S.of(context).desire_array_1,
			S.of(context).desire_array_2,
			S.of(context).desire_array_3,
			S.of(context).desire_array_4,
			S.of(context).desire_array_5,
			S.of(context).desire_array_6,
			S.of(context).desire_array_7,
			S.of(context).desire_array_8,
			S.of(context).desire_array_9,
			S.of(context).desire_array_10,
			S.of(context).desire_array_11,
			S.of(context).desire_array_12,
			S.of(context).desire_array_13,
			S.of(context).desire_array_14,
			S.of(context).desire_array_15,
			S.of(context).desire_array_16,
			S.of(context).desire_array_17,
			S.of(context).desire_array_18,
			S.of(context).desire_array_19,
			S.of(context).desire_array_20,
			S.of(context).desire_array_21,
			S.of(context).desire_array_22,
			S.of(context).desire_array_23,
			S.of(context).desire_array_24,
			S.of(context).desire_array_25,
			S.of(context).desire_array_26,
			S.of(context).desire_array_27,
			S.of(context).desire_array_28,
			S.of(context).desire_array_29,
			S.of(context).desire_array_30,
			S.of(context).desire_array_31,
			S.of(context).desire_array_32,
			S.of(context).desire_array_33,
			S.of(context).desire_array_34,
			S.of(context).desire_array_35,
			S.of(context).desire_array_36,
			S.of(context).desire_array_37,
			S.of(context).desire_array_38,
			S.of(context).desire_array_39,
			S.of(context).desire_array_40,
			S.of(context).desire_array_41
		]);
		moment.addAll([
			S.of(context).defmoment_array_0,
			S.of(context).defmoment_array_1,
			S.of(context).defmoment_array_2,
			S.of(context).defmoment_array_3,
			S.of(context).defmoment_array_4,
			S.of(context).defmoment_array_5,
			S.of(context).defmoment_array_6,
			S.of(context).defmoment_array_7,
			S.of(context).defmoment_array_8,
			S.of(context).defmoment_array_9,
			S.of(context).defmoment_array_10,
			S.of(context).defmoment_array_11,
			S.of(context).defmoment_array_12,
			S.of(context).defmoment_array_13,
			S.of(context).defmoment_array_14
		]);
		phrases_array.addAll([
			S.of(context).phrases_0,
			S.of(context).phrases_1,
			S.of(context).phrases_2,
			S.of(context).phrases_3,
			S.of(context).phrases_4,
			S.of(context).phrases_5,
			S.of(context).phrases_6,
			S.of(context).phrases_7,
			S.of(context).phrases_8,
			S.of(context).phrases_9,
			S.of(context).phrases_10,
			S.of(context).phrases_11,
			S.of(context).phrases_12,
			S.of(context).phrases_13,
			S.of(context).phrases_14,
			S.of(context).phrases_15,
			S.of(context).phrases_16,
			S.of(context).phrases_17,
			S.of(context).phrases_18,
			S.of(context).phrases_19,
			S.of(context).phrases_20,
			S.of(context).phrases_21,
			S.of(context).phrases_22,
			S.of(context).phrases_23,
			S.of(context).phrases_24,
			S.of(context).phrases_25
		]);
		traits.addAll([
			S.of(context).trait_array_0,
			S.of(context).trait_array_1,
			S.of(context).trait_array_2,
			S.of(context).trait_array_3,
			S.of(context).trait_array_4,
			S.of(context).trait_array_5,
			S.of(context).trait_array_6,
			S.of(context).trait_array_7,
			S.of(context).trait_array_8,
			S.of(context).trait_array_9,
			S.of(context).trait_array_10,
			S.of(context).trait_array_11,
			S.of(context).trait_array_12,
			S.of(context).trait_array_13,
			S.of(context).trait_array_14,
			S.of(context).trait_array_15,
			S.of(context).trait_array_16,
			S.of(context).trait_array_17,
			S.of(context).trait_array_18,
			S.of(context).trait_array_19,
			S.of(context).trait_array_20,
			S.of(context).trait_array_21,
			S.of(context).trait_array_22,
			S.of(context).trait_array_23,
			S.of(context).trait_array_24,
			S.of(context).trait_array_25,
			S.of(context).trait_array_26,
			S.of(context).trait_array_27,
			S.of(context).trait_array_28,
			S.of(context).trait_array_29,
			S.of(context).trait_array_30,
			S.of(context).trait_array_31,
			S.of(context).trait_array_32,
			S.of(context).trait_array_33,
			S.of(context).trait_array_34,
			S.of(context).trait_array_35,
			S.of(context).trait_array_36,
			S.of(context).trait_array_37,
			S.of(context).trait_array_38,
			S.of(context).trait_array_39,
			S.of(context).trait_array_40,
			S.of(context).trait_array_41,
			S.of(context).trait_array_42,
			S.of(context).trait_array_43,
			S.of(context).trait_array_44,
		]);
		needs.addAll([
			S.of(context).need_array_0,
			S.of(context).need_array_1,
			S.of(context).need_array_2,
			S.of(context).need_array_3,
			S.of(context).need_array_4,
			S.of(context).need_array_5,
			S.of(context).need_array_6,
			S.of(context).need_array_7,
			S.of(context).need_array_8,
			S.of(context).need_array_9,
			S.of(context).need_array_10,
			S.of(context).need_array_11,
			S.of(context).need_array_12,
			S.of(context).need_array_13,
			S.of(context).need_array_14,
			S.of(context).need_array_15,
			S.of(context).need_array_16,
			S.of(context).need_array_17,
		]);

		var r = new Random();
		int gender = r.nextInt(2) + 1;
		int index = r.nextInt(male_names.length);
		int index2 = r.nextInt(female_names.length);
		int index3 = r.nextInt(last_name.length);

		if (gender == 1)
			selectedName = male_names[index];
		else
			selectedName = female_names[index2];

		String selectedLastName = last_name[index3].toLowerCase();
		String capi_lastname = selectedLastName.toUpperCase().substring(1);
		String completeName = selectedName + " " + selectedLastName;

		int index4 = r.nextInt(placeOfBirth.length);
		String placeBirth = placeOfBirth[index4];

		int age = r.nextInt(60) + 12;

		int index5 = r.nextInt(profession.length);
		String job = profession[index5];

		int index_height = r.nextInt(height.length);
		String height_temp = height[index_height];

		int index_hair = r.nextInt(haircolor.length);
		String hair = haircolor[index_hair];

		int index_eye = r.nextInt(eyecolor.length);
		String eye = eyecolor[index_eye];

		int index_body = r.nextInt(bodybuild.length);
		String body = bodybuild[index_body];

		int index6 = r.nextInt(desire.length);
		String wish = desire[index6];

		int index7 = r.nextInt(moment.length);
		String defmoment = moment[index7];

		int index8 = r.nextInt(traits.length);
		int index9 = r.nextInt(traits.length);
		int index10 = r.nextInt(traits.length);
		String trait1 = traits[index8];
		String trait2 = traits[index9];
		String trait3 = traits[index10];

		int index20 = r.nextInt(phrases_array.length);
		String phrase_txt = phrases_array[index20];

		int index11 = r.nextInt(needs.length);
		String need = needs[index11];

		String birthday = generateRandomBirthday();

		bio.addAll([
			completeName,
			placeBirth,
			age.toString(),
			gender.toString(),
			job,
			height_temp,
			hair,
			eye,
			body,
			wish,
			defmoment,
			trait1,
			trait2,
			trait3,
			need,
			phrase_txt,
			birthday
		]);

		return bio;
	}

	String generateRandomBirthday(){
		var random = new Random();
		int r_year = random.nextInt(2019 - 1990);
		r_year += 1990;
		int r_month = random.nextInt(11) + 1;
		int r_day = random.nextInt(27) + 1;

		var date = DateTime(r_year, r_month, r_day);
		var formatter = new DateFormat('yyyy-MM-dd');
		String formatted = formatter.format(date);
		return formatted;
	}

	gotoProfileScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
	}

	gotoPremiumScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumScreen()));
	}

	gotoDiscoverScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverScreen()));
	}

	gotoChallengeScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeScreen()));
	}

	gotoPromptsScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => PromptsScreen()));
	}

	gotoMainScreen(BuildContext context) {
		Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			drawer: Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: <Widget>[
						Container(
							height: 90.0,
							child: DrawerHeader(
								child: Text(
									""
								),
								decoration: BoxDecoration(color: Common.containerBackColor)),
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuWorkshop, color: Common.containerBackColor),
							title: Text(S.of(context).story_tab),
							onTap: () => {gotoMainScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuChallenge, color: Common.containerBackColor),
							),
							title: Text(S.of(context).writing_challenge_tab),
							onTap: () => {gotoChallengeScreen(context)},
						),

						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: SvgPicture.asset(ImageConstants.SideMenuPrompts, color: Common.containerBackColor),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).trigger_tab),
							onTap: () => {gotoPromptsScreen(context)},
						),
						ListTile(
							leading: Container(
								width: 24,
								height: 24,
								child: Image.asset(ImageConstants.SideMenuPremium, color: Common.containerBackColor),
								decoration: new BoxDecoration(),
							),
							title: Text(S.of(context).premium_tab),
							onTap: () => {gotoPremiumScreen(context)},
						),
						ListTile(
							leading: SvgPicture.asset(ImageConstants.SideMenuProfile, color: Common.containerBackColor),
							title: Text(S.of(context).my_profile),
							onTap: () => {gotoProfileScreen(context)},
						),
					],
				),
			),
			appBar: AppBar(
				title: Text(S.of(context).character_create),
			),
			body: SingleChildScrollView(
				child: ConstrainedBox(
					constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							GestureDetector(
								onTap: () => onPhoto(context),
								child: Container(
									padding: EdgeInsets.only(top: 16, bottom: 16),
									height: 200,
									child: imgString == ''
										? Icon(
										Icons.photo_camera,
										color: Common.containerBackColor,
										size: 60)
										: Utility.imageFromBase64String(imgString)
								),
							),
							SizedBox(
								height: 20,
							),
							basicContainer(context),
							SizedBox(
								height: 20,
							),
							personalityContainer(context),
							SizedBox(
								height: 20,
							),
							storyContainer(context),
							SizedBox(
								height: 20,
							),
							noteContainer(context),
						],
					),
				),
			),
			floatingActionButton: Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					FloatingActionButton(
						heroTag: 2,
						child: Image.asset(ImageConstants.ic_random),
						onPressed: () => onRandom(context),
					),
					SizedBox(
						width: 10,
					),
					FloatingActionButton(
						heroTag: 1,
						child: Image.asset(ImageConstants.ic_menu_save),
						onPressed: () => onSave(context),
					),
				],
			)
		);
	}

	basicContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						'Basic',
						style: TextStyle(fontSize: 18),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_name
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: nameCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_age
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: ageCtrl,
						maxLines: 1,
						keyboardType: TextInputType.number,
						inputFormatters: <TextInputFormatter>[
							WhitelistingTextInputFormatter.digitsOnly
						],
					),
					SizedBox(
						height: 10,
					),
					genderDropDown(context),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_height
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: heightCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_haircolor
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: hairCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_eyecolor
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: eyeCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_bodybuild
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: bodyCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_profession
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: professionCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_placebirth
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: placeOfBirthCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).birthdate_add_text
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: birthCtrl,
						maxLines: 1,
						keyboardType: TextInputType.number,
						inputFormatters: <TextInputFormatter>[
							WhitelistingTextInputFormatter.digitsOnly
						],
					),
				],

			),
		));
	}

	genderDropDown(BuildContext context) {
		List<String> genderList = StringConstants.genderList(context);
		if (gender == "") {
			setState(() {
				gender = genderList[0];
			});
		}
		return (Container(
			width: 200,
			child: DropdownButton<String>(
				value: gender,
				icon: Icon(Icons.arrow_drop_down),
				iconSize: 24,
				style: TextStyle(fontSize: 18, color: Common.containerBackColor),
				isExpanded: true,
				onChanged: (String data) {
					setState(() {
						gender = data;
					});
				},
				items: genderList.map((e) {
					return DropdownMenuItem(
						value: e,
						child: Text(e),
					);
				}).toList()),
		));
	}

	personalityContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						'Personality',
						style: TextStyle(fontSize: 18),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_phrase
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: phraseCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_trait
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: trait1Ctrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_trait
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: trait1Ctr2,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_trait
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: trait1Ctr3,
						maxLines: 1,
					),
				],

			),
		));
	}

	storyContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						'Story',
						style: TextStyle(fontSize: 18),
					),
					SizedBox(
						height: 10,
					),
					roleDropDown(context),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_defmoment
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: momnetCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_desire
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: wantCtrl,
						maxLines: 1,
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_add_need
						),
						style: TextStyle(fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: needCtrl,
						maxLines: 1,
					),
				],

			),
		));
	}

	roleDropDown(BuildContext context) {
		List<String> roleList = StringConstants.storyList(context);
		if (role == "") {
			setState(() {
				role = roleList[0];
			});
		}
		return (Container(
			width: 200,
			child: DropdownButton<String>(
				value: role,
				icon: Icon(Icons.arrow_drop_down),
				iconSize: 24,
				style: TextStyle(fontSize: 18, color: Common.containerBackColor),
				isExpanded: true,
				onChanged: (String data) {
					setState(() {
						role = data;
					});
				},
				items: roleList.map((e) {
					return DropdownMenuItem(
						value: e,
						child: Text(e),
					);
				}).toList()),
		));
	}

	noteContainer(BuildContext context) {
		return (Container(
			padding: EdgeInsets.only(left: 10, right: 10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					Text(
						'Notes',
						style: TextStyle(fontSize: 18, ),
					),
					SizedBox(
						height: 10,
					),
					TextField(
						decoration: InputDecoration(
							hintText: S.of(context).character_notes_tv
						),
						style: TextStyle( fontSize: 14),
//						cursorColor: Colors.black,
						onChanged: (value) {},
						controller: noteCtrl,
						maxLines: 10,
					),
				],
			),
		));
	}
}
