Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F904325B6C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 03:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBZCAe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 21:00:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12581 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBZCAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 21:00:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dmt7z73twzMcFl;
        Fri, 26 Feb 2021 09:57:19 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Feb 2021 09:59:16 +0800
Subject: Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
To:     "Moore, Robert" <robert.moore@intel.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
References: <20210225112620.1827-1-yuzenghui@huawei.com>
 <BYAPR11MB3256E28FD567C5FEB0EDCA94879E9@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3b009c89-c3cc-8fd2-4ef6-5b8d27a88119@huawei.com>
Date:   Fri, 26 Feb 2021 09:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3256E28FD567C5FEB0EDCA94879E9@BYAPR11MB3256.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/26 4:45, Moore, Robert wrote:
> If the field is two bits, I think the ACPI_DMT_* symbol should be ACPI_DMT_FLAGS2, not ACPI_DMT_FLAGS1

The SMMUv3 flags is decoded as:

- bit[0]	"COHACC Override"
- bit[2:1]	"HTTU Override"
- bit[3]	"Proximity Domain Valid"
- bit[31:4]	"Reserved"

whilst ACPI_DMT_FLAGS2 will extract bit[3:2] for us, right?

> -----Original Message-----
> From: Zenghui Yu <yuzenghui@huawei.com>
> Sent: Thursday, February 25, 2021 3:26 AM
> To: devel@acpica.org; linux-acpi@vger.kernel.org
> Cc: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>; robin.murphy@arm.com; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; guohanjun@huawei.com; wanghaibin.wang@huawei.com; Zenghui Yu <yuzenghui@huawei.com>; Kunkun Jiang <jiangkunkun@huawei.com>
> Subject: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 subtable
> 
> As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU which should always have been 2 bits.
> 
> Fixes: 9f7c3e148f44 ("IORT: Add in support for the SMMUv3 subtable")
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   source/common/dmtbinfo2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c index 17a80ba21..321f106fa 100644
> --- a/source/common/dmtbinfo2.c
> +++ b/source/common/dmtbinfo2.c
> @@ -343,7 +343,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Base Address", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags (decoded below)", 0},
>       {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHACC Override", 0},
> -    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU Override", 0},
> +    {ACPI_DMT_FLAGS1,   ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU Override", 0},
>       {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Proximity Domain Valid", 0},
>       {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reserved", 0},
>       {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS Address", 0},
> --
> 2.19.1
> 
> .
> 
