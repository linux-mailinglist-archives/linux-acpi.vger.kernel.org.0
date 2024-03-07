Return-Path: <linux-acpi+bounces-4171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA47E875B37
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 00:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772901F225A6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7647784;
	Thu,  7 Mar 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nj89UMB8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B41D698;
	Thu,  7 Mar 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709855492; cv=none; b=TSd1SMkYAViKiKsND2c5BtvTeknkqz8YejR33zFJgb0vE1/aAEmEc4914ucSi+mOHP7TzL89oSJToby9REeHxDxT9OtSztdUZ/10+SxkO2jYKLJxiGvHslG9Ov94zqGbZ3YE8eBNSspYjKww9364kUKn6Gbys/W7/Gl6HX6W+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709855492; c=relaxed/simple;
	bh=H616toJDSIX34uDV94bgH1B1W8ztcGskB+igjluTuOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIOYfwWwpWgtMzaGqgV9oYa33yLYx1qQ1L1ovIa5d9wbiA/nrkZ1jUZHT5mJYrbZJNQ/89NbMWrAlcabjxdmq8j4MHFuJjPNnflFP/2QhJ+GIGw6JLgpSfyR2jtsJFhC1XgSZeEKz8f0J4E6c2kZguB1bGmGN7N2GxGqQNnSsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nj89UMB8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709855490; x=1741391490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H616toJDSIX34uDV94bgH1B1W8ztcGskB+igjluTuOg=;
  b=nj89UMB8jg1NarKIqUNqCYJu0FzaqwJlt0i3qxgbw8Rpkkj54FF+IdJ5
   L4NzU7cpjbxE1M6gAWAmATxrwkDGlE6cfD6kVIe6Bcl04/VO7t+HaW6Ep
   038peH1PqUSIQbFlsUWrsU5mif4lB2HdzVPJYlaWcsXiA1DAJyc71lY79
   W96oO5Hc1DmAcJadBNfn0eShdSp02z2TsHPUPxxsdOw7ORuGPQtQKpMlD
   o54R4xu0y906wNQJcCat4TOMaaHJZ2sFmJHdnj58uGxCeQo3MTkZSaaZI
   KrlwbCj66dLxw++5EH+e6q3MSOut9eE+/bG5skgXJGTO5713u7BzgHa/c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4683221"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4683221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="41199837"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.247.118.100]) ([10.247.118.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:51:24 -0800
Message-ID: <1dfdec49-5d37-4117-96d6-3191cb12ee2d@intel.com>
Date: Thu, 7 Mar 2024 16:51:18 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] cxl/region: Add memory hotplug notifier for cxl
 region
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net, rafael@kernel.org,
 gregkh@linuxfoundation.org, Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
 <20240220231402.3156281-12-dave.jiang@intel.com>
 <20240306145331.00003e54@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240306145331.00003e54@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/24 7:53 AM, Jonathan Cameron wrote:
> On Tue, 20 Feb 2024 16:12:40 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> When the CXL region is formed, the driver would computed the performance
>> data for the region. However this data is not available at the node data
>> collection that has been populated by the HMAT during kernel
>> initialization. Add a memory hotplug notifier to update the access
>> coordinates to the 'struct memory_target' context kept by the
>> HMAT_REPORTING code.
>>
>> Add CXL_CALLBACK_PRI for a memory hotplug callback priority. Set the
>> priority number to be called before HMAT_CALLBACK_PRI. The CXL update must
>> happen before hmat_callback().
>>
>> A new HMAT_REPORING helper hmat_update_target_coordinates() is added in
> 
> REPORTING
> 
>> order to allow CXL to update the memory_target access coordinates.
>>
>> A new ext_updated member is added to the memory_target to indicate that
>> the access coordinates within the memory_target has been updated by an
>> external agent such as CXL. This prevents data being overwritten by the
>> hmat_update_target_attrs() triggered by hmat_callback().
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> One missing error check and another trivial comment.
> With error check handled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> 
>> +static void remove_coord_notifier(void *data)
>> +{
>> +	struct notifier_block *memory_notifier = data;
>> +
>> +	unregister_memory_notifier(memory_notifier);
> 
> Trivial but no real loss of info if you do

ok will change

> 
> 	unregister_memory_notifier(data);
> 
>> +}
>> +
>>  static int cxl_region_probe(struct device *dev)
>>  {
>>  	struct cxl_region *cxlr = to_cxl_region(dev);
>> @@ -3081,6 +3151,12 @@ static int cxl_region_probe(struct device *dev)
>>  		goto out;
>>  	}
>>  
>> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
>> +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
>> +	register_memory_notifier(&cxlr->memory_notifier);
>> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier,
>> +				      &cxlr->memory_notifier);
>> +
> 
> Check rc?  Very unlikely to fail, but you never know..

It's actually checked a few lines down after cxl_region_sem gets released. Probably too far away for diff to include it.

DJ
> 
>>  	/*
>>  	 * From this point on any path that changes the region's state away from
>>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> 
> 

