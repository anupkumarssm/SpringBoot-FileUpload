<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Base64</title>
</head>

<body>  
	<div class="row my-2" >
	<div class="col-sm-8"></div>
	<div class="col-sm-4"><button type="button" class="btn btn-primary btn-sm form-control"
			data-toggle="modal" data-target="#base64Modal">Add</button></div>
	</div>
	<div class="card border border-primary my-2">
		<div class="card-header"><b>Base64 Images</b></div>
		<div class="card-body">
	<div class="row my-2">
		<c:forEach var="getImages" items="${getAllImages}" varStatus="counter">
			<div class="col-sm-3">
				<div class="card">
					<div class="card-header">${getImages.name}
						<button class="btn btn-info btn-sm float-right" onclick="onClickEdit('${getImages.id}','${getImages.name}','${getImages.filename}','${getImages.filepath}')"><i class="fas fa-edit"></i></button>
						&nbsp;
						<button class="btn btn-danger btn-sm float-right"><a class="text-white" href="deleteimage?id=${getImages.id}"><i class="fas fa-trash"></i></a></button>
					</div>
					<div class="card-body">
						<img style='display: block; height: 150px; width: 220px;'
							src='${getImages.filepath}' />
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<c:if test="${empty getAllImages}">
				<h5 align="center">No Data</h5>
				</c:if>
</div>
</div>
	<div class="modal" id="base64Modal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="modalHeaderName">Add Form</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="card">
						<form action="savebase64formsubmit" method="post">
						<input type="hidden" class="form-control" name="id" id="formId" value="0">
							<div class="card-body">
								<div class="form-group">
									<label for="username">Name :</label> <input type="text"
										class="form-control" name="name" id="name" required="required">
								</div>
								<div class="form-group">
									<label for="username">Image : </label><br> <img id="img" height="150"
										style="width: 200px; height: 200px;"> <input id="inp"
										class="form-control" type="file" > 
										 <input id="imagename"
										class="form-control" type="hidden" name="filename"> 
										<input type="hidden" id="base64string"
										name="filepath" class="form-control">
								</div>
							</div>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger form-control col-sm-4" data-dismiss="modal">Close</button>
					<input type="submit" id="submitBtn"
						class="btn btn-sm btn-info form-control col-sm-4" value="Submit">
				</div>
				</form>
			</div>
		</div>
	</div>

<div class="modal" id="waitmodal">
		<div class="modal-dialog">
			<div class="modal-content"> 
				<div class="modal-body">
					<img style="" src="resources/images/wait.gif">
				</div>
			</div>
		</div>
	</div>
	
	<br>

	<script type="text/javascript"> 
	$(document).ready(function() {
		$('#submitBtn').click(function() {
			var name = $("#name").val();
			if(name != ''){
				$("#waitmodal").modal().show();
			}
		});
		
		$('#base64Modal').on('hidden.bs.modal', function () {
		    $(this).find('form').trigger('reset');
		    $("#base64string").val();
		    $('#img').attr('src', '');
			$('#img').removeAttr('src');
		    });
		});

	</script>

	<script type="text/javascript">
		function readFile() {
			var filesize;
			var input = document.getElementById('inp');
			if (!input.files) {
				console.error("This browser doesn't seem to support the `files` property of file inputs.");
			} else if (!input.files[0]) {
				addPara("Please select a file before clicking 'Load'");
			} else {
				var file = input.files[0];
				addPara("File " + file.name + " is " + file.size + " bytes in size");
				filesize = file.size;
				$("#imagename").val(file.name);

			}
			if (this.files && this.files[0]) {
				var FR = new FileReader();
				FR.addEventListener("load", function(e) {
					if (filesize > 15000) {
						alert("Please Select upto 15 kb");
						$('#img').attr('src', '');
						$('#img').removeAttr('src');
						$("#inp").val("");
					} else {
						document.getElementById("img").src = e.target.result;
						$("#base64string").val(e.target.result);
					}
				});
				FR.readAsDataURL(this.files[0]);
			}
		}
		document.getElementById("inp").addEventListener("change", readFile);
		
		function addPara(text) {
			var p = document.createElement("p");
			p.textContent = text;
			document.body.appendChild(p);
			
		}
		
		function onClickEdit(id,name,imagename,image) {  
			$("#modalHeaderName").html("Update Form");
			$("#formId").val(id);
			$("#name").val(name);
			$("#base64string").val(image); 
			$("#imagename").val(imagename); 
			document.getElementById("img").src = image;
			$("#base64Modal").modal().show();
		}; 
		
	</script>
</body>
</html>