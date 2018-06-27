function num_fields = fieldcount(asset_obj)
% Determines the number of fields in an frogp object
% Used by frogc child class methods
num_fields = length(fieldnames(asset_obj));