<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>File upload</title>
</head>
<body>
	<div class="row my-2">
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
			<button type="button" class="btn btn-primary btn-sm form-control"
				data-toggle="modal" data-target="#singleFileuploadModal">Single
				Fileupload</button>
		</div>
		<div class="col-sm-4">
			<button type="button" class="btn btn-primary btn-sm form-control"
				data-toggle="modal" data-target="#multipleFileuploadModal">Multiple
				Fileupload</button>
		</div>
	</div>
	<c:if test="${not empty message}">
		<div class="alert alert-success" role="alert">${message}</div>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-danger" role="alert">${error}</div>
	</c:if>

	<div class="card border border-primary my-2">
		<div class="card-header">
			<b>Single Fileupload</b>
		</div>
		<div class="card-body">
			<div class="row my-2">
				<c:forEach var="getfiles" items="${getAllSingleFileUploadred}"
					varStatus="counter">
					<div class="col-sm-3">
						<div class="card">
							<div class="card-header">
								${getfiles.name}
								<button class="btn btn-danger btn-sm float-right">
									<a class="text-white" href="deletefile?id=${getfiles.id}"><i
										class="fas fa-trash"></i></a>
								</button>
							</div>
							<div class="card-body">
								<a href="downloadFile?id=${getfiles.id}" target="_blank">${getfiles.filename}</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${empty getAllSingleFileUploadred}">
				<h5 align="center">No Data</h5>
			</c:if>
		</div>
	</div>

	<div class="card border border-primary">
		<div class="card-header">
			<b>Multiple Fileupload</b>
		</div>
		<div class="card-body">
			<div class="row my-2">
				<c:forEach var="getfiles" items="${getAllMultiFileUploadred}"
					varStatus="counter">
					<div class="col-sm-3">
						<div class="card">
							<div class="card-header">
								${getfiles.name} 
								<button class="btn btn-danger btn-sm float-right">
									<a class="text-white" href="deletefile?id=${getfiles.id}"><i
										class="fas fa-trash"></i></a>
								</button>
							</div>
							<div class="card-body">
								<a href="downloadFile?id=${getfiles.id}" target="_blank">${getfiles.filename}</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:if test="${empty getAllMultiFileUploadred}">
				<h5 align="center">No Data</h5>
			</c:if>
		</div>
	</div>




	<div class="modal" id="singleFileuploadModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="modalHeaderName">Single Fileupload
						Form</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="card">
						<form action="singlefileuploadform" method="post"
							enctype="multipart/form-data">
							<input type="hidden" class="form-control" name="id" id="formId"
								value="0">
							<div class="card-body">
								<div class="form-group">
									<label for="username">Name :</label> <input type="text"
										class="form-control" name="name" id="name" required="required">
								</div>
								<div class="form-group">
									<label for="username">File : </label><br> <input id="file"
										class="form-control" type="file" name="file">
								</div>
							</div>
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button"
									class="btn btn-danger form-control col-sm-4"
									data-dismiss="modal">Close</button>
								<input type="submit" id="submitBtn"
									class="btn btn-sm btn-info form-control col-sm-4" value="Submit">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal" id="multipleFileuploadModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="modalHeaderName">Multiple
						Fileupload Form</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="card">
						<div class="card-body">
							<form action="multiplefileuploadform" method="post"
								enctype="multipart/form-data">
								<div class="table-responsive">
									<table class="table table-bordered" id="dynamic_field">
										<tr>
											<td>
												<div class="form-group">
													<input type="text" id ="mname" name="name" placeholder="Enter Name"
														class="form-control" required="required" />
												</div>
												<div class="form-group">
													<input type="file" name="file" class="form-control" />
												</div>
											</td><td></td>
										</tr>
									</table>
									<div class="text-center"><button type="button" name="add" id="add"
										class="btn btn-success form-control col-sm-4"><i class="fas fa-plus"></i> &nbsp; More</button></div>
								</div>
								<div class="modal-footer">
								<button type="button"
									class="btn btn-danger form-control col-sm-4"
									data-dismiss="modal">Close</button>
								<input type="submit" id="submitBtnm"
									class="btn btn-sm btn-info form-control col-sm-4" value="Submit">
							</div>
							</form>
						</div>
					</div>
				</div>
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
			$('#submitBtnm').click(function() {
				var mname = $("#mname").val();
				if(mname != ''){
				$("#waitmodal").modal().show();
				}
			}); 
		});
	</script>

	<script>
		$(document)
				.ready(
						function() {
							var i = 1;
							$('#add')
									.click(
											function() {
												i++;
												$('#dynamic_field')
														.append(
																'<tr id="row'+i+'"><td><div class="form-group"><input type="text" name="name" placeholder="Enter Name" class="form-control" required="required"/></div><div class="form-group"><input type="file" name="file" class="form-control" /> </div></td><td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');
											});

							$(document).on('click', '.btn_remove', function() {
								var button_id = $(this).attr("id");
								$('#row' + button_id + '').remove();
							});
						});
	</script>


</body>
</html>