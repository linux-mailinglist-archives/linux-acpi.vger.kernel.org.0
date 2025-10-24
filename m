Return-Path: <linux-acpi+bounces-18207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA1C07C58
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7242C3B1426
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EB334370;
	Fri, 24 Oct 2025 18:34:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972C1F5F6;
	Fri, 24 Oct 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330871; cv=none; b=ZeKJgHj30L3gWWRkRJ7K4EcmTwxAbSr+3IJDt2anT0M8tzxmxsQxBIXWvoTYt9hfo6PXGB0rxDK8HTkaVGWncbHdHd6tIg5eV8hufbXn/96eFXLrZogkx/PRtHTo3LqkeJ+EPK3G22lPKGmphPG2vmFvnVIprXv/89WIc1Z31iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330871; c=relaxed/simple;
	bh=CUoqa9yHGpnsx8l3dO7VBde+OKXLiBwKyY9hF9ks/6g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDuIOI7bnDgNneUMcRMFjLpDDPvktBn8pdScTKmsbYszjU1H1W+/YgEsdjQrcqyTHY7Z3mexNzo6uKtwJN91R5jnhFR/Qry34vpagLi6NmoiGT+nPCgrK6gRotBeopvp77+RlAIl89vMjPsXOB+11ikF7/Qd6Ax0F8BYeFPyoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWg63GFRz6M4f9;
	Sat, 25 Oct 2025 02:30:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D958E14010C;
	Sat, 25 Oct 2025 02:34:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:34:24 +0100
Date: Fri, 24 Oct 2025 19:34:22 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>, Fenghua Yu <fenghuay@nvdia.com>
Subject: Re: [PATCH v3 27/29] arm_mpam: Add helper to reset saved mbwu state
Message-ID: <20251024193422.00000bc5@huawei.com>
In-Reply-To: <20251017185645.26604-28-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-28-james.morse@arm.com>
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

On Fri, 17 Oct 2025 18:56:43 +0000
James Morse <james.morse@arm.com> wrote:

> resctrl expects to reset the bandwidth counters when the filesystem
> is mounted.
> 
> To allow this, add a helper that clears the saved mbwu state. Instead
> of cross calling to each CPU that can access the component MSC to
> write to the counter, set a flag that causes it to be zero'd on the
> the next read. This is easily done by forcing a configuration update.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvdia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
A couple of little places in here where I think moving things back to earlier
patches would reduce churn a little which is always nice for reviewers.

Either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> Changes since v2:
>  * Switched to guard and fixed non _srcu list walker.
>  * Made a comment about what is proteted by which lock a list.
> ---
>  drivers/resctrl/mpam_devices.c  | 46 ++++++++++++++++++++++++++++++++-
>  drivers/resctrl/mpam_internal.h |  7 ++++-
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index c207a6d2832c..89d4f42168ed 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c

>  	/*
>  	 * Read the existing configuration to avoid re-writing the same values.
>  	 * This saves waiting for 'nrdy' on subsequent reads.
> @@ -1090,7 +1100,10 @@ static void __ris_msmon_read(void *arg)
>  	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>  	clean_msmon_ctl_val(&cur_ctl);
>  	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
> -	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
> +	config_mismatch = cur_flt != flt_val ||
> +			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);

Push back to earlier patch perhaps?  I guess someone might ask why you don't do it
inline, but to me it seems complex enough that I doubt they will.
Nice to reduce the churn where it is easy to do.

> +
> +	if (config_mismatch || reset_on_next_read)
>  		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>  
>  	switch (m->type) {
> @@ -1242,6 +1255,37 @@ int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>  	return err;
>  }


> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index ff38b4bbfc2b..6632699ae814 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -204,10 +204,14 @@ struct mon_cfg {
>  
>  /*
>   * Changes to enabled and cfg are protected by the msc->lock.
> - * Changes to prev_val and correction are protected by the msc's mon_sel_lock.
> + * The msc's mon_sel_lock protects:
Nice to push this formatting change back to earlier patch so this
becomes a one line change.

> + * - reset_on_next_read
> + * - prev_val
> + * - correction
>   */
>  struct msmon_mbwu_state {
>  	bool		enabled;
> +	bool		reset_on_next_read;
>  	struct mon_cfg	cfg;


