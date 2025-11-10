Return-Path: <linux-acpi+bounces-18744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B199DC4834A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17E504FEBB5
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF93043C9;
	Mon, 10 Nov 2025 16:44:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9228642B;
	Mon, 10 Nov 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793067; cv=none; b=s6vdTQ8ZeQ1T+gcOGCRdFae9K+1o5kphprR24rbilAATBlPhBLXMfjiVKSpXvlYHLfW+mSxBK91hiSEur99gTHA+ZK3v3yrkVH5xnk9whE/ygjnG4Sh1E/m52uz6cx8Yi3UI1n1SnpmEhOwmA2ZwvOa9xRbIy/cQqfdSbiC6RAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793067; c=relaxed/simple;
	bh=vRF7+VjZVlLUMRBXuIOjuK3iwZIyfWHkYNR6D6MwJ7g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlOe2xgW9q0rW9lvc6xLOOOgFArClMgUgRVQE6HtSQYBFBB92OF0dDiVGRH0MUAKThDF0BJBSrh5ZaIdmadr708kO9WeBSFTE3LpuDOEeuYOYJmz46ZKqIyeIUeboxQuRd9H1xnYZNij08Z4eCPS0iUImbMO5HW6tSnAgEXCpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4wTy6ZkgzJ46BR;
	Tue, 11 Nov 2025 00:43:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D33C140372;
	Tue, 11 Nov 2025 00:44:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:44:18 +0000
Date: Mon, 10 Nov 2025 16:44:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gavin Shan <gshan@redhat.com>
CC: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>,
	<amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Message-ID: <20251110164417.000042aa@huawei.com>
In-Reply-To: <5b9136d6-b6c0-4f24-a8d2-05d7700140a8@redhat.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-11-ben.horgan@arm.com>
	<5b9136d6-b6c0-4f24-a8d2-05d7700140a8@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 8 Nov 2025 19:28:43 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> > only be accessible from those CPUs, and they may not be online.
> > Touching the hardware early is pointless as MPAM can't be used until
> > the system-wide common values for num_partid and num_pmg have been
> > discovered.
> >   
> 
> I'm not sure if below commit log is more clearer as I'm not a English
> native speaker:

I'm normally very flexible on English usage as long as meaning is
conveyed but I'm not keen on changing authors Engish in a fashion that
doesn't necessarily improve it. So a few thoughts from me as a native
speaker. Note don't mind changing text for clarity if the English usage
is too obscure.

> 
> MPAM probing is convoluted. MSCs that are integrated to a set of CPUs
> may only be accessible from those CPUs, ...

To me both are equally valid.

Probing MPAM -> implies MPAM is a thing which is probed (MPAM as noun)
MPAM probing -> implies that MPAM is a special form of probing (MPAM as kind
of adjective giving the flavor of probing that is happening)

So slight preference from me for current text.

> 
> > Start with driver probe/remove and mapping the MSC.
> > 
> > CC: Carl Worth <carl@os.amperecomputing.com>
> > Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> > Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> > Tested-by: Peter Newman <peternewman@google.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Ben Horgan <ben.horgan@arm.com>

> > diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> > new file mode 100644
> > index 000000000000..ef2f3adf64a9
> > --- /dev/null
> > +++ b/drivers/resctrl/Kconfig
> > @@ -0,0 +1,15 @@
> > +menuconfig ARM64_MPAM_DRIVER
> > +	bool "MPAM driver"
> > +	depends on ARM64 && ARM64_MPAM && EXPERT
> > +	help
> > +	  Memory System Resource Partitioning and Monitoring (MPAM) driver for
> > +	  System IP, e,g. caches and memory controllers.
> > +
> > +if ARM64_MPAM_DRIVER
> > +
> > +config ARM64_MPAM_DRIVER_DEBUG
> > +	bool "Enable debug messages from the MPAM driver"
> > +	help
> > +	  Say yes here to enable debug messages from the MPAM driver.
> > +
> > +endif  
> 
> I am asking myself why "depends on ARM64_MPAM_DRIVER" can't be used here? :-)

Fairly sure that came up in an earlier review. IIRC other stuff going to be added
later in this if/endif block.

> 
> > diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> > new file mode 100644
> > index 000000000000..898199dcf80d
> > --- /dev/null
> > +++ b/drivers/resctrl/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
> > +mpam-y						+= mpam_devices.o
> > +
> > +ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
> > diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> > new file mode 100644
> > index 000000000000..6c6be133d73a
> > --- /dev/null
> > +++ b/drivers/resctrl/mpam_devices.c
> > @@ -0,0 +1,194 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2025 Arm Ltd.
> > +
> > +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/arm_mpam.h>
> > +#include <linux/cacheinfo.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/gfp.h>
> > +#include <linux/list.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/printk.h>
> > +#include <linux/srcu.h>
> > +#include <linux/types.h>
> > +
> > +#include "mpam_internal.h"
> > +
> > +/*
> > + * mpam_list_lock protects the SRCU lists when writing. Once the
> > + * mpam_enabled key is enabled these lists are read-only,
> > + * unless the error interrupt disables the driver.
> > + */  
> 
> s/when writing/for writing
To me not a clear improvement.  The when writing is a bit passive in that
it is talking about something that 'is the case' rather than something 'we
make' the case. 

> s/are read-only/become read-only
Nope to this one.  Become implies it happens at a later stage, are
implies that it happens before mpam_enabled_key is enabled which is more
correct (subtle though!)

> 
> > +static DEFINE_MUTEX(mpam_list_lock);
> > +static LIST_HEAD(mpam_all_msc);
> > +
> > +struct srcu_struct mpam_srcu;
> > +
> > +/*
> > + * Number of MSCs that have been probed. Once all MSC have been probed MPAM
> > + * can be enabled.
> > + */  
> 
> s/all MSC/all MSCs  (?)
yes.
> 
> > +static atomic_t mpam_num_msc;
> > +
> > +/*
> > + * An MSC can control traffic from a set of CPUs, but may only be accessible
> > + * from a (hopefully wider) set of CPUs. The common reason for this is power
> > + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
> > + * corresponding cache may also be powered off. By making accesses from
> > + * one of those CPUs, we ensure this isn't the case.
> > + */  
> 
> s/An MSC/A MSC (?)

No on this one.  I would pronounce MSC and Em-ess-sea
so rules are you therefore use An.  This is a truely weird quirk of
English!


> s/from a/from the
Another subtle case.  "the" implies that we all know exactly which wider
set of CPUs.  "a" implies that there is at least one that can use. So
in my mind, a is slightly more correct, but others may disagree.

> s/isn't the case/is the case (?)

I think original is correct.  The thing that isn't the case is the
".. may also be powered off." and that's what we want to avoid.
I'm not 100% sure on intention of that comment though - so good
one to query!

Thanks,

Jonathan


