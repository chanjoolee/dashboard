/*==================================================================================
 UI & design consuting - FOR C&C (주)에프오알씨앤씨 - UI Creative Team 
www.forcnc.co.kr  / (02)322-0637
jquery.ui.js
==================================================================================*/

/*===========================================
GNB, gnb, Footer, GNB sub tab(Master tab)
===========================================*/
//layout
$(document).ready(function(){
    setLayout();
    fn_layout_setTimeout();
    $(window).resize(function(){
        setLayout();
        fn_layout_setTimeout();
    });
});
function setLayout(){
    //높이 설정
    $('#lay_container').css('height', 'auto' );
    $('#lay_wrap.lay_expand_cover #lay_gnb').css('height', 'auto' );
    if ( window.innerHeight < $(document).height() ){ //브라우저가 html 보다 height가 작을 때
        if ( $('#lay_gnb').outerHeight() > $('#lay_contents').outerHeight() ){ //gnb가 contents보다 height가 클 때
            $('#lay_wrap.lay_expand_cover #lay_gnb').css('height', $('.gnb_wrap').outerHeight());
            $('#lay_container').css('height', $('.gnb_wrap').outerHeight() );
        } else { //contents가 gnb보다 height가 클 때
            $('#lay_container').css('height', $('#lay_contents').outerHeight() );
            $('#lay_wrap.lay_expand_cover #lay_gnb').css('height', $('#lay_contents').outerHeight());
        }
    } else { //브라우저가 html보다 height가 클 때
        $('#lay_container').css('height', $(window).height() );
        $('#lay_wrap.lay_expand_cover #lay_gnb').css('height', $(window).height() );
    }
}
//처음 화면 로드시
var layout_timeout;
var cnt = 0;
function fn_layout_setTimeout() {
    if (cnt > 5) {
        clearTimeout(layout_timeout);
    }
    else {
        setLayout();
        layout_timeout = setTimeout(fn_layout_setTimeout, 500);
        cnt++;
    }
}


// gnb sub tab & master tab
// * obj : 요소명 ('#id', '.class')
function tabMove(obj){
    var $obj = $(obj),
        $tab_list = $obj.find('.tab_list');
    $obj.find('.btn_tab_right').click(function(e){
        if ( - $tab_list.width() + $obj.find('.tab_list_wrap').width() < parseFloat($tab_list.css('margin-left')) ) {
            $tab_list.animate({
                'margin-left': '-=100'
            }, 100);
        }
        e.stopPropagation();
    });
    $obj.find('.btn_tab_left').click(function(e){
        if ( parseFloat( $tab_list.css('margin-left') ) < 0 ){
            $tab_list.animate({
                'margin-left': '+=100'
            }, 100);
        }
        e.stopPropagation();
    });
}

