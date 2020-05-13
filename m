Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE44D1D0FB2
	for <lists+linux-acpi@lfdr.de>; Wed, 13 May 2020 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEMK3D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 May 2020 06:29:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgEMK3C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 May 2020 06:29:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E4691FB;
        Wed, 13 May 2020 03:29:01 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F355B3F305;
        Wed, 13 May 2020 03:28:59 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI/IORT: Fix PMCG node always look for a single ID
 mapping.
To:     Hanjun Guo <guohanjun@huawei.com>,
        Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        patches@amperecomputing.com, linux-arm-kernel@lists.infradead.org,
        Len Brown <lenb@kernel.org>
References: <1589327760-5464-1-git-send-email-tuanphan@os.amperecomputing.com>
 <6f9996d3-18f1-0432-0e59-adc2cf086c9c@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2c2795ed-c2cb-a166-cd6d-0e920bd05ea3@arm.com>
Date:   Wed, 13 May 2020 11:28:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6f9996d3-18f1-0432-0e59-adc2cf086c9c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-05-13 4:16 am, Hanjun Guo wrote:
> On 2020/5/13 7:56, Tuan Phan wrote:
>> PMCG node can have zero ID mapping if its overflow interrupt
>> is wire based. The code to parse PMCG node can not assume it will
>> have a single ID mapping.
>>
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> 
> It's better to add
> 
> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
> 
>> ---
>> Changes in v2:
>> - Used pmcg node to detect wired base overflow interrupt.
>>   drivers/acpi/arm64/iort.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index ed3d2d1..11a4e8e 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -414,6 +414,7 @@ static struct acpi_iort_node 
>> *iort_node_get_id(struct acpi_iort_node *node,
>>   static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>>   {
>>       struct acpi_iort_smmu_v3 *smmu;
>> +    struct acpi_iort_pmcg *pmcg;
>>       switch (node->type) {
>>       case ACPI_IORT_NODE_SMMU_V3:
>> @@ -441,6 +442,10 @@ static int iort_get_id_mapping_index(struct 
>> acpi_iort_node *node)
>>           return smmu->id_mapping_index;
>>       case ACPI_IORT_NODE_PMCG:
>> +        pmcg = (struct acpi_iort_pmcg *)node->node_data;
>> +        if (pmcg->overflow_gsiv)

	if (pmcg->overflow_gsiv || node->mapping_count == 0)

...if there is no GSIV, we should still *also* check that index 0 is 
valid before we return it.

Robin.

>> +            return -EINVAL;
>> +
>>           return 0;
>>       default:
>>           return -EINVAL;
> 
> With my comments addressed,
> 
> Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
