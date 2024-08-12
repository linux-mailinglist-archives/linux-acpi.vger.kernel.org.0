Return-Path: <linux-acpi+bounces-7525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F145794E597
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 05:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39DF1F2222A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B71369AE;
	Mon, 12 Aug 2024 03:46:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD318C22
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 03:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723434382; cv=none; b=NBRfQL3dXNvgf5D1wGqC8j8ZG9FALsur6SS0Km5bLTE3UjFC8jc60EbIdP/+xT+AKqytWNNDzkZjyBJLX6Yv4DL0YnB6dKnnk3LWtMmqPvUts6sqCgz75PtT0EgQPU3tnBHHX6XvPapjPcwRRGMMaSKI/rLP+OhzZd7ogprVzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723434382; c=relaxed/simple;
	bh=foDMjZfjUkrNXPNvJ9Hb/4HgH25XbciWV2tVucuqS4I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b3Trqki6yE3c+sBkvnkdpS70FRR8XoO3m31ZLpL+jEybMSRnlUuUMvHqmUOaIP8jEQ1nfDnBiOFS0A6FR91iW6osZGeDx9NhSroXU4Ww34PVIpbYvW+UGwfcI6uGa8FeprTAdphKgr3SdvZRL1snfWpK6+Y5iMB/rT9yaCoSx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wj0kQ32tzzfb82;
	Mon, 12 Aug 2024 11:44:14 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 89F2F180101;
	Mon, 12 Aug 2024 11:46:10 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 11:46:10 +0800
Subject: Re: [PATCH v2 4/4] ARM64: ACPI: Move the NUMA code to
 drivers/acpi/arm64/
To: kernel test robot <lkp@intel.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Will Deacon <will@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240811042303.3498761-5-guohanjun@huawei.com>
 <202408121026.c3mDLUsP-lkp@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <8be9d042-3e57-8458-271f-d213ba519bd4@huawei.com>
Date: Mon, 12 Aug 2024 11:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202408121026.c3mDLUsP-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/12 11:02, kernel test robot wrote:
> Hi Hanjun,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.11-rc3 next-20240809]
> [cannot apply to arm-perf/for-next/perf]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hanjun-Guo/ARM64-ACPI-Remove-the-leftover-acpi_init_cpus/20240811-122442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20240811042303.3498761-5-guohanjun%40huawei.com
> patch subject: [PATCH v2 4/4] ARM64: ACPI: Move the NUMA code to drivers/acpi/arm64/
> config: arm64-randconfig-001-20240812 (https://download.01.org/0day-ci/archive/20240812/202408121026.c3mDLUsP-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408121026.c3mDLUsP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408121026.c3mDLUsP-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>     aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>     aarch64-linux-ld: arch/arm64/kernel/smp.o: in function `smp_init_cpus':
>>> arch/arm64/kernel/smp.c:669:(.init.text+0x424): undefined reference to `acpi_map_cpus_to_nodes'

Good catch, I missed the random config which CONFIG_NUMA is not set.

Thanks
Hanjun