//gnb Fold
// * 함수 : gnbFold(ani, gnbW, gnbMargin, status)
// * ani(슬라이드 방식) : 'slide' / 'cover'
// * gnbW(gnb 너비) : 정수
// * gnbMargin(gnb와 Contents 사이 여백) : 정수. 여백이 없다면 0
// * status(초기 gnb fold 여부 세팅) : true(접혀있는 상태) / false(펼쳐진 상태)
function gnbFold(ani, gnbW, gnbMargin, status, btnTop) {
	var _gnbW = gnbW,
		_gnbMargin =_gnbW+gnbMargin,
		_btnTop = btnTop,
		_gnbTop = $("#lay_container").offset().top+_btnTop;
	
	//초기 세팅
	$("#lay_gnb .gnb_wrap").css('width', _gnbW+'px');
	if(ani == 'cover'){
		var _bwHeight = $(window).height() - $('#lay_header').height();
		$('#lay_gnb').css('margin-top', $("#lay_container").offset().top ).css('min-height', _bwHeight);
		$(window).resize(function(){
			_bwHeight = $(window).height() - $('#lay_header').height();
			$('#lay_gnb').css('min-height', _bwHeight);
		});
	};
	if(status == true){
		$("body").removeClass("unfolded");
		$("body").addClass("folded");
		$("#lay_gnb").css('width', '0');
		$(".gnb_basic .gnb_wrapper").css('width', '0');
		if(ani == 'slide'){
			$("#lay_contents").css('marginLeft', '0');
			$('.btn_folder_wrap').css('top',_gnbTop);
		};
		gnbFolded();
	} else {
		$("#lay_gnb").css('width', _gnbW);
		//혜미 - false slide일때 설정
		if(ani == 'slide'){
			$("#lay_contents").css('marginLeft', _gnbMargin);
		};
	};
	
	$(".gnb_btn_folder").bind("click", function() {
		if($("#lay_gnb").width()<100) {
			gnbUnfolded();
		} else {
			gnbFolded();
		}
	});
	function gnbFolded() {
		$("body").removeClass("unfolded");
		$("body").addClass("folded");
		$('.btn_folder_wrap').css('visibility', 'hidden');
		$("#lay_gnb").animate({'width':'0'});
		$(".gnb_basic .gnb_wrapper").animate({
			'width':'0'
		}, function(){
			$('.btn_folder_wrap').css('visibility', 'visible');
		});
        $('.lower_menu_box').animate({
            'opacity': 0,
            'width':'0'
        });
		if(ani == 'slide'){
			$("#lay_contents").animate({
				'marginLeft':'0'
			}, function(){
				$('.btn_folder_wrap').css({
					'position':'fixed',
					'left':0,
					'top':_gnbTop
				});
			});
            $('#lay_wrap').not('.lay_100').find(".contents_wrap").animate({
                'width':'1280'
            });
            $('#lay_wrap').not('.lay_100').find(".tab_master_wrap").animate({
                'width':'1250'
            });
		} else if(ani == 'cover'){
			
		};
	}
	function gnbUnfolded() {
		$("body").addClass("unfolded");
		$("body").removeClass("folded");
		$("#lay_gnb").animate({'width':_gnbW});
		$(".gnb_basic .gnb_wrapper").animate({
			'width':_gnbW
		}, function(){
			$('.btn_folder_wrap').css('visibility', 'visible');
		});
		if(ani == 'slide'){
			$('.btn_folder_wrap').css({
				'position':'absolute',
				'left':'auto',
				'top':_btnTop,
				'visibility':'hidden'
			});
			$("#lay_contents").animate({
                'marginLeft':_gnbMargin,
            });
            $('#lay_wrap').not('.lay_100').find(".contents_wrap").animate({
                'width':1070
            });
            $('#lay_wrap').not('.lay_100').find(".tab_master_wrap").animate({
                'width':1040
            });
		};
	}
};

//gnb Menu
// * 함수 : gnbSet(gnbtype)
// * gnbtype : gnb 타입 : 'basic'
function gnbSet(gnbtype){
    // 배경색 적용
    $('#lay_gnb').css('background-color', $('.gnb_basic').css('background-color'));

    // lower_menu가 있을 경우, bullet표시 및 오른쪽 메뉴 열림
    var toggleRight = "<span class='btn_sub_menu'><span class='gnb_basic_ico gnb_basic_ico_right'></span></span>";

    $('.gnb_basic').each(function(){
        $(this).find('.lower_menu_box').closest('.gnb_list').find('>.gnb_link').prepend(toggleRight);
    });

    $('.gnb_basic .gnb_link.depth1').click(function(e){
        var $list = $(this).closest('.gnb_list');
        if ( $list.hasClass('active') ){
            $list.removeClass('active');
            $list.find('.lower_menu_box').animate({'width':'0', 'opacity':'0'}, 200); 
            lowermenuClose( $list.find('.lower_menu_box') );
        } else {
            $list.addClass('active');
            lowermenuClose( $list.siblings('.active').find('.lower_menu_box') );
            $list.siblings().removeClass('active');
            $list.find('.lower_menu_box').animate({'width':'250', 'opacity':'1'}, 200); 
            $list.siblings().find('.lower_menu_box').animate({'width':'0', 'opacity':'0'}, 200); ;
        }
        e.stopPropagation();
    });

    // lower_menu_box의 close버튼 클릭시 lower_menu_box 닫힘
    $('.btn_lower_menu_close').click(function(){
        $(this).closest('.lower_menu_box').animate({'width':'0', 'opacity':'0'}, 200);
        $(this).closest('.gnb_list').removeClass('active');
        $(this).closest('.lower_menu_box').find('ul').not('.gnb_depth2').hide();
        lowermenuClose( $(this).closest('.lower_menu_box') )
    });

    // 하위메뉴 보기 클릭시 하위메뉴 열리고 아이콘 변경
    var toggleDown = "<span class='btn_lower_menu'><span class='gnb_basic_ico gnb_basic_ico_down'></span></span>",
        gnbH = $('#lay_gnb').outerHeight();
    $('.lower_menu_box .gnb_depth2 ul').closest('.gnb_list').find('>.gnb_link').prepend(toggleDown);
    $('.lower_menu_box .gnb_link').click(function(e){
        var $list = $(this).closest('.gnb_list');
        if ( $list.find('ul').length > 0) {
            if ( $list.hasClass('open') ){
                $list.removeClass('open');
                $(this).find('.gnb_basic_ico').addClass('gnb_basic_ico_down').removeClass('gnb_basic_ico_up');
                $(this).siblings('ul').slideUp(200);
                $(this).siblings('ul').find('ul').slideUp(200);
                                $(this).siblings('ul').find('.gnb_basic_ico').removeClass('gnb_basic_ico_up').addClass('gnb_basic_ico_down');
                $(this).siblings('ul').find('.gnb_list').removeClass('open');

            } else {
                $list.addClass('open');
                $(this).find('.gnb_basic_ico').removeClass('gnb_basic_ico_down').addClass('gnb_basic_ico_up');
                $(this).siblings('ul').slideDown(200);
            }
            lowermenuScroll();   
        }
        e.stopPropagation();
    });
};
function lowermenuScroll(){
    var extraH = $('.gnb_tit').outerHeight() + $('.lower_ban_section').outerHeight(),
        maxH = $('#lay_gnb').outerHeight() - extraH - 80; //숫자는 .lower_menu_wrap의 padding과 .lower_ban_section의 margin
    $('.lower_gnb_section').css('max-height', maxH);
}
function lowermenuClose(obj){
    var $obj=$(obj);
    $obj.find('.gnb_basic_ico').removeClass('gnb_basic_ico_up').addClass('gnb_basic_ico_down');
    $obj.find('ul').not('.gnb_depth2').slideUp(200);
    $obj.find('.gnb_list').removeClass('open');
}

