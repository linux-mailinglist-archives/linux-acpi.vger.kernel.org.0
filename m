Return-Path: <linux-acpi+bounces-6360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EA9061AC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 04:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C642281718
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2B5103F;
	Thu, 13 Jun 2024 02:19:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812A273FE
	for <linux-acpi@vger.kernel.org>; Thu, 13 Jun 2024 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245177; cv=none; b=MpdOmdfzIoGR139lTmaLxXTz94dtgDwYbLBJL31TL+D8iard/45MwlHw8dWB2A+YOTev5BwfG/2TQ5ypYrmDuh2N7sqQDpAr+um8Mup3EF5hoFuGB1Yjbr1ubYf+6ZI9JOj9DUd73Nfy+DR4BvwMtM/ZKhIqOuBPOhCyjCBdhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245177; c=relaxed/simple;
	bh=MVhY2fCnsIdzEkNS7RZGAmPaxB4QbpXrUcZR5NaVC6o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kKwogl3aqubPTQDMA4Uz/YhGJ3UBiHDbsu7hSmFSL4xsbqspFNh4xur0ymwiubQKRkdn8bul0UDWumYC8kF+tSWx7Ojq7GHC2bNYR+J3SOcqeos4F/hB4oHqP281bWi3KE0yYuQzhFv8n6iUb6XDUruMOPwBRH805q3xPHWX5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W05fj3m4VzdcYt;
	Thu, 13 Jun 2024 10:18:05 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 35CE51402CA;
	Thu, 13 Jun 2024 10:19:33 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Jun 2024 10:19:32 +0800
Subject: Re: [PATCH 0/3] ACPI: arm64: some cleanups
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <46b65718-af88-05d5-24f9-1254a692ecbf@huawei.com>
Date: Thu, 13 Jun 2024 10:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605131458.3341095-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/5 21:14, Sudeep Holla wrote:
> Hi,
> 
> Couple of patches to move the ACPI arch specific code into
> drivers/acpi/arm64/ as they are not strictly arch specific to
> keep them under arch/arm64.
> 
> Regards,
> Sudeep
> 
> Sudeep Holla (3):
>    ACPI: arm64: Sort entries alphabetically
>    arm64: cpuidle: Move ACPI specific code into drivers/acpi/arm64/
>    arm64: FFH: Move ACPI specific code into drivers/acpi/arm64/
> 
>   arch/arm64/kernel/Makefile                    |   1 -
>   arch/arm64/kernel/acpi.c                      | 105 -----------------
>   drivers/acpi/arm64/Makefile                   |   6 +-
>   .../kernel => drivers/acpi/arm64}/cpuidle.c   |   4 -
>   drivers/acpi/arm64/ffh.c                      | 107 ++++++++++++++++++
>   5 files changed, 111 insertions(+), 112 deletions(-)
>   rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)
>   create mode 100644 drivers/acpi/arm64/ffh.c

Looks good to me, and I did a successful compile test,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

