Return-Path: <linux-acpi+bounces-18841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06EC547E4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941783A3586
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498262C234F;
	Wed, 12 Nov 2025 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXJh+C3i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1702C1581;
	Wed, 12 Nov 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980118; cv=none; b=AnSlw24m5T6Kuq7V1QfbYG6MVZ0ikhs5qLsS4emFr8aYR+On/gG+q+1QToc64/6CjfxmRcvPK3voOMuceT7Vmz6vvG2X08jFYa0kyC+ES2XBJiMuUhdcQVBoMI3x1kqFPKTBs91k8cHeSi5aCt3Qb4jClma39VPrRkuRnXWXgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980118; c=relaxed/simple;
	bh=g+Xw7BPdzEBxw6q3bSFXlrq7sqUQnBs9h7Pk/Q4IXh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKkJU+tYCJyTLT7epSIhhohPU6Snl9Wu8RY5galw5341TXDP69VQyP2o+Q6YIgzqOQeXgqls/uXtdvwgsVOQUJYG4CL9lcEaEOhBxIdGRAAdaMNHdw1JuXYeKA5vGSMt25qTh08VJpt4rWJHclry3F9xWG9nx1BDdx0vrJiq4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXJh+C3i; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762980116; x=1794516116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g+Xw7BPdzEBxw6q3bSFXlrq7sqUQnBs9h7Pk/Q4IXh0=;
  b=bXJh+C3iCmAQ2R7BWGMuwGTttkPtVvjq53LMOtkoiv/tx8O3QLODYxKB
   Hd8OY2DkMEU69zJ3fiUV3MdcGImCaPSP9LW5jZXAaYUIk4ns1bVpN1jit
   DybnRn/lcCBU80v1s+OPLquBOEVYA5FtZvD7kNLAqpdeg1uzBpvNFxske
   UjfrEeg9QNLoM5YLG11AYSFwBhr8yuDLVJTJyYuGh7rmFp/F1xAdy84Qw
   rgQZrYPabPM9YuJILozfCcWW7D6xMVvUMveUgg+K/Zr3k3/cZmCwThXfg
   FLi/Up53m4WN8I9AN/EGFVixB25T2TuKk5qUbRJmp90GnkRG5ejF25jwj
   Q==;
X-CSE-ConnectionGUID: nExPJQpoSzGMJiIJ+rTAIw==
X-CSE-MsgGUID: eQTZnMb+TsmnYvEV3FG9+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64938345"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="64938345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 12:41:55 -0800
X-CSE-ConnectionGUID: nuFgINl/Rg2KCimrlImb5g==
X-CSE-MsgGUID: i+I/7OpbTG2B2QTmlum93w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="219970307"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 12:41:55 -0800
Message-ID: <55116a54-dd66-4444-aaeb-56ffc3ff5712@intel.com>
Date: Wed, 12 Nov 2025 13:41:54 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 2/2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
To: dan.j.williams@intel.com, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: vishal.l.verma@intel.com, ira.weiny@intel.com, rafael@kernel.org
References: <20251105235115.85062-1-dave.jiang@intel.com>
 <20251105235115.85062-3-dave.jiang@intel.com>
 <690e977966ca5_74f59100b@dwillia2-mobl4.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <690e977966ca5_74f59100b@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 6:06 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>> The following lockdep splat was observed while kernel auto-online a CXL
>> memory region:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.17.0djtest+ #53 Tainted: G        W
>> ------------------------------------------------------
>> systemd-udevd/3334 is trying to acquire lock:
>> ffffffff90346188 (hmem_resource_lock){+.+.}-{4:4}, at: hmem_register_resource+0x31/0x50
>>
>> but task is already holding lock:
>> ffffffff90338890 ((node_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x2e/0x70
>>
>> which lock already depends on the new lock.
>> [..]
>> Chain exists of:
>>   hmem_resource_lock --> mem_hotplug_lock --> (node_chain).rwsem
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   rlock((node_chain).rwsem);
>>                                lock(mem_hotplug_lock);
>>                                lock((node_chain).rwsem);
>>   lock(hmem_resource_lock);
>>
>> The lock ordering can cause potential deadlock. There are instances
>> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
>> versa.
>>
>> Split out the target update section of hmat_register_target() so that
>> hmat_callback() only envokes that section instead of attempt to register
> 
> s/envokes/invokes/
> 
>> hmem devices that it does not need to.
>>
>> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Fix fixes tag. (Jonathan)
>> - Refactor hmat_hotplug_target(). (Jonathan)
>> ---
>>  drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
>>  1 file changed, 26 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 1dc73d20d989..d10cbe93c3a7 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -874,10 +874,33 @@ static void hmat_register_target_devices(struct memory_target *target)
>>  	}
>>  }
>>  
>> -static void hmat_register_target(struct memory_target *target)
>> +static void hmat_hotplug_target(struct memory_target *target)
> 
> Ah, this makes sense, but is quite a bit of churn with the new
> indentation and new function name which is a slightly odd fit since
> initial setup is not "hotplug". Is the following equivalent / easier to
> follow?

Yes and no. We also need to remove the generic target block out of the hotplug path. So I'll just keep the original version.

DJ

> 
> Either way,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 5a36d57289b4..a1be8cf70dc4 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -878,22 +878,16 @@ static void hmat_register_target(struct memory_target *target)
>  {
>  	int nid = pxm_to_node(target->memory_pxm);
>  
> -	/*
> -	 * Devices may belong to either an offline or online
> -	 * node, so unconditionally add them.
> -	 */
> -	hmat_register_target_devices(target);
> -
>  	/*
>  	 * Register generic port perf numbers. The nid may not be
>  	 * initialized and is still NUMA_NO_NODE.
>  	 */
> -	mutex_lock(&target_lock);
> +	guard(mutex)(&target_lock);
>  	if (*(u16 *)target->gen_port_device_handle) {
>  		hmat_update_generic_target(target);
>  		target->registered = true;
> +		return;
>  	}
> -	mutex_unlock(&target_lock);
>  
>  	/*
>  	 * Skip offline nodes. This can happen when memory
> @@ -905,7 +899,6 @@ static void hmat_register_target(struct memory_target *target)
>  	if (nid == NUMA_NO_NODE || !node_online(nid))
>  		return;
>  
> -	mutex_lock(&target_lock);
>  	if (!target->registered) {
>  		hmat_register_target_initiators(target);
>  		hmat_register_target_cache(target);
> @@ -913,15 +906,16 @@ static void hmat_register_target(struct memory_target *target)
>  		hmat_register_target_perf(target, ACCESS_COORDINATE_CPU);
>  		target->registered = true;
>  	}
> -	mutex_unlock(&target_lock);
>  }
>  
>  static void hmat_register_targets(void)
>  {
>  	struct memory_target *target;
>  
> -	list_for_each_entry(target, &targets, node)
> +	list_for_each_entry(target, &targets, node) {
> +		hmat_register_target_devices(target);
>  		hmat_register_target(target);
> +	}
>  }
>  
>  static int hmat_callback(struct notifier_block *self,


