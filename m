Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66C31A917A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 05:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgDODOG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 23:14:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731048AbgDODOD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Apr 2020 23:14:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E965EEBDCFC4ED20D06F;
        Wed, 15 Apr 2020 11:13:59 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 11:13:56 +0800
Subject: Re: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
To:     "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200413143156.22633-1-yanaijie@huawei.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3C68A849E@ORSMSX108.amr.corp.intel.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <7c560f1c-5074-fa6c-4dbf-fb2ae37b0c46@huawei.com>
Date:   Wed, 15 Apr 2020 11:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3C68A849E@ORSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



ÔÚ 2020/4/15 4:22, Moore, Robert Ð´µÀ:
> I think we've discussed this in the past. ARRAY_SIZE is not standard, and will get in the way of portability:
> 

Thanks for the explanation. Got it.


> On gcc v7.4.0:
> ../../../source/components/resources/rsdumpinfo.c:335:25: note: in expansion of macro 'ACPI_RSD_TABLE_SIZE'
>       {ACPI_RSD_TITLE,    ACPI_RSD_TABLE_SIZE (AcpiRsDumpGenericReg),         "Generic Register",         NULL},
> 
> ../../../source/components/resources/rsdumpinfo.c:166:37: error: initializer element is not constant
>   #define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE (name)
> 
> 
> And, on MSVC 2017:
> Severity	Code	Description	Project	File	Line	Suppression State
> Warning	C4013	'ARRAY_SIZE' undefined; assuming extern returning int	AcpiExec	c:\acpica\source\components\resources\rsdumpinfo.c	179	
> -----Original Message-----
> From: Jason Yan <yanaijie@huawei.com>
> Sent: Monday, April 13, 2020 7:32 AM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Cc: Jason Yan <yanaijie@huawei.com>
> Subject: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
> 
> Fix the following coccicheck warning:
> 
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> ./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/acpi/acpica/rsdumpinfo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
> index cafa8134b4c6..f1ba4cd8080f 100644
> --- a/drivers/acpi/acpica/rsdumpinfo.c
> +++ b/drivers/acpi/acpica/rsdumpinfo.c
> @@ -15,7 +15,7 @@ ACPI_MODULE_NAME("rsdumpinfo")  #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
>   #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
>   #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
> -#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
> +#define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE(name)
>   /*******************************************************************************
>    *
>    * Resource Descriptor info tables
> --
> 2.21.1
> 
> 
> .
> 

