const AppError = require('./Error');

const handleFieldsAreEmpty = err => {
  const message = err.message;
  return new AppError(message, 400);
};

const handleDuplicateEmail = err => {
  const message = "This email is already exists";
  return new AppError(message, 409);
};

  const handleDuplicateUsername = err => {
    const message = "Username already taken";
    return new AppError(message, 409);
  };
const handleDuplicateCardID = err => {
  const message = "Duplicate CardID";
  return new AppError(message, 400);
};
const handleDupImg= err => {
  const message = "Duplicate Image";
  return new AppError(message, 400);
};
const handleDuplicateInvCode = err => {
  const message = "Duplicate Invitation code";
  return new AppError(message, 400);
};
const handleDuplicateTelephone = err => {
    const message = "This phone number is already registered";
    return new AppError(message, 400);
  };
  const handleBiscootKey= err => {
    const message = "Does not Exist";
    return new AppError(message, 400);
  };

const handlePhoneInvalid = err => {
  const message = "Phone number must only contain numerical digits";
  return new AppError(message, 400);
};

const handleEmailInvalid = err => {
  const message = "Email is invalid";
  return new AppError(message, 400);
};

const handleSupplier= err => {
  const message = "Supplier does not exist";
  return new AppError(message, 400);
};
const handleDuplicateAdmin= err => {
  const message = "Already admin";
  return new AppError(message, 400);
};
const handleAdress= err => {
  const message = "Duplicate Address";
  return new AppError(message, 400);
};
const handlebiscootInRental = err => {
  const message = "inserted Biscoot id does not exist!!!";
  return new AppError(message, 400);
};

const hundledup  = err => {
  const message = "Duplicate pkey!!";
  return new AppError(message, 400);
};
const handleNoEmailOrPass = err => {
  const message = "please provide email & password";
  return new AppError(message, 400);
};
const handleWrongEmailOrPass = err => {
  const message = "incorrect email or password";
  return new AppError(message, 401);
};
const noexist = err => {
  const message = "Reference Does not exist";
  return new AppError(message, 401);
};

const sendErrorDev = (err, res) => {
  res.status(err.statusCode).json({
    status: err.status,
    error: err,
    message: err.message,
    stack: err.stack
  });
}

const sendErrorProd = (err, res) => {
  if (err.isOperational) {
    res.status(err.statusCode).json({
      status: err.status,
      message: err.message
    });
  }
  else {

    console.error('error is :::>', err);
    res.status(500).json({
      status: 'error',
      message: 'something went wrong'
    });
  }
}


module.exports = (err, req, res, next) => {
    err.statusCode = err.statusCode || 500;
    err.status = err.status || 'error';
    let error = err;
    if (error.message == 'Some required Fields are empty') error = handleFieldsAreEmpty(error);
    if (error.message == 'duplicate key value violates unique constraint "client_email_key"') error = handleDuplicateEmail(error);
    if (error.message == 'duplicate key value violates unique constraint "client_card_id_key"') error = handleDuplicateCardID(error);
    if (error.message == 'duplicate key value violates unique constraint "client_card_id_key"') error = handleDuplicateCardID(error); 
    if (error.message == 'duplicate key value violates unique constraint "client_username_key"') error = handleDuplicateUsername(error);
    if (error.message == 'duplicate key value violates unique constraint "client_invitation_code_key"') error = handleDuplicateInvCode(error);
    if (error.message == 'insert or update on table "rent_biscoot" violates foreign key constraint "rent_biscoot_biscoot_id_fkey"') error = handlebiscootInRental(error);
    if (error.message == 'duplicate key value violates unique constraint "biscoot_image_key"') error = handleDupImg(error);
    if (error.message == 'insert or update on table "feedback_biscoot" violates foreign key constraint "feedback_biscoot_biscoot_id_fkey"') error = handleBiscootKey(error);
    if (error.message == 'duplicate key value violates unique constraint "client_telephone_key"') error = handleDuplicateTelephone(error);    
    if (error.message == 'duplicate key value violates unique constraint "supplier_email_key"') error = handleDuplicateEmail(error); ''
    if (error.message == 'Phone number must only contain numerical digits"') error = handlePhoneInvalid(error);
    if (error.message == 'duplicate key value violates unique constraint "employee_username_key"') error = handleDuplicateUsername(error);
    if (error.message == 'insert or update on table "shipment_order" violates foreign key constraint "shipment_order_supplier_id_fkey"')error = handleSupplier(error);
    if (error.message == 'Email is invalid"') error = handleEmailInvalid(error);
    if (error.message == 'insert or update on table "feedback_biscoot" violates foreign key constraint "feedback_biscoot_client_id_fkey"') error = noexist(error);
    if (error.message == 'insert or update on table "rent_biscoot" violates foreign key constraint "rent_biscoot_client_id_fkey"') error = noexist(error);
    if (error.message == 'duplicate key value violates unique constraint "admin_pkey"') error = hundledup(error);
    if (error.message == 'duplicate key value violates unique constraint "employee_pkey"')error = hundledup(error);
    if (error.message == 'update or delete on table "employee" violates foreign key constraint "admin_admin_id_fkey" on table "admin"')error = noexist(error);
    if (error.message =='duplicate key value violates unique constraint "address"')error = handleAdress(error);
    if (error.message == 'please provide email & password"') error = handleNoEmailOrPass(error);
    if (error.message == 'incorrect email or password"') error = handleWrongEmailOrPass(error);
    sendErrorProd(error,res);
  }
