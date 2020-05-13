Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B61D054E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 May 2020 05:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEMDQj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 23:16:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgEMDQi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 23:16:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2437A48CDD2EC4FFADEA;
        Wed, 13 May 2020 11:16:36 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 11:16:34 +0800
Subject: Re: [PATCH v2] ACPI/IORT: Fix PMCG node always look for a single ID
 mapping.
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
CC:     <patches@amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1589327760-5464-1-git-send-email-tuanphan@os.amperecomputing.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6f9996d3-18f1-0432-0e59-adc2cf086c9c@huawei.com>
Date:   Wed, 13 May 2020 11:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1589327760-5464-1-git-send-email-tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/13 7:56, Tuan Phan wrote:
> PMCG node can have zero ID mapping if its overflow interrupt
> is wire based. The code to parse PMCG node can not assume it will
> have a single ID mapping.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>

It's better to add

Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")

> ---
> Changes in v2:
> - Used pmcg node to detect wired base overflow interrupt.
>   
>   drivers/acpi/arm64/iort.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1..11a4e8e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -414,6 +414,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>   {
>   	struct acpi_iort_smmu_v3 *smmu;
> +	struct acpi_iort_pmcg *pmcg;
>   
>   	switch (node->type) {
>   	case ACPI_IORT_NODE_SMMU_V3:
> @@ -441,6 +442,10 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>   
>   		return smmu->id_mapping_index;
>   	case ACPI_IORT_NODE_PMCG:
> +		pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +		if (pmcg->overflow_gsiv)
> +			return -EINVAL;
> +
>   		return 0;
>   	default:
>   		return -EINVAL;

With my comments addressed,

Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>

