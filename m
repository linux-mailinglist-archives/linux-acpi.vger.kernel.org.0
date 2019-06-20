Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC5034CB3D
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfFTJoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 05:44:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfFTJoD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jun 2019 05:44:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BB59360;
        Thu, 20 Jun 2019 02:44:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5548C3F246;
        Thu, 20 Jun 2019 02:44:02 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:43:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, lee.jones@linaro.org,
        leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190620094357.GA20872@e121166-lin.cambridge.arm.com>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 19, 2019 at 02:18:31PM +0200, Ard Biesheuvel wrote:
> Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> are clearly ACPI 5.1 based, given that that is the first ACPI revision
> that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> which has a non-zero field on those systems.
> 
> So in these cases, infer from the ARM boot flags that the FADT must be
> 5.1 or later, and treat it as 5.1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

AFAICS this should be harmless, so:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 803f0494dd3e..7722e85fb69c 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -155,10 +155,14 @@ static int __init acpi_fadt_sanity_check(void)
>  	 */
>  	if (table->revision < 5 ||
>  	   (table->revision == 5 && fadt->minor_revision < 1)) {
> -		pr_err("Unsupported FADT revision %d.%d, should be 5.1+\n",
> +		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 5.1+\n",
>  		       table->revision, fadt->minor_revision);
> -		ret = -EINVAL;
> -		goto out;
> +
> +		if (!fadt->arm_boot_flags) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		pr_err("FADT has ARM boot flags set, assuming 5.1\n");
>  	}
>  
>  	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> -- 
> 2.20.1
> 
