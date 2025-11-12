Return-Path: <linux-acpi+bounces-18845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B7C54A80
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99CEB3442AA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6018E2D0C9C;
	Wed, 12 Nov 2025 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToRdpqbL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33C2874F1;
	Wed, 12 Nov 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984019; cv=none; b=jvOQX1iNE4K6ipSlJ6CxLjJZmDcKGc0QCrk2tF3yWuRiFgfWxaMtyqDgtMtk3vrhNJ9ObonJ+JH6MAOiBf5MfP153Z7fOaQRt7JzuAQTBj4eSMq/LqGqvypaphfjfqGgw5+9fj2/P0rRE0151NFC3iZU83KTPyz/ZoKjGq/syR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984019; c=relaxed/simple;
	bh=73hOZus6bt7WW1nOCZjFEPbG31JqufaOom4uB2E5Lds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cp19Bk2tTLx3l64GRPYCzRldvxIqwQAqNbmmvYfW7RV48XPac+WSE2zl73Nkxa0rIMg9nvObws1ODDyhRbgs2y2c4Uo7DNMf1TcTlHEBmpesBCQU06kYIxRguG94ghrEet9LG2VxaMhLfzMo9oOboGgSBLsrR9X6czlgvOkfC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToRdpqbL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762984018; x=1794520018;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=73hOZus6bt7WW1nOCZjFEPbG31JqufaOom4uB2E5Lds=;
  b=ToRdpqbLswau2Xk1AIMNa+wrIRgwnLtOOJL3rIfT0HfdCLHmos/vxg0O
   Qsg5uuXYHP0XjEcdBIx+nAlI09zixftkcLxktMkpJqG9f+Bt83biIbtFF
   iFLOvnpAgXO+tXi5lNUn55RsxAs0TCH/IORi/tTGFYUf+WTzUZj0r23yQ
   j8Kfpy/u40TPpK2pV678Y1afwhXS5xEoZydffKzQC7glNh5XqzhtuaCOd
   U6VNYn4TlpPsNEZCII1JvHKTnCnnBIN7ovzBKph7wVGB49M0OEc9hWU2c
   dgioZn+N1i9LOZIOrp3aSGhdNogSOC2HyPUMKJThy/ni8TLav8fZuAhRD
   A==;
X-CSE-ConnectionGUID: XLlqdu9ITmus4Xp1b8ww1A==
X-CSE-MsgGUID: sSS1j3GLRQWEVdftoV3EvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52620696"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="52620696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:46:57 -0800
X-CSE-ConnectionGUID: Vq6SPGbNR1mtyKtxYQK6yw==
X-CSE-MsgGUID: CH6M+xK4TKmRQNXPzyywsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="220085316"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:46:56 -0800
Message-ID: <87c9b0f7-77f8-4671-9c89-9b76107f4a39@intel.com>
Date: Wed, 12 Nov 2025 14:46:55 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 2/2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
References: <20251105235115.85062-1-dave.jiang@intel.com>
 <20251105235115.85062-3-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251105235115.85062-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 4:51 PM, Dave Jiang wrote:
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

Applied to cxl/fixes
71cd75e2b101a31d09f031e132a6ad04c911e164

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


