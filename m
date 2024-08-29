Return-Path: <linux-acpi+bounces-7961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA196476C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF1B24CBD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C01946C4;
	Thu, 29 Aug 2024 13:52:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC042A96;
	Thu, 29 Aug 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939574; cv=none; b=SA55vJPRAetatd60t7/ZcDhkI8JuWyjUu1KfPlUJLZPi0G2NV1ElMik/P4pvv/cahTTKfC5YgriJaWzzYhpPE6ak1RuneQi4MXSG1Jolc6NJYlldZuuIPHLsJR+Vrc4xLNSVAI8fUgw7PZ5oSDIoab5f2JaY53xJBNRaWNMTJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939574; c=relaxed/simple;
	bh=GCrCUmkL3lEkFSY2Xmrjgpf2mHTKOAuoT0wdLOC6swg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bBa0MVbTrMb//AlMNE18aVsUd8djOhtQ3+ZuANldbTneDV6OVHeNKxNhxYn5Xv66I5yFiP7IOnFzFXL0QXAB5db4Jxs2XFAUHK5YysBqYwP7ldLE48L2inZKWWTk+++cvT9F442fRxCqKZ2bLd9+UCdXOw933kFlmUzItA0YjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvjQW4Dzhz1S9FQ;
	Thu, 29 Aug 2024 21:52:35 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id ED9EA140153;
	Thu, 29 Aug 2024 21:52:48 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 21:52:48 +0800
Subject: Re: [PATCH] acpi/arm64: Adjust error handling procedure in
 gtdt_parse_timer_block()
To: Aleksandr Mishin <amishin@t-argos.ru>, Fu Wei <fu.wei@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <20240827101239.22020-1-amishin@t-argos.ru>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <66f51691-db2b-5c1b-865f-a3ee708f670a@huawei.com>
Date: Thu, 29 Aug 2024 21:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827101239.22020-1-amishin@t-argos.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/27 18:12, Aleksandr Mishin wrote:
> In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
> will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
> because do{} block will be executed even if 'i == 0'.
> 
> Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/acpi/arm64/gtdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09..eb6c2d360387 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -283,7 +283,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
>   		if (frame->virt_irq > 0)
>   			acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
>   		frame->virt_irq = 0;
> -	} while (i-- >= 0 && gtdt_frame--);
> +	} while (i-- > 0 && gtdt_frame--);

Good catch,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

It's a fix in the error path, so I think it's OK for next release cycle.

Thanks
Hanjun

