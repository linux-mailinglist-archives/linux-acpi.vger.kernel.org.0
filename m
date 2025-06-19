Return-Path: <linux-acpi+bounces-14468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E3AE093F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119187A3E3C
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD8D22AE71;
	Thu, 19 Jun 2025 14:54:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8792253E4;
	Thu, 19 Jun 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344862; cv=none; b=GJNUy7EgX0DF6/PKl+GwN60hephGJnv5EAm6+TLAFmqtTAMZ7FaCyEspH78ke6uCAXkI1wNZp23zhrxEoUVtlBtEhQ2dgayElg1bYP/+1BeBw9NJ2DryGA+rf9XGTSuelQ+sdGhVYV4+2ArATXWBs3eCAvm7mmphz5QhvfnMvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344862; c=relaxed/simple;
	bh=qr3fGPf/Vfgs+6IUhKd7QaMyGqnlthhXO+HFIWeg/V4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GHrKZcAaX9Dk3I3gHcDVYD6C7pt8mCWxTJsNQ9J2KQZdKMdHLy0BgEH1R7ZbmRrXRaJdPJ2uiE9QE6hAdNBI8aYcZysYZBa1TaaKgdBPNhel2kBw+G7zMhFNMNb5odmmCzpmvlHvdGfnG0z7EjWUdS7Ahv3TTUGVVQJZsX9GULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bNNrd1Fq0ztSkH;
	Thu, 19 Jun 2025 22:53:05 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 574EC14011F;
	Thu, 19 Jun 2025 22:54:15 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 22:54:14 +0800
Subject: Re: [PATCH 2/2] ACPI: Suppress misleading SPCR console message when
 SPCR table is absent
To: Li Chen <me@linux.beauty>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Liu Wei <liuwei09@cestc.cn>, Ryan Roberts
	<ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Li Chen <chenl311@chinatelecom.cn>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20250606072802.191580-1-me@linux.beauty>
 <20250606072802.191580-3-me@linux.beauty>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <551bafb9-4a85-9339-8af3-ad0a4d267491@huawei.com>
Date: Thu, 19 Jun 2025 22:54:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250606072802.191580-3-me@linux.beauty>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Li Chen,

On 2025/6/6 15:27, Li Chen wrote:
> From: Li Chen<chenl311@chinatelecom.cn>
> 
> The kernel currently prints:
> "Use ACPI SPCR as default console: No/Yes"
> 
> even on systems that lack an SPCR table. This can
> mislead users into thinking the SPCR table exists
> on the machines without SPCR.
> 
> With this change, the message is only printed if
> acpi_parse_spcr() succeeds (i.e., if the SPCR table
> is present and parsed). This avoids user confusion
> on SPCR-less systems.
> 
> Signed-off-by: Li Chen<chenl311@chinatelecom.cn>
> ---
>   arch/arm64/kernel/acpi.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index b9a66fc146c9f..bf29e7b668f1d 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -197,6 +197,8 @@ static int __init acpi_fadt_sanity_check(void)
>    */
>   void __init acpi_boot_table_init(void)
>   {
> +	int ret;
> +
>   	/*
>   	 * Enable ACPI instead of device tree unless
>   	 * - ACPI has been disabled explicitly (acpi=off), or
> @@ -250,10 +252,11 @@ void __init acpi_boot_table_init(void)
>   		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
>   		 * table as default serial console.
>   		 */
> -		acpi_parse_spcr(earlycon_acpi_spcr_enable,
> +		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
>   			!param_acpi_nospcr);
> -		pr_info("Use ACPI SPCR as default console: %s\n",
> -				param_acpi_nospcr ? "No" : "Yes");
> +		if (!ret)
> +			pr_info("Use ACPI SPCR as default console: %s\n",
> +					param_acpi_nospcr ? "No" : "Yes");

Print "No" for:
- CONFIG_ACPI_SPCR_TABLE is disabled
- ret != 0
- param_acpi_nospcr = 1

Only print "Yes" for ret = 0.

Thanks
Hanjun

