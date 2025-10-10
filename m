Return-Path: <linux-acpi+bounces-17706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC79BCB924
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 05:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B04F3720
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 03:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9141268C40;
	Fri, 10 Oct 2025 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dUfzL1br"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064B3D76;
	Fri, 10 Oct 2025 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067688; cv=none; b=UOfMzPUXNK4TW66WZBuB4+5pucnU9zt4GUk+UAajGE5Zq03Ue4ucCuGUsOWsPoX6zeqmbj+6ycQW6m5Pxwzt8bewlCMIzjELoXA6DVH6S5jx+0R3DKWn9Jjf51bvoNySINkW3Zkrw7bzYIim3IpRWIGiKcAvfGDgzT5k6mgwI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067688; c=relaxed/simple;
	bh=Z9CW37xU5+4MOU34pEGDAWryAljY9qOsHKNFc7fKDZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OmNnFPGG7xkin7LEG2mDi1o5rj0HI0RhXVf9tOHwqrhy7FuZK9idVzykvptwGqB/Zb8Bcm4GyfNuKoBhAfH6s3/dRW6Vt/3EeqWZ3cvPgr8kPtfaBwe/Jk2h/FIdWdx3Ig/Q9d6HHADcd1Ni9kaIh6jAKHtoP76gvFSmPTyj7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dUfzL1br; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6ib9FPglNu41CzWqVMwNxnGJL+FukWXzH1VDfijrkoY=;
	b=dUfzL1brp36gtrQslDAIiDiRXLr5YllztSUN9fxkQsmF3d3cb8W9f/FaTOlXw/qNZxOUE3dGx
	stzw4ksTgDb2c2LIbIki/+MsSdrX9XP553OU2mvHEKmQh1wU+TDnSOvBCO8jOvs0EquzrVQUTlf
	74kKI5T5PGkQgsTGqR3nYtc=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cjXZY6dqYzpTKC;
	Fri, 10 Oct 2025 11:40:37 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 86CFB140279;
	Fri, 10 Oct 2025 11:41:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Oct 2025 11:41:22 +0800
Message-ID: <fa16cacc-07a8-ae85-a391-1736765f1cad@huawei.com>
Date: Fri, 10 Oct 2025 11:41:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 09/26] perf: arm_spe_pmu: Convert to new IRQ affinity
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
 <20250922082833.2038905-10-maz@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250922082833.2038905-10-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/9/22 16:28, Marc Zyngier wrote:
> Now that the relevant interrupt controllers are equipped with
> a callback returning the affinity of per-CPU interrupts, switch
> the ARM SPE driver over to this new method.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 369e77ad5f13f..a1c86a1f21427 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -1211,8 +1211,10 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pmu *spe_pmu)
>  static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
>  {
>  	struct platform_device *pdev = spe_pmu->pdev;
> -	int irq = platform_get_irq(pdev, 0);
> +	const struct cpumask *affinity;
> +	int irq;
>  
> +	irq = platform_get_irq_affinity(pdev, 0, &affinity);
>  	if (irq < 0)
>  		return -ENXIO;
>  
> @@ -1221,10 +1223,7 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
>  		return -EINVAL;
>  	}
>  
> -	if (irq_get_percpu_devid_partition(irq, &spe_pmu->supported_cpus)) {
> -		dev_err(&pdev->dev, "failed to get PPI partition (%d)\n", irq);
> -		return -EINVAL;
> -	}
> +	cpumask_copy(&spe_pmu->supported_cpus, affinity);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  	spe_pmu->irq = irq;
>  	return 0;

