Return-Path: <linux-acpi+bounces-16921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE89AB574F1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A8B178007
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A232F83D8;
	Mon, 15 Sep 2025 09:31:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81717221DA5;
	Mon, 15 Sep 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928665; cv=none; b=HV98ECYuyDFbUY+AduPuD9cj77gds9bh6mtUBRculIlOMLnYHDCByPOUpWy77pwg9+JRjFWu9pB6ByJb3kTNqDBFyJoC9b3YcFniEvm8CufZic/rGOL7CsbIyV+c/Be5pxuHgPwYxIa09Q9Iaj/FfOyU45+jeQKSoOaFsqjRikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928665; c=relaxed/simple;
	bh=UFhV/7AGyMsS824TQlWmd24PvS2Vmm4dlKYWw7YtZKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjzZpTLtoLJVAgHAoEIUK0mJE0kXiZfUCuUgnWHrXEGENtt+H0NM5xaU5T2JhNy1cvn90hSoWTv+vB1hsK0uSxkwDTRqaGBHuMauwOjqFhrlXhEygGPL+56+iwUw9C+UiC0RCMRc//B/aMbT/KladaF613U3SvzuY63nAHkNP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9831E1063;
	Mon, 15 Sep 2025 02:30:54 -0700 (PDT)
Received: from [10.1.35.47] (unknown [10.1.35.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BDB33F694;
	Mon, 15 Sep 2025 02:31:00 -0700 (PDT)
Message-ID: <ef6ac601-22a6-48f6-98d7-32ff93a2d21e@arm.com>
Date: Mon, 15 Sep 2025 10:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] coresight: trbe: Convert to new IRQ affinity
 retrieval API
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Peter
 <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 James Clark <james.clark@linaro.org>
References: <20250915085702.519996-1-maz@kernel.org>
 <20250915085702.519996-8-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250915085702.519996-8-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 09:56, Marc Zyngier wrote:
> Now that the relevant interrupt controllers are equipped with
> a callback returning the affinity of per-CPU interrupts, switch
> the TRBE driver over to this new method.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Assuming this goes via irqchip tree,

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8267dd1a2130d..c512f8faa6012 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1472,9 +1472,10 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
>   static int arm_trbe_probe_irq(struct platform_device *pdev,
>   			      struct trbe_drvdata *drvdata)
>   {
> +	const struct cpumask *affinity;
>   	int ret;
>   
> -	drvdata->irq = platform_get_irq(pdev, 0);
> +	drvdata->irq = platform_get_irq_affinity(pdev, 0, &affinity);
>   	if (drvdata->irq < 0) {
>   		pr_err("IRQ not found for the platform device\n");
>   		return drvdata->irq;
> @@ -1485,8 +1486,7 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
>   		return -EINVAL;
>   	}
>   
> -	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
> -		return -EINVAL;
> +	cpumask_copy(&drvdata->supported_cpus, affinity);
>   
>   	drvdata->handle = alloc_percpu(struct perf_output_handle *);
>   	if (!drvdata->handle)


