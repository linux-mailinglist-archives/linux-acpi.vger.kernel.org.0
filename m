Return-Path: <linux-acpi+bounces-15820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA856B2B778
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1C37A89D5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D9F2D2499;
	Tue, 19 Aug 2025 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToeFspIY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8C2D2494;
	Tue, 19 Aug 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573292; cv=none; b=mN0P8fUYF74tQVYLVUYAcBxbtDdO0Ta5UJuJa6wyktfNo9gBVsZVHKM5LUDheeQ9y2kwYDhvD0es8DffelnZ/7T32wi9scqyYpMKUshQEUQNysNSbqTgwr3q9CE7mfsuRzZPnpYXAMkA4YIGwzfcKsHYIKeCQFb3mtk9JAj6SPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573292; c=relaxed/simple;
	bh=LxlrR9y3l9B1O3j3VWx5sgYjS8asj4a64ifyNhQl3PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID3n1RBdcPyuOAIHM4o2S7nca35j5zoug/2kpSoX8iMhJ/kVFmS4WKN8DJ0HeARoIf1cjAwxUEbAeNPULpxQzdFuxGovfzj0VflTBe9hok+mRPf4ZQo8OFie9BTwl2z7cljwS9WxWqi+7f6Xz/GWHvPVdwHglQYU5oUlcZW05UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToeFspIY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755573290; x=1787109290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LxlrR9y3l9B1O3j3VWx5sgYjS8asj4a64ifyNhQl3PI=;
  b=ToeFspIYVB+JEWvAGUzdJmk0RVy0jG5C0bizTfJUq10MHDwCTlOdyCiQ
   9dPjP9Ok7/CgNHG9hZI8ggiwiug5kSwg6+2PHigXz5pUeI6bJsim9qnRP
   C3LLyP5kj7MtRpYFEf7qlpSCLHulLjxLEjcLRcfB0cc7QDdh6VjsFFfNZ
   JssNUrVNA2bMB2DB581dz/b0p0ZV3ihy3GICiE7u31whwufVj+s3ZbIoK
   R4Tp/88CMUYAo/vtApZ9dXezvhPHZC7Z4vWqxKUN5RidIwYzdv+GN8k64
   ySCeEiMMzDqTuIvoGQQ+g2jCk8UrRPISCOtqYQ//bPwljbn0xVZ2e4Tx/
   Q==;
X-CSE-ConnectionGUID: A1AyEoK6RkuPNN2Y3RwbZg==
X-CSE-MsgGUID: fqkDk2yaSH6eLc1Ac3uqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57665038"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57665038"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 20:14:50 -0700
X-CSE-ConnectionGUID: zilxxI6GSgGGUkjyRwoWNA==
X-CSE-MsgGUID: o+lzAP11T1CM4lG+w8RhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="173080724"
Received: from c02x38vbjhd2mac.jf.intel.com (HELO [10.54.75.30]) ([10.54.75.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 20:14:49 -0700
Message-ID: <3e48429a-b52d-43a1-b48a-06fb46f0a37c@linux.intel.com>
Date: Mon, 18 Aug 2025 20:14:45 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
 <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
 <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-18 07:08, Dave Jiang wrote:
> 
> 
> On 8/16/25 12:29 AM, David Hildenbrand wrote:
>> On 14.08.25 19:16, Dave Jiang wrote:
>>> Add clarification to comment for memory hotplug callback ordering as the
>>> current comment does not provide clear language on which callback happens
>>> first.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>   include/linux/memory.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>>> index 40eb70ccb09d..02314723e5bd 100644
>>> --- a/include/linux/memory.h
>>> +++ b/include/linux/memory.h
>>> @@ -116,7 +116,7 @@ struct mem_section;
>>>     /*
>>>    * Priorities for the hotplug memory callback routines (stored in decreasing
>>> - * order in the callback chain)
>>> + * order in the callback chain). The callback ordering happens from high to low.
>>>    */
>>>   #define DEFAULT_CALLBACK_PRI    0
>>>   #define SLAB_CALLBACK_PRI    1
>>
>> "stored in decreasing order in the callback chain"
>>
>> is pretty clear? It's a chain after all that gets called.
> 
> I can drop the patch. For some reason when I read it I'm thinking the opposite, and when Marc was also confused I started questioning things.
> 

I think we both found the current comment confusing (even together!)
because:

- It very briefly alludes to an implementation detail (the chain)
  without really getting into detail. A "chain" could be bi-directional;
  why not? This one is... "most likely" not. Doubt.

- Higher priorities can have lower numbers, example: "P1 bugs". Not the
  case here, but this "double standards" situation makes _all_
  priorities suspicious and confusing.

- Constants that come first in the file are called last.


I would go further than Dave and also drop the "chain" implementation
detail because it makes the reader to think too much.  Not needed and
distracting at this particular point in the file.

/*
 * Priorities for the hotplug memory callback routines.
 * Invoked from high to low.
 */

  => Hopefully zero cognitive load.



