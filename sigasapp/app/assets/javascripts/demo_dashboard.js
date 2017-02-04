$(function(){        
    /* reportrange */
    if($("#reportrange").length > 0){   
        $("#reportrange").daterangepicker({                    
            ranges: {
               'Today': [moment(), moment()],
               'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
               'Last 7 Days': [moment().subtract(6, 'days'), moment()],
               'Last 30 Days': [moment().subtract(29, 'days'), moment()],
               'This Month': [moment().startOf('month'), moment().endOf('month')],
               'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            },
            opens: 'left',
            buttonClasses: ['btn btn-default'],
            applyClass: 'btn-small btn-primary',
            cancelClass: 'btn-small',
            format: 'MM.DD.YYYY',
            separator: ' to ',
            startDate: moment().subtract('days', 29),
            endDate: moment()            
          },function(start, end) {
              $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        });
        
        $("#reportrange span").html(moment().subtract('days', 29).format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
    }
    /* end reportrange */
    
    /* Donut dashboard chart */
    Morris.Donut({
        element: 'dashboard-donut-1',
        data: [
            {label: "Returned", value: 2513},
            {label: "New", value: 764},
            {label: "Registred", value: 311}
        ],
        colors: ['#33414E', '#1caf9a', '#FEA223'],
        resize: true
    });
    /* END Donut dashboard chart */
	
	
    /* Bar dashboard chart */
    Morris.Bar({
        element: 'dashboard-bar-1',
        data: [
            { y: 'Oct 10', a: 75, b: 35 },
            { y: 'Oct 11', a: 64, b: 26 },
            { y: 'Oct 12', a: 78, b: 39 },
            { y: 'Oct 13', a: 82, b: 34 },
            { y: 'Oct 14', a: 86, b: 39 },
            { y: 'Oct 15', a: 94, b: 40 },
            { y: 'Oct 16', a: 96, b: 41 }
        ],
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['New Users', 'Returned'],
        barColors: ['#33414E', '#1caf9a'],
        gridTextSize: '10px',
        hideHover: true,
        resize: true,
        gridLineColor: '#E5E5E5'
    });
    /* END Bar dashboard chart */
    
    /* Line dashboard chart */
    Morris.Line({
      element: 'dashboard-line-1',
      data: [
        { y: '2014-10-10', a: 2,b: 4},
        { y: '2014-10-11', a: 4,b: 6},
        { y: '2014-10-12', a: 7,b: 10},
        { y: '2014-10-13', a: 5,b: 7},
        { y: '2014-10-14', a: 6,b: 9},
        { y: '2014-10-15', a: 9,b: 12},
        { y: '2014-10-16', a: 18,b: 20}
      ],
      xkey: 'y',
      ykeys: ['a','b'],
      labels: ['Sales','Event'],
      resize: true,
      hideHover: true,
      xLabels: 'day',
      gridTextSize: '10px',
      lineColors: ['#1caf9a','#33414E'],
      gridLineColor: '#E5E5E5'
    });   
    /* EMD Line dashboard chart */
    /* Moris Area Chart */
      Morris.Area({
      element: 'dashboard-area-1',
      data: [
        { y: '2014-10-10', a: 17,b: 19},
        { y: '2014-10-11', a: 19,b: 21},
        { y: '2014-10-12', a: 22,b: 25},
        { y: '2014-10-13', a: 20,b: 22},
        { y: '2014-10-14', a: 21,b: 24},
        { y: '2014-10-15', a: 34,b: 37},
        { y: '2014-10-16', a: 43,b: 45}
      ],
      xkey: 'y',
      ykeys: ['a','b'],
      labels: ['Sales','Event'],
      resize: true,
      hideHover: true,
      xLabels: 'day',
      gridTextSize: '10px',
      lineColors: ['#1caf9a','#33414E'],
      gridLineColor: '#E5E5E5'
    });
    /* End Moris Area Chart */
    
    
    $(".x-navigation-minimize").on("click",function(){
        setTimeout(function(){
            rdc_resize();
        },200);    
    });
});

function notyConfirm(url){
    noty({
        text: 'Deseja confirmar esta operação?',
        layout: 'center',
        buttons: [
                {addClass: 'btn btn-success btn-clean', text: 'Sim', onClick: function($noty) {
                    $noty.close();
                    window.location= url ; 
                }
                },
                {addClass: 'btn btn-danger btn-clean', text: 'Cancelar', onClick: function($noty) {
                    $noty.close();
                    }
                }
            ]
    })                                                    
}
/* ASSOCIATES VIEW */
  function checkDirectionRole(){
    if ($("#role").val() == "" || $("#biennium").val() == "") {
      $("#saveDirectionRoleBtn").attr("disabled", true);
    } else {
      $("#saveDirectionRoleBtn").attr("disabled", false);
    }
  }
  
  function checkDependentForm(){
    if ($("#name").val() == "" || $("#bond").val() == "") {
      $("#saveDependentFormBtn").attr("disabled", true);
    } else {
      $("#saveDependentFormBtn").attr("disabled", false);
    }
  }      

  function loadSocialTab(id){
    $.ajax({
      url: "/direction-roles/" + id,
      success: function(response){
        directionFunctions = "";
        for (role in response) {
          if (role == 4) {
            directionFunctions += '...';
            break;
          } else {
            if (role > 0) directionFunctions += ', ';
            
          }
          directionFunctions += response[role].role + " (" + response[role].biennium + ")" ;
        }
        $("#direction_roles").text(directionFunctions);
      },
    });
    
    /* Buscar a lista de nomes dos sócios dependentes */
    $.ajax({
      url: "/associate-dependents/",
      success: function(response){
        var availableDependents = [];
        for (associate in response) {
          tmp = response[associate].registration + ' - ' + response[associate].name;
          availableDependents.push(tmp);
        }
        var dependens = new autoComplete({
          selector: '#name',
          minChars: 3,
          source: function(term, suggest){
              term = term.toLowerCase();
              var choices = availableDependents;
              var suggestions = [];
              for (i=0;i<choices.length;i++)
                  if (~choices[i].toLowerCase().indexOf(term)) suggestions.push(choices[i]);
              suggest(suggestions);
          }
        });
      },
    });
    
    /* Buscar Dependents */
    $.ajax({
      url: "/associate-dependents/" + id,
      success: function(response){
        var dependentsHtml = "";
        for (dependent in response) {
          dependent = response[dependent];//....
          dependentsHtml += '<div class="col-md-2 col-xs-2">' +
                            ' <div class="friend">' +
                            '   <img src="' + dependent[2] + '" >' +
                            '   <span> ' + dependent[0] + ' (' + dependent[1] + ') </span>' +
                            '   <a href="' + dependent[3] + '"><button class="btn btn-default btn-sm"> Ver </button></a>' +
                            '   <button onclick="notyConfirm(\'' + dependent[4] + '\');" class="btn btn-danger btn-sm"> Remover </button>' +
                            ' </div>' +                                            
                            '</div>';
        }
        $("#dependents_cards").html(dependentsHtml);
      },
    });
    
  }
  
  function loadFinancialTab(id){
    year = $("#date_year").val();
    $.ajax({
      url: "/associate-charges/" + id + '/' + year,
      success: function(response){
        var chargesHtml = "";
        for (charge in response) {
          charges = response[charge];//....
          chargesHtml += '<tr>' +
                         ' <td>' + charges[0] + '</td>' +
                         ' <td>' + charges[1] + '</td>' +
                         ' <td>' + charges[2] + '</td>' +
                         ' <td>' + charges[3] + '</td>' +
                         ' <td>' +
                         '  <a href="' + charges[4] + '"><button class="btn btn-default btn-sm"> Ver </button></a>' +
                         '  <button onclick="notyConfirm(\'' + charges[5] + '\');" class="btn btn-danger btn-sm"> Remover </button>' +
                         ' </td>' +
                         '</tr>';
        }
        $("#associate_charges_list").html(chargesHtml);
      },
    });
  }
  
  
  
  function manageDirectionRole(id){
    $.ajax({
      url: "/direction-roles/" + id,
      success: function(response){
        directionFunctions = "";
        for (role in response) {
          directionFunctions += '<button onclick="notyConfirm(\'/remove-direction-role/' + id + '/' + response[role].id + '\');" class="btn btn-link"> x </button>';
          directionFunctions += response[role].role + " (" + response[role].biennium + ")  <br />" ;
        }
        $("#direction_roles_list").html(directionFunctions);
      },
    });
  }
  
  function addDepentent(id){
    $.ajax({
      url: "/direction-roles/" + id,
      success: function(response){
        directionFunctions = "";
        for (role in response) {
          directionFunctions += '<button onclick="notyConfirm(\'/remove-direction-role/' + id + '/' + response[role].id + '\');" class="btn btn-link"> x </button>';
          directionFunctions += response[role].role + " (" + response[role].biennium + ")  <br />" ;
        }
        $("#direction_roles_list").html(directionFunctions);
      },
    });
  }
/* ASSOCIATES VIEW END */       
