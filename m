Return-Path: <linux-acpi+bounces-14824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85432AEC59A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jun 2025 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46083B9B3A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jun 2025 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA76221287;
	Sat, 28 Jun 2025 07:42:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED63FC2;
	Sat, 28 Jun 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096528; cv=none; b=EMsABkmTk9ycBjeSGPcqVobZeD0rxgv4nTOsUlCGjeeR42KHd84GzW9YWLriHUNW0EwZS/+4hBI+XIzdQZ0L+EEpE4Yw5QIjrisxWA7O5ev6eOGJ/zIVDJC+igewTOnWQCf16yvOfgoKa6TbL4nMF4I+vXnM1+Iz5IdE6PeeHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096528; c=relaxed/simple;
	bh=QZI4f0Jg7b0IvKOoiNsofEQtiG+a1gOaMn0v3Y3FbEQ=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f+CEnzmSe48bKgQTt1L4QED1sR1GBGBCVJSz/xM8t89QW1iOyLXsqyiPTt91eS5oaFOhsucaH7jyugWh9g0BQ4yc0MXcwb/5vmDnKldOhYOW53ibGBFRAJ7dahW1AqgyOSGHrU4QRYMKA5khpYs6Q4EY7i62rqsyOkNVs30wOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bTklm3rKCz10XKK;
	Sat, 28 Jun 2025 15:37:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 30664180492;
	Sat, 28 Jun 2025 15:42:03 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Jun 2025 15:42:02 +0800
Subject: Re: [PATCH v2 0/2] ACPI: Improve SPCR handling and messaging on
 SPCR-less systems
To: Li Chen <me@linux.beauty>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Liu Wei <liuwei09@cestc.cn>, Ryan Roberts
	<ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250620131309.126555-1-me@linux.beauty>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <67983ddc-b8f8-43b5-209f-ca77c91fe56b@huawei.com>
Date: Sat, 28 Jun 2025 15:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250620131309.126555-1-me@linux.beauty>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/6/20 21:13, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> This small series improves the kernel behavior and output when the ACPI SPCR
> table is not present or not supported.
> 
> Currently, even on systems that completely lack an SPCR table, the kernel prints:
> "Use ACPI SPCR as default console: Yes"
> 
> This may mislead users into thinking an SPCR table exists
> when in fact there is no such table at all. This series addresses this in two steps:
> 
> Patch 1 ensures that acpi_parse_spcr() returns -ENODEV if CONFIG_ACPI_SPCR_TABLE is disabled.
> 
> Patch 2 updates arm64 acpi_boot_table_init() to only print the Yes
> if acpi_parse_spcr() succeeds.
> 
> This results in cleaner and more accurate boot logs on ARM64.
> 
> Tested on both SPCR-enabled and SPCR-less qemu-system arm64 virt platform. [1]
> 
> Changelog:
> v2: refine the printk message logic as suggested by Hanjun Guo. [2]
> 
> [1]: https://patchew.org/QEMU/20250528105404.457729-1-me@linux.beauty/
> [2]: https://www.spinics.net/lists/kernel/msg5730585.html
> 
> Li Chen (2):
>    ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is
>      disabled
>    ACPI: Suppress misleading SPCR console message when SPCR table is
>      absent
> 
>   arch/arm64/kernel/acpi.c | 10 +++++++---
>   include/linux/acpi.h     |  2 +-
>   2 files changed, 8 insertions(+), 4 deletions(-)

This version looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

