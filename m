Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40C12F6A8
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 11:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgACKRF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jan 2020 05:17:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACKRF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 05:17:05 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72A20D0FA716A3920038;
        Fri,  3 Jan 2020 18:17:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 18:16:57 +0800
Subject: Re: [RFC PATCH 2/2] ACPI/IORT: Workaround for IORT ID count "minus
 one" issue
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Erik Schmauss <erik.schmauss@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
 <1577092997-9852-2-git-send-email-guohanjun@huawei.com>
 <ea7d6a0d1b804982909ffa43b48ccee2@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <999f5557-f6f9-828e-4d6b-c7865d00e43e@huawei.com>
Date:   Fri, 3 Jan 2020 18:14:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ea7d6a0d1b804982909ffa43b48ccee2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/1/2 18:20, Shameerali Kolothum Thodi wrote:
> Hi Hanjun,
> 
>> -----Original Message-----
>> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Hanjun
>> Guo
>> Sent: 23 December 2019 09:23
>> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Sudeep Holla
>> <sudeep.holla@arm.com>; Rafael J. Wysocki <rafael@kernel.org>; Pankaj
>> Bansal <pankaj.bansal@nxp.com>; Erik Schmauss <erik.schmauss@intel.com>
>> Cc: linux-acpi@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
>> linux-arm-kernel@lists.infradead.org
>> Subject: [RFC PATCH 2/2] ACPI/IORT: Workaround for IORT ID count "minus
>> one" issue
>>
>> The IORT spec [0] says Number of IDs = The number of IDs in the range minus
>> one, it is confusing but it was written down in the first version of the
>> IORT spec. But the IORT ID mapping function iort_id_map() did something
>> wrong from the start, which bails out if:
>>
>> the request ID >= the input base + number of IDs
>>
>> This is wrong because it ignored the "minus one", and breaks some valid
>> usecases such as ID mapping to contain single device mapping without
>> single mapping flag set.
>>
>> Pankaj Bansal proposed a solution to fix the issue [1], which bails
>> out if:
>>
>> the request ID > the input base + number of IDs
>>
>> This works as the spec defined, unfortunately some firmware didn't
>> minus one for the number of IDs in the range, and the propoased
>> solution will break those systems in this way:
>>
>> PCI hostbridge mapping entry 1:
>> Input base:  0x1000
>> ID Count:    0x100
>> Output base: 0x1000
>> Output reference: 0xC4  //ITS reference
>>
>> PCI hostbridge mapping entry 2:
>> Input base:  0x1100
>> ID Count:    0x100
>> Output base: 0x2000
>> Output reference: 0xD4  //ITS reference
>>
>> Two mapping entries which the second entry's Input base = the first
>> entry's Input base + ID count, so for requester ID 0x1100 will map
>> to ITS 0xC4 not 0xD4 if we update '>=' to '>'.
>>
>> So introduce a workaround to match the IORT's OEM information for
>> the broken firmware, also update the logic of the ID mapping for
>> firmwares report the number of IDs as the IORT spec defined, to
>> make the code compatible for both kinds of system.
>>
>> I checked the ACPI tables in the tianocore/edk2-platforms [2], only
>> HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
>> info table, if we break other platforms, we can add that later.
>>
>> [0]:
>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_
>> Remapping_Table.pdf
>> [1]: https://patchwork.kernel.org/patch/11292823/
>> [2]: https://github.com/tianocore/edk2-platforms
>>
>> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  drivers/acpi/arm64/iort.c | 54
>> ++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 33f7198..112b1b0 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -298,6 +298,41 @@ static acpi_status iort_match_node_callback(struct
>> acpi_iort_node *node,
>>  	return status;
>>  }
>>
>> +struct iort_workaround_oem_info {
>> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
>> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>> +	u32 oem_revision;
>> +};
>> +
>> +static bool apply_id_count_workaround;
>> +
>> +static struct iort_workaround_oem_info wa_info[] __initdata = {
>> +	{
>> +		.oem_id		= "HISI  ",
>> +		.oem_table_id	= "HIP07   ",
>> +		.oem_revision	= 0,
>> +	}, {
>> +		.oem_id		= "HISI  ",
>> +		.oem_table_id	= "HIP08   ",
>> +		.oem_revision	= 0,
>> +	}
>> +};
>> +
>> +static void __init
>> +iort_check_id_count_workaround(struct acpi_table_header *tbl)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
>> +		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE)
>> &&
>> +		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id,
>> ACPI_OEM_TABLE_ID_SIZE) &&
>> +		    wa_info[i].oem_revision == tbl->oem_revision) {
>> +			apply_id_count_workaround = true;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
> 
> Can we get rid of the above and instead use acpi_match_platform_list() ? Please 
> take a look at the pmcg_plat_info used for the HIP08 SMMUv3 PMCG erratum.

Thanks for the reminding, I noticed acpi_match_platform_list() before but I
thought it was a little overkill (get the table header for each OEM info),
I will take a look further to see if I can consolidate the OEM information retrieve.

Thanks
Hanjun

