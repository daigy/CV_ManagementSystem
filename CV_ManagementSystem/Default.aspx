<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CV_ManagementSystem._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
        #previewContainer { width: 300px; height: 300px; overflow: hidden; }
        #previewImage { max-width: 100%; }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div>
            <h2>Upload and Adjust Photo</h2>
            
            <!-- File Upload -->
            <input type="file" id="fileUpload" accept="image/*">
            <br /><br />

            <!-- Image Preview and Crop Area -->
            <div id="previewContainer">
                <img id="previewImage">
            </div>

            <br />
            <!-- Buttons -->
            <button type="button" id="cropButton"> Save</button>
            <asp:Button ID="btnSave" runat="server" Text="Save to Database" OnClick="btnSave_Click" style="visibility:hidden;" />

            <br /><br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <!-- Hidden Field to Store Cropped Image -->
            <asp:HiddenField ID="hiddenCroppedImage" runat="server" />
        </div>
      <!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Cropper.js for image resizing -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.js"></script>

     <script>
        var cropper;
        var canvas;

        // Image Preview & Cropper Initialization
        document.getElementById('fileUpload').addEventListener('change', function (event) {
            var file = event.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var image = document.getElementById('previewImage');
                    image.src = e.target.result;

                    // Destroy previous cropper instance if exists
                    if (cropper) cropper.destroy();

                    // Initialize Cropper.js
                    cropper = new Cropper(image, {
                        aspectRatio: 1,
                        viewMode: 2
                    });
                };
                reader.readAsDataURL(file);
            }
        });

        // Crop Image and Store in Hidden Field
        document.getElementById('cropButton').addEventListener('click', function () {
            if (cropper) {
                canvas = cropper.getCroppedCanvas({
                    width: 200,
                    height: 200
                });

                // Convert canvas to base64
                var croppedImageData = canvas.toDataURL("image/png");

                // Store in hidden field
                document.getElementById('<%= hiddenCroppedImage.ClientID %>').value = croppedImageData;
                
                $('#<%=btnSave.ClientID %>').click();
                // Show Save Button
              

            }
        });
     </script>
</asp:Content>
