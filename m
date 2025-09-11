Return-Path: <linux-acpi+bounces-16683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EDB537CD
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17CA583AEB
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3B194A44;
	Thu, 11 Sep 2025 15:31:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DB3FFD;
	Thu, 11 Sep 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604712; cv=none; b=ZeJZ5GHCF5M4ODtDCwXOfqt30Pa6ZS7x9Oxu+s2Cr9hecN5vVokBRcjgbfWo2V3Sb/IHXxi8bBHINfn7/aM5vlxByz1szTNTnHcnn3oFg1FyWtOSiWe+uc1HAYNS3EfdPUBQt+N2z1kquZWIapI4EXXWLE51RBOyR8uQ0o09qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604712; c=relaxed/simple;
	bh=WGLQJ4HQwkkBe6Q8BjXQ13kUxNZL5cfjEQ7dcCSNxok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0c4fQz5vqJNFUD+1H3cESwgBY0ydYLoYq8DfCQC0f/keHYumdisFpRDkIcESyu0vGWMR0IDjFaWc8pl3Ben46tMWjQaDZSWZIPObaj/NZ2LVrJ16YsKE4Gks+Qlwjyii3zMGONZXjZ9uNvZTLOwCUKUKs8NjlVO6KfPbTRwwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C145C153B;
	Thu, 11 Sep 2025 08:31:40 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7233F63F;
	Thu, 11 Sep 2025 08:31:44 -0700 (PDT)
Message-ID: <aaefa134-b520-42d2-a700-4f7382b0318f@arm.com>
Date: Thu, 11 Sep 2025 16:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-13-james.morse@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20250910204309.20751-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 9/10/25 21:42, James Morse wrote:
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
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Change since v1:
>  * Made accesses to outer_lock_held READ_ONCE() for torn values in the failure
>    case.
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

These stale variables can be removed in the patch that introduced them,
outer_mon_sel_lock, inner_mon_sel_lock, inner_mon_sel_flags. Jonathan
has already pointed out the stale comment and paragraph in the commit
message.

Thanks,

Ben


