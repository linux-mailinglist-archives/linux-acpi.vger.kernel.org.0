Return-Path: <linux-acpi+bounces-19991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2BCFD39D
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 11:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FEB9301E142
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0130C35F;
	Wed,  7 Jan 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="gW8onxhF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFF240604;
	Wed,  7 Jan 2026 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781303; cv=none; b=r/+FmBwBVQXDhf3dr8yectUDSyB6oq8YcDg5ALBC3LKX3VkD/s1xjkTYNv9Pe926ZWDvHcmmfdNnDC7z+Ay9w7XI9f0vTbx4/D0+H6guFJVTGxQ5araMjA3FP0467brDsl7JJo7lnTZwpuxG4QA7Ae9BnJwWrjsHpapPOuoob1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781303; c=relaxed/simple;
	bh=wInYPifjuwVvIxgztCYiN9gDzH+VQL2Cm5P3YYnqg0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c1DszHPm+mZ/v9iKu4z63KiLrZiQnK/La1vGdmLS0969/EO0GkTK/NOX+xZco8AS7UVCEwxvZKy0CTeunVUa/O6ke4T+4thjNFzEUMdZrw/x30GAc5Yx9kv9Zu6gTPMs2eyJe3366pT8c+6kAKMQSq4xHZq7Ovt7CWEmjanej0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=gW8onxhF; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+9OKR7L64zOfI7bUed2VWIdKJBr6gvcL6uNlYxD3Pmc=;
	b=gW8onxhFeeNVRFVdxwr3Nx8lCcjVH2msAjSQCWezN2uAscULKO+2QitfHwdR2vhd5ZyTqCxzm
	fitcAdhyetoV/EehQbmZ3o9e+sTcJkf9Y6y4BChlXu/F5+giFF5Ru4sW7009n6Bs7k/hMrNzco6
	yrww9e2Dq7nn+MlbrX+CO8Q=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dmPBQ1Jr4zLlSr;
	Wed,  7 Jan 2026 18:18:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id ED19F40538;
	Wed,  7 Jan 2026 18:21:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 18:21:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 7 Jan
 2026 18:21:35 +0800
Message-ID: <026561ca-8aca-4585-92f9-d1b65fd32b5c@huawei.com>
Date: Wed, 7 Jan 2026 18:21:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
To: <AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lenb@kernel.org>, <bp@alien8.de>,
	<rafael@kernel.org>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251223100914.2407069-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hi Amandeep,

Could you help test this series on your platform?
It would be perfect if has your Tested-by.

/Huisong

在 2025/12/23 18:09, Huisong Li 写道:
> This series of patches have been reverted due to the crash issue reported
> by Borislav [1] and a missing cpuidle sysfs directory reported by Amandeep.
>
> The root cause was commit 7a8c994cbb2d (ACPI: processor: idle: Optimize
> ACPI idle driver registration).  Since the other patches in the series
> depended on this commit, they were also reverted.
>
> I have analyzed these issues and implemented the following fixes:
> Fix for the Crash:
> The crash occurred because 'max_cstate' (which defaults to 8) was not
> updated before the ACPI idle states were initialized.  As a result, the idle
> driver believed multiple C-states were available, but only the state with
> index 1 was actually initialized in the per-CPU acpi_cstate array.  When the
> cpuidle governor tried to access a C-state index greater than 1, it hit a
> NULL pointer.
> Patch 1/6 fixes this by adding acpi_processor_cstate_first_run_checks() to
> update 'max_cstate' before initialization.
>
> Fix for missing /sys/devices/system/cpu/cpu*/cpuidle directory:
> The previous optimization depended on an external patch [2].  In kernel versions
> without that patch, acpi_processor_start() was being called before the ACPI idle
> driver had finished registering.  This caused the cpuidle device registration
> to fail, resulting in the missing directory.
> Patch 1/6 fixes this by moving acpi_processor_register_idle_driver() ahead of
> the acpi_processor_driver registration.
>
> Note:
> In this series, only patch 1/6 has been modified to address these bugs, more
> detail changes please see the commit.  Patches 2-6/6 remain identical to the
> versions that were previously merged.
>
> [1] https://lore.kernel.org/lkml/20251124200019.GIaSS5U9HhsWBotrQZ@fat_crate.local/
> [2] https://lore.kernel.org/all/20240529133446.28446-2-Jonathan.Cameron@huawei.com/
>
> Huisong Li (4):
>    ACPI: processor: idle: Optimize ACPI idle driver registration
>    ACPI: processor: Remove unused empty stubs of some functions
>    ACPI: processor: idle: Rearrange declarations in header file
>    ACPI: processor: Do not expose global variable acpi_idle_driver
>
> Rafael J. Wysocki (2):
>    ACPI: processor: Update cpuidle driver check in
>      __acpi_processor_start()
>    ACPI: processor: idle: Redefine two functions as void
>
>   drivers/acpi/processor_driver.c |  13 +++-
>   drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-------------
>   include/acpi/processor.h        |  34 ++--------
>   3 files changed, 86 insertions(+), 77 deletions(-)
>

