<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="TestTaskAjax.List" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .custom-button,
        .custom-button-email,
        .custom-button-delete {
            border: none;
            padding: 5px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 3px 1px;
            cursor: pointer;
            border-radius: 3px;
        }

        .custom-button {
            background-color: #4CAF50; /* Green color, change as needed */
            color: white;
        }

        .custom-button-email {
            background-color: Highlight; /* You may need to replace 'Highlight' with a specific color */
            color: white;
        }

        .custom-button-delete {
            background-color: #f44336; /* Red color, change as needed */
            color: white;
        }

            /* Hover effect */
            .custom-button:hover,
            .custom-button-email:hover,
            .custom-button-delete:hover {
                opacity: 0.8; /* Adjust the opacity to your liking */
            }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .center {
            text-align: center;
        }

        .action-buttons {
            display: flex; /* Use Flexbox for layout */
            justify-content: space-between; /* Space out buttons */
            gap: 10px; /* Add spacing between buttons */
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this record?");
        }
    </script>
</head>
<body>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <form runat="server">
        <p></p>
        <center>
            <%-- <asp:LinkButton runat="server" ID="btnSearch">
    <span aria-hidden="true" class="glyphicon glyphicon-search"></span>
        </asp:LinkButton>--%>
            <asp:Label ID="Label1" runat="server" Text="Search by Id/Name/Email/Phone Number:" AssociatedControlID="txtSearch"></asp:Label>&nbsp
        <asp:TextBox runat="server" ID="txtSearch" placeholder="Search" />&nbsp&nbsp&nbsp
            <%--<input type="button" value="Search" ID="txtsearchSql" class="btn-dark"/>--%>
            <asp:Button runat="server" ID="txtsearchSql" Text="Search" CssClass="btn-dark" OnClick="txtsearchSql_Click" />
            <%-- <asp:Label ID="Label2" runat="server" Text="Search by Name" AssociatedControlID="txtSearch0"></asp:Label>
&nbsp;<asp:TextBox runat="server" ID="txtSearch0" placeholder="Search" />&nbsp&nbsp&nbsp
        <asp:Label ID="Label3" runat="server" Text="Search by created date" AssociatedControlID="txtSearch1"></asp:Label>
        <asp:TextBox runat="server" ID="txtSearch1" placeholder="Search" />&nbsp&nbsp&nbsp--%>
        </center>
        <p></p>
        <div class="action-buttons">
            <asp:Repeater ID="repeater1" runat="server">
                <HeaderTemplate>
                    <table class="center">
                        <tr>
                            <th>ContactID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>PhoneNumber</th>
                            <th>Created Date</th>
                            <th>Address</th>
                            <th>Action Buttons</th>

                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <!-- Hidden Field for User ID -->
                            <asp:HiddenField ID="HiddenUserId" runat="server" Value='<%# Eval("ContactID") %>' />
                            <!-- Display User ID -->
                            <%# Eval("ContactID") %>
                        </td>
                        <td><%# Eval("Name") %></td>
                        <td><%# Eval("Email") %></td>

                        <td><%# Eval("Phone") %></td>
                        <td><%# Eval("CreatedDate", "{0:MM-dd-yyyy}") %></td>
                        <td><%# Eval("Address") %></td>

                        <td>
                            <div class="action-buttons">
                                <!-- Edit Button -->
                                <asp:LinkButton runat="server" ID="lnkEdit" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" CssClass="custom-button" />
                                <!-- Delete Button -->
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" OnClientClick="return confirmDelete();" CssClass="custom-button-delete" />

                                <!-- Email Button -->
                                <asp:LinkButton runat="server" ID="lnkEmail" Text="Email" CommandName="Email" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" CssClass="custom-button-email" />
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr>
                        <td>
                            <!-- Hidden Field for User ID -->
                            <asp:HiddenField ID="HiddenUserId" runat="server" Value='<%# Eval("ContactID") %>' />
                            <!-- Display User ID -->
                            <%# Eval("ContactID") %>
                        </td>
                        <td><%# Eval("Name") %></td>
                        <td><%# Eval("Email") %></td>

                        <td><%# Eval("Phone") %></td>
                        <td><%# Eval("CreatedDate", "{0:MM-dd-yyyy}") %></td>
                        <td><%# Eval("Address") %></td>


                        <td>
                            <div class="action-buttons">
                                <!-- Edit Button -->
                                <asp:LinkButton runat="server" ID="lnkEdit" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" CssClass="custom-button" />
                                <!-- Delete Button -->
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" OnClientClick="return confirmDelete();" CssClass="custom-button-delete" />
                                <!-- Email Button -->
                                <asp:LinkButton runat="server" ID="lnkEmail" Text="Email" CommandName="Email" CommandArgument='<%# Eval("ContactID") %>' OnCommand="lnk_Command" CssClass="custom-button-email" />
                            </div>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <br />
        <div style="text-align: center">
            <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton runat="server" ID="lnkPage" CssClass="page-link" CommandName="Page" CommandArgument='<%# Container.DataItem %>'>
                    <%# Container.DataItem %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            alert(44);
            $("#txtsearchSql").click(function (event) {

                var keyword = $('#txtSearch').val();


                $.ajax({
                    url: "List.aspx/txtsearchSql_Click",
                    type: 'post',
                    contentType: 'application/json',
                    data: JSON.stringify({ keyparam: keyword }),
                    datatype: 'json',
                    success: function (result) {
                        //window.location.href = 'https://localhost:44397/List.aspx';
                        // window.location.replace('https://www.example.com');
                    },

                });
                $('#txtSearch').val(null);

            });


          
        });
    </script>--%>
</body>
</html>
