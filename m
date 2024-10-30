Return-Path: <linux-acpi+bounces-9142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA049B7081
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 00:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6E1C2083A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CDC1D0E03;
	Wed, 30 Oct 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOfFo8xJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD87213EF6;
	Wed, 30 Oct 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730330968; cv=none; b=J8UwUAACjhKJo25Dz6/0Sp+alFGX7N1dKES3no8emhlTZwFlYcNCXFavGvKwMsGqMnMiGSzMYMigtTCdrO5Ctm0OJXV+jsZQ7qFE5kxKRf2NxIQ7X0fBXPD9pb91giFup7H21BcT+V3ml3J9tsl+s7Kmwcr2nlvPDY2cussnSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730330968; c=relaxed/simple;
	bh=NT0DF9JVGdZiwOJ0vHt8V9qzbLspxkPpRrOw6Ncsu+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTCM7CH/fUtc9RVobPmjzHh/sRV84UPrpPuARBC/gZNyJgqpulMakzMM/7jv88UamucEvhdkl3iOIjv58FISZJ9/u5HPQmF38tlpO6QlM45pdlRXx0yDUo3BzZwYdDWCMljwbYkWjPHYlgNysxoekri79NerSZf0kcL67TR+E9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOfFo8xJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730330966; x=1761866966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NT0DF9JVGdZiwOJ0vHt8V9qzbLspxkPpRrOw6Ncsu+k=;
  b=mOfFo8xJ94XNHop53TUf5r5EbVm3f8qEAHHioCTxfjRYqVpbMHtdl2VS
   UKWusn8iLYgX4geA+eOsAWnEJDU2wA8Il1PwahMpA1Uu3ACy7ybIg2krx
   OkycDILgxTZgZDP8Ova+mzDWBEvmB8QFjUIBTdk742uZcbgUhfn0qN90+
   sg1sxAiBTKEGFkBExnQtMkcDFyzXOPh+1H2PF6hntlt0M2YCQC+XpcCQJ
   V72kJ0ExvO7F4FUD3OnmaY4U3gKGddUFbpq4UwvlkzNKHpZ9/Oe6YfVmG
   Xy21zHR4Pxue/FPILZf14LcVrsKthhv0nNbaxQBNL9FZmqnJD5jmozeoS
   w==;
X-CSE-ConnectionGUID: rtqgAKDlTnW2cI5IxtErjg==
X-CSE-MsgGUID: 64V8UunjR+aQmDyiOvVmDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30011736"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30011736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:29:25 -0700
X-CSE-ConnectionGUID: GK7MuAdNQIKzNGb2vQpcYw==
X-CSE-MsgGUID: sXZnDTTTQducy1AWgP+VHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82380027"
Received: from nnlnb-sb-019.ccr.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:29:25 -0700
Message-ID: <c5d0f22e-b4f5-42df-8e15-efe73d58fda3@intel.com>
Date: Wed, 30 Oct 2024 16:29:23 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] cxl: Add extended linear cache address alias
 emission for cxl events
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-6-dave.jiang@intel.com>
 <20241017173810.00002ab5@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017173810.00002ab5@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:38 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:57 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add the aliased address of exteneded linear cache when emitting event
> extended
> 
>> trace for DRAM and general media of CXL events.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Trivial comment inline. 
>> ---
>>  drivers/cxl/core/acpi.c   | 10 ++++++++++
>>  drivers/cxl/core/core.h   |  7 +++++++
>>  drivers/cxl/core/mbox.c   | 42 ++++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/core/region.c |  2 +-
>>  drivers/cxl/core/trace.h  | 24 ++++++++++++++--------
>>  5 files changed, 73 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
>> index f13b4dae6ac5..f74136320fc3 100644
>> --- a/drivers/cxl/core/acpi.c
>> +++ b/drivers/cxl/core/acpi.c
>> @@ -9,3 +9,13 @@ int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>>  {
>>  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>>  }
>> +
>> +int cxl_acpi_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
>> +{
>> +	return hmat_extended_linear_cache_address_xlat(address, alias, nid);
> 
> Can we just stub them out in acpi.h?  I'm not sure wrapping them gives us
> anything useful.

It's already stubbed out in acpi.h. Here it's wrapped so that core/mbox.c does not need pull in linux/acpi.h header.
> 
>> +}
>> +
>> +int cxl_acpi_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
>> +{
>> +	return hmat_extended_linear_cache_alias_xlat(address, alias, nid);
>> +}
> 
> 


