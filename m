Return-Path: <linux-acpi+bounces-17829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A6BE4E45
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCAF2356848
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5321CA13;
	Thu, 16 Oct 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aq/qfu09"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E56218ADD;
	Thu, 16 Oct 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636403; cv=none; b=hygMQ6O1R9L9HBpsUi9E9m488yXPUrsCE+w4sNaphxzpRwTNFN7kb09fx71/rE2motXl3eRUh6BlvDW0k1Nap9vNPWksw3L7Xl0Hv1e7isWlKOEJcOI5et3bMKk+4fG0qP1GBlPmpT3Zq3Wg7mqJObvMsOp6V1Rr30SXVeWDssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636403; c=relaxed/simple;
	bh=dEV+1IIB52ehcD6qDGjqoGIjfy3Tv9SSkcBXrJR4Fd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4dTsWQ/o2CBltSs0t5uJwql5aQMD7kzvCmr3yKRqGLoMaR+lcDP51NpeQPYot9UfK9nF37VIGYWt2zfiHF2I9QhUf7BnwBeami5lBhhkemv9WxHMnPeVXVafO6TrtrB+q6STIqW+MP3CaViTu4B1ZbwM3WzomopR2Mz+8L0bvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aq/qfu09; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760636401; x=1792172401;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dEV+1IIB52ehcD6qDGjqoGIjfy3Tv9SSkcBXrJR4Fd0=;
  b=aq/qfu09jKR5Zo+HDDu8djnD4lmfsnAwQo0ejVe/RtBoX7lFzljja18S
   V6fF82P5Zbnssmh4WODBEW7SRm66893ClAUqhF2YZkzzGVZZVNnP+EGH6
   pLaMKiU3RF5R9vx/FYqnoMJAExz8qbeodRMSHp9wixTG4qNQX4HBYicy5
   gskJKGXMduKZ53QeL+yaRbqaFxIWlW3v/WA0vc/JQ6S8U94qK41g2j/cl
   EzZnhzs+T6KmDmEolo5R9CW3D6m/hWzyD2wll9BGqvK1X0B/5Wwp0feKl
   LZmfuCScwgYhbK0Q3sK797wRLa2wcW3LfKQ0cduXX46+JMX9GkyGkigEk
   Q==;
X-CSE-ConnectionGUID: SlESKybQQMus5IOk6jTUvQ==
X-CSE-MsgGUID: NIqDn3HxQZaNrWTHncekrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66705314"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66705314"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:40:00 -0700
X-CSE-ConnectionGUID: e6fARCcBQPecAV+t8BGi0g==
X-CSE-MsgGUID: sUD53FoJSBOigMNvPtqDfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181728490"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.4]) ([10.125.108.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 10:40:00 -0700
Message-ID: <32ca1961-5ed6-47b5-af0e-70e7e87bba96@intel.com>
Date: Thu, 16 Oct 2025 10:39:59 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
To: dan.j.williams@intel.com, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: vishal.l.verma@intel.com, ira.weiny@intel.com, rafael@kernel.org
References: <20251015162958.11249-1-dave.jiang@intel.com>
 <68f001e4e4a2c_2f8991001a@dwillia2-mobl4.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <68f001e4e4a2c_2f8991001a@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/15/25 1:19 PM, dan.j.williams@intel.com wrote:
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
>> Remove registering of target devices from the hmat_callback(). By the
>> time the hmat hotplug notifier is being called, there should not be
>> hmem targets that still need to be registered.
>>
>> Fixes: cf8741ac57ed ("ACPI: NUMA: HMAT: Register "soft reserved" memory as an "hmem" device")
>> Link: https://lore.kernel.org/nvdimm/68e46a09c2a07_2980100f3@dwillia2-mobl4.notmuch/
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Drop target registering in hmat_callback instead. (Dan)
>> ---
>>  drivers/acpi/numa/hmat.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 5a36d57289b4..5084ae1688f6 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -874,7 +874,8 @@ static void hmat_register_target_devices(struct memory_target *target)
>>  	}
>>  }
>>  
>> -static void hmat_register_target(struct memory_target *target)
>> +static void hmat_register_target(struct memory_target *target,
>> +				 bool register_devices)
>>  {
>>  	int nid = pxm_to_node(target->memory_pxm);
>>  
>> @@ -882,7 +883,8 @@ static void hmat_register_target(struct memory_target *target)
>>  	 * Devices may belong to either an offline or online
>>  	 * node, so unconditionally add them.
>>  	 */
>> -	hmat_register_target_devices(target);
>> +	if (register_devices)
>> +		hmat_register_target_devices(target);
> 
> Why a new flag to pass around and not something like:
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 5a36d57289b4..9f9f09480765 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -867,6 +867,9 @@ static void hmat_register_target_devices(struct memory_target *target)
>         if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>                 return;
>  
> +       if (target->registered)
> +               return;
> +

So this still triggers the lockdep warning. I don't think it's smart enough to know that it gets around the issue. My changes with a new flag does not trigger the lockdep.

DJ

>         for (res = target->memregions.child; res; res = res->sibling) {
>                 int target_nid = pxm_to_node(target->memory_pxm);
>  
> 
> ...?


