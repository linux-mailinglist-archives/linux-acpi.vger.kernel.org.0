Return-Path: <linux-acpi+bounces-17360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5ECBA44E6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C81627CF8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DBE1DE3DB;
	Fri, 26 Sep 2025 14:55:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB038DE1;
	Fri, 26 Sep 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898551; cv=none; b=hUD6bBrUUve0/Q7bQLv9URgnEfwlmrAo4RriuZP2+gGOckUHFx65irqJhuxiFpZ/dfZRWx4HRAp2gEUK44cQaCoZgNUnGHrS0DXPM5xEraTH8kRcN+KBUFQP8psqvrHqDBwc/hURZDYVDCbWJBCsExyShYcJ0bfjtZg2ZOjgbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898551; c=relaxed/simple;
	bh=0mm1hkT7I8vBwdwgCh0nra0c96U5ujPd8oXOOzYXcwc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvSCQAxwMDg3WWCvimRGKij8Hlo0HV+JkNDlE+PD66dGYhakIMFncsNplxon/DRssVJ7yGZfQ0h07Eue58P3KJ9MUva/gN5za9bC5jOHi1oy07sVSSzuFlf5HoqwPpsCT1YCYrtyShaB+X+cbz8LW7NIqF2JjpJeSbKrNVGTJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cYDD06v2Wz6L4vW;
	Fri, 26 Sep 2025 22:55:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DF77140373;
	Fri, 26 Sep 2025 22:55:46 +0800 (CST)
Received: from localhost (10.47.75.77) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 15:55:44 +0100
Date: Fri, 26 Sep 2025 15:55:43 +0100
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
Subject: Re: [PATCH v2 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Message-ID: <20250926155543.00005de0@huawei.com>
In-Reply-To: <9982847d-2878-4748-8c65-2d98a2e47396@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-8-james.morse@arm.com>
	<20250911143544.000026aa@huawei.com>
	<9982847d-2878-4748-8c65-2d98a2e47396@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)


> >> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> >> new file mode 100644
> >> index 000000000000..7c63d590fc98
> >> --- /dev/null
> >> +++ b/drivers/resctrl/mpam_internal.h
> >> @@ -0,0 +1,65 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +// Copyright (C) 2025 Arm Ltd.
> >> +
> >> +#ifndef MPAM_INTERNAL_H
> >> +#define MPAM_INTERNAL_H
> >> +
> >> +#include <linux/arm_mpam.h>
> >> +#include <linux/cpumask.h>
> >> +#include <linux/io.h>
> >> +#include <linux/mailbox_client.h>
> >> +#include <linux/mutex.h>  
> > 
> > spinlock.h  
> 
> Fixed,
> 
> 
> >> +#include <linux/resctrl.h>  
> > 
> > Not spotting anything rsctl yet.  So maybe this belongs later.  
> 
> There shouldn't be anything that depends on resctrl in this series - looks like
> this is a 2018 era bug in the way I carved this up!
> 
> 
> >> +#include <linux/sizes.h>
> >> +
> >> +struct mpam_msc {
> >> +	/* member of mpam_all_msc */
> >> +	struct list_head        all_msc_list;
> >> +
> >> +	int			id;  
> > 
> > I'd follow (approx) include what you use principles to make later header
> > shuffling easier. So a forward def for this.  
> 
> -ENOPARSE
> 
> I'm sure I'll work this out from your later comments.

I missed on the comment (I think). Would have made more sense a line later.
Add a forwards def

struct platform_device;

as no reason to include the appropriate header
(and you didn't anwyay).




