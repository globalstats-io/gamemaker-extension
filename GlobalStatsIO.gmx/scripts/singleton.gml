/// @description assure an object stays a singleton

if (instance_number(object_index)>1) {
    instance_destroy();
    return true;
}
persistent = true;
return false;

