Return-Path: <linux-acpi+bounces-19175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DACC7712C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6AE212BA28
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 02:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4232DC77F;
	Fri, 21 Nov 2025 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0l4c6nxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FB2DC331;
	Fri, 21 Nov 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693608; cv=none; b=kbiCIkmhADNsaWy7rHCn3WJQyyPBjl0ta8b0HWfW/BT7I0Ewr4B0+kLbHpWanuWI25w080iSvTVVca9zLGLpvRnaqcBE9x8VYhhAXJA806juESUHbJGR1a97ZXJJRZuZbFssWSLYoicG/GDlINSS25PMMxOpHTqMD6x5YJvj0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693608; c=relaxed/simple;
	bh=+gsMA1+hWdaO6ed0h8dby9oSLwVDwvWhBVQVPeS1WNI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EW17h5Zl6JNUBDVp4siI1bSIlAsIpxVx/obdieDfQ3hwu+dJm4sH8IchWdxm5jf52n7Fk9xCnIJxVPhqCAeLJB8EZHJod4H+ZIDhmMu3v6R7+owwBV/SHrui/doxOT91XZU7GVClIlGMw4+hwwL79Frvei4q9Hdxj+uzZNUxsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0l4c6nxs; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mAz/1oH2RY8bQ6hSH5AGCpUtof/CMLL2nn5dRziZWjs=;
	b=0l4c6nxsLtQEt4kv9Z2jOFhnMnG2+4V8j/k+e26DRPVij1puraib4XO0X1my4eB/rPeSyx7K5
	Srqv5/WoaPBe7WEGSnJoUlaFBc93Q3Rdc4S4PQGMGLk+4oA29Y6Djsid96RkMJH03JlHy8ZD/OE
	Y/gBG9D0Su0Q0+cKeZVLIww=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCKVY3HPHzKmT1;
	Fri, 21 Nov 2025 10:51:33 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DDBF7140119;
	Fri, 21 Nov 2025 10:53:18 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 10:53:18 +0800
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
To: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
References: <20251030110115.1842961-1-maz@kernel.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c1edd6cc-0542-8d22-6edc-60c619c9e162@huawei.com>
Date: Fri, 21 Nov 2025 10:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030110115.1842961-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/10/30 19:01, Marc Zyngier wrote:
> Use the actual timer counter instead of the watchdog counter.
> 
> Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO timers")
> Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>   drivers/acpi/arm64/gtdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index fd995a1d3d248..8cc8af8fd408c 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
>   				continue;
>   
>   			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
> -							     gwdt_count, &atm,
> +							     mmio_timer_count, &atm,
>   							     sizeof(atm));
>   			if (IS_ERR(pdev)) {
> -				pr_err("Can't register timer %d\n", gwdt_count);
> +				pr_err("Can't register timer %d\n", mmio_timer_count);
>   				continue;
>   			}

"typo" I think :)

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Will this go via ARM64 tree?

Thanks
Hanjun

