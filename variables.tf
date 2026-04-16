# variable "list_01" {
#     type = list(string)
#     default = [ "kiran", "sai", "hitesh" ]
# }

# variable "list_02" {
#     type = list(number)
#     default = [ 1, 2, 3 ]
# }
# output "list_01_value" {
#     value = flatten([ for data in var.list_01 : [ for value in var.list_02: value ]] if data == "kiran")
# }


variable "rg_prefix" {
    type = string
    default = "Terraform"
}

