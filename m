Return-Path: <linux-acpi+bounces-15713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0EB272B7
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 00:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA31A1C83B1E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FF28469C;
	Thu, 14 Aug 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzvN/Jd3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4328466D;
	Thu, 14 Aug 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212381; cv=none; b=aFuOwSQfu4fly/N9CHWc6tsW2omJUN0bVsxOnr9HglNxZ4ezZtKGmqBOb3yjAq773bbVGr4Zvm4GLFxzEwFDFPdCu2PYBdvltrKlphIBb9evo4caBXFcdO5JKE8k3V400CbOLvKqQLSQKc0DJo9Qi4hV8ACcsE5VcNai3xdJ3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212381; c=relaxed/simple;
	bh=ZGYwUpkU4jmgTE0WlS6XJk9TY+Aoxymu4El+HfWaW0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS1/Bbm/ZFVkSjHGy9W27X0bv0ri7UkpZVlQ7z50mcGc0wipj2Rrne2UcU1uOTtsYzh+xBAN47KE2wGv54KorhA1rMipEVrJPdxY1TRgffq24x4rqd19gErrqsoXK86lA4sLflnmRAKdyZf0xoHIVPjyetS4aNlHWQ4NfVtJGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzvN/Jd3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212379; x=1786748379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZGYwUpkU4jmgTE0WlS6XJk9TY+Aoxymu4El+HfWaW0I=;
  b=gzvN/Jd3XhjMb8uHgQv8DTAMxANk5XOO1R5VyVv6un16RKeKgSmNhb7H
   p+Ag319lJCBN/MD1oGR/xIlT2mGQR1BSxtVHR2tBJm6g6zRXck0v/NCI4
   80XP6LwcDZL6L+wm9q+wXpEKn9iCAl13xaQ+bzJ504odu/0MoFx7Iimhw
   FccseNwRczAmWsuhr2e8O0YiayDWwcLYQxBY8r6hw7W4aR9oHu9Wx8QpA
   HBS0Cz4w8UAl4Du9Er6NWTW14jQGt46+fWtblQg16uJJKBf+nGASWAAOE
   z3ZpApmxZ5Nk+2b6ddhJS6Pf6lNYo3Pdr/rykDXJp6og18qi0dUuqJQY3
   g==;
X-CSE-ConnectionGUID: zbqXqYHkSyu4RCiLFfXrdw==
X-CSE-MsgGUID: xXi/s0e/Rbe5QyrKBIqIPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68918453"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68918453"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:59:38 -0700
X-CSE-ConnectionGUID: byPaCU8rSzOcUAGXpOauEQ==
X-CSE-MsgGUID: GUKMalPvTAyOADggg+ffHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171336269"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.169]) ([10.247.119.169])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:59:31 -0700
Message-ID: <9a6f573c-1346-4173-a5f6-27678c011aa8@intel.com>
Date: Thu, 14 Aug 2025 15:59:25 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl, acpi/hmat: Update CXL access coordinates
 directly instead of through HMAT
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, marc.herbert@linux.intel.com,
 akpm@linux-foundation.org, david@redhat.com
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-4-dave.jiang@intel.com>
 <689e64229859f_50ce10082@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <689e64229859f_50ce10082@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/25 3:33 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>> The current implementation of CXL memory hotplug notifier gets called
>> before the HMAT memory hotplug notifier. The CXL driver calculates the
>> access coordinates (bandwidth and latency values) for the CXL end to
>> end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
>> memory hotplug notifier writes the access coordinates to the HMAT target
>> structs. Then the HMAT memory hotplug notifier is called and it creates
>> the access coordinates for the node sysfs attributes.
> 
> Perhaps summarize quickly here the before and after of sysfs, so people
> know if they are impacted by this bug, and backporters can verify they
> fixed it?

ok

> 
>> The original intent of the 'ext_updated' flag in HMAT handling code was to
>> stop HMAT memory hotplug callback from clobbering the access coordinates
>> after CXL has injected its calculated coordinates and replaced the generic
>> target access coordinates provided by the HMAT table in the HMAT target
>> structs. However the flag is hacky at best and blocks the updates from
>> other CXL regions that are onlined in the same node later on. Remove the
>> 'ext_updated' flag usage and just update the access coordinates for the
>> nodes directly without touching HMAT target data.
>>
>> The hotplug memory callback ordering is changed. Instead of changing CXL,
>> move HMAT back so there's room for the levels rather than have CXL share
>> the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
>> callback to be executed after the HMAT callback.
>>
>> With the change, the CXL hotplug memory notifier runs after the HMAT
>> callback. The HMAT callback will create the node sysfs attributes for
>> access coordinates. The CXL callback will write the access coordinates to
>> the now created node sysfs attributes directly and will not pollute the
>> HMAT target values.
>>
>> Fixes: debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated by SRAT")
> 
> Why that one and not?
> 
> 067353a46d8c cxl/region: Add memory hotplug notifier for cxl region

I think I grabbed the wrong line for 'git blame'. 

> 
> It is the ext_updated machinery that is the main problem that messes up
> sysfs, right?
> 
> ...and per the backport concern this should be cc: stable as well.
> 
> Other than that you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


