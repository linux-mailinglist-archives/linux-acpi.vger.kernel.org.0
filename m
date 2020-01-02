Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF012E597
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2020 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgABLSW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jan 2020 06:18:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728111AbgABLSW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Jan 2020 06:18:22 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E3A86358BA1AB7826A05;
        Thu,  2 Jan 2020 11:18:20 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 2 Jan 2020 11:18:20 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Jan 2020
 11:18:20 +0000
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Robert Richter <rrichter@marvell.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <639f61ab-e692-caaf-9b4e-b848b05caee2@huawei.com>
Date:   Thu, 2 Jan 2020 11:18:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+

On 30/12/2019 12:27, Guohanjun (Hanjun Guo) wrote:
> The IORT spec [0] says Number of IDs = The number of IDs in the range minus
> one, it is confusing but it was written down in the first version of the
> IORT spec. But the IORT ID mapping function iort_id_map() did something
> wrong from the start, which bails out if:
> 
> the request ID >= the input base + number of IDs
> 
> This is wrong because it ignored the "minus one", and breaks some valid
> usecases such as ID mapping to contain single device mapping without
> single mapping flag set.
> 
> Pankaj Bansal proposed a solution to fix the issue [1], which bails
> out if:
> 
> the request ID > the input base + number of IDs
> 
> This works as the spec defined, unfortunately some firmware didn't
> minus one for the number of IDs in the range, and the propoased
> solution will break those systems in this way:
> 
> PCI hostbridge mapping entry 1:
> Input base:  0x1000
> ID Count:    0x100
> Output base: 0x1000
> Output reference: 0xC4  //ITS reference
> 
> PCI hostbridge mapping entry 2:
> Input base:  0x1100
> ID Count:    0x100
> Output base: 0x2000
> Output reference: 0xD4  //ITS reference
> 
> Two mapping entries which the second entry's Input base = the first
> entry's Input base + ID count, so for requester ID 0x1100 will map
> to ITS 0xC4 not 0xD4 if we update '>=' to '>'.
> 
> So introduce a workaround to match the IORT's OEM information for
> the broken firmware, also update the logic of the ID mapping for
> firmwares report the number of IDs as the IORT spec defined, to
> make the code compatible for both kinds of system.
> 
> I checked the ACPI tables in the tianocore/edk2-platforms [2], 

Hi Hanjun,

only
> HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
> info table, 

Are you asserting that other platforms are ok on the basis that NumIds = 
large power of 2 - 1, e.g. 0xffff? Is this strictly proper?

if we break other platforms, we can add that later.
> 

I think that it would be better to audit others now as well as best as 
reasonably possible. There is somewhat limited coverage in [2].

Thanks,
John


> [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> [1]: https://patchwork.kernel.org/patch/11292823/
> [2]: https://github.com/tianocore/edk2-platforms
> 
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> 
> RFC->v1:
> - Print warning when matched the workaround info, suggested by Pankaj.
> 
>   drivers/acpi/arm64/iort.c | 55 ++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 33f7198..60eb10d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -298,6 +298,42 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>   	return status;
>   }
>   
> +struct iort_workaround_oem_info {
> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +	u32 oem_revision;
> +};
> +
> +static bool apply_id_count_workaround;
> +
> +static struct iort_workaround_oem_info wa_info[] __initdata = {
> +	{
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP07   ",
> +		.oem_revision	= 0,
> +	}, {
> +		.oem_id		= "HISI  ",
> +		.oem_table_id	= "HIP08   ",
> +		.oem_revision	= 0,
> +	}
> +};
> +
> +static void __init
> +iort_check_id_count_workaround(struct acpi_table_header *tbl)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> +		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +		    wa_info[i].oem_revision == tbl->oem_revision) {
> +			apply_id_count_workaround = true;
> +			pr_warn(FW_BUG "ID count for ID mapping entry is wrong, applying workaround\n");
> +			break;
> +		}
> +	}
> +}
> +
>   static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>   		       u32 *rid_out)
>   {
> @@ -314,9 +350,21 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>   		return -ENXIO;
>   	}
>   
> -	if (rid_in < map->input_base ||
> -	    (rid_in >= map->input_base + map->id_count))
> -		return -ENXIO;
> +	/*
> +	 * IORT spec says Number of IDs = The number of IDs in the range minus
> +	 * one, but the IORT code ingored the "minus one", and some firmware
> +	 * did that too, so apply a workaround here to keep compatible with
> +	 * both new and old versions of the firmware.
> +	 */
> +	if (apply_id_count_workaround) {
> +		if (rid_in < map->input_base ||
> +			(rid_in >= map->input_base + map->id_count))
> +			return -ENXIO;
> +	} else {
> +		if (rid_in < map->input_base ||
> +			(rid_in > map->input_base + map->id_count))
> +			return -ENXIO;
> +	}
>   
>   	*rid_out = map->output_base + (rid_in - map->input_base);
>   	return 0;
> @@ -1631,5 +1679,6 @@ void __init acpi_iort_init(void)
>   		return;
>   	}
>   
> +	iort_check_id_count_workaround(iort_table);
>   	iort_init_platform_devices();
>   }
> 

