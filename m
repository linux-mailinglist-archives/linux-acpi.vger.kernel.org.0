Return-Path: <linux-acpi+bounces-17807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD0BE09EC
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A963AF332
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1672BE04D;
	Wed, 15 Oct 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c10wzr7N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0C28BA81;
	Wed, 15 Oct 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559706; cv=none; b=nJbCzQDeAzhSFwn2TgJqZqzylX3Pugjo+s0HOG5tKKRvI3zouKaNNNBEyMXzgZJHXrwghqZBLEyZH3OGNv2Vkft1SIfUqT3vlkgvyTOUV8qf9eVI8G3oRWFqH/dfUI1Du8BECv9CAjD1iu9SXtuaJXmVm3Ne+G2gofDly2EfCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559706; c=relaxed/simple;
	bh=EcCY2XhDrhiXOAGa7WBT+bi2gS4d3WPElAIa9foGgJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKgI48rNDiAF06NqgErhINsEDTmvTTNV7cMrnP/CeVOfluGjlKd8hTguuD4XEv7YpDngTcki/8/WwXB7R/gkPBqKQXAUmo8MrKFxgIOw2wMn+Tx1SgGxLAiwwfmswoSVXrXPhrXml6tS6iyq+VR3/ml9ZpJloJtMI4JSkJqWLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c10wzr7N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760559705; x=1792095705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EcCY2XhDrhiXOAGa7WBT+bi2gS4d3WPElAIa9foGgJo=;
  b=c10wzr7NvoA32+Kf+rwXH/skLL8ug92F8iZ+prxwDRDLUvogX+i3jeLZ
   klsj24RRihJQm5zY5ppi5+qifsuVwRQIYU2eX3XnERVnLRY5RcF+oPhlZ
   /2I6BEWqDNuY+RRUMGpqVVoqtdGbK8CpomkLLiq9k/+p8I3Fbg7r66F7Y
   e1n1OE+bPudOTUVxUZCzOzdW6u3CoX3DOeR6GOa/zaEkPsLpcIfX1sBSW
   fQoI4KvxbMLwb58kPEq3yMKw504aRU53L+DAWxzXiFbkKqoM5Yzzp36Da
   92cMGh9AWHo8kuYiC7KTHqfBH3Mcq8CwxHvydGh2gjvF7SyO9ICF4tyUB
   g==;
X-CSE-ConnectionGUID: TaQdOduNRjClAQ7LaFD7eg==
X-CSE-MsgGUID: CKrGAWVIRXm9vo0mpskzqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="66396982"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="66396982"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:21:44 -0700
X-CSE-ConnectionGUID: aEA+r6uhTEqOad1Iq+D4/w==
X-CSE-MsgGUID: 971oLku7SC+x37r/9EBDYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182677003"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.221]) ([10.125.111.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:21:42 -0700
Message-ID: <9671f553-1a45-42ed-8fe2-e45a5ab0e8d1@intel.com>
Date: Wed, 15 Oct 2025 13:21:41 -0700
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

That works. I was tunnel visioned in trying to not mess up the current code flow.

DJ> 
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
>         for (res = target->memregions.child; res; res = res->sibling) {
>                 int target_nid = pxm_to_node(target->memory_pxm);
>  
> 
> ...?


