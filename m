Return-Path: <linux-acpi+bounces-17044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1CB59D6D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213603A49AB
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5331FEE2;
	Tue, 16 Sep 2025 16:19:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D127B347;
	Tue, 16 Sep 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039591; cv=none; b=Sc4K7OVTR7aGEWFTK/Hlptrcu4LBmPkHm8FlE9XtyWC36uoE6SC6zSuZLoPFb3R5Att7Ubk/bEK/ERJDHS1G2so16M/gEDsRQhx5PsrkrKtqFWyCq3iIxDozFZR73ew+1+Lynd/9hKGE7xY68f5a6DjCUgZtfi9O1W0aJ7TOdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039591; c=relaxed/simple;
	bh=bJcQW5p9EO0GU8UiAUBpNbVfPaMHH18JNPsKxz+LU8g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H70l80lqTrvk9Jlgn+4SdV58JP2K5FbFzyLeiMiHypM8gGLYMFOY+Wd6iQTzRG+uvKhPkjwhnLedXLL+4dDLGLVO5szw9WIu5RdLPL21Q3N/NnYmOuO/2UtxJrjiMF+p+CERQRA87YwErx2uveZZ20faWy8j2vLLuIJwV3WM/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR6VL2XSNz6K9LN;
	Wed, 17 Sep 2025 00:16:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A9AFB1402F1;
	Wed, 17 Sep 2025 00:19:45 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 18:19:44 +0200
Date: Tue, 16 Sep 2025 17:19:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>
Subject: Re: [PATCH v2 15/25] genirq: Update request_percpu_nmi() to take an
 affinity
Message-ID: <20250916171943.000032d6@huawei.com>
In-Reply-To: <20250915085702.519996-16-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-16-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 09:56:52 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Continue spreading the notion of affinity to the percpu interrupt
> request code by updating the call sites that use request_percpu_nmi()
> (all two of them) to take an affinity pointer. This pointer is
> firmly NULL for now.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
A few fussy reviewer comments inline.

> ---
>  arch/arm64/kernel/smp.c   |  2 +-
>  drivers/perf/arm_pmu.c    |  4 +++-
>  include/linux/interrupt.h |  4 ++--
>  kernel/irq/manage.c       | 11 +++++++----
>  4 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 68cea3a4a35ca..6fb838eee2e7d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1094,7 +1094,7 @@ static void ipi_setup_sgi(int ipi)
>  	irq = ipi_irq_base + ipi;
>  
>  	if (ipi_should_be_nmi(ipi)) {
> -		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
> +		err = request_percpu_nmi(irq, ipi_handler, "IPI", NULL, &irq_stat);
>  		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
>  	} else {
>  		err = request_percpu_irq(irq, ipi_handler, "IPI", &irq_stat);
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 5c310e803dd78..de9eca2290a97 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -659,7 +659,9 @@ int armpmu_request_irq(int irq, int cpu)
>  			irq_ops = &pmunmi_ops;
>  		}
>  	} else if (armpmu_count_irq_users(irq) == 0) {
> -		err = request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
> +		err = request_percpu_nmi(irq, handler, "arm-pmu",
> +					 NULL,

I was assuming this odd formatting was to help reduce churn in a later patch, but nope
this whole block get replaced in patch 18.  So might as well move NULL up a line
an have a cleaner intermediate state.

> +					 &cpu_armpmu);
>  
>  		/* If cannot get an NMI, get a normal interrupt */
>  		if (err) {
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 52147d5f432b3..2134e7c08c169 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -197,8 +197,8 @@ request_percpu_irq(unsigned int irq, irq_handler_t handler,
>  }
>  
>  extern int __must_check
> -request_percpu_nmi(unsigned int irq, irq_handler_t handler,
> -		   const char *devname, void __percpu *dev);
> +request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *devname,
Odd inconsistency in parameter naming devname/name

Perhaps worth tidying that up whilst here. I only noticed because of the
wrap comment below.


> +		   const struct cpumask *affinity, void __percpu *dev_id);
>  
>  extern const void *free_irq(unsigned int, void *);
>  extern void free_percpu_irq(unsigned int, void __percpu *);
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 5f4c651677436..49c237aca2a70 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2527,6 +2527,7 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
>   * @irq:	Interrupt line to allocate
>   * @handler:	Function to be called when the IRQ occurs.
>   * @name:	An ascii name for the claiming device
> + * @affinity:	A cpumask describing the target CPUs for this interrupt
>   * @dev_id:	A percpu cookie passed back to the handler function
>   *
>   * This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
> @@ -2544,7 +2545,8 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
>   * will fail returning a negative value.
>   */
>  int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
> -		       const char *name, void __percpu *dev_id)
> +		       const char *name,
> +		       const struct cpumask *affinity, void __percpu *dev_id)

This seems like an odd wrap and I can't immediately see it making more sense
in later patches.

>  {

>  


