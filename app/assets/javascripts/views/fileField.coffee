CivicSourcing.FileFieldView =  Em.View.extend(

  templateName: 'views/fileField'

  didInsertElement: ->
    $('#file_upload').fileupload
      url: "/api/v1/uploads"
      dataType: "json"
      beforeSend: ->
        $("#sample_image").attr "src", ""
      success: (response) =>
        upload = @get('context.content').store.
          createRecord('upload', response.upload)
        @get('context.content').set('upload', upload)
        $("#sample_image").attr "src", upload.get("file.file.url")

)