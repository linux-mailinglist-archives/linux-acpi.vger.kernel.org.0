Return-Path: <linux-acpi+bounces-8860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350B9A4B97
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AC41C2204D
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97E1DC07B;
	Sat, 19 Oct 2024 06:41:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2571D2704;
	Sat, 19 Oct 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729320089; cv=none; b=KvvHV/sKOiELZQxojEUDrJ4YDdLjXTO3JQD9wHVdutAg4NxSlDid3kZV/dBBN22Ci3c9Daqsv34fC+OUF9xDTALbA5H1LvwuP3vLCCtqK1I0AURBP50UezZdjSbvRMn8zc4/i6nabSCIfdl3NKhwikxNc8zKLEZFixIbrdBKzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729320089; c=relaxed/simple;
	bh=sDY5sKHK1RUNYpSHzuRV0CuT80rp/8pk8NwaBaz8Zzw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UHG0lmL9ysz5m+++7e9JLXolLC6sUbUEZ5JWHuh3RUwN6BEyA2QjH14jjwlF5nu4jGFDQdvdS8+XYlmimAhw31JYkrnLNnutbM6pkr8NJWDxEkUuHZODYu3IxITrMEhf5VB7A/AqJlgihYPkAk98+pK5/Nn7jA4XOfDH4OP4FLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XVsPp0ZVhz1SCpM;
	Sat, 19 Oct 2024 14:39:58 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FFF41A0188;
	Sat, 19 Oct 2024 14:41:16 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 14:41:15 +0800
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
To: Zheng Zengkai <zhengzengkai@huawei.com>, <lpieralisi@kernel.org>,
	<sudeep.holla@arm.com>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c1b7159e-3bd1-ff2d-da94-fcf5a48220d2@huawei.com>
Date: Sat, 19 Oct 2024 14:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241016095458.34126-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/16 17:54, Zheng Zengkai wrote:
> As suggested by Marc and Lorenzo, first we need to check whether the
> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
> de-referencing what it points at to detect the length of the platform
> timer struct and then check that the length of current platform_timer
> struct is also valid, i.e. the length is not zero and within gtdt_end.
> Now next_platform_timer() only checks against gtdt_end for the entry of
> subsequent platform timer without checking the length of it and will
> not report error if the check failed and the existing check in function
> acpi_gtdt_init() is also not enough.
> 
> Modify the for_each_platform_timer() iterator and use it combined with
> a dedicated check function platform_timer_valid() to do the check
> against table length (gtdt_end) for each element of platform timer
> array in function acpi_gtdt_init(), making sure that both their entry
> and length actually fit in the table.
> 
> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Co-developed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Nit: since there is a "Co-developed-by:" for Marc, the
"Signed-off-by:" can be removed. The rest of the patch looks
good to me.

I did a test again Kunpeng ARM sever and no regressions,
hopefully will not trigger firmware bugs for other
platforms.

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

