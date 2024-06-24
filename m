Return-Path: <linux-acpi+bounces-6592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C9914080
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 04:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B12B20819
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2024 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5ED4A31;
	Mon, 24 Jun 2024 02:26:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8D46BA;
	Mon, 24 Jun 2024 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196005; cv=none; b=UEz+75x6TszHuPLrhaocYuun24xMywuZwuPeVXxnbmXDUEcke3B3J6/wo2angqAZvjqZLBxiGaPOMrUWktKuC6F93rhK5JO2Z8aedrdbuRiYKn4OIQV2oIKeTMmIgaH9lfq3od31v4iTQwWP/W7Rmdju5L9dAVAaYfy0YqZTJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196005; c=relaxed/simple;
	bh=VF6ss1E9xCanAEWNpbP5BdN9LJRvLeanmOYgYq+Fq4U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y3QD8BJ7PxfEsw32Bddb0jCdq6KbkLgE4xoQ2Pc00IB4HRQhcfEglvMKz4XODjKGVOqGfZZT9Qe2OY93W0YauiYJ6AHM3ykJ4cWvXh1IKLAPMM7zHBh4yKDoq34q4LLt2lmjI4rvI2QjwfLDjtrfhNsucTixnJU2vaUGOAPZP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W6sDP5dnlzxTFc;
	Mon, 24 Jun 2024 10:22:13 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 043F718007C;
	Mon, 24 Jun 2024 10:26:31 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Jun 2024 10:26:29 +0800
Subject: Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>, <sunilvl@ventanamicro.com>,
	<arnd@arndb.de>
CC: <xiaobo55x@gmail.com>, <ajones@ventanamicro.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Morton
	<akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>, Baoquan
 He <bhe@redhat.com>, Evan Green <evan@rivosinc.com>,
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Zong Li
	<zong.li@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, Alexandre
 Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, Jisheng Zhang <jszhang@kernel.org>, James Morse
	<james.morse@arm.com>, Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier
	<maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck
	<tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Robert Richter
	<rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-acpi@vger.kernel.org>
References: <cover.1718268003.git.haibo1.xu@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <d9c996b8-fe36-1b69-331a-94eb2547cc0f@huawei.com>
Date: Mon, 24 Jun 2024 10:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/13 16:54, Haibo Xu wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 change the ACPI_NUMA to a hidden option since it would be selected
> by default on all supported platform.
> Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.

Looks good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

