Return-Path: <linux-acpi+bounces-11383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F50A40740
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A707A6B9B
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A5207670;
	Sat, 22 Feb 2025 10:06:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D2202C40;
	Sat, 22 Feb 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218798; cv=none; b=SLQ2KJb//vZSNHUpyc4X4r8vZA9UHNFBR+7J9DRUVizBS6Y4SFRmjGwVtA872b78dUtuy/8caTw7dVUscb3mf3D1Tl48jBxiZmd3194kOtcNYaha+4JXOBCbS89QJaqe1hgN6xNP8Z2xM7qus+1oLlrL/3M7Iq7Ket6DUV3zRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218798; c=relaxed/simple;
	bh=Lv2voLQK6jHaJMOKYmw7WUiLwYV7+E67yPAzbTONFmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qq+/UjicFKfYyxRRS5XF6En6jsydKEu2cvC+vJS7xGmHlDTnJO6GSDV6kJcf5Df3Rk8r/d4UsAELP29ak9taR8zQ8WjPja9uzMnQntAQTVM02UBpK487651RWV8fmzM63iBxWkSyjiuxhKFDV7UEXuKOSx+oVwAFwJibCtRnupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z0N0C0bJ5z1HJhc;
	Sat, 22 Feb 2025 18:04:59 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 452991406AC;
	Sat, 22 Feb 2025 18:06:32 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 18:06:31 +0800
Message-ID: <da5d18c7-cf09-4956-ad9c-231b12cc0267@huawei.com>
Date: Sat, 22 Feb 2025 18:06:30 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<sashal@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
 <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/2/21 21:14, Sumit Gupta wrote:
> 
> 
> On 19/02/25 00:53, Rafael J. Wysocki wrote:
>>
>> There seems to be some quite fundamental disagreement on how this
>> should be done, so I'm afraid I cannot do much about it ATM.
>>
>> Please agree on a common approach and come back to me when you are ready.
>>
>> Sending two concurrent patchsets under confusingly similar names again
>> and again isn't particularly helpful.
>>
>> Thanks!
> 
> Hi Rafael,
> 
> Thank you for looking into this.
> 
> Hi Lifeng,
> 
> As per the discussion, we can make the driver future extensible and
> also can optimize the register read/write access.
> 
> I gave some thought and below is my proposal.
> 
> 1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
>    to read/write a cpc register.

'patch 1-7' in [1] doesn't conflicts with [2], so can be reviewed and
applied separately. I would follow this up in that series.

> 
> 2) Pick my patches in [2]:
>    - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
>                 Also, update existing API's to read/write regs in batch.
>    - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
>      all CPU's in Auto mode and set registers with right values.
>      They can be updated after boot from sysfs to change hints to HW.
>      I can use the optimized API's from [1] where required in [2].
> 
> Let me know if you are okay with this proposal.
> I can also send an updated patch series with all the patches combined?

As mentioned above, 'patch 1-7' in [1] can be reviewed and applied
separately. No need to be combined with other patches.

About how to support auto selection mode in cppc_cpufreq, I think we need
to sort out usecases, scenarios, and requirements from both of us before we
disscus and agree on a design to implement. I am currently working on it
and will sent out my thoughts later.

Regards,
Lifeng

> 
> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> [2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
> 
> Regards,
> Sumit Gupta
> 


