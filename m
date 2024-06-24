Return-Path: <linux-acpi+bounces-6591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1602491404E
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 04:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFAA2815F7
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9274414;
	Mon, 24 Jun 2024 02:09:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853C440C;
	Mon, 24 Jun 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194986; cv=none; b=BADFcPGhUFsrqQ7rXVmDyNpnJIEjdtgtei54hxvai15lRJakkj6c2OpjRhQ/RYemv1k0W7ZXPtruW5iGJhaEOhFtTfOvmS419hHRaaRu9XwnoS6/p/c04irQQ2W45d+7YBaOS8NWH52GELSJFkHDQ9ru9qY8Y6puSZcl45HsnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194986; c=relaxed/simple;
	bh=3Ogjb9qfwiwCNAN31aXeHrBAHEHsNNSJBRBbRk9+6VI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t93/k+NnxRWSKLbHDsp5TDhkXmyrgwg4yLKeL7h+LaK/OMkPRqIfC9hWWDIsm7QIbGFMy5wdkDhqHbVwWmjYmmRq+o1jnDt5SiPKR2ArCnQaxTLODxieR8rge8t5KgFXdNCb77DWL5Kf6pOpgG8n5ZwPIMkioVj2oyP20dviaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W6rsb3sBwzPsdf;
	Mon, 24 Jun 2024 10:05:55 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 62E90140E62;
	Mon, 24 Jun 2024 10:09:33 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Jun 2024 10:09:32 +0800
Subject: Re: [PATCH] ACPI / amba: Drop unnecessary check for registered
 amba_dummy_clk
To: Youwan Wang <youwan@nfschina.com>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <rafael@kernel.org>, <sudeep.holla@arm.com>,
	<catalin.marinas@arm.com>, <will@kernel.org>
References: <20240620133758.319392-1-youwan@nfschina.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <974a1539-531a-6aa3-ba07-5d2c9003d08f@huawei.com>
Date: Mon, 24 Jun 2024 10:09:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620133758.319392-1-youwan@nfschina.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Youwan,

Please use v4 for your patch subject which was suggested by Sudeep:

[PATCH v4] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk

On 2024/6/20 21:37, Youwan Wang wrote:
> amba_register_dummy_clk() is called only once from acpi_amba_init()
> and acpi_amba_init() itself is called once during the initialisation.
> amba_dummy_clk can't be initialised before this in any other code
> path and hence the check for already registered amba_dummy_clk is
> not necessary. Drop the same.
> 
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> v1->v2->v3: Modify the commit log description

Please update it as follows:

Changes from v3:
- Update the commit message suggested by Sudeep;
- Add Acked-by from Sudeep;
- +Cc ARM64 maintainers Catalin and Will.

> ---
>   drivers/acpi/arm64/amba.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 60be8ee1dbdc..ef438417cc80 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -35,11 +35,7 @@ static const struct acpi_device_id amba_id_list[] = {
>   
>   static void amba_register_dummy_clk(void)
>   {
> -	static struct clk *amba_dummy_clk;
> -
> -	/* If clock already registered */
> -	if (amba_dummy_clk)
> -		return;
> +	struct clk *amba_dummy_clk;
>   
>   	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
>   	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);

With that updated,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

