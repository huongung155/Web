/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var but1 = document.querySelector("#button1");
var	img1 = document.querySelector("#img1");
var but2 = document.querySelector("#button2");
var	img2 = document.querySelector("#img2");
var imgArr1 = ["https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=17f6660f41a9b4cd3978e88b15b01584e&authkey=AbQJEJiu6QCgCNhjJ_Tqx7E",
				"https://6.viki.io/image/25b3a5e8fa2643fb9702e1a1ab1b6ab4.jpeg?x=b&s=460x268&e=t&f=t&cb=1",
				"http://www.hancinema.net/photos/fullsizephoto793312.jpg",
				"https://i.pinimg.com/originals/08/4d/4e/084d4e4e141f32d58af2303ee425591d.jpg"];

var imgArr2 = ["https://6.viki.io/image/4ccb68ea09e344caa9bc557c2c369eb7.jpeg?x=b&s=460x268&e=t&f=t&cb=1",
				"https://i.ytimg.com/vi/FHXBNuKjI48/maxresdefault.jpg",
				"https://0.viki.io/v/66268/0c5f3532635daaed9d1dfc6eb6d50b1c8b0f30a3.jpg?x=b&s=380x214&q=h&e=t&f=t&cb=1",
				"http://images5.fanpop.com/image/photos/32000000/Sungkyunkwan-Scandal-sungkyunkwan-scandal-32032987-1280-720.jpg"];
var count1 = 1;

but1.addEventListener("click", function(){
	img1.setAttribute("src", imgArr1[count1]);
	if(++count1 === imgArr1.length){
		count1 = 0;
	}
});

var count2 = 1;

but2.addEventListener("click", function(){
	img2.setAttribute("src", imgArr2[count2]);
	if(++count2 === imgArr2.length){
		count2 = 0;
	}
});