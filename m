Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695F4AD742
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Feb 2022 12:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiBHLcU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Feb 2022 06:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356873AbiBHLKe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Feb 2022 06:10:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8611C03FEC0
        for <linux-acpi@vger.kernel.org>; Tue,  8 Feb 2022 03:10:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68011D4;
        Tue,  8 Feb 2022 03:10:33 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800FC3F73B;
        Tue,  8 Feb 2022 03:10:32 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:10:26 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        catalin.marinas@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] ACPI/IORT: Check node revision for PMCG resources
Message-ID: <20220208111026.GA6233@lpieralisi>
References: <75628ae41c257fb73588f7bf1c4459160e04be2b.1643916258.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75628ae41c257fb73588f7bf1c4459160e04be2b.1643916258.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 03, 2022 at 07:31:24PM +0000, Robin Murphy wrote:
> The original version of the IORT PMCG definition had an oversight
> wherein there was no way to describe the second register page for an
> implementation using the recommended RELOC_CTRS feature. Although the
> spec was fixed, and the final patches merged to ACPICA and Linux written
> against the new version, it seems that some old firmware based on the
> original revision has survived and turned up in the wild.
> 
> Add a check for the original PMCG definition, and avoid filling in the
> second memory resource with nonsense if so. Otherwise it is likely that
> something horrible will happen when the PMCG driver attempts to probe.
> 
> Reported-by: Michael Petlan <mpetlan@redhat.com>
> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Simpler workaround, since I realised platform_get_resource()
>     should happily just skip over a zero-initialised hole in the
>     resource array.
> 
>  drivers/acpi/arm64/iort.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Should we send it to stable kernels ?

I'd kindly ask Catalin/Will to pick it up please.

Thanks,
Lorenzo

> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 175397913be1..7092b94b2aae 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1371,9 +1371,17 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
>  	res[0].start = pmcg->page0_base_address;
>  	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
>  	res[0].flags = IORESOURCE_MEM;
> -	res[1].start = pmcg->page1_base_address;
> -	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> -	res[1].flags = IORESOURCE_MEM;
> +	/*
> +	 * The initial version in DEN0049C lacked a way to describe register
> +	 * page 1, which makes it broken for most PMCG implementations; in
> +	 * that case, just let the driver fail gracefully if it expects to
> +	 * find a second memory resource.
> +	 */
> +	if (node->revision > 0) {
> +		res[1].start = pmcg->page1_base_address;
> +		res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> +		res[1].flags = IORESOURCE_MEM;
> +	}
>  
>  	if (pmcg->overflow_gsiv)
>  		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> -- 
> 2.28.0.dirty
> 
