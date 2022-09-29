Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA505EF35C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiI2KW2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 06:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiI2KW0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 06:22:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6194143285
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 03:22:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31BC52309;
        Thu, 29 Sep 2022 03:22:27 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DDE53F73B;
        Thu, 29 Sep 2022 03:22:19 -0700 (PDT)
Message-ID: <0862c961-d047-6c5d-e577-62a58b1d1bc5@arm.com>
Date:   Thu, 29 Sep 2022 11:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ACPI/IORT: Update SMMUv3 DeviceID support
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com
References: <4b3e2ead4f392d1a47a7528da119d57918e5d806.1664392886.git.robin.murphy@arm.com>
 <YzTe5AaGDauUyzDB@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YzTe5AaGDauUyzDB@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-09-29 00:55, Nicolin Chen wrote:
> On Wed, Sep 28, 2022 at 08:21:26PM +0100, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> IORT E.e now allows SMMUv3 nodes to describe the DeviceID for MSIs
>> independently of wired GSIVs, where the previous oddly-restrictive
>> definition meant that an SMMU without PRI support had to provide a
>> DeviceID even if it didn't support MSIs either. Support this, with
>> the usual temporary flag definition while the real one is making
>> its way through ACPICA.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> All the indentations in this patch are using white spaces vs. tabs,

That must be something at your end - they're definitely tabs here, and 
the copy in the lore archives looks right too.

> so it fails at git-apply. I manually fixed them and tested the PATCH
> by applying a small revision hack to the IORT binaries:
> 
> ---------
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 3269a888fb7a..5a4eef7b937c 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -333,8 +333,20 @@ void __iomem __ref
>   		return NULL;
>   	}
>   
> -	if (!acpi_permanent_mmap)
> -		return __acpi_map_table((unsigned long)phys, size);
> +	if (!acpi_permanent_mmap) {
> +		virt = __acpi_map_table((unsigned long)phys, size);
> +		if (!strncmp((char *)virt, "IORT", 4)) {
> +			u8 *tmp = virt;
> +			int i = 0x30;
> +			while (i < size) {
> +				if (tmp[i] == 0x4) /* SMMUv3 */
> +					tmp[i + 3] = 0x5; /* Revision */
> +				i += tmp[i + 1]; /* next node */
> +				continue;
> +			}
> +		}
> +		return virt;
> +	}
>   
>   	mutex_lock(&acpi_ioremap_lock);
>   	/* Check if there's a suitable mapping already. */
> ---------
> 
> Once the indentations are fixed,
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks for confirming!
Robin.

> 
> Thanks!
> Nicolin
> 
>> ---
>>   drivers/acpi/arm64/iort.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index ca2aed86b540..51bc3c1d8d42 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -402,6 +402,10 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>>          return NULL;
>>   }
>>
>> +#ifndef ACPI_IORT_SMMU_V3_DEVICEID_VALID
>> +#define ACPI_IORT_SMMU_V3_DEVICEID_VALID (1 << 4)
>> +#endif
>> +
>>   static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>>   {
>>          struct acpi_iort_smmu_v3 *smmu;
>> @@ -418,12 +422,16 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>>
>>                  smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>>                  /*
>> -                * ID mapping index is only ignored if all interrupts are
>> -                * GSIV based
>> +                * Until IORT E.e (node rev. 5), the ID mapping index was
>> +                * defined to be valid unless all interrupts are GSIV-based.
>>                   */
>> -               if (smmu->event_gsiv && smmu->pri_gsiv && smmu->gerr_gsiv
>> -                   && smmu->sync_gsiv)
>> +               if (node->revision < 5) {
>> +                       if (smmu->event_gsiv && smmu->pri_gsiv &&
>> +                           smmu->gerr_gsiv && smmu->sync_gsiv)
>> +                               return -EINVAL;
>> +               } else if (!(smmu->flags & ACPI_IORT_SMMU_V3_DEVICEID_VALID)) {
>>                          return -EINVAL;
>> +               }
>>
>>                  if (smmu->id_mapping_index >= node->mapping_count) {
>>                          pr_err(FW_BUG "[node %p type %d] ID mapping index overflows valid mappings\n",
>> --
>> 2.36.1.dirty
>>
