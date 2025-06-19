Return-Path: <linux-acpi+bounces-14467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE7AE08F9
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD31882B74
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBD226541;
	Thu, 19 Jun 2025 14:42:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0C1F4C9F;
	Thu, 19 Jun 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344159; cv=none; b=F4gQExces4hbQ55VV2Ly8tHJUnh4LNQBoJNSW/DEafTtjfqCUbv/R8LsY4eEguvR4R107L0KLKsJ89b9Pi0orlxu3smRcT0zdORjxCjJD35Ex4xQf4rGhrY3/ZhCLjaKsv4L463oRQCqEO87A5pZUbAqXaXOY2qOggv8eTitIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344159; c=relaxed/simple;
	bh=gdTGjd6pcw2UEWFBhdQNIPDZSoY1C0kjX28xf7y7oe8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tfKZ/exbRyRmJIvKUjcWY39+xsZ3LmoL2oRAaCaIAJ8zNkIrhxN26V38aDT3rYPBWZFjDRGmdDP2QTg3HucoOZhoG3D7EbACgSucE/WHUNxXNGst6qi/CVgASdd7bpoRCdOgfcUvl2JDVPTYO18cs4E2wf89UhNhUP6v/Nne1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bNNYt6MQ2z1d1qs;
	Thu, 19 Jun 2025 22:40:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E3B2E14011A;
	Thu, 19 Jun 2025 22:42:31 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 22:42:30 +0800
Subject: Re: [PATCH 0/2] ACPI: Improve SPCR handling and messaging on
 SPCR-less systems
To: Li Chen <me@linux.beauty>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Liu Wei <liuwei09@cestc.cn>, Ryan Roberts
	<ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Li Chen <chenl311@chinatelecom.cn>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20250606072802.191580-1-me@linux.beauty>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <af292806-633e-287a-2c05-777ac7bab22b@huawei.com>
Date: Thu, 19 Jun 2025 22:42:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250606072802.191580-1-me@linux.beauty>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Li Chen,

On 2025/6/6 15:27, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> This small series improves the kernel behavior and output when the ACPI SPCR
> table is not present or not supported.
> 
> Currently, even on systems that completely lack an SPCR table, the kernel prints:
> "Use ACPI SPCR as default console: Yes"

Agreed, this is wrong, we need to fix it.

> 
> Or if with acpi=nospcr:
> "Use ACPI SPCR as default console: No"

I think this is OK, it's just to let you know we are not
using ACPI SPCR console when ACPI is enabled, including
cases with no SPCR table.

> 
> This may mislead users into thinking an SPCR table exists
> when in fact there is no such table at all. This series addresses this in two steps:
> 
> Patch 1 ensures that acpi_parse_spcr() returns -ENODEV if CONFIG_ACPI_SPCR_TABLE is disabled.
> 
> Patch 2 updates arm64 acpi_boot_table_init() to only print the SPCR console message
> if acpi_parse_spcr() succeeds.

I have some detail comments for patch 2.

Thanks
Hanjun

