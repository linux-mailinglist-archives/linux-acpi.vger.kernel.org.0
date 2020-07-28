Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31923020D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 07:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgG1FuQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 01:50:16 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:14944
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgG1FuQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 01:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldLe8VHuEScYBO1HUU/UrkuMAtxnc75ILxj71OkKnh8C2fz/wDLhNLijR/qnX1fEg1M6J3HtESmNo+sZ1XlgyKZj4oxMfQrJfCFe9m3hcFTMqi4Gv2Ru80zOMx2mSGENw0JCjNLhEpzIjtv3vtjArjrUFNI54XqtWnTTENN4U5GotzVQyRblWDyGydmgUKBvGAZ7vniDh1fhrE6Wya0RzpJHdPqVG5nLivzw0dbBAgM9Ue24UpIMZB2klqsI62dum1UsP1CvYW4pA9/vEbchjpGadGF1lGwXcY1FdcDe8/BAj9yuqCx9SJr74R+JCaZ/OzOSIVpa8rGjcRtnrfJ2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph05vRWDJJAGmWgF0c/SV36MPAaeyE/x282LusFhpvY=;
 b=YczA9Qwt0vigkig45x1XwPHAEnVY/8U1UWsH9K82ooWUGGAEmnP/K7eovLd3Zl1tMyN0h/8EeNgcJ7498AAfWW5X5ef56dI8yLwBV1WJb5HtxLzYAkJ/KYckEX9c3ijYk2X2156iDOhXFxUkywP+M0hMsYC2d6zIB60NqqqXRGtopd1FbChv5GjhMpEN1PdsOhg6lP5Z3pe/KFdkDsDAPUxmvuIQluBXg8kg/RZ0cY4OJ0Njfp5AFFK1RBSKLdVloaLfMfqM+gxt2UTBxdGELrJq8fETK5uyMoeauReRE5WQ02fkju0LqSXU7rtXmeEnJXGebQVy7etTs0cKB5l0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph05vRWDJJAGmWgF0c/SV36MPAaeyE/x282LusFhpvY=;
 b=HQAuzdLiT7DV3MWF96Y5pxDIPLNQGWr5p5Je8LvqbJE7QOrvtEjRGUvVxPWXSRykT7qxKtCvhNu9JjXns0hkmndjx6gRn6xj4kSwM6mNt7w5DBTJDcLSWFPXVHZ9qZGccIHANI6qluRJ2UEqSSqgaR0WqxhqJhWa8bLn8r0i7MY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 05:50:12 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 05:50:12 +0000
Subject: Re: [PATCH 1/4] ACPI: APD: Change name from ST to FCH
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
 <20200720050500.23357-2-akshu.agrawal@amd.com>
 <CAJZ5v0j264hcr0AbwXou240K73xfQ5Q0pF4TEP11SAOT2nuOjA@mail.gmail.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <27966cc7-cb5a-fd18-2244-5106d8853ea1@amd.com>
