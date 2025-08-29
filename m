Return-Path: <linux-acpi+bounces-16193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF7B3C15D
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DF0188E277
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A26A33A008;
	Fri, 29 Aug 2025 16:57:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A03081BE;
	Fri, 29 Aug 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486620; cv=none; b=dyV5sd32wRE8CaRClPuHTH7MEsJ0i0VmGFWKd31fnaaFWzE6Z07yiKX0kspyVCeVBwQ3k1VsPZ6bNEfUkoqJuPzWs+E1IgCjEFU7QRwbceUcbsYqTHEtJVIzsZ2n4OZ8Fe8oevQEAodsmxiPjVwfEcuPFilSU4kRIfp3OhU2R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486620; c=relaxed/simple;
	bh=kb2fY1IV7K43cE3ikrAg8qLiIqn49GbYUA49McI1fGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+67bu1+pA0EuJ1anv7uStET9zvYz5HaeAJBBApiduye7oeUJfKGdLPEAJ16ew76iHenTdQqPJsHj090lagcC1jClZ/xX8u0xICNwBindGfGfSceeokre7yZCTa2DSA9ojxi7Vc6xQ9f9gFUiFU+uvr9VNqmcs46hDcO9zVmcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2033B12FC;
	Fri, 29 Aug 2025 09:56:49 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F50B3F738;
	Fri, 29 Aug 2025 09:56:51 -0700 (PDT)
Message-ID: <ee847bec-ad08-473e-96b5-407872c2a0f2@arm.com>
Date: Fri, 29 Aug 2025 17:56:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] arm_mpam: Add kunit test for bitmap reset
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-33-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250822153048.2287-33-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/25 16:30, James Morse wrote:
> The bitmap reset code has been a source of bugs. Add a unit test.
> 
> This currently has to be built in, as the rest of the driver is
> builtin.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/Kconfig             | 13 ++++++
>  drivers/resctrl/mpam_devices.c      |  4 ++
>  drivers/resctrl/test_mpam_devices.c | 68 +++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 drivers/resctrl/test_mpam_devices.c
> 
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index dff7b87280ab..f5e0609975e4 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -4,8 +4,21 @@ config ARM64_MPAM_DRIVER
>  	bool "MPAM driver for System IP, e,g. caches and memory controllers"
>  	depends on ARM64_MPAM && EXPERT
>  
> +menu "ARM64 MPAM driver options"
> +
>  config ARM64_MPAM_DRIVER_DEBUG
>  	bool "Enable debug messages from the MPAM driver."
>  	depends on ARM64_MPAM_DRIVER
>  	help
>  	  Say yes here to enable debug messages from the MPAM driver.
> +
> +config MPAM_KUNIT_TEST
> +	bool "KUnit tests for MPAM driver " if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
It depends on ARM64_MPAM_DRIVER as well.

> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable this option to run tests in the MPAM driver.
> +
> +	  If unsure, say N.
> +
> +endmenu
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 65c30ebfe001..4cf5aae88c53 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2903,3 +2903,7 @@ static int __init mpam_msc_driver_init(void)
>  }
>  /* Must occur after arm64_mpam_register_cpus() from arch_initcall() */
>  subsys_initcall(mpam_msc_driver_init);
> +
> +#ifdef CONFIG_MPAM_KUNIT_TEST
> +#include "test_mpam_devices.c"
> +#endif
> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
> new file mode 100644
> index 000000000000..8e9d6c88171c
> --- /dev/null
> +++ b/drivers/resctrl/test_mpam_devices.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Arm Ltd.
> +/* This file is intended to be included into mpam_devices.c */
> +
> +#include <kunit/test.h>
> +
> +static void test_mpam_reset_msc_bitmap(struct kunit *test)
> +{
> +	char *buf = kunit_kzalloc(test, SZ_16K, GFP_KERNEL);
> +	struct mpam_msc fake_msc;
> +	u32 *test_result;
> +
> +	if (!buf)
> +		return;
> +
> +	fake_msc.mapped_hwpage = buf;
> +	fake_msc.mapped_hwpage_sz = SZ_16K;
> +	cpumask_copy(&fake_msc.accessibility, cpu_possible_mask);
> +
> +	mutex_init(&fake_msc.part_sel_lock);
> +	mutex_lock(&fake_msc.part_sel_lock);
> +
> +	test_result = (u32 *)(buf + MPAMCFG_CPBM);
> +
> +	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 0);
> +	KUNIT_EXPECT_EQ(test, test_result[0], 0);
> +	KUNIT_EXPECT_EQ(test, test_result[1], 0);
> +	test_result[0] = 0;
> +	test_result[1] = 0;
> +
> +	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 1);
> +	KUNIT_EXPECT_EQ(test, test_result[0], 1);
> +	KUNIT_EXPECT_EQ(test, test_result[1], 0);
> +	test_result[0] = 0;
> +	test_result[1] = 0;
> +
> +	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 16);
> +	KUNIT_EXPECT_EQ(test, test_result[0], 0xffff);
> +	KUNIT_EXPECT_EQ(test, test_result[1], 0);
> +	test_result[0] = 0;
> +	test_result[1] = 0;
> +
> +	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 32);
> +	KUNIT_EXPECT_EQ(test, test_result[0], 0xffffffff);
> +	KUNIT_EXPECT_EQ(test, test_result[1], 0);
> +	test_result[0] = 0;
> +	test_result[1] = 0;
> +
> +	mpam_reset_msc_bitmap(&fake_msc, MPAMCFG_CPBM, 33);
> +	KUNIT_EXPECT_EQ(test, test_result[0], 0xffffffff);
> +	KUNIT_EXPECT_EQ(test, test_result[1], 1);
> +	test_result[0] = 0;
> +	test_result[1] = 0;
> +
> +	mutex_unlock(&fake_msc.part_sel_lock);
> +}
> +
> +static struct kunit_case mpam_devices_test_cases[] = {
> +	KUNIT_CASE(test_mpam_reset_msc_bitmap),
> +	{}
> +};
> +
> +static struct kunit_suite mpam_devices_test_suite = {
> +	.name = "mpam_devices_test_suite",
> +	.test_cases = mpam_devices_test_cases,
> +};
> +
> +kunit_test_suites(&mpam_devices_test_suite);

Thanks,

Ben


