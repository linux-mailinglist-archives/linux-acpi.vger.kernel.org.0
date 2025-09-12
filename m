Return-Path: <linux-acpi+bounces-16731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF04B54FC1
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2842189545F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B330EF7C;
	Fri, 12 Sep 2025 13:37:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7D3019BD;
	Fri, 12 Sep 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684233; cv=none; b=NoIVWCqQmfyPSj9SJTaO0Lkp+j5XPWJWTahlfrYoLbGrHi3vkP09Hr1KQdNyxRZtExP/Rq3NKHGt0nICSkhX4YDCx1g/Qqri+JN4mIgoG2n4uBguPjbDxZzf1FzdKINun55vGWbvQk1N91meuvvTPb4F93X6l2+npNZRsRVHToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684233; c=relaxed/simple;
	bh=caCHJd76BgXdmJ9d1eRBAJ32I6fa8yfJlblZoCmMvqY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbkIcXjf8noNxpQvAtguKip48fxhb0DOMHkEDAwTDido2w0ZHJ1MHFmMGEEuHi8uf0B3H5Y5Iyge/GD7dGqSlYH5kfp7tlYWnkQsdEyHgFphIYGHHJZUZDE538eS7GALf0xi7is/42bgIEPRLBMXNMatezWAiyiqOW2nWrPJUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNb4f50qdz6M535;
	Fri, 12 Sep 2025 21:34:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 211D11402A4;
	Fri, 12 Sep 2025 21:37:08 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:37:05 +0200
Date: Fri, 12 Sep 2025 14:37:04 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 28/29] arm_mpam: Add kunit test for bitmap reset
Message-ID: <20250912143704.00001ae8@huawei.com>
In-Reply-To: <20250910204309.20751-29-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-29-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:43:08 +0000
James Morse <james.morse@arm.com> wrote:

> The bitmap reset code has been a source of bugs. Add a unit test.
> 
> This currently has to be built in, as the rest of the driver is
> builtin.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Few trivial comments inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/resctrl/Kconfig             | 10 +++++
>  drivers/resctrl/mpam_devices.c      |  4 ++
>  drivers/resctrl/test_mpam_devices.c | 68 +++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 drivers/resctrl/test_mpam_devices.c
> 
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index c30532a3a3a4..ef59b3057d5d 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -5,10 +5,20 @@ menuconfig ARM64_MPAM_DRIVER
>  	  MPAM driver for System IP, e,g. caches and memory controllers.
>  
>  if ARM64_MPAM_DRIVER
> +
>  config ARM64_MPAM_DRIVER_DEBUG
>  	bool "Enable debug messages from the MPAM driver"
>  	depends on ARM64_MPAM_DRIVER

Doing this under an if for the same isn't useful. So if you want to do this
style I'd do it before adding this earlier config option.

>  	help
>  	  Say yes here to enable debug messages from the MPAM driver.
>  
> +config MPAM_KUNIT_TEST
> +	bool "KUnit tests for MPAM driver " if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable this option to run tests in the MPAM driver.
> +
> +	  If unsure, say N.
> +
>  endif

> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
> new file mode 100644
> index 000000000000..3e7058f7601c
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
> +	char __iomem *buf = kunit_kzalloc(test, SZ_16K, GFP_KERNEL);
> +	struct mpam_msc fake_msc = {0};

= { }; is sufficient and what newer c specs have adopted to mean
fill everything including holes in structures with 0.  There are some
tests that ensure that behavior applies with older compilers + the options
we use for building the kernel.

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

Perhaps add a comment to say this is to satisfy lock markings?
Otherwise someone might wonder why mutex_init() immediately followed
by taking the lock maskes sense.

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



