# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#****************************** Banks seeds **********************************
Bank.create! name: "JPMorgan"
Bank.create! name: "Bank of America"
Bank.create! name: "ICBC"
Bank.create! name: "HSBC"
Bank.create! name: "Citigroup"

#****************************** Providers seeds ******************************
providers_names = [
  "Apple Inc.",
  "Microsoft Corporation",
  "Google LLC",
  "Amazon.com Inc.",
  "IBM Corporation",
  "Intel Corporation",
  "Cisco Systems Inc.",
  "Oracle Corporation",
  "SAP SE",
  "Dell Technologies Inc.",
  "Hewlett Packard Enterprise (HPE)",
  "NVIDIA Corporation",
  "Adobe Inc.",
  "Salesforce.com Inc.",
  "Facebook, Inc. (now Meta Platforms, Inc.)",
  "Twitter Inc.",
  "Qualcomm Incorporated",
  "Samsung Electronics Co., Ltd.",
  "Huawei Technologies Co., Ltd.",
  "Xiaomi Corporation",
  "Sony Corporation",
  "LG Electronics Inc.",
  "Panasonic Corporation",
  "Toshiba Corporation",
  "Lenovo Group Limited",
  "ASUSTeK Computer Inc.",
  "Acer Inc.",
  "Dell EMC",
  "NetApp Inc.",
  "Western Digital Corporation",
  "Seagate Technology plc",
  "Micron Technology Inc.",
  "Advanced Micro Devices, Inc. (AMD)",
  "Texas Instruments Incorporated",
  "Broadcom Inc.",
  "NXP Semiconductors N.V.",
  "Applied Materials Inc.",
  "Lam Research Corporation",
  "Analog Devices Inc.",
  "Micron Technology Inc.",
  "HP Inc.",
  "Cisco Systems Inc.",
  "Uber Technologies Inc.",
  "Airbnb Inc.",
  "Netflix Inc.",
  "PayPal Holdings Inc.",
  "Tesla Inc.",
  "SpaceX",
  "Palantir Technologies Inc.",
  "Zoom Video Communications Inc.",
  "Square Inc.",
  "Dropbox Inc.",
  "Slack Technologies Inc.",
  "VMware Inc.",
  "Electronic Arts Inc. (EA)",
  "Activision Blizzard Inc.",
  "Epic Games Inc.",
  "Roku Inc.",
  "Logitech International S.A.",
  "GoPro Inc.",
  "Fitbit Inc.",
  "Garmin Ltd.",
  "Etsy Inc.",
  "Pinterest Inc.",
  "Snap Inc.",
  "Spotify Technology S.A.",
  "Alibaba Group Holding Limited",
  "Tencent Holdings Limited",
  "Baidu Inc.",
  "JD.com Inc.",
  "WeChat",
  "Alphabet Inc. (Google parent company)",
  "Verizon Communications Inc.",
  "AT&T Inc.",
  "Comcast Corporation",
  "Intellectual Ventures LLC",
  "Tesla, Inc.",
  "Micron Technology Inc.",
  "Zebra Technologies Corporation",
  "Qualtrics International Inc."
]

providers_names.each_with_index do |name, index|
  # Random datetime between now and 1 year ago
  datetime = Time.now - rand(365).days

  attributes = {
    name: name,
    nit: "#{100000000 + index}-0",
    contact_name: "Person #{index}",
    contact_phone: "+54 11 #{index}",
    account_number: "00000000#{index}",
    bank_id: Bank.all.map{|b| b.id}.sample,  # Chooses random bank
    created_at: datetime,
    updated_at: datetime
  }

  Provider.create! attributes
end