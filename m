Return-Path: <linux-acpi+bounces-8861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8639A4B9B
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003421F225E5
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35961DC1BE;
	Sat, 19 Oct 2024 06:47:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9C1D7E4E;
	Sat, 19 Oct 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729320450; cv=none; b=cSpTyKonrQVmhC77UHTLB8hplQFSwJ5jiVMSdzhQsS4FbzSswCOo71DV5FHSvBtg8gE8Sx1vlvOiYfge/6XOZkpZnq1+eB0yGc2WPAIfFs9gCZBT8liFraH9uyvukM9QMme/fLMGCa6s6bkKdi9UlVVtZQoVrljYTtmHtk1t8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729320450; c=relaxed/simple;
	bh=TuluZFAJeAyvx3XPIHzgTg8IdC0i7SLk3CLtCI5BVXs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n0P3PPBa0pDIgMW3WfIIp2vo2r2CTfKa8pQBcy2AdEudxMbToi9b7PVTQHJvxmmE2RAFcbwZlcdCcHnjRmEqYk4c9Ysk5pGu1oD0S/ve7JN6i3fsC7CYaOAb+k52MvHSv5XwYhIkfDwF2yPwWWL4okpUN/pQ78/iZH7MideN2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVsXk1ds5zyT9X;
	Sat, 19 Oct 2024 14:45:58 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BA43140258;
	Sat, 19 Oct 2024 14:47:25 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 14:47:24 +0800
Subject: Re: [PATCH] acpi/arm64: remove unnecessary cast
To: Min-Hua Chen <minhuadotchen@gmail.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240917233827.73167-1-minhuadotchen@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e7632dd4-6009-53f3-e61a-ccb15d9f88f3@huawei.com>
Date: Sat, 19 Oct 2024 14:47:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240917233827.73167-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/9/18 7:38, Min-Hua Chen wrote:
> DEFINE_RES_IRQ returns struct resource type, so it is
> unnecessary to cast it to struct resource.
> 
> Remove the unnecessary cast to fix the following sparse warnings:
> 
> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast to non-scalar
> drivers/acpi/arm64/gtdt.c:355:19: sparse: warning: cast from non-scalar
> 
> No functional changes intended.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>   drivers/acpi/arm64/gtdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..24bd479de91f 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -352,7 +352,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
>   	}
>   
>   	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
> -	res[2] = (struct resource)DEFINE_RES_IRQ(irq);
> +	res[2] = DEFINE_RES_IRQ(irq);
>   	if (irq <= 0) {
>   		pr_warn("failed to map the Watchdog interrupt.\n");
>   		nr_res--;
> 

It's a minor issue, but I think it deserves a patch to make
the code cleaner,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

