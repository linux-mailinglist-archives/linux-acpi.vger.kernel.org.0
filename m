Return-Path: <linux-acpi+bounces-17705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE55BCB90F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 05:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 313E14F8618
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71D26A091;
	Fri, 10 Oct 2025 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Q9xnfrVr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107426B74D;
	Fri, 10 Oct 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067577; cv=none; b=AXjCkw+XQPpqO4d9Ezc3V7KhC5HeadW7CdQ53SnMTyVNyeVaChGrQ6kIHkBa3p2zJy3A8plqNCBbEgocA+4Vn3f1TEIWC6IabdqdBnT91x4shwqqBvBzbtXjRzsLFJR7Gw4KyXfwPj14fHsNtPri8L9YRDfIZVUqJt7xfTSXlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067577; c=relaxed/simple;
	bh=HAHSKsweYgDeZ9whWne147CCDcr2rKaRTzz/0XzYW2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sGJSlK6VIncZeTBOqA8yG1gfcFijRoFmqJHIjCjITak31bsi3O/0g2BxmvOWyFWB0rcnKlwQRmFdNBoXEme1UmVfH5UgwwlvgjGDpNbn9qV8qF6tc+Hd+NYZYVa/9kBeuAb32A0G5H8FfBngyHh7ng14dDejwsAqc35WInCFBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Q9xnfrVr; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cjXRn1SDpzTh8t;
	Fri, 10 Oct 2025 11:34:45 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QfS5ejxh5GqFmut0s+Xz893zHL/kygYE/3kNRX/2D8k=;
	b=Q9xnfrVr0DDuqZ7xoRBKLV+QSlEIy6Nh2e4fWpJLD0pwKnpLggkoKJi0uye7ZYQchgd7BL34x
	9T+Yx+mitq31Nstri3bUTHQfe0NYyf3E4Pzmqy2yZYsJJ1UznXAriHKkpfdvKKW1KtC/O1PpcYx
	WWLHZF/+GWkmNwovjYo0/s8=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cjXXh24Zhz1cyVx;
	Fri, 10 Oct 2025 11:39:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 578531401F3;
	Fri, 10 Oct 2025 11:39:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 11:39:16 +0800
Message-ID: <4491c8b6-adab-1e86-19cc-777a8a9c8858@huawei.com>
Date: Fri, 10 Oct 2025 11:39:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 08/26] perf: arm_pmu: Convert to new IRQ affinity
 retrieval API
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
 <20250922082833.2038905-9-maz@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250922082833.2038905-9-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/9/22 16:28, Marc Zyngier wrote:
> Now that the relevant interrupt controllers are equipped with
> a callback returning the affinity of per-CPU interrupts, switch
> the OF side of the ARM PMU driver over to this new method.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/perf/arm_pmu_platform.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 118170a5cedef..9c0494d8a867a 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -42,14 +42,13 @@ static int probe_current_pmu(struct arm_pmu *pmu,
>  	return ret;
>  }
>  
> -static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq)
> +static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq,
> +				const struct cpumask *affinity)
>  {
> -	int cpu, ret;
>  	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
> +	int cpu;
>  
> -	ret = irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
> -	if (ret)
> -		return ret;
> +	cpumask_copy(&pmu->supported_cpus, affinity);
>  
>  	for_each_cpu(cpu, &pmu->supported_cpus)
>  		per_cpu(hw_events->irq, cpu) = irq;
> @@ -115,9 +114,12 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>  	}
>  
>  	if (num_irqs == 1) {
> -		int irq = platform_get_irq(pdev, 0);
> +		const struct cpumask *affinity;
> +		int irq;
> +
> +		irq = platform_get_irq_affinity(pdev, 0, &affinity);
>  		if ((irq > 0) && irq_is_percpu_devid(irq))
> -			return pmu_parse_percpu_irq(pmu, irq);
> +			return pmu_parse_percpu_irq(pmu, irq, affinity);
>  	}
>  

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  	if (nr_cpu_ids != 1 && !pmu_has_irq_affinity(dev->of_node))

