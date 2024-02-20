Return-Path: <linux-acpi+bounces-3733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9D85C609
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 21:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7820B1F237F2
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E514AD15;
	Tue, 20 Feb 2024 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iovmzbsi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA5B14AD0F;
	Tue, 20 Feb 2024 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462042; cv=none; b=lwbqv/a+U4PfTb5CJ2kqCmqFZ35RQTLq2VT2rSKcfwpL94usgTxJ5StKE4GYcuBAigRWN7wA8uhPAxBKsspb014J5Dck/eoWR6x/T6babXJ8ulPWQ+Eecj/2esvmrRpMqnUc9Q1Ps+8Nua6S/uCtaZ5wx5WoxJt2Mo86QKBjDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462042; c=relaxed/simple;
	bh=coBNBJZqZQulRwZmdqk8CbaLdhZFBDB0EfkXY6AOdAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwvZnuD+vNkiGRDbpqqZAZgoPRyJ3BGtubu/5yrHt5hRmkFU/qoPfbzizO+XXBOTlRRwp2bRQFDYN9iTZqokR7/4wh/ZfTkit9+OWb/OSmDvCeiZcRSf0KM3DACh0dmiRbo3VKgkAQCJ4otJIyEPDEKw28IKfmwlJJOsyf/6PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iovmzbsi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462041; x=1739998041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=coBNBJZqZQulRwZmdqk8CbaLdhZFBDB0EfkXY6AOdAg=;
  b=IovmzbsiYbj0T+lvKwLhWhrWBxW1dIZLnQJ/MlGKzL0PHwtU/zWVP6DA
   HLq79p+p1D00kyjiqGP42IyLvBYICgqIER3vcH4KElK03z6905LM0i0P/
   KQKWWuxkgmli3kW38G3XJXgfdqluqXfTOWNxq4SuK8/t5UUe3W0uLwtq5
   rQAvUy8RL/qVC6dcQ5R/sbNwXG0Tq24M7v1Vq/E7oOguOgsfRKZV+8h5L
   XKShQXgh/jpFpTRtHBSDFkcu8+bdwhkHsay5ciUNQBygeokpQIo1d6B49
   PcEt02y2KXvSGT5K/xvqNX2D9P+lR04dU2zaXq28KxvodAgCgzzpIIt1x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13997357"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13997357"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5188934"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.92]) ([10.246.112.92])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:47:14 -0800
Message-ID: <7b4f2506-2672-4569-9552-24ae92a4a3a4@intel.com>
Date: Tue, 20 Feb 2024 13:47:12 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] cxl/region: Deal with numa nodes not enumarated
 by SRAT
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net, rafael@kernel.org,
 gregkh@linuxfoundation.org
References: <20240206222951.1833098-1-dave.jiang@intel.com>
 <20240206222951.1833098-13-dave.jiang@intel.com>
 <20240215172436.000064a7@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240215172436.000064a7@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 10:24 AM, Jonathan Cameron wrote:
> On Tue, 6 Feb 2024 15:28:40 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> For the numa nodes that are not created by SRAT, no memory_target is
>> allocated and is not managed by the HMAT_REPORTING code. Therefore
>> hmat_callback() memory hotplug notifier will exit early on those NUMA
>> nodes. The CXL memory hotplug notifier will need to call
>> node_set_perf_attrs() directly in order to setup the access sysfs
>> attributes.
>>
>> In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
>> stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
>> check if a NUMA node id is defined by SRAT or created by CFMWS.
>>
>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
>> for a node. The sysfs path of
>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> node
> 
>> to the NUMA node of the CXL region.
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Trivial comment inline.
> Otherwise LGTM
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v5:
>> - Fix ARM compile of missing prototype (0day)
>> ---
> 
> 
> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 19e419f18472..db51e35cb44f 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3084,7 +3084,12 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>  
>>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>>  		if (cxlr->coord[i].read_bandwidth) {
>> -			rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
>> +			rc = 0;
>> +			if (cxl_need_node_perf_attrs_update(nid))
>> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> maybe
> continue;
> here

Whether we are updating the node attrs or the hmat perf attrs, we want to refresh the CXL sysfs attrs to make sure is_visible() has changed.

DJ
 
>> +			else
>> +				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
>> +
> 
> Then no need to indent the above
> 
>>  			if (rc == 0)
>>  				cset++;
>>  		}
> 

