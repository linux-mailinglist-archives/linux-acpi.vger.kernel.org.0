Return-Path: <linux-acpi+bounces-14811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16DCAEC3A7
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jun 2025 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3B4A4871
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jun 2025 00:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6614A4E0;
	Sat, 28 Jun 2025 00:54:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960C2BAF9;
	Sat, 28 Jun 2025 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751072081; cv=none; b=O6feZqkTSYG11gbRDY699coxpThCb4zSn/owcVtfG6o8nSD7i4b44YfYRluty0sLPg33eVWZLGGUp+yYO5yhzwbCh6/42so5oIaBFEloeb8LrVMDJJ9CVHg29N2coTuNhRV/9sR8I78qETxQBZQRvTPIkFIlz7bQGhJBDcROLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751072081; c=relaxed/simple;
	bh=hpqgdN9GMa6JTSo6elury4zstcyceOBRhYV2jn/jFAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E5EDN3RKWsXn2TL21RX8hR4uBD36F2wZtyJ65fWTCaWxmXDXx4/H4MHpfJd2Q/pWY9daqLdATjtZONMIX48xqOYq6VMwe8n5mB1zpP+aOxm93d2LVeKLG1bPQP3vcMSe4XVecE90q6Ee+1LV3AIT3WDJ/b0yxTwesKuZzTu23fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bTYmC6gFtz1d1fy;
	Sat, 28 Jun 2025 08:52:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DDAE9180486;
	Sat, 28 Jun 2025 08:54:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Jun 2025 08:54:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Jun
 2025 08:54:34 +0800
Message-ID: <99e8badc-cd1d-4a8f-a56d-6c534a18ab0f@huawei.com>
Date: Sat, 28 Jun 2025 08:54:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: idle: Fix resource rollback in
 acpi_processor_power_init
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>
References: <20250619061327.1674384-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250619061327.1674384-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Kindly ping for review.

在 2025/6/19 14:13, Huisong Li 写道:
> There are two resource rollback issues in acpi_processor_power_init:
> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
> 2> Do not free cpuidle device memory when register cpuidle device failed.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 2c2dc559e0f8..3548ab9dac9e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>   		}
>   
>   		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -		if (!dev)
> -			return -ENOMEM;
> +		if (!dev) {
> +			retval = -ENOMEM;
> +			goto unregister_driver;
> +		}
>   		per_cpu(acpi_cpuidle_device, pr->id) = dev;
>   
>   		acpi_processor_setup_cpuidle_dev(pr, dev);
> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>   		 * must already be registered before registering device
>   		 */
>   		retval = cpuidle_register_device(dev);
> -		if (retval) {
> -			if (acpi_processor_registered == 0)
> -				cpuidle_unregister_driver(&acpi_idle_driver);
> -			return retval;
> -		}
> +		if (retval)
> +			goto free_cpuidle_device;
> +
>   		acpi_processor_registered++;
>   	}
>   	return 0;
> +
> +free_cpuidle_device:
> +	per_cpu(acpi_cpuidle_device, pr->id) = NULL;
> +	kfree(dev);
> +
> +unregister_driver:
> +	if (acpi_processor_registered == 0)
> +		cpuidle_unregister_driver(&acpi_idle_driver);
> +
> +	return retval;
>   }
>   
>   int acpi_processor_power_exit(struct acpi_processor *pr)

