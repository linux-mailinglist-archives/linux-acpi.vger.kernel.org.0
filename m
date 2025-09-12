Return-Path: <linux-acpi+bounces-16715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF46B54C93
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E0172B8E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C8338F3B;
	Fri, 12 Sep 2025 11:55:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB9337694;
	Fri, 12 Sep 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678142; cv=none; b=Y1U+nthHOu/GzG/T5S9BOEpsV6ZzIOLFAJ5RweYdUBOb60e3UuJJrU1zvKWe344ND7mvqfxZ8G7Sq19PEHreD0kYd4fZCtI4yY2AESNLniwKCz2/ed13jaEZk/Luh6U74rTo1u8M7M75e2mjkxJJX9hIHfDrwnpEfjpKhMWUtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678142; c=relaxed/simple;
	bh=a9xjflvIj1GvX/AYeSv78nJnUVdvj5cwSlEFF++3IBk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/na20nYqD3C54uKo44bI+iksZigwz362TuWidj9o9BPKV6/5KafJnoHK7HlM3pKHRh2eUTiobDdtFmY31E5eaGYkz+PK9alNif5WbHXIWcmfVPhm538qG5hI9h2CCuO9KdFJEPcO7nChDQsjxO70lrHNkJJePpDSl1QAcLA820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNXqX6c7Xz6M4Wk;
	Fri, 12 Sep 2025 19:52:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4330814037D;
	Fri, 12 Sep 2025 19:55:38 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 13:55:37 +0200
Date: Fri, 12 Sep 2025 12:55:35 +0100
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
Subject: Re: [PATCH v2 15/29] arm_mpam: Reset MSC controls from cpu hp
 callbacks
Message-ID: <20250912125535.0000151c@huawei.com>
In-Reply-To: <20250910204309.20751-16-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-16-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:55 +0000
James Morse <james.morse@arm.com> wrote:

> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtyied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Just one trivial passing comment from me.

Jonathan

> ---
> Changes since RFC:
>  * Last bitmap write will always be non-zero.
>  * Dropped READ_ONCE() - teh value can no longer change.
>  * Write 0 to proporitional stride, remove the bwa_fract variable.
>  * Removed nested srcu lock, the assert should cover it.
> ---
>  drivers/resctrl/mpam_devices.c  | 117 ++++++++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h |   8 +++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index cd8e95fa5fd6..0353313cf284 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

>  
> @@ -818,6 +921,20 @@ static int mpam_discovery_cpu_online(unsigned int cpu)
>  
>  static int mpam_cpu_offline(unsigned int cpu)
>  {
> +	int idx;
> +	struct mpam_msc *msc;
> +
> +	idx = srcu_read_lock(&mpam_srcu);

Might be worth using
guard(srcu)(&mpam_srcu);
here but only real advantage it bring is in hiding the local idx variable
away.  

> +	list_for_each_entry_srcu(msc, &mpam_all_msc, all_msc_list,
> +				 srcu_read_lock_held(&mpam_srcu)) {
> +		if (!cpumask_test_cpu(cpu, &msc->accessibility))
> +			continue;
> +
> +		if (atomic_dec_and_test(&msc->online_refs))
> +			mpam_reset_msc(msc, false);
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
>  	return 0;
>  }



