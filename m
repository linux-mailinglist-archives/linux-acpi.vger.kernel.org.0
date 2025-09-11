Return-Path: <linux-acpi+bounces-16680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD3B537A1
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA141880454
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8985343D95;
	Thu, 11 Sep 2025 15:24:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C9320396;
	Thu, 11 Sep 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604288; cv=none; b=RyW7GtTxP5mIc2Rgg2kpt7cgy3KD2TWbHc6qirJ/dNgAb1MTyt5gURBL/ZbItjWZ4UUiDvQdo9vvPliQbchBsVQSzVo8m2ZeBzP5Zf49lOUOejEcMrOp+jLhtKrrR81lOQXeCzDKvN/hc7Z/k+ZmEDjY9bTdAG1tbIGY0IueM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604288; c=relaxed/simple;
	bh=s54H608mafpfDu/qCPS+J6iA2phyioVRz9Izw3j4ZXU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3h29euxNCJI+FNyIeWLwkP41Hls40SjLcaLB7MGIZZhZjgUhZpGCWCLjfOkiq+7p4SpIOeb1T2GPijynYHRXLP6hNToQjyn60jQul4bMy2LXvxDbm0mdH0xN+O6lRCabJ9gjVMf9lBwfDj4dQ292vRe8rAHOVOzNBqwXuHSScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cN1Xw350vz6GDBK;
	Thu, 11 Sep 2025 23:23:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 09DA81402FE;
	Thu, 11 Sep 2025 23:24:44 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Sep
 2025 17:24:42 +0200
Date: Thu, 11 Sep 2025 16:24:40 +0100
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
Subject: Re: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
Message-ID: <20250911162440.0000600b@huawei.com>
In-Reply-To: <20250910204309.20751-13-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-13-james.morse@arm.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:52 +0000
James Morse <james.morse@arm.com> wrote:

> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> mailboxes it must be able to sleep, meaning a mutex must be used. The
> SCMI platforms can't support an overflow interrupt.
> 
> Clearly these two can't exist for one MSC at the same time.
> 
> Add helpers for the MON_SEL locking. The outer lock must be taken in a
> pre-emptible context before the inner lock can be taken. On systems with
> SCMI mailboxes where the MON_SEL accesses must sleep - the inner lock
> will fail to be 'taken' if the caller is unable to sleep. This will allow
> callers to fail without having to explicitly check the interface type of
> each MSC.

Comments talk about outer locks, but not actually seeing that in the current code.

> 
> Signed-off-by: James Morse <james.morse@arm.com>

 ---
> Change since v1:
>  * Made accesses to outer_lock_held READ_ONCE() for torn values in the failure
>    case.
Comment on wrong patch?  No READ_ONCE() in here.

> ---
>  drivers/resctrl/mpam_devices.c  |  3 +--
>  drivers/resctrl/mpam_internal.h | 37 +++++++++++++++++++++++++++++----
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 24dc81c15ec8..a26b012452e2 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -748,8 +748,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>  
>  		mutex_init(&msc->probe_lock);
>  		mutex_init(&msc->part_sel_lock);
> -		mutex_init(&msc->outer_mon_sel_lock);
> -		raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +		mpam_mon_sel_lock_init(msc);
>  		msc->id = pdev->id;
>  		msc->pdev = pdev;
>  		INIT_LIST_HEAD_RCU(&msc->all_msc_list);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 828ce93c95d5..4cc44d4e21c4 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -70,12 +70,17 @@ struct mpam_msc {
>  
>  	/*
>  	 * mon_sel_lock protects access to the MSC hardware registers that are
> -	 * affected by MPAMCFG_MON_SEL.
> +	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
> +	 * Access to mon_sel is needed from both process and interrupt contexts,
> +	 * but is complicated by firmware-backed platforms that can't make any
> +	 * access unless they can sleep.
> +	 * Always use the mpam_mon_sel_lock() helpers.
> +	 * Accessed to mon_sel need to be able to fail if they occur in the wrong
> +	 * context.
>  	 * If needed, take msc->probe_lock first.
>  	 */
> -	struct mutex		outer_mon_sel_lock;
> -	raw_spinlock_t		inner_mon_sel_lock;
> -	unsigned long		inner_mon_sel_flags;
> +	raw_spinlock_t		_mon_sel_lock;
> +	unsigned long		_mon_sel_flags;
>  
>  	void __iomem		*mapped_hwpage;
>  	size_t			mapped_hwpage_sz;
> @@ -83,6 +88,30 @@ struct mpam_msc {
>  	struct mpam_garbage	garbage;
>  };
>  
> +/* Returning false here means accesses to mon_sel must fail and report an error. */
> +static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
> +{
> +	WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO);
> +
> +	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	return true;
> +}
> +
> +static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
> +{
> +	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +}
> +
> +static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
> +{
> +	lockdep_assert_held_once(&msc->_mon_sel_lock);
> +}
> +
> +static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
> +{
> +	raw_spin_lock_init(&msc->_mon_sel_lock);
> +}
> +
>  struct mpam_class {
>  	/* mpam_components in this class */
>  	struct list_head	components;