// Layer Select (hover)
// Location information (selective type)에 적용
// * obj : 요소명 ('#id', '.class')
function layer_select(obj){
    $obj = $(obj);
	$obj.bind({
		mouseenter: function() {
			$(this).children('.layer_selector_box').slideDown(300);
			$(this).children('.layer_selector').addClass('active');
		},
		mouseleave: function() {
			$(this).children('.layer_selector_box').slideUp(200);
			$(this).children('.layer_selector').removeClass('active');
		}
	});
};

// Layer Select Click 
// 통합검색 페이지의 고급검색, footer의 family site, gnb의 select 에 적용
// * obj : 요소명 ('#id', '.class')
function layer_select_click(obj) {
	var $obj = $(obj);
	$obj.children(".layer_selector").click(function(e){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			$obj.children(".layer_selector_box").fadeOut();
		} else {
			$(this).addClass("active");
			$obj.children(".layer_selector_box").fadeIn();
		};
        e.stopPropagation();
	});
	$obj.find(".btn_layer_close").click(function(){
		$obj.children(".layer_selector_box").fadeOut();
		$obj.children(".layer_selector").removeClass("active");
	});
    $(window).click(function(){
        $obj.find('.layer_selector').removeClass('active');
        $obj.children(".layer_selector_box").fadeOut();
    });
};



/*===========================================
Popup
===========================================*/
//layer popup setting
function mw_set(mw_name){
	var mw_name = $('.' + mw_name);

	$('#mw').css('display', 'none');
	mw_name.css('display', 'none');
};

