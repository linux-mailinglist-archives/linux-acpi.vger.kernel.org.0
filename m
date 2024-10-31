Return-Path: <linux-acpi+bounces-9210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8E9B8504
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 22:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC89283866
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906751CC16B;
	Thu, 31 Oct 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7UNteQ1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C711C2DA4;
	Thu, 31 Oct 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409154; cv=none; b=cRNsFFqvKM5mAilwW5eXBov7hgyteU4e281KMeG+Dp0Gm8qA57vlH3M5KK9pwEvrw0cghUKDLWAxR4qxw6BY+DY0EbLJqnNFwR1RmAl0yvDDL+5JNmV6PL7Co6I12wZCcwytbvwPzIVtG39wn4gRT8kbwwppqfvPMBGYfQXewVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409154; c=relaxed/simple;
	bh=70XK6vu3nUiFYpImnOO6mvKgQcShruBvh9wu/WdgiKQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uENqU6UsudxQY5W8J2iu8RCjDy+ZY+nhwY5bc1Gc/MrdsFKpmB5JOgfM7qXL9y4mqO3wM9cVjLiAOmBfB/yypSOoyr+Qp1hbgaILMwBnL5WDth8fLVCjIKQoAqoS8QneMZfKDkLoMNsiQMzgcz8Vzq/Xb3ObRGuUkVWKfF+OwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7UNteQ1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730409149; x=1761945149;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=70XK6vu3nUiFYpImnOO6mvKgQcShruBvh9wu/WdgiKQ=;
  b=T7UNteQ1N5ZJakPZoqryqATt4zZI/WzSF5Vkbdnhd7fThqxvXfbs47IX
   kh8ao/STdXUWFD/0rVZtjIehbs6wd6C+AZ6trx8c8jT0U6pGGD28KR75U
   1xisRuZ4vmI6lnR68of2APRdCbrs0Z6zIQ4t09zGpYtWWNIbMcsDXeqyM
   nZxFsmVekExD/aZFDx/hWutkq7FGBWanZzmzOxfh6vBFrVeGs92t3WprM
   RgmJuwfswSJrB9tVsipWlNp6XfTv4iMp1cAIu75DPIjbRwDXmlyV50xpo
   qV0ZrF3CsusAviwTK9Zu9xXaRIqgvfdSvuSW5NkoQagjF94/6lH+s0Ohq
   g==;
X-CSE-ConnectionGUID: zVauI12UQWihAHrrnhfDiw==
X-CSE-MsgGUID: kcnwkJ+PSeGh7RyedmXUow==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41561139"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="41561139"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 14:12:27 -0700
X-CSE-ConnectionGUID: K0XZWdqlR7y3+/JRdb37QA==
X-CSE-MsgGUID: h/KmmvPcQjK8VbbG/6AJZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83101311"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 14:12:25 -0700
Message-ID: <f12b70be-7b67-4925-9aee-691e18a1660a@intel.com>
Date: Thu, 31 Oct 2024 14:12:24 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] cxl: Add mce notifier to emit aliased address for
 extended linear cache
From: Dave Jiang <dave.jiang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-7-dave.jiang@intel.com>
 <20241017174058.000078bc@Huawei.com>
 <3f0b1003-751d-4890-a045-854586eeda22@intel.com>
Content-Language: en-US
In-Reply-To: <3f0b1003-751d-4890-a045-854586eeda22@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 4:37 PM, Dave Jiang wrote:
> 
> 
> On 10/17/24 9:40 AM, Jonathan Cameron wrote:
>> On Fri, 27 Sep 2024 07:16:58 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> Below is a setup with extended linear cache configuration with an example
>>> layout of of memory region shown below presented as a single memory region
>>> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
>>> The kernel sees a region of total 256G of system memory.
>>>
>>>               128G DRAM                          128G CXL memory
>>> |-----------------------------------|-------------------------------------|
>>>
>>> Data resides in either DRAM or far memory (FM) with no replication. Hot data
>>> is swapped into DRAM by the hardware behind the scenes. When error is detected
>>> in one location, it is possible that error also resides in the aliased
>>> location. Therefore when a memory location that is flagged by MCE is part of
>>> the special region, the aliased memory location needs to be offlined as well.
>>>
>>> Add an mce notify callback to identify if the MCE address location is part of
>>> an extended linear cache region and handle accordingly.
>>>
>>> Added symbol export to set_mce_nospec() in x86 code in order to call
>>> set_mce_nospec() from the CXL MCE notify callback.
>>
>> Whilst not commenting on whether any other implementation might exist,
>> this code should be written to be arch independent at some level.
> 
> I did get a 0-day report on this with mce bits. But with asm/mce.h included, it seems to make other archs happy as well AFAICT.

Ok I was wrong. Arch wrappers needed to deal with MCE bits only exists for x86. 

>>
>>>
>>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> 


