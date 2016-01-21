var wastedMoney = 0;

var addWastedMoney = function addWastedMoney(newCost) {
    wastedMoney = parseFloat((wastedMoney + newCost).toFixed(2))
};

var getDataForGames = function getDataForGames(gameIds) {
    var source   = $("#gameTemplate").html();
    var template = Handlebars.compile(source);
    var table = $('#games tbody');

    gameIds.forEach(function(value) {
        $.get("/results/"+value, function(data) {
            addWastedMoney(data.cost);
            $('#waste').text(wastedMoney);

            table.append(template(data))
        })
    })
};