Return-Path: <linux-acpi+bounces-9589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6369C8D64
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4815B282737
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527533993;
	Thu, 14 Nov 2024 14:55:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97C126BEE
	for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596122; cv=none; b=NR0YiKBt4vXEIqb2cjaj6T0oeCypRm2dKDwlASwVOp3S+QBfxsAd++ZL1JZ6TZuE+sAQ5reSOXhCtNCMuZ3YsZmeKCPLwljwKyrC3Of5afevbqn3IwbAK//sUE35bQCtAQlnTd4ppeQHobNsJhBMkSeAhJ/e1ULftU9reZObQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596122; c=relaxed/simple;
	bh=hhHUZMYlIogO3sY3W49p3VJ0TP3xWZ4FpJinRMGpX9I=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ppuCueF2tvZGYmxETLkMCoqE3v4LomG3MzaIswHjFjXWwtVXzKZokpiYjESsjUrFY3FtA9yYr1v95Z43UWCxuIj0bUjHXr4rY6kTGjy8wcM4xFjGARO7agiCg00ARRUvvVWo/dxSQxm/tDcSMXSA1aiU1hneMHsZ0EAmAkdZMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xq36N6rHXz10R0K;
	Thu, 14 Nov 2024 22:52:44 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id DA8D218009E;
	Thu, 14 Nov 2024 22:55:15 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 14 Nov 2024 22:55:15 +0800
CC: <yangyicong@hisilicon.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <fanghao11@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] ACPI/IORT: Add PMCG platform information for HiSilicon
 HIP09A
To: Qinxin Xia <xiaqinxin@huawei.com>, <lpieralisi@kernel.org>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>
References: <20241107094036.2398983-1-xiaqinxin@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <4ac9e057-725c-a0ae-e2db-612ea359bec1@huawei.com>
Date: Thu, 14 Nov 2024 22:55:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241107094036.2398983-1-xiaqinxin@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/11/7 17:40, Qinxin Xia wrote:
> HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
> and thus suffers the same erratum. List them in the PMCG platform
> information list without introducing a new SMMU PMCG Model.
> 
> Update the silicon-errata.rst as well.
> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  Documentation/arch/arm64/silicon-errata.rst | 4 ++--
>  drivers/acpi/arm64/iort.c                   | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index 65bfab1b1861..b21c0b1ed567 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -255,8 +255,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> -| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
> -|                | ,11} SMMU PMCG  |                 |                             |
> +| Hisilicon      | Hip{08,09x,10x, | #162001900      | N/A                         |
> +|                | 11} SMMU PMCG   |                 |                             |
>  +----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 4c745a26226b..bf3be532e089 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1703,6 +1703,8 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
>  	/* HiSilicon Hip09 Platform */
>  	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
>  	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
> +	{"HISI  ", "HIP09A  ", 0, ACPI_SIG_IORT, greater_than_or_equal,
> +	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
>  	/* HiSilicon Hip10/11 Platform uses the same SMMU IP with Hip09 */
>  	{"HISI  ", "HIP10   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
>  	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
> 

