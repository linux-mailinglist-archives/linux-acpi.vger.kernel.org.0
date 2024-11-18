Return-Path: <linux-acpi+bounces-9626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D524C9D0841
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5991B2134E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2924A1E;
	Mon, 18 Nov 2024 04:00:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5942AB3
	for <linux-acpi@vger.kernel.org>; Mon, 18 Nov 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902422; cv=none; b=OlVXiR0GJ61QKUufYTjaz+YHtWCre0MOI1Ny5KvAVvAyls0mw7WNmoRyJqyxsQwikUDLQT47mfzzQ/AoH98HRqAXwXskJeUx9i7VP6lpLnaQDVONgB0/iIKC27aWEBcHPYycV9dym+zbYRTEqYEt8BJUoFHfNx5N4fRzfDNjhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902422; c=relaxed/simple;
	bh=qii1FsL0yIK97RwQ+eDKl4KndUN8v2wXy5JIqLNA/28=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K3mnW9Q6kDwJbABluGeRCdqTaN++Nhu6Sk5WXkvsUaTZ06ppQ/2ToS4yWfbzGTFhZDHYmH8LJaxlZD1NIZxjlbktF8wpfuGB2oKh+ULqJpTcvlcEpYHPUBzu7Xk6Hr3GuuiCH7j5QaKophsckm1Zs1XUhr3oScF9eTNw9Sj4rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XsDPS6rbQz1k06Y;
	Mon, 18 Nov 2024 11:58:20 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D1A771A016C;
	Mon, 18 Nov 2024 12:00:16 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Nov 2024 12:00:16 +0800
Subject: Re: [PATCH] ACPI/IORT: Add PMCG platform information for HiSilicon
 HIP09A
To: Qinxin Xia <xiaqinxin@huawei.com>, <lpieralisi@kernel.org>,
	<sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
	<linuxarm@huawei.com>
References: <20241107094036.2398983-1-xiaqinxin@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7b52e89f-2afa-a5f3-3634-4916693076ad@huawei.com>
Date: Mon, 18 Nov 2024 12:00:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241107094036.2398983-1-xiaqinxin@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/11/7 17:40, Qinxin Xia wrote:
> HiSilicon HIP09A platforms using the same SMMU PMCG with HIP09
> and thus suffers the same erratum. List them in the PMCG platform
> information list without introducing a new SMMU PMCG Model.
> 
> Update the silicon-errata.rst as well.
> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>   Documentation/arch/arm64/silicon-errata.rst | 4 ++--
>   drivers/acpi/arm64/iort.c                   | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index 65bfab1b1861..b21c0b1ed567 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -255,8 +255,8 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
>   +----------------+-----------------+-----------------+-----------------------------+
> -| Hisilicon      | Hip{08,09,10,10C| #162001900      | N/A                         |
> -|                | ,11} SMMU PMCG  |                 |                             |
> +| Hisilicon      | Hip{08,09x,10x, | #162001900      | N/A                         |

Since x is also a letter, I think it's better to add 09A after 09, with
no confusion.

> +|                | 11} SMMU PMCG   |                 |                             |
>   +----------------+-----------------+-----------------+-----------------------------+
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 4c745a26226b..bf3be532e089 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1703,6 +1703,8 @@ static struct acpi_platform_list pmcg_plat_info[] __initdata = {
>   	/* HiSilicon Hip09 Platform */
>   	{"HISI  ", "HIP09   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
>   	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
> +	{"HISI  ", "HIP09A  ", 0, ACPI_SIG_IORT, greater_than_or_equal,
> +	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},
>   	/* HiSilicon Hip10/11 Platform uses the same SMMU IP with Hip09 */
>   	{"HISI  ", "HIP10   ", 0, ACPI_SIG_IORT, greater_than_or_equal,
>   	 "Erratum #162001900", IORT_SMMU_V3_PMCG_HISI_HIP09},

Please update the patch, and resend with Catalin and Will CCed.

Thanks
Hanjun

