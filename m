Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AF1D2B6D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENJ3x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 05:29:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgENJ3x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 May 2020 05:29:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F26531B;
        Thu, 14 May 2020 02:29:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47A93F71E;
        Thu, 14 May 2020 02:29:50 -0700 (PDT)
Date:   Thu, 14 May 2020 10:29:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI/IORT: Fix PMCG node always look for a single ID
 mapping.
Message-ID: <20200514092944.GA18032@e121166-lin.cambridge.arm.com>
References: <1589415122-5899-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589415122-5899-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Please update the subject:

Subject: "ACPI/IORT: Fix PMCG node single ID mapping handling"

On Wed, May 13, 2020 at 05:12:02PM -0700, Tuan Phan wrote:
> PMCG node can have zero ID mapping if its overflow interrupt
> is wire based. The code to parse PMCG node can not assume it will
> have a single ID mapping.

"An IORT PMCG node can have no ID mapping if its overflow interrupt is
wire based therefore the code that parses the PMCG node can not assume
the node will always have a single mapping present at index 0.

Fix iort_get_id_mapping_index() by checking for an overflow interrupt
and mapping count."

> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
> Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> v1 -> v2:
> - Use pmcg node to detect wired base overflow interrupt.
> 
> v2 -> v3:
> - Address Hanjun and Robin's comments.
> 
>  drivers/acpi/arm64/iort.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
