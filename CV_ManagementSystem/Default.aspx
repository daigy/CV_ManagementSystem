<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CV_ManagementSystem._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
       /* #previewContainer { width: 300px; height: 300px; overflow: hidden; }
        #previewImage { max-width: 100%; }*/
       .animate-charcter
            {
                font-weight: 200;
                font-family: serif!important;
                margin-top:10%!important;
                text-transform: uppercase;
                position: relative;
                display: inline-block;
                padding-top: 2.0em;
                padding-right: 0.05em;
                padding-left: 4em;
                padding-bottom: 0.15em;
                background-image: linear-gradient(
                -225deg,
                #17a2b8 0%,
                #44107a 29%,
                #ff1361 67%,
                #0e6471 100%
              );
              background-size: auto auto;
              background-clip: border-box;
              background-size: 200% auto;
              color: #fff;
              background-clip: text;
              text-fill-color: transparent;
              -webkit-background-clip: text;
              -webkit-text-fill-color: transparent;
              animation: textclip 2s linear infinite;
              display: inline-block;
              font-size: 35px;
            }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container-fluid" style="height:710px">
       <div class="row">
           <div class="col-12">
               <h1 class="animate-charcter">
                   <span class="text-wrapper" style="margin-left:200px;">
                       <span class="letters">WELCOME  TO  THE  CV  TEMPLATE  MANAGEMENT  PORTAL</span>
                   </span>
               </h1>
           </div>
       </div>
   </div>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
   <script type="text/javascript">    
       anime.timeline({ loop: true })
           .add({
               targets: '.ml14 .line',
               scaleX: [0, 1],
               opacity: [0.5, 1],
               easing: "easeInOutExpo",
               duration: 900
           }).add({
               targets: '.ml14 .letter',
               opacity: [0, 1],
               translateX: [40, 0],
               translateZ: 0,
               scaleX: [0.3, 1],
               easing: "easeOutExpo",
               duration: 800,
               offset: '-=600',
               delay: (el, i) => 150 + 25 * i
           }).add({
               targets: '.ml14',
               opacity: 0,
               duration: 1000,
               easing: "easeOutExpo",
               delay: 1000
           });
   </script>
    <%-- <div>
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
        </div>--%>
      <!-- jQuery -->
<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
     </script>--%>
</asp:Content>
