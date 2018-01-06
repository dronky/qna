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

        $('#answer_vote-' + answerId).html('<p>Result:' + answer.get_vote + '</p>');
    });

    $(document).on('ajax:success', 'a.vote_question', function(e, data, status, xhr) {
        var question = $.parseJSON(xhr.responseText);

        $('#question_vote-' + question.id).html('<p>Result:' + question.get_vote + '</p>');
    });

    $(document).on('ajax:success', '.send_comment_form', function(e, data, status, xhr) {
        var comment = $.parseJSON(xhr.responseText);

        $('.list_of_comments').prepend('<li>'+ comment.get_comment+ '</li>');
    });

    App.cable.subscriptions.create('QuestionsChannel', {
        connected: function() {
            console.log('Connected - questions');
            this.perform('follow');
            },

        received: function(data) {
            $('.questions_list').append(data)
        }
    });

    App.cable.subscriptions.create('AnswersChannel', {
        connected: function() {
            var question_id = $('.question_details').data('id');
            console.log('Connected - answers');
            this.perform('follow_answer', {id: question_id});
        },

        received: function(data) {
            $('#list_of_answers').append(data)
        }
    });

    App.cable.subscriptions.create('CommentsChannel', {
        connected: function() {
            var id = $('.')
            console.log('Connected - comments');
            this.perform('follow', {id: id, type: type});
        },

        received: function(data) {
            $('.list_of_comments').prepend(data)
        }
    });

    App.cable.subscriptions.create('AnswersCommentChannel', {
        connected: function() {
            console.log('Connected - answer comments');
            this.perform('follow');
        },

        received: function(data) {
            $('.comments_answer_' + data.answer_id).append(data.body)
        }
    });
});
