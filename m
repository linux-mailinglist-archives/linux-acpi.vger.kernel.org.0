Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FA1DB453
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETM6f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 08:58:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETM6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 08:58:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A917130E;
        Wed, 20 May 2020 05:58:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246EE3F52E;
        Wed, 20 May 2020 05:58:33 -0700 (PDT)
Date:   Wed, 20 May 2020 13:58:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI/IORT: Fix PMCG node single ID mapping handling.
Message-ID: <20200520125813.GA6906@e121166-lin.cambridge.arm.com>
References: <1589570686-5780-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589570686-5780-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 15, 2020 at 12:24:46PM -0700, Tuan Phan wrote:
> An IORT PMCG node can have no ID mapping if its overflow interrupt is
> wire based therefore the code that parses the PMCG node can not assume
> the node will always have a single mapping present at index 0.
> 
> Fix iort_get_id_mapping_index() by checking for an overflow interrupt
> and mapping count.
> 
> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG").

Remove these periods in the $SUBJECT and commit references, I
don't know why you keep adding them.

Anyway - I don't know if it is too late for v5.8 but this patch
is ready to be merged (minus the nits I have just mentioned).

Lorenzo

> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> v1 -> v2:
> - Use pmcg node to detect wired base overflow interrupt.
> 
> v2 -> v3:
> - Address Hanjun and Robin's comments.
> 
> v3 -> v4:
> - Update the title and description as mentioned by Lorenzo.
> 
>  drivers/acpi/arm64/iort.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ed3d2d1..12bb70e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -414,6 +414,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
> +	struct acpi_iort_pmcg *pmcg;
>  
>  	switch (node->type) {
>  	case ACPI_IORT_NODE_SMMU_V3:
> @@ -441,6 +442,10 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>  
>  		return smmu->id_mapping_index;
>  	case ACPI_IORT_NODE_PMCG:
> +		pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +		if (pmcg->overflow_gsiv || node->mapping_count == 0)
> +			return -EINVAL;
> +
>  		return 0;
>  	default:
>  		return -EINVAL;
> -- 
> 2.7.4
> 