Date:   Tue, 28 Jul 2020 11:20:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAJZ5v0j264hcr0AbwXou240K73xfQ5Q0pF4TEP11SAOT2nuOjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.179.172) by MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 05:50:10 +0000
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1094a65f-d32c-4fee-851a-08d832ba184c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01859265B1CABBD47FE1F5A0F8730@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V57gYslpPtlJAjNmziaAYpVwC49SsZ7aJB0PlzasqcNf+ctEbo2cO+7w11l2Jx8eomf1tphVbKa+8ZxXwm2yUoa+/l06kMDSntm0sod6DQkxspEYalu0W3DLq6NDPmErhs1lVQswCSHUfsv2J0QTQe933bCsYEQc6Hd6t87wRCzWrLUHi9sk6/5e/CSCy+O0q9kRaqsorSxkyfUyaJjLFcBDmPOdq76FaYEwGANm2grHreaOe/sAsrPOfBdu/58l+AB3iHhX3veiSumJcULIjrxb3sd73nww04ZN4pUl+v2rYus0Pj3H9XGL7l4/BI/g6AU0p6/mtsMv32YzAEF7G9ml8EN/RRovMHFgsORJnI0G4siJ3uc/KvLcCD55Cpj1wKMLJV4ei465L9cU9MV6KD7xaSqwQUAWRotK7cqTDVjzOLQE1qRw8C/L28J7JyFtpMTN3q+8zcPtoZ/hQOIKmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(966005)(316002)(16576012)(31686004)(6486002)(8936002)(8676002)(83380400001)(6636002)(4326008)(2906002)(186003)(5660300002)(16526019)(6666004)(53546011)(26005)(2616005)(956004)(66556008)(66476007)(66946007)(110136005)(54906003)(478600001)(36756003)(31696002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NQFZXgrL1JJM0EQaLFm4ZuvZnxkeDCbhqkjxq2n1W3xhHPmsJy/avlZmSZx6Io0wUNDANr9sxtKIQ7NsNidcrh1sD7TvhF3acHzomgVXAXbrzypwJ2i4CCdl1FZsGqDDXciv906PQa4NbXoDhFufr+/6QJ+i9tqDwNVNTXhcvQ3EqH0Syp/KYlLCeZTuYuuJAyaFKjUUPWCqB1yNcZpL9dnn3hfYC0F8zSBaYxrDZ/kh3yQyTJEZLZz7flIkMqGIbTV6b9RBxTh2Zux1+7/NdeNuhWC9CB9g8MKFQvH/VwgWSE94MAhRcLkBW/AZthQwz+lwnC10S/WQuWajYUBOkp9PJ2jMIwDxQrGZqW/9qow6A2CIiQLb5Ak28RFN0vx0sDjB5TlwHDgRHj7ZauoMOVh17Et9uqfqIGKSjNxzLurjmomzbRGRLKc5I5LCW1sQOAw/yBk+Ddw6wcsRXYXwvwMLLYgRjzG51y1/zeqxBIvOtdlaEhITRPdyCYZTp0hP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1094a65f-d32c-4fee-851a-08d832ba184c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:50:12.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIkxDNRwuvTyxzT2vnVg3VVYX/vj8MtQyFjkBA+/+je8ZQMUvN0r9YBQBTxjTy3evAI306KrtuVN4LlMArWHvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 7/27/2020 6:58 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 20, 2020 at 7:06 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>> AMD SoC general pupose clk is present in new platforms with
>> same MMIO mappings. We can reuse the same clk handler support
>> for other platforms. Hence, changing name from ST(SoC) to FCH(IP)
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> This patch and the [3/4] appear to be part of a larger series which
> isn't visible to me as a whole.

Link to other patches:

https://patchwork.kernel.org/patch/11672857/

https://patchwork.kernel.org/patch/11672861/

>
> Do you want me to apply them nevertheless?

This patch on its own will cause compilation error as we need the second 
patch.

Since, there is dependency we need them to be merged together. Can you 
or Stephen please suggest a way forward.


Thanks,

Akshu

>> ---
>>   drivers/acpi/acpi_apd.c                            | 14 +++++++-------
>>   .../linux/platform_data/{clk-st.h => clk-fch.h}    | 10 +++++-----
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>   rename include/linux/platform_data/{clk-st.h => clk-fch.h} (53%)
>>
>> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
>> index ba2612e9a0eb..2d99e46add1a 100644
>> --- a/drivers/acpi/acpi_apd.c
>> +++ b/drivers/acpi/acpi_apd.c
>> @@ -8,7 +8,7 @@
>>    */
>>
>>   #include <linux/clk-provider.h>
>> -#include <linux/platform_data/clk-st.h>
>> +#include <linux/platform_data/clk-fch.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/clkdev.h>
>> @@ -79,11 +79,11 @@ static int misc_check_res(struct acpi_resource *ares, void *data)
>>          return !acpi_dev_resource_memory(ares, &res);
>>   }
>>
>> -static int st_misc_setup(struct apd_private_data *pdata)
>> +static int fch_misc_setup(struct apd_private_data *pdata)
>>   {
>>          struct acpi_device *adev = pdata->adev;
>>          struct platform_device *clkdev;
>> -       struct st_clk_data *clk_data;
>> +       struct fch_clk_data *clk_data;
>>          struct resource_entry *rentry;
>>          struct list_head resource_list;
>>          int ret;
>> @@ -106,7 +106,7 @@ static int st_misc_setup(struct apd_private_data *pdata)
>>
>>          acpi_dev_free_resource_list(&resource_list);
>>
>> -       clkdev = platform_device_register_data(&adev->dev, "clk-st",
>> +       clkdev = platform_device_register_data(&adev->dev, "clk-fch",
>>                                                 PLATFORM_DEVID_NONE, clk_data,
>>                                                 sizeof(*clk_data));
>>          return PTR_ERR_OR_ZERO(clkdev);
>> @@ -135,8 +135,8 @@ static const struct apd_device_desc cz_uart_desc = {
>>          .properties = uart_properties,
>>   };
>>
>> -static const struct apd_device_desc st_misc_desc = {
>> -       .setup = st_misc_setup,
>> +static const struct apd_device_desc fch_misc_desc = {
>> +       .setup = fch_misc_setup,
>>   };
>>   #endif
>>
>> @@ -239,7 +239,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>>          { "AMD0020", APD_ADDR(cz_uart_desc) },
>>          { "AMDI0020", APD_ADDR(cz_uart_desc) },
>>          { "AMD0030", },
>> -       { "AMD0040", APD_ADDR(st_misc_desc)},
>> +       { "AMD0040", APD_ADDR(fch_misc_desc)},
>>   #endif
>>   #ifdef CONFIG_ARM64
>>          { "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
>> diff --git a/include/linux/platform_data/clk-st.h b/include/linux/platform_data/clk-fch.h
>> similarity index 53%
>> rename from include/linux/platform_data/clk-st.h
>> rename to include/linux/platform_data/clk-fch.h
>> index 7cdb6a402b35..850ca776156d 100644
>> --- a/include/linux/platform_data/clk-st.h
>> +++ b/include/linux/platform_data/clk-fch.h
>> @@ -1,17 +1,17 @@
>>   /* SPDX-License-Identifier: MIT */
>>   /*
>> - * clock framework for AMD Stoney based clock
>> + * clock framework for AMD misc clocks
>>    *
>>    * Copyright 2018 Advanced Micro Devices, Inc.
>>    */
>>
>> -#ifndef __CLK_ST_H
>> -#define __CLK_ST_H
>> +#ifndef __CLK_FCH_H
>> +#define __CLK_FCH_H
>>
>>   #include <linux/compiler.h>
>>
>> -struct st_clk_data {
>> +struct fch_clk_data {
>>          void __iomem *base;
>>   };
>>
>> -#endif /* __CLK_ST_H */
>> +#endif /* __CLK_FCH_H */
>> --
>> 2.20.1
>>
