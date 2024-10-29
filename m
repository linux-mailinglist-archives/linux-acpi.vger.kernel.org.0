Return-Path: <linux-acpi+bounces-9104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC889B5619
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 23:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120562819D1
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F44209680;
	Tue, 29 Oct 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfz6y9EU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AF1EE021;
	Tue, 29 Oct 2024 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242538; cv=none; b=SKBbnnQzFUprUOgdWRb2vFkbnt4VtpNZeWPMJCxj9/iibo7ER60EV7KUPQH2Hpz1mdW0S3epRXGgIWb6JpTk5fWXH5gWNzKcefRGG2cJB3xqpsqJYY4Fhdf3GfVL73G6I71QUS+LA8+OOMP+A9Erc8d7bwXERuIuMEod1U/J73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242538; c=relaxed/simple;
	bh=GvV0OiG7pNnyr5RCxFggfVW492GfMbpnRN6lw61Zx4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COQyuUsXDVBDSZ1zPhvsCzJ4cUIfzVUVb6g4owtujn7HM2AL7CUBZqUU0yRylH/C+K4mdqFq0HtT6ZIwQvXqoPsE6ZarEuBUMkFXMbQ9DTeIiISKvBZ4XKDDvAm+GspHp/6gqQsD2DFMXO2Pp6PPrMG8g/1I1/GPqCP6HWPML3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yfz6y9EU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730242536; x=1761778536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvV0OiG7pNnyr5RCxFggfVW492GfMbpnRN6lw61Zx4E=;
  b=Yfz6y9EU/zm9+qXSu2x01Q26bY1/mqbkMP9Q6s48FUWMNrQUTDlEZGID
   k3HA4jTamh58VTKMFzi9ti/wfF+8UXhZ8t5//nNhhQ8yBEW6G10om1FBd
   iPLsK9/wuCFhAjkEi522blObRvkBDoe5+uKUK2knRyJ8pj4AJho7EYlzs
   6q18sAh59VhESCWo1QiX5JjH2VxtGcKqWiRgw27KuPtCo/GPulGfSie/W
   uEBT83GNMrJ4eR/fAcaXGbxaLywVvhabJcY6NClZgWQkrRfapn6OdSBmR
   5b/nhGP+90u6blgnXCsOI9fQN0Nu6hOPmSPZZV5lwCw/u+xQtJTxx7r4Q
   Q==;
X-CSE-ConnectionGUID: 3E9NNu8dQ/esne04FsbsJA==
X-CSE-MsgGUID: syTFrvXBT2CwkP5rjRB4oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30112579"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30112579"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:55:36 -0700
X-CSE-ConnectionGUID: YnVLoB8tTIyZ80cXFuWVXQ==
X-CSE-MsgGUID: UQ4zSrA1SBKFVRnKgfTQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="112943317"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:55:34 -0700
Message-ID: <033bff85-0179-46d0-b1dd-946751505c25@intel.com>
Date: Tue, 29 Oct 2024 15:55:33 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] acpi/hmat / cxl: Add exclusive caching
 enumeration and RAS support
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20241017174634.000079a1@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017174634.000079a1@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:46 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:52 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Hi all,
>> I'm looking for comments on the approach and the implementation of dealing with
>> this exclusive caching configuration. I have concerns with the discovering and
>> handling of I/O hole in the memory mapping and looking for suggestions on if
>> there are better ways to do it. I will be taking a 4 weeks sabbatical starting
>> next week and I apologize in advance in the delay on responses. Thank you in
>> advance for reviewing the patches.
>>
>> The MCE folks will be interested in patch 6/6 where MCE_PRIO_CXL is added.
>>
>>
>> Certain systems provide an exclusive caching memory configurations where a
>> 1:1 layout of DRAM and far memory (FR) such as CXL memory is utilized. In
> (FM) at least that is what you use later.
> 
> 
>> this configuration, the memory region is provided as a single memory region
>> to the OS. For example such as below:
>>
>>              128GB DRAM                         128GB CXL memory
>> |------------------------------------|------------------------------------|
> 
> So this differs slightly from what I expected.  
> The ACPI spec change I believe allows for the CXL memory to be be N times
> bigger than the cache.

Right. Spec allows that. Implementation I'm dealing with is only 1:1. So only limited implementation for now. 
> 
> I'm not against only supporting 1:1, but I didn't immediately see code
> to check for that and scream if it sees something different.

Yes. I need to add detection for that and emit warning.

> 
> Also as I mention in one of the patches, I don't recall the ACPI stuff
> giving an 'order' to the two types of memory.  Maybe I'm missing that
> but in theory at least I think the code needs to be more flexible
> (or renamed perhaps).

Yes no requirement by the spec on the ordering. Just available implementation.

> 
> Jonathan
> 
> 
> 


