var wastedMoney = 0;
var count = 0;

var addWastedMoney = function addWastedMoney(newCost, totalGames) {
    wastedMoney = parseFloat((wastedMoney + newCost).toFixed(2))
    $('#waste').text(wastedMoney);
    count += 1;
    if(count == totalGames) {
        $('#placeholder').remove();
    }
};

var getDataForGames = function getDataForGames(gameIds) {
    var source   = $("#gameTemplate").html();
    var template = Handlebars.compile(source);
    var table = $('#games tbody');

    gameIds.forEach(function(value) {
        $.get("/results/"+value, function(data) {
            addWastedMoney(data.cost, gameIds.length);
            table.append(template(data))
        })
    })
};