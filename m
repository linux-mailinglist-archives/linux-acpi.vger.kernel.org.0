Return-Path: <linux-acpi+bounces-17707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8FBCB967
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 06:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DC04E247A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 04:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384F433B3;
	Fri, 10 Oct 2025 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l9lGzF70"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78930C2EA;
	Fri, 10 Oct 2025 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068809; cv=none; b=LVDCWlWLojpdE+bvy0QdDFX/cO9ko4IcQAx39wX5Ce/lBUmdzYF4DU7Kq4jtmSuByuvNrP/4ZaouhrzFpuIXLkWDX0+LFtLTg8W4oHe1ispFDi1xypzVMkh92NvIaRG+vuqwY/itNXzHzkeERmF5RCnYyj+lH5UWyWTeZnEttCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068809; c=relaxed/simple;
	bh=FEMzFMjlL0olVV+s4U5QQXQVBeOiTTXpdL+OsP2gbfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OfqdabvpW20Nd+X7KUJflzxbGKY+t1aD/X8Iwc/YUDTE2oX6+0ivRQ5ntRHt+bDebxPnh0aXd0SWuUvj49bRA2hLbuJMOMJ7a8tPyYB9siftsa3Y+gTxm6CMNplHaB0isUugsyJrXzASPjRIGbZi+byqijNlTqlYSQ5pqHDxQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l9lGzF70; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vXp9FK80IBNcMVhCOtsMWfNtGvpQvwTItDMeUKloxVA=;
	b=l9lGzF70bPdjT0nV5RiTGSfa8jTXN4gvTl8kJcHJnZvZ1D4yh8qRTU2qP2yITch55LKQU+AKi
	jIDXYtXSit6MOPt1HHgSH2Mm0HJ4zI6ctgMGGNr0lvVCLujslUlnm5EN4pxHJjQsbjPXJyKwen8
	+il0WfnGnegPH1HI50rMITA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cjY032lryznTWt;
	Fri, 10 Oct 2025 11:59:15 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B67D180042;
	Fri, 10 Oct 2025 12:00:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 12:00:02 +0800
Message-ID: <46d6bf56-3e7a-92d9-218f-4135d8850be9@huawei.com>
Date: Fri, 10 Oct 2025 11:59:59 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 13/26] genirq: Factor-in percpu irqaction creation
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James
 Clark <james.clark@linaro.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
References: <20250922082833.2038905-1-maz@kernel.org>
 <20250922082833.2038905-14-maz@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250922082833.2038905-14-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/9/22 16:28, Marc Zyngier wrote:
> Move the code creating a per-cpu irqaction into its own helper, so that
> future changes to this code can be kept localised.
> 
> At the same time, fix the documentation which appears to say the wrong
> thing when it comes to interrupts being automatically enabled
> (percpu_devid interrupts never are).
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  kernel/irq/manage.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c94837382037e..d9ddc30678b5d 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2442,6 +2442,24 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
>  	return retval;
>  }
>  
> +static
> +struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long flags,
> +					  const char *devname, void __percpu *dev_id)
> +{
> +	struct irqaction *action;
> +
> +	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +	if (!action)
> +		return NULL;
> +
> +	action->handler = handler;
> +	action->flags = flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
> +	action->name = devname;
> +	action->percpu_dev_id = dev_id;
> +
> +	return action;
> +}

This helper could be more universal by consider by distinguishing dev_id
and percpu_dev_id， so we can use it in request_nmi() and
request_threaded_irq() .

> +
>  /**
>   * __request_percpu_irq - allocate a percpu interrupt line
>   * @irq:	Interrupt line to allocate
> @@ -2450,9 +2468,9 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
>   * @devname:	An ascii name for the claiming device
>   * @dev_id:	A percpu cookie passed back to the handler function
>   *
> - * This call allocates interrupt resources and enables the interrupt on the
> - * local CPU. If the interrupt is supposed to be enabled on other CPUs, it
> - * has to be done on each CPU using enable_percpu_irq().
> + * This call allocates interrupt resources, but doesn't enable the interrupt
> + * on any CPU, as all percpu-devid interrupts are flagged with IRQ_NOAUTOEN.
> + * It has to be done on each CPU using enable_percpu_irq().
>   *
>   * @dev_id must be globally unique. It is a per-cpu variable, and
>   * the handler gets called with the interrupted CPU's instance of
> @@ -2477,15 +2495,10 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
>  	if (flags && flags != IRQF_TIMER)
>  		return -EINVAL;
>  
> -	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +	action = create_percpu_irqaction(handler, flags, devname, dev_id);
>  	if (!action)
>  		return -ENOMEM;
>  
> -	action->handler = handler;
> -	action->flags = flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
> -	action->name = devname;
> -	action->percpu_dev_id = dev_id;
> -
>  	retval = irq_chip_pm_get(&desc->irq_data);
>  	if (retval < 0) {
>  		kfree(action);
> @@ -2546,16 +2559,11 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
>  	if (irq_is_nmi(desc))
>  		return -EINVAL;
>  
> -	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
> +	action = create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCING,
> +					 name, dev_id);
>  	if (!action)
>  		return -ENOMEM;
>  
> -	action->handler = handler;
> -	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_NO_THREAD
> -		| IRQF_NOBALANCING;
> -	action->name = name;
> -	action->percpu_dev_id = dev_id;
> -
>  	retval = irq_chip_pm_get(&desc->irq_data);
>  	if (retval < 0)
>  		goto err_out;

