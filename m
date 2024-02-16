Return-Path: <linux-acpi+bounces-3631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7328858805
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 22:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F082282991
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B8145B18;
	Fri, 16 Feb 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brGsL+M/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB58145328;
	Fri, 16 Feb 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118942; cv=none; b=pAJAEs04pE9kaTO884m/oPlTr3SJC/iebekFyLe11O0ieAZjph1xCryg8a4QVmn2eSZa63Xgc/wy7Ys3w2nrGW+HFPICspGU5QZ3R6jx2HyKgqcY/8ThoO/i4yPZXIWaoS5LBXPvU0qTkdUvZaHpxuhVEy5vNAQ9fslPMmL/t5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118942; c=relaxed/simple;
	bh=z5aMfbXyqV84KC8Z/t4aLEv9U3SbaKx+axyNiFZiCXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3772oFhv+WTVk7DiKhAFvSgnbCceSgkB6Gvb7zVGEe+0cR+1B0VdlgTn0I5xYTuEV3kDoI7DgrdvVKZvWMkEJucwKumGZzhBwi5RIB2TD7Fx1VgzrI6saM/8tB14JKAOOje8aIYjNv0pLuyGHaPu84KGttFFkP0ygJzxyi4GBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brGsL+M/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708118940; x=1739654940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z5aMfbXyqV84KC8Z/t4aLEv9U3SbaKx+axyNiFZiCXk=;
  b=brGsL+M/JSRKT+gs3hn/ZMFVTO1+Sj3vWfjZioN0F6Yvwh5bbKGLgqli
   cd9evD7aENTtSsO2zeyy68TbRyxD37phZoX2zqcLLbRL6jhhTSjMv2E9b
   kqEkZk/kko+N+N0uFk/Tcb40mdjnCwc0/d/ss32vU7j+Qp1CnYoAcfcjk
   kdPuldoVuK+1pW35/c6t4aOkE7OLtJGYACelhoiRCkMnyh35i+jP8Kqgy
   R3pK6ynrqrtP1dvbliFHCgk/UZNbeFXO+dBE5TUf8obHFjWFuweXGIrbG
   KQXD/zpjhW96911E2BfSW8aHYv7MxbfVQm3Q80jqBUhWwXHt5GEzfxfmn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2130562"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2130562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="34987573"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.39]) ([10.246.112.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:28:58 -0800
Message-ID: <12006877-65d2-4599-b931-823e2458a69f@intel.com>
Date: Fri, 16 Feb 2024 14:28:57 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] cxl: Split out combine_coordinates() for common
 shared usage
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net, rafael@kernel.org,
 gregkh@linuxfoundation.org
References: <20240206222951.1833098-1-dave.jiang@intel.com>
 <20240206222951.1833098-6-dave.jiang@intel.com>
 <20240215165129.00001e01@Huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240215165129.00001e01@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 9:51 AM, Jonathan Cameron wrote:
> On Tue, 6 Feb 2024 15:28:33 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Refactor the common code of combining coordinates in order to reduce code.
>> Create a new function cxl_cooordinates_combine() it combine two 'struct
>> access_coordinate'.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Fix comment header (0-day)
>> - Remove EXPORT_SYMBOL (Dan)
>> ---
>>  drivers/cxl/core/cdat.c | 32 +++++++++++++++++++++++---------
>>  drivers/cxl/core/port.c | 18 ++----------------
>>  drivers/cxl/cxl.h       |  4 ++++
>>  3 files changed, 29 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 08fd0baea7a0..096320390ad9 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -185,15 +185,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  	xa_for_each(dsmas_xa, index, dent) {
>>  		int qos_class;
>>  
>> -		dent->coord.read_latency = dent->coord.read_latency +
>> -					   c.read_latency;
>> -		dent->coord.write_latency = dent->coord.write_latency +
>> -					    c.write_latency;
>> -		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
>> -						   dent->coord.read_bandwidth);
>> -		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
>> -						    dent->coord.write_bandwidth);
>> -
>> +		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
>>  		dent->entries = 1;
>>  		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
>>  					      &qos_class);
>> @@ -484,4 +476,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>>  
>> +/**
>> + * cxl_coordinates_combine - Combine the two input coordinates
>> + *
>> + * @out: Output coordinate of c1 and c2 combined
>> + * @c1: first coordinate, to be written to
> 
> When you say to be written to, what do you mean?
> Left over from adding out?

Yeah I'm not sure why it says that. Seems like half a sentence I left dangling. Going to change the block to below:

/**
 * cxl_coordinates_combine - Combine the two input coordinates
 *
 * @out: Output coordinate of c1 and c2 combined
 * @c1: input coordinates
 * @c2: input coordinates
 */


> 
> No obvious reason for this to have any idea that c1 and c2 are
> ordered.  
> 
>> + * @c2: second coordinate
>> + */
>> +void cxl_coordinates_combine(struct access_coordinate *out,
>> +			     struct access_coordinate *c1,
>> +			     struct access_coordinate *c2)
>> +{
>> +		if (c2->write_bandwidth)
>> +			out->write_bandwidth = min(c1->write_bandwidth,
>> +						   c2->write_bandwidth);
> 
> Why check c2->write_bandwidth?
> Code already does it, but I'm not sure why + I don't think you should
> treat c1 and c2 differently.

I think I need to check both and make sure that neither are 0 since we are taking the min of the two and both need to be valid.

> 
>> +		out->write_latency = c1->write_latency + c2->write_latency;
>> +
>> +		if (c2->read_bandwidth)
>> +			out->read_bandwidth = min(c1->read_bandwidth,
>> +						  c2->read_bandwidth);
>> +		out->read_latency = c1->read_latency + c2->read_latency;
>> +}
>> +
>>  MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 612bf7e1e847..af9458b2678c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2096,20 +2096,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>>  
>> -static void combine_coordinates(struct access_coordinate *c1,
>> -				struct access_coordinate *c2)
>> -{
>> -		if (c2->write_bandwidth)
>> -			c1->write_bandwidth = min(c1->write_bandwidth,
>> -						  c2->write_bandwidth);
>> -		c1->write_latency += c2->write_latency;
>> -
>> -		if (c2->read_bandwidth)
>> -			c1->read_bandwidth = min(c1->read_bandwidth,
>> -						 c2->read_bandwidth);
>> -		c1->read_latency += c2->read_latency;
>> -}
>> -
>>  /**
>>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>>   *				   of CXL path
>> @@ -2143,7 +2129,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  	 * nothing to gather.
>>  	 */
>>  	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
>> -		combine_coordinates(&c, &dport->sw_coord);
>> +		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
>>  		c.write_latency += dport->link_latency;
>>  		c.read_latency += dport->link_latency;
>>  
>> @@ -2152,7 +2138,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  	}
>>  
>>  	/* Augment with the generic port (host bridge) perf data */
>> -	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
>> +	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
>>  
>>  	/* Get the calculated PCI paths bandwidth */
>>  	pdev = to_pci_dev(port->uport_dev->parent);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index fe7448f2745e..fab2da4b1f04 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -882,6 +882,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  
>>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>>  
>> +void cxl_coordinates_combine(struct access_coordinate *out,
>> +			     struct access_coordinate *c1,
>> +			     struct access_coordinate *c2);
>> +
>>  /*
>>   * Unit test builds overrides this to __weak, find the 'strong' version
>>   * of these symbols in tools/testing/cxl/.
> 

