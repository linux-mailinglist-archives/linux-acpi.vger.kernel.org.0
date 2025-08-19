Return-Path: <linux-acpi+bounces-15839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2973B2C89C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 17:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626B83AAFA2
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2927CCF3;
	Tue, 19 Aug 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWI2V0nW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D44127D773;
	Tue, 19 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618010; cv=none; b=NF1D3AVDlJxdCuBi9YILgUa8LMwwz81RtH8Lmr5xXvfRxkBm/W5IvClkEcZDHMQdnZW6Dg1RvZF8yo/sjBNG2MWb77zH5LQuzFQwH6k8dsca9t9EUIWBuvgp1pz0TnendgkVxvhqW1DKllo/JaE8DCvPZbiXD5+i/+AukA6zVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618010; c=relaxed/simple;
	bh=mb22CbyTSLKtrklNFTa9P+2epTAAccGvqYeFCikf+sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwAo0r2KEIyQRy9iPM8KXZOccJQv8P30oW7gIhHGZEEzVaILZqEdKUJ07VtfCGkyrZguvNWEDvrN5wPKSgaF2iSR4dnd6YXR1t6f/qMKcNPIzBdNQn5XD5wE+9b7Aft0dBQQxt0clgeqHfGKv4DzS38pXinN23pOtbbGD6UF1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWI2V0nW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755618009; x=1787154009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mb22CbyTSLKtrklNFTa9P+2epTAAccGvqYeFCikf+sk=;
  b=DWI2V0nWdIYa8FeZbFBMKTwX4AI3HWtXL9+pEw29WWFI8WW260eAo6M5
   ur2KCZ9oqwgjHDDbwvx+/oz1yrbVlywIo7lAJXkIt7PfnJJHAnIyRIiJS
   f+NmnhFHzVpGk/8VZ8kJRj9PHH95PMmQoqACuSeY1F/94l0oV+Zu4fcZ7
   hGnIf+sh25+Hf9ZAmWnYiqctcOqqMP2dZehsJa6Bnm6TWUwQ/v+FMqRC7
   hQlr8iu6/qmRARodMryrZR49pJZ2mHAKjA1NVcPYicC9kGC5yedISaPop
   kE/ZRLlA5NB8hgCeMm+JvznoCmpScglib+tC5sTZL58y6VSQDYQab6lsP
   w==;
X-CSE-ConnectionGUID: C8ULNMt2SZqqRC9+cLZz9Q==
X-CSE-MsgGUID: O+IkSYBsR8CubCwNgLTyQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68964399"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="68964399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:40:08 -0700
X-CSE-ConnectionGUID: waRshYcTSwiiQ01LJfjtYQ==
X-CSE-MsgGUID: vRqpxgOkQEaech0MTM9LTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173121892"
Received: from unknown (HELO [10.247.119.200]) ([10.247.119.200])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:40:00 -0700
Message-ID: <41ec1e23-e0f6-4275-ba9b-a34c2cbddbd9@intel.com>
Date: Tue, 19 Aug 2025 08:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: David Hildenbrand <david@redhat.com>,
 Marc Herbert <marc.herbert@linux.intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
 <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
 <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
 <3e48429a-b52d-43a1-b48a-06fb46f0a37c@linux.intel.com>
 <83a930e5-660e-49ed-8c34-66c4edf93665@redhat.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <83a930e5-660e-49ed-8c34-66c4edf93665@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/19/25 2:18 AM, David Hildenbrand wrote:
> On 19.08.25 05:14, Marc Herbert wrote:
>>
>>
>> On 2025-08-18 07:08, Dave Jiang wrote:
>>>
>>>
>>> On 8/16/25 12:29 AM, David Hildenbrand wrote:
>>>> On 14.08.25 19:16, Dave Jiang wrote:
>>>>> Add clarification to comment for memory hotplug callback ordering as the
>>>>> current comment does not provide clear language on which callback happens
>>>>> first.
>>>>>
>>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>>> ---
>>>>>    include/linux/memory.h | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>>>> index 40eb70ccb09d..02314723e5bd 100644
>>>>> --- a/include/linux/memory.h
>>>>> +++ b/include/linux/memory.h
>>>>> @@ -116,7 +116,7 @@ struct mem_section;
>>>>>      /*
>>>>>     * Priorities for the hotplug memory callback routines (stored in decreasing
>>>>> - * order in the callback chain)
>>>>> + * order in the callback chain). The callback ordering happens from high to low.
>>>>>     */
>>>>>    #define DEFAULT_CALLBACK_PRI    0
>>>>>    #define SLAB_CALLBACK_PRI    1
>>>>
>>>> "stored in decreasing order in the callback chain"
>>>>
>>>> is pretty clear? It's a chain after all that gets called.
>>>
>>> I can drop the patch. For some reason when I read it I'm thinking the opposite, and when Marc was also confused I started questioning things.
>>>
>>
>> I think we both found the current comment confusing (even together!)
>> because:
>>
>> - It very briefly alludes to an implementation detail (the chain)
>>    without really getting into detail. A "chain" could be bi-directional;
>>    why not? This one is... "most likely" not. Doubt.
>>
> 
> Please note that the memory notifier is really just using the generic *notifier chain* mechanism as documented in include/linux/notifier.h.
> 
> Here is a good summary of that mechanism. I don't quite agree with the "implementation detail" part, but that information might indeed not be required here.
> 
> https://0xax.gitbooks.io/linux-insides/content/Concepts/linux-cpu-4.html
> 
>> - Higher priorities can have lower numbers, example: "P1 bugs". Not the
>>    case here, but this "double standards" situation makes _all_
>>    priorities suspicious and confusing.
>>
> 
> Yes, "priorities" are handled differently in different context.
> 
>> - Constants that come first in the file are called last.
> 
> Yes, but that part makes perfect sense to me.
>  > I would go further than Dave and also drop the "chain" implementation
>> detail because it makes the reader to think too much.  Not needed and
>> distracting at this particular point in the file.
> 
>  > /*
>>   * Priorities for the hotplug memory callback routines.
>>   * Invoked from high to low.
>>   */
>>
>>    => Hopefully zero cognitive load.
> 
> Still confusion about how a high priority translates to a number, maybe?
> 
> /*
>  * Priorities for the hotplug memory callback routines. Invoked from
>  * high to low. Higher priorities corresponds to higher numbers.
>  */
> 

This reads clear to me. I will adopt this comment if there are no additional objections. 


