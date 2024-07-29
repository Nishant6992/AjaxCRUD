<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="starter.aspx.cs" Inherits="TestTaskAjax.starter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <center>
            <h3>Contact registration form</h3>
            <div class="container-fluid">
                <div class="form-control">
                    <label>Name</label>

                    <asp:TextBox ID="txtname" placeholder="Enter your name" runat="server"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtname" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    <br />
                    <p></p>

                    <label>Phone</label>
                    <%--<input type="number" placeholder="Enter your Phone Number" id="txtphone"/>--%>
                    <asp:TextBox ID="txtphone" runat="server" TextMode="Number" MinLength="10"></asp:TextBox>

                    <br />
                    <p></p>
                    <label>Email</label>
                    <%--<input type="email" placeholder="yourmail@example.com" id="txtmail" value="" />--%>
                    <asp:TextBox TextMode="Email" ID="txtmail" runat="server"></asp:TextBox>
                    <p id="result"></p>
                    <br />
                    <label>Address</label>
                    <%--<input type="text" name="name" placeholder="Enter your address" id="txtaddress"/>--%>
                    <asp:TextBox SkinID="" placeholder="Enter your address" ID="txtaddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <br />
                    <p></p>
                    <input type="button" name="name" value="Submit" id="submitButton" runat="server" />
                    <asp:HiddenField ID="hdnIDUpdate" runat="server" ClientIDMode="Static" />
                </div>
            </div>
        </center>
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            const validateEmail = (email) => {
                return email.match(
                    /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                );
            };

            const validate = () => {
                const $result = $('#result');
                const email = $('#txtmail').val();
                $result.text('');

                if (validateEmail(email)) {
                    $result.text(email + ' is valid.');
                    $result.css('color', 'green');
                } else {
                    $result.text(email + ' is invalid.');
                    $result.css('color', 'red');
                }
                return false;
            }

            $('#txtmail').on('input', validate);

            $("#submitButton").click(function (event) {
                alert(85);

                var updatedButtonValue = $("#submitButton").val();
                if (updatedButtonValue == "Submit") {

                    if ($('#txtname').val() == '' || $('#txtmail').val() == '' || $('#txtaddress').val() == '' || $('#txtphone').val() == '') {
                        alert("All fields are required..");
                    }
                    else {
                        event.preventDefault();
                        var name = $('#txtname').val();
                        var email = $('#txtmail').val();
                        var address = $('#txtaddress').val();
                        var phone = $('#txtphone').val();


                        $.ajax({
                            url: "starter.aspx/sql_submit",
                            type: 'post',
                            contentType: 'application/json',
                            data: JSON.stringify({ nameparam: name, emailparam: email, addressparam: address, phoneparam: phone }),
                            datatype: 'json',
                            success: function (result) {
                                window.location.href = 'https://localhost:44397/List.aspx';
                                // window.location.replace('https://www.example.com');
                            },

                        });
                        $('#txtname').val(null);
                        $('#txtmail').val(null);
                        $('#txtaddress').val(null);
                        $('#txtphone').val(null);
                    }
                }
                else {
                    var name = $('#txtname').val();
                    var email = $('#txtmail').val();
                    var address = $('#txtaddress').val();
                    var phone = $('#txtphone').val();
                    var contactID = $('#hdnIDUpdate').val();


                    $.ajax({
                        url: "starter.aspx/sql_update",
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify({ contactID: contactID ,nameparam: name, emailparam: email, addressparam: address, phoneparam: phone }),
                        datatype: 'json',
                        success: function (result) {
                            window.location.href = 'https://localhost:44397/List.aspx';
                            // window.location.replace('https://www.example.com');
                        },

                    });

                }

            });
        });
    </script>

</body>
</html>
