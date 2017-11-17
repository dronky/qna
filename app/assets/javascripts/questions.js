$(document).on('turbolinks:load', function () {
    $('#answerButton').click(function (e) {
        e.preventDefault();
        $('#comment_form').toggle();
    });
    $('#editButton').click(function (e) {
        e.preventDefault();
        $('#edit_form').toggle();
    });
    $('.editAnswerButton').click(function (e) {
        e.preventDefault();
        var answerId = $(this).data('answer-id');
        $('#answer-' + answerId).toggle();
    });

    $(document).on('ajax:success', 'a.vote_answer', function(e, data, status, xhr) {
        var answerId = $(this).data('answer-id');
        var answer = $.parseJSON(xhr.responseText);

        $('#answer_vote-' + answerId).html('<p>Result:' + answer.votes + '</p>');
    });
});