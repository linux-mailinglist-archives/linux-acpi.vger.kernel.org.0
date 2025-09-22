Return-Path: <linux-acpi+bounces-17211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2DB929F9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269882A6DB6
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194F31A551;
	Mon, 22 Sep 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moLJzsOW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5E31A54B;
	Mon, 22 Sep 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566625; cv=none; b=jf4JJqhwqG2vbSm8DV62xuxRkMKmI/Oixqkg60ru5QfK0OrO+NFPN1Rjdl82cKu/m89H7LY+muLUS36awSwFGJ8RFYY1hqXnrQLapVbGBG24sBAJzYdHOAMB6OkHzGIxDAdYIUodev1EmFmTBz2QLvwmQ+8Wve6uApd++I60j40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566625; c=relaxed/simple;
	bh=hvo9whrU6Oe08PtPIH2oc+mLj8QJ5uC8qV5k/Mjiz8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p425KY44qa1CAqLwSPABh/KKwj+TqRIANWbS+xzan9UvvpWZ85lONBVFqJM9Nh65rEGQwSehthm7B2Jf1E+i2wKY52Tm1hKUcN8YXiXc7xI9HizzmnyDMjHcs6WnRwv67vgHqlx2VxmcUf/2rb6zoi/V/ABHgxEeLqqTyEVDGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moLJzsOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36008C4CEF0;
	Mon, 22 Sep 2025 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758566625;
	bh=hvo9whrU6Oe08PtPIH2oc+mLj8QJ5uC8qV5k/Mjiz8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moLJzsOWRr8vIRDkJ7j/azsOpKAfKWNvEmKAUaHVLd7rSG4XJkgFU+s6whwI3sjel
	 C9EE1spuHM2yOLUdoeDgTiYO31INGIEJ2KxMDy03bWzdW/uaFjsqcrY2jX2CWwFRCr
	 Uu1hf/Eds2tAnx3oKLrD1gdAeBQDS547Y0R2Ad9XBkH8FsEvoMQMww3PNS/Jk8/5eR
	 JnTEMkAZYldEur7UyQZ8VQrXgpzUa1kcRJXyR7RkTa/MNJTkgfDgMvmMjKl/1ezkft
	 EY2PO84e/1HbUE5Nm4qjJYR+JCJQHteKSHlg2j2jRIlkhMNgv2PZgJr15oyT/ToCgi
	 TQfnps53dLxXw==
Message-ID: <24bf4cd9-c992-463a-a17d-0a828c16f8f0@kernel.org>
Date: Mon, 22 Sep 2025 20:43:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/26] irqchip/apple-aic: Drop support for custom PMU
 irq partitions
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 James Clark <james.clark@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20250922082833.2038905-1-maz@kernel.org>
 <20250922082833.2038905-23-maz@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250922082833.2038905-23-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.25 10:28, Marc Zyngier wrote:
> Similarly to what has been done for GICv3, drop the irq partitioning
> support from the AIC driver, effectively merging the two per-cpu
> interrupts for the PMU.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>


>   drivers/irqchip/irq-apple-aic.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index cb8b6f40ce8d3..6305d25b9e77b 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -578,16 +578,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>   	}
>   
>   	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
> -			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
> -		int irq;
> -		if (cpumask_test_cpu(smp_processor_id(),
> -				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
> -			irq = AIC_CPU_PMU_P;
> -		else
> -			irq = AIC_CPU_PMU_E;
> +			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT))
>   		generic_handle_domain_irq(aic_irqc->hw_domain,
> -					  AIC_FIQ_HWIRQ(irq));
> -	}
> +					  AIC_FIQ_HWIRQ(AIC_CPU_PMU_P));

Probably one of the most confusing diffs for a change that's actually 
fairly simple that the diff algorithm generated! I was only able to tell 
what's going on by looking at the file after applying this.





Sven

