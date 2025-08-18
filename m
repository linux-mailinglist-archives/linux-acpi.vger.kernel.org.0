Return-Path: <linux-acpi+bounces-15797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CAB2AA85
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2779F1BA8415
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC7310627;
	Mon, 18 Aug 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiUXYv2s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE6207A0B;
	Mon, 18 Aug 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526142; cv=none; b=VEwRpgi1gLC5cK8L9hqCx3bRUd4LZUhc9SGOCQBT+7zlDtIzJwk5nq4h/HvXxuBRxoBC/s60fTa7HrjjAFiBYQWNwhekzPyDGCyKrQ7deK1EPUrIlsp8gH1q1NI5LValmr8aHKS7Y6BYndqaolBTpXQb5qSQ/FJZiowBl9gLrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526142; c=relaxed/simple;
	bh=3g19J1X9s3bz8Fgt5s8uW8MlkBC9D5GiHsIpGBalIe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2AbH1MWhS56v792KNhK77kzo/9bAXhIt2V6uLHB5bCmioPQNvQGNtdqDeA/SJac4ZjyHUhzLW016mBq3m+5dYoS85GavGKlbcROdTGr4FkMw2q0DGWdqzsYDnRQXvyWyvFKSnOtdFXm6yOFgwufliSIsfgYKD3UkNIJ0RrdirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiUXYv2s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755526141; x=1787062141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3g19J1X9s3bz8Fgt5s8uW8MlkBC9D5GiHsIpGBalIe8=;
  b=NiUXYv2sgc3/Fsxwt9MRCwlA8TCsAPzt/N9Jxo9HWC5IrmZ14QAlI787
   p7l7SJ5UcbZMr2xHSLz7RpnPp3y/7actNbylS652d02DCZkLRzWW4V11J
   axHVXSVM1VlmdqkCoYC0hvtvG7ATKT12VnAYShio01QZUenJhLy62J9Oc
   qoupmRPrjglgUXWLl4sT+AqqgC1IJ+SbfGYV0QOOwzbw6fnzkEjHQzvUq
   HIbw9Hbjop4wN4u2/bhzgrQ9M841bBTFmATjNC9fzsuEmMz3GQJSVFfo/
   3me5p1+e2VKP6/ThCJEMiVPG8kCTpfUVMZeQFGQo0rQ6HIGEcupLDPgmd
   Q==;
X-CSE-ConnectionGUID: QhLNGhjHRmi5/SrzZdi+lg==
X-CSE-MsgGUID: cgB2/h3sQrWwUIZpNzOiHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57896837"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57896837"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 07:09:00 -0700
X-CSE-ConnectionGUID: etcIFZB3Sbin3J6c2gfLaQ==
X-CSE-MsgGUID: 4UM+PZ20QIKHjHfYv2T9mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171807103"
Received: from cvapit-mobl1 (HELO [10.247.119.195]) ([10.247.119.195])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 07:08:52 -0700
Message-ID: <cd3d3e33-7b2e-45f1-977f-2d634ff1ef81@intel.com>
Date: Mon, 18 Aug 2025 07:08:46 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory
 callback priorities
To: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-2-dave.jiang@intel.com>
 <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <c3e30bf7-403a-4105-8e04-a73b80039ea5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/16/25 12:29 AM, David Hildenbrand wrote:
> On 14.08.25 19:16, Dave Jiang wrote:
>> Add clarification to comment for memory hotplug callback ordering as the
>> current comment does not provide clear language on which callback happens
>> first.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   include/linux/memory.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index 40eb70ccb09d..02314723e5bd 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -116,7 +116,7 @@ struct mem_section;
>>     /*
>>    * Priorities for the hotplug memory callback routines (stored in decreasing
>> - * order in the callback chain)
>> + * order in the callback chain). The callback ordering happens from high to low.
>>    */
>>   #define DEFAULT_CALLBACK_PRI    0
>>   #define SLAB_CALLBACK_PRI    1
> 
> "stored in decreasing order in the callback chain"
> 
> is pretty clear? It's a chain after all that gets called.

I can drop the patch. For some reason when I read it I'm thinking the opposite, and when Marc was also confused I started questioning things.

> 


