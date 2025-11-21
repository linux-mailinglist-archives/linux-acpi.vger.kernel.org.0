Return-Path: <linux-acpi+bounces-19176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D9C7713E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 03:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 5A2CF29411
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 02:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A322DC349;
	Fri, 21 Nov 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H6AnNPoi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE478F26;
	Fri, 21 Nov 2025 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763693716; cv=none; b=HxxnVV+yUzZsCW5gU9r1aDNl/xaAwgZ774cCYKw2PNC/ZbJxqQAHvuwfsmJGhibRWEsSeqki52ZNPLY7wcH8jujB6FJEyKFF9uvrhLgFEWD2XATM4833HCMf07mMP1xby8VwYSfb/iTWmCSnjVelSfEtFQlrP+n3SwCNlGxHa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763693716; c=relaxed/simple;
	bh=SoDyP5CR9vD2JgAfyOyNk28v3F/csFAloZXyzayWmNw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qLwNG1EsdWjTnVKjVauFrMGKufNA6wu6GeAIFfR6HNjxjkjzWxvZcTs45xTVXw3Cz42MRphiGwgSFaWkv8u8cztlBuJZ7SJ/XZ1jr5vhSu1HITROBm5SAGrYkVrkKOWR1w39l0OprxTiWOLp45d5KSEBd7x2rtTOKmqsUFOp2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H6AnNPoi; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ER8ewFOGGd8QGx4NBRFdiGjkdK1dvNgkH90P2P9iMT0=;
	b=H6AnNPoiAVnNyOJKYe1Vv04meLzcwXyNABLyUfXIf4bkFRTBacXuNITKhrQpsjfMGbiY1vYwt
	mIu6yoX0FIN0m9xP3o8OWoc+lRFELxfeUe1pl3PyFPF+jp5DoLYzzBUgJecOO8Eg/RFaJlz5D9h
	cF68nkxSXphx8Ukgll6AmKk=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dCKXk6vDyz1cyQG;
	Fri, 21 Nov 2025 10:53:26 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 22A9F180043;
	Fri, 21 Nov 2025 10:55:12 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 10:55:11 +0800
Subject: Re: [PATCH] ACPI: GTDT: Get rid of acpi_arch_timer_mem_init()
To: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20251030110137.1843007-1-maz@kernel.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bdeee7b3-ce47-b4af-4fee-d7d4b50602f8@huawei.com>
Date: Fri, 21 Nov 2025 10:55:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030110137.1843007-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/10/30 19:01, Marc Zyngier wrote:
> Since 0f67b56d84b4c ("clocksource/drivers/arm_arch_timer_mmio: Switch
> over to standalone driver"), acpi_arch_timer_mem_init() is unused.
> 
> Remove it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

