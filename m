Return-Path: <linux-acpi+bounces-18777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C8C4EE57
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060553AE251
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCA36B047;
	Tue, 11 Nov 2025 15:56:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49E2D9ECB;
	Tue, 11 Nov 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876588; cv=none; b=sXOgEi+KIyIvLkHRJ9fyTGaDpuXOi1+3teHpMvoD34LpO54AyqkgVfolyqZ97vTwSx793dZzi0cySehxd1jcTAByfJJVezu2g0xRQe1D5MHENedN26x7u9UW5Sg4D6qD4hLGTAwlLwY2V2rOHEz6EFuH0M0kMS4mxw66sAFfS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876588; c=relaxed/simple;
	bh=W8CisLsHpplR32lGt4X7voHqYskVHjABt2aYWdACx0k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/xPb3GE74MprYoWNOk7Sc/S/GIbo37Llhw29Spw5uv7eMmVJLE3iZgnlTsUAG82Wz0nw9xPJgrrRTvbID/82hvAQwrArJf1FoR79F7gt13lyDvkZUN9Ygjn0zqiP+si/NOLsqbJX/1WehxStEfMIGH+gUyBR3GJKGTnro6iEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5WNP2bG3zHnGhp;
	Tue, 11 Nov 2025 23:56:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B3AB0140136;
	Tue, 11 Nov 2025 23:56:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:56:22 +0000
Date: Tue, 11 Nov 2025 15:56:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
Subject: Re: [RESEND PATCH v4 2/2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
Message-ID: <20251111155620.0000306e@huawei.com>
In-Reply-To: <20251105235115.85062-3-dave.jiang@intel.com>
References: <20251105235115.85062-1-dave.jiang@intel.com>
	<20251105235115.85062-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 5 Nov 2025 16:51:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The following lockdep splat was observed while kernel auto-online a CXL
> memory region:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.17.0djtest+ #53 Tainted: G        W
> ------------------------------------------------------
> systemd-udevd/3334 is trying to acquire lock:
> ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50
> 
> but task is already holding lock:
> ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70
> 
> which lock already depends on the new lock.
> [..]
> Chain exists of:
>   hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   rlock((node_chain).rwsem);
>                                lock(mem_hotplug_lock);
>                                lock((node_chain).rwsem);
>   lock(hmem_resource_lock);
> 
> The lock ordering can cause potential deadlock. There are instances
> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
> versa.
> 
> Split out the target update section of hmat_register_target() so that
> hmat_callback() only envokes that section instead of attempt to register
> hmem devices that it does not need to.
> 
> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial inline. I'm also fine with the version Dan posted.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> v4:
> - Fix fixes tag. (Jonathan)
> - Refactor hmat_hotplug_target(). (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1dc73d20d989..d10cbe93c3a7 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -874,10 +874,33 @@ static void hmat_register_target_devices(struct memory_target *target)
>  	}
>  }
>  
> -static void hmat_register_target(struct memory_target *target)
> +static void hmat_hotplug_target(struct memory_target *target)
>  {
>  	int nid = pxm_to_node(target->memory_pxm);
>  
> +	/*
> +	 * Skip offline nodes. This can happen when memory
> +	 * marked EFI_MEMORY_SP, "specific purpose", is applied
> +	 * to all the memory in a proximity domain leading to
> +	 * the node being marked offline / unplugged, or if
> +	 * memory-only "hotplug" node is offline.

If this version goes forwards, rewrap closer to 80 chars. I guess it ended
up short in some previous refactor.

> +	 */
> +	if (nid == NUMA_NO_NODE || !node_online(nid))
> +		return;
> +
> +	guard(mutex)(&target_lock);
> +	if (target->registered)
> +		return;
> +
> +	hmat_register_target_initiators(target);
> +	hmat_register_target_cache(target);
> +	hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
> +	hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
> +	target->registered = true;
> +}
> +
> +static void hmat_register_target(struct memory_target *target)
> +{
>  	/*
>  	 * Devices may belong to either an offline or online
>  	 * node, so unconditionally add them.
> @@ -896,25 +919,7 @@ static void hmat_register_target(struct memory_target *target)
>  		}
>  	}
>  
> -	/*
> -	 * Skip offline nodes. This can happen when memory
> -	 * marked EFI_MEMORY_SP, "specific purpose", is applied
> -	 * to all the memory in a proximity domain leading to
> -	 * the node being marked offline / unplugged, or if
> -	 * memory-only "hotplug" node is offline.
> -	 */
> -	if (nid == NUMA_NO_NODE || !node_online(nid))
> -		return;
> -
> -	mutex_lock(&target_lock);
> -	if (!target->registered) {
> -		hmat_register_target_initiators(target);
> -		hmat_register_target_cache(target);
> -		hmat_register_target_perf(target, ACCESS_COORDINATE_LOCAL);
> -		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
> -		target->registered = true;
> -	}
> -	mutex_unlock(&target_lock);
> +	hmat_hotplug_target(target);
>  }
>  
>  static void hmat_register_targets(void)
> @@ -940,7 +945,7 @@ static int hmat_callback(struct notifier_block *self,
>  	if (!target)
>  		return NOTIFY_OK;
>  
> -	hmat_register_target(target);
> +	hmat_hotplug_target(target);
>  	return NOTIFY_OK;
>  }
>  