//layer popup Open/Close
function layer_open(mw_id){
	var mw_id = $('#' + mw_id),
		bg = mw_id.parents('pop_bg');

	if(bg){
		$('#mw').fadeIn();	
		mw_id.fadeIn();
	}else{
		mw_id.fadeIn();
	};
	
	mw_id.css('display', 'block');
	
	if ( mw_id.outerHeight() < $(document).height() ){
        mw_id.css("top", Math.max(0, (($(window).height() - $(mw_id).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	}else{
		mw_id.css('top', '0px');
	};
	
	mw_id.find('.close_area').click(function(e){
		if(bg){
			$('#mw').fadeOut();
			mw_id.fadeOut();
		}else{
			mw_id.fadeOut();
		}
		e.preventDefault();
	});

	$('#mw .pop_bg').click(function(e){	
		$('#mw').fadeOut();
		mw_id.fadeOut();
		e.preventDefault();
	});
};

//GNB Popup
function pop_gnb(){
	$('.pop_gnb').hide().slideDown();
	$('.pop_gnb .close_area').click(function(){
		$('.pop_gnb').slideUp();
	});
};

//Window popup
function window_open(url, w, h, l, t, target){
	window.open(url,target,"'scrollbars=auto,toolbar=no,menubar=no,location=no,status=no,resizable=no,fullscreen=no,channelmode=no,width="+w+",height="+h+",left="+l+",top="+t+"'");
};


/*===========================================
Board
===========================================*/
//Schedule Layout
function schedule_layout(){
    $('.schedule_t_row_schedule').each(function(index){
        var dataHeight = Math.round( $(this).children('.schedule_data').height() ),
        	dataTop = $(this).children('.schedule_list').offset.top;
        $(this).find('.schedule_data .grid_wrap').css('height', dataHeight+'px');
    });
};

//Timeline
function timeline(){
	var objMargin = 15,
		prevIndex,//전전 요소
		prevIndex2,//전 요소
		prevTop,
		prevTop2,
		prevHeight,
		prevHeight2,
		objTop;
	$('.timeline_list_area .timeline_list').each(function(index){
		if(index==0){//0번째
			$(this).css('top', '0');
			$(this).addClass('t_left');
		} else if(index==1){//1번째
			var objTop = objMargin + 35 +"px";
			$(this).css('top', objTop);
			$(this).addClass('t_right');
		} else{
			prevTop = $('.timeline_list_area .timeline_list').eq(prevIndex).position();
			prevTop2 = $('.timeline_list_area .timeline_list').eq(prevIndex2).position();
			prevHeight = $('.timeline_list_area .timeline_list').eq(prevIndex).height();
			prevHeight2 = $('.timeline_list_area .timeline_list').eq(prevIndex2).height();

			if(prevTop.top+prevHeight < prevTop2.top+prevHeight2){
				objTop = prevTop.top+prevHeight+objMargin;
				if($('.timeline_list_area .timeline_list').eq(prevIndex2).hasClass('t_left') == true){
					$(this).addClass('t_right');
				}else{
					$(this).addClass('t_left');
				};
			}else if(prevTop.top+prevHeight > prevTop2.top+prevHeight2){
				objTop = prevTop2.top+prevHeight2+objMargin;
				$(this).addClass('t_right');
				if($('.timeline_list_area .timeline_list').eq(prevIndex2).hasClass('t_left') == true){
					$(this).addClass('t_right');
				}else{
					$(this).addClass('t_left');
				};
			}else{
				objTop = prevTop.top+prevHeight+objMargin;
				$(this).addClass('t_left');
			};
			$(this).css('top', objTop+'px');
		};
		prevIndex = index-1;
		prevIndex2 = index;
	});
	var boxHeight = $('.timeline_list:last-child').position().top+$('.timeline_list:last-child').height()+objMargin;
	$('.timeline_list_area').css('height', boxHeight+'px').css('visibility', 'visible');
    setLayout();
};

// filter
function filter(){
    $('.btn_filter').click(function(){
        var $filter = $(this).siblings('.filter');
        $filter.css({
            'display' :'block',
            'top' : $(this).offset().top - $('#lay_header').outerHeight() + $(this).outerHeight() + 5
        });
    });
    $('.btn_filter_close').click(function(){
        $(this).closest('.filter').css('display', 'none'); 
    });
};

// List board - 정렬
function listArray(obj){
    var $obj = $(obj);
    // board_array_anchor 클릭 시, array_list 보여주고 화살표 모양 변경
    $obj.find('.board_array_anchor').click(function(e){
        if ( $(this).siblings('.array_list').css('display') == 'block' ){
            $(this).siblings('.array_list').fadeOut(200).removeClass('active');
            $obj.find('.board_list_ico').addClass('board_list_ico_arrow_down').removeClass('board_list_ico_arrow_up');
        } else {
            $(this).siblings('.array_list').fadeIn(200).addClass('active');
            $obj.find('.board_list_ico').removeClass('board_list_ico_arrow_down').addClass('board_list_ico_arrow_up');
        }
        e.stopPropagation();
    });
    // array_list 닫고 화살표 모양 변경
    $obj.find('.array_item').click(function(e){
        $(this).closest('.array_list').fadeOut(200).removeClass('active');
        $obj.find('.board_list_ico').addClass('board_list_ico_arrow_down').removeClass('board_list_ico_arrow_up');
        e.stopPropagation();
    });
    $(window).click(function(e){
        if ( $('.array_list').hasClass('active') ){
            $('.array_list').fadeOut(200).removeClass('active'); 
            $obj.find('.board_list_ico').addClass('board_list_ico_arrow_down').removeClass('board_list_ico_arrow_up');
        };
        e.stopPropagation();
    });
}

// List board - inner
function listInner(){
    $('.expandable_link').click(function(){
        var $exp_row = $('tr[name=' + $(this).attr('id') + ']');
        if ( $exp_row.hasClass('active') ){
            $exp_row.removeClass('active').css('display', 'none');
        } else {
            $exp_row.addClass('active').css('display', 'table-row');
        }
    });
}

// List board - fold
function listFold(){
    $('.expandable_link').click(function(){
        if ( $(this).closest('.board_list_row').hasClass('active') ) {
            $(this).closest('.board_list_row').removeClass('active');
            $(this).closest('.board_list_row').find('.exp_body').slideUp(200);
            $(this).find('.board_exp_ico').addClass('board_exp_ico_plus').removeClass('board_exp_ico_minus');
        } else {
            $(this).closest('.board_list_row').addClass('active');
            $(this).closest('.board_list_row').find('.exp_body').slideDown(200);
            $(this).find('.board_exp_ico').addClass('board_exp_ico_minus').removeClass('board_exp_ico_plus');
        }
    });
}

// List board - option
function listOption(){
    $('.expandable_btn').click(function(){
        var $exp_row = $('tr[name=' + $(this).attr('id') + ']'),
            tri = "<span class='tri'></span>";
        if ( $exp_row.hasClass('active') ){
            $exp_row.removeClass('active').css('display', 'none');
            $(this).find('.board_exp_ico').addClass('board_exp_ico_close').removeClass('board_exp_ico_open');
            $(this).find('.tri').detach();
        } else {
            $exp_row.addClass('active').css('display', 'table-row');
            $(this).find('.board_exp_ico').removeClass('board_exp_ico_close').addClass('board_exp_ico_open');
            $(this).append(tri);
        }
    });
}


/*===========================================
기타
===========================================*/
//Tab menu
// * obj : Tab 요소('#id', '.class')
// * viewact : 탭 콘텐츠영역 여부(true/false)
// * subtab : 서브탭 여부(true/false)
function tab_view(obj,viewact,subtab){
	var $obj = $(obj),
		viewact = viewact,
		subtab = subtab;
    $('.tab_contents_wrap[rel="'+ $obj.attr('id') +'"]').find('> .tab_contents').hide();
	if(viewact==true && subtab!==true){
		$('.tab_contents_wrap[rel="'+ $obj.attr('id') +'"]').find(".tab_contents:first").show();
	};
    
	if(subtab==true){ // 서브탭이 있을 경우
		var selSubTab = $('.tab_list:first').attr("rel");
        if ( $obj.find('.tab_sub_item').hasClass('selected') ){ //서브 탭(tab_sub_item)이 선택된 경우
            var itemRel = $obj.find('.tab_sub_item.selected').find('.tab_sub_link').attr('rel');
            $obj.find('.tab_sub_item.selected').closest('.tab_sub_area').show();
            $("#"+itemRel).fadeIn();
        } else if ( $obj.find('.tab_item').hasClass('selected') ){ //탭(tab_item)이 선택된 경우
            var itemRel = $obj.find('.tab_item.selected').find('.tab_link').attr('rel');
            $("#"+itemRel).fadeIn();
        } else if ( $obj.find('.tab_item:first-child').attr('rel') == $obj.find('.tab_sub_area').attr('id') ){ //아무것도 선택되지 않았을 때, 첫번 탭 메뉴의 서브탭이 있는 경우
            $obj.find('.tab_item:first-child').addClass('selected');
            $("#"+ $obj.find('.tab_item:first-child').attr('rel')).show();
            $("#"+ $obj.find('.tab_item:first-child').attr('rel')).find('.tab_sub_item:first-child').addClass('selected')
            $('.tab_contents_wrap[rel="'+ $obj.attr('id') +'"]').find(".tab_contents:first").show();
        } else { //아무것도 선택되지 않았을 때, 첫번 탭 메뉴의 서브탭이 없는 경우
            $obj.find('.tab_item:first-child').addClass('selected');
            $('.tab_contents_wrap[rel="'+ $obj.attr('id') +'"]').find(".tab_contents:first").show();
        }
        
        $obj.find(".tab_link").click(function () {
            var $item = $(this).closest('.tab_item'),
                itemRel = $(this).attr('rel'),
                subTabAreaRel = $item.attr('rel');
            $item.addClass('selected');
            $item.siblings('.tab_item').removeClass('selected');
            $obj.find('.tab_sub_area').hide();
            $('#'+subTabAreaRel).fadeIn(200);
            $('#'+itemRel).siblings('.tab_contents').hide();
            $('#'+itemRel).fadeIn(200);
            
            var subTabConRel = $('#'+subTabAreaRel).find('.tab_sub_item:first-child .tab_sub_link').attr('rel');
            $obj.find('.tab_sub_item').removeClass('selected')
            $('#'+subTabAreaRel).find('.tab_sub_item:first-child').addClass('selected');
            $('#'+subTabConRel).siblings('.tab_contents').hide();
            $('#'+subTabConRel).fadeIn(200);
        });
        $obj.find(".tab_sub_link").click(function () {
            var $item = $(this).closest('.tab_sub_item'),
                itemRel = $(this).attr('rel');
            $item.addClass('selected');
            $item.siblings('.tab_sub_item').removeClass('selected');
            $('#'+itemRel).siblings('.tab_contents').hide();
            $('#'+itemRel).fadeIn(200);
        });
	}else{ // 서브 탭이 없을 경우
        if ($obj.find('.tab_item').hasClass('selected') == false){
            $obj.find('.tab_item:first-child').addClass('selected');
        };
        $("#"+ $obj.find('.tab_item.selected .tab_link').attr('rel')).show();        
		$obj.find(".tab_link").click(function () {
			var $item = $(this).closest('.tab_item'),
                itemRel = $(this).attr('rel');
            $item.addClass('selected');
            $item.siblings('.tab_item').removeClass('selected');
            $('#'+itemRel).siblings('.tab_contents').hide();
            $('#'+itemRel).fadeIn(200);
		});
	};
};

//Step : 진행 완료되었거나 진행중인 스텝만 이동 가능
// * obj : Tab 요소('#id', '.class')
// 클래스 : completed - 완료된 스텝, ongoing - 진행 중인 스텝, active - 사용자가 클릭한 스텝 
function step_view(obj){
	var $obj = $(obj),
		currentIndex = 0,
        ongoingIndex = $obj.find(".step_list").index($obj.find(".step_list.ongoing"));
    
    $('.step_contents_wrap[rel="'+ $obj.attr('id') +'"]').find('.step_contents').hide();
    $('.step_contents_wrap[rel="'+ $obj.attr('id') +'"]').find(".step_contents").eq(ongoingIndex).show();
	$obj.find(".step_link").click(function () {
		if( $(this).closest('.step_list').hasClass("completed")==true || $(this).closest('.step_list').hasClass("ongoing")==true ){
	        currentIndex = $(this).closest(".step_list").index();
			$(this).closest('.step').find('.step_list').removeClass("active");
	        $(this).closest('.step').find('.step_list').eq(currentIndex).addClass("active");
	        $('.step_contents_wrap[rel="'+ $obj.attr('id') +'"]').find('.step_contents').hide();
	        var activeTab = $(this).attr("rel");
	        $("#" + activeTab).fadeIn();
		};
    });
};

//treemenu
// * obj : Tab 요소('#id', '.class')
function tree(obj){ 
    $tree = $(obj);
    var togglePlus = "<button class='toggle plus'></button>",
        toggleMinus = "<button class='toggle minus'></button>";
    
    //default
    $tree.find('li:last-child').addClass('last');
    $tree.find('ul').siblings('.tree_item_wrap').prepend(togglePlus);
    $tree.find('.toggle').siblings('a').find('.ico').addClass('folder');
    
    //open 되어있는 li가 있을 경우
    $tree.find('.tree_item.open').parents('.tree_item').addClass('open');
    $tree.find('.tree_item.open').find('>ul').css('display', 'block');
    $tree.find('.tree_list').each(function(){
        if ( $(this).css('display') == 'block' ){
            $(this).siblings('.tree_item_wrap').find('.toggle').removeClass('plus').addClass('minus');
            $(this).siblings('.tree_item_wrap').find('.ico').removeClass('folder').addClass('folder_open')
        };
    });
    
    //click toggle
    $tree.find('.toggle').click(function(e){
        var $item = $(this).closest('.tree_item'),
            $ico = $(this).siblings('a').find('.ico');
        $item.toggleClass('open');
        if ( $item.hasClass('open') ){
            $(this).removeClass('plus').addClass('minus');
            $ico.removeClass('folder').addClass('folder_open');
            $item.find('>ul').slideDown(200);
        } else {
            $(this).removeClass('minus').addClass('plus');
            $ico.removeClass('folder_open').addClass('folder');
            $item.find('>ul').slideUp(200);
        }
        e.stopPropagation();
    });
};

//Sidebar
// * obj : Tab 요소('#id', '.class')
function sidebar(obj){
    var $obj = $(obj);
    $obj.find('.tab_contents').hide();
    $obj.find('.tab_contents:first').show();
    
    $obj.find(".tab_list_link").click(function () {
		$obj.find('.tab_list').removeClass("selected");
		$(this).parent().addClass("selected");
		$obj.find(".tab_contents").hide();
		var activeTab = $(this).attr("rel");
		$("#" + activeTab).fadeIn();
	});
    
    //우측슬라이드 
	var $slide = $obj.find(".slidebar_smart_slide"),
		$con1 = $obj.find(".sidebar_contents_area1"),
		$con2 = $obj.find(".sidebar_contents_area2"),
		$bg = $obj.find("#sidebar_smart_bg"),
		$showbtn1 = $obj.find(".tab_smart_1"),
		$showbtn2 = $obj.find(".tab_smart_2"),
		$slidebox = $obj.find(".slide_wrap");
	$obj.find(".tab_smart").bind("click", function(e) {
		if($(this).hasClass("selected")){
			$(this).removeClass("selected");
			menuSlideClose();
            e.stopPropagation();
		}else{
			$obj.find(".tab_smart").removeClass("selected");
			$(this).addClass("selected");
			menuSlideOpen($(this));
            e.stopPropagation();
		};
	});
    
    function menuSlideOpen(tabName){
		var $tabName = tabName,
			$actCon = $tabName.attr("rel");
		if($slidebox.width()<200) {
			$obj.find("#sidebar_smart_bg").fadeIn();
			$("body").scrollTop(0);
			$("html").css("overflow", "hidden");
			$("#" + $actCon).show();
			$slidebox.animate({
				width: "425"
			}, 300);
		} else {
			$slidebox.children(".sidebar_contents_area").hide();
			$("#" + $actCon).fadeIn();
		};
	};
	function menuSlideClose(){
		$obj.find("#sidebar_smart_bg").fadeOut();
		$("html").css("overflow", "auto");
		$slidebox.animate({
			width: "0"
		}, 300, function() {
			$slidebox.children(".sidebar_contents_area").hide();
            $obj.find(".tab_smart").removeClass("selected");
		});
	};
    $('#sidebar_smart_bg').click(function(){
        menuSlideClose();
    });
}

//Unified Search LNB
// * 함수 : lnbSet(obj)
// * obj : 통합검색 LNB ('#id', '.class')
function lnbSet(obj){
    var toggleUp = "<span class='lnb_srch_ico lnb_srch_ico_up'></span>",
        $obj = $(obj);
    $obj.find('.lnb_list.depth3').addClass('open');
    $obj.find('ul').siblings('.lnb_link').prepend(toggleUp);
    $obj.find('.lnb_link').click(function(e){
        var $list = $(this).closest('.lnb_list');
        if ( $list.hasClass('open') ){
            $list.removeClass('open');
            $(this).find('.lnb_srch_ico').removeClass('lnb_srch_ico_up').addClass('lnb_srch_ico_down');
            $(this).closest('.lnb_link').siblings('ul').slideUp(200);
            $(this).closest('.lnb_link').siblings('ul').find('ul').slideUp(200);
        } else {
            $list.addClass('open');
            $(this).find('.lnb_srch_ico').addClass('lnb_srch_ico_up').removeClass('lnb_srch_ico_down');
            $(this).siblings('ul').slideDown(200);
        }   
        e.stopPropagation();     
    });
};
