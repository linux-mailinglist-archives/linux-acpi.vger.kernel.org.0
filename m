Return-Path: <linux-acpi+bounces-9103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174E9B5611
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 23:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046211F23B64
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08F18FDC5;
	Tue, 29 Oct 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlVpdMqV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02820B1EA;
	Tue, 29 Oct 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242304; cv=none; b=rJWNHdkniyezaS499Ja/imV3nWHebSM33B8jRIhD3wxMLKMv+vNpaFjaefEX2C7R7xdr/fxRpD0ynnQ7Jml8fgQCFfKT7e2jzwbOTog1AwSh1JHXZy25qyCylliyTUGx3JkAbLPoiw6Z5SkJOL6I0bGjqki48xyGf8RLAhT+K1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242304; c=relaxed/simple;
	bh=UEhu3GTXnnqTt9U9ea5ir6rPcrFzUbHg45E+tRVsrUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osr5ya2oFiboscT15k/dxe72uI9culn0qcJPqah6GgP550tTNEzZW4XoP8NV2FJ7JdvRwcLCaqPKwEn3ctmMyrs+2gkFlcx7CHE1mEiEM+DcOcamyY34eZ0+Uio+/LLhGOU8Bsh+HO71Y0mEn+v/9qZ8VzS1h4qrOFW2gUzWYcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlVpdMqV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730242302; x=1761778302;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UEhu3GTXnnqTt9U9ea5ir6rPcrFzUbHg45E+tRVsrUc=;
  b=AlVpdMqVeeyvc2b/OvbM6HhM/822IzPX2AM4O5gVzlgmMBCANF6UKstE
   OfPKc9OR6t8UU00/0jx8muFp6Bitg2bSO7iHQBtSsVcwrtLS2S9wo3tcb
   SrMiNBJw6Z1r6i2UZhM33UCaAmeKPuJe0a4HztziBbRhoulzVuMyd4ioh
   jEUavNcwoBKf+uYke55eTxkZxyh/RuoRIJufYoVC5OYl+9YVMOTF5i0R6
   IzpM4WuGVVfRhSOPx2Vm9MZvT7IauqOMBp87TX0Tq2snzYZxRXaLMri4O
   CtglPdaOrBsUjU24BGuoZ/q0zu5Lf767UmkYHzJN1saJUm5vMLBCgC7em
   g==;
X-CSE-ConnectionGUID: VBqdXIczScSWDnzuyvpvQQ==
X-CSE-MsgGUID: OOTuBaOrQ72vk1KvnqJAtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30019110"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="30019110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:51:42 -0700
X-CSE-ConnectionGUID: lCwzaCxcROqX4hlHHizuxA==
X-CSE-MsgGUID: Nr47RsoZQxKmBjwF7RE3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="86060587"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.108.71]) ([10.125.108.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:51:40 -0700
Message-ID: <012f721d-9cff-43ba-8b94-f61c75d379df@intel.com>
Date: Tue, 29 Oct 2024 15:51:39 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "Weiny, Ira" <ira.weiny@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-5-dave.jiang@intel.com>
 <20241017173326.0000191a@Huawei.com>
 <SJ1PR11MB6083FB95773B782EA494C985FC472@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241017175942.000072b4@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017175942.000072b4@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:59 AM, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 16:46:35 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
>>> What does the I/O hole correspond to in the system?  
>>
>> PCIe mmio mapped space. 32-bit devices must have addresses below 4G
>> so X86 systems have a physical memory map that looks like:
>>
>> 0 - 2G: RAM
>> 2G-4G: MMIO
>> 4G-end of memory: RAM
>> end of memory-infinity: 64-bit MMIO
>>
>> Depending on how much MMIO there is different systems put the
>> dividing line at other addresses than 2G.
> 
> Ah, thanks. So this weird cache setup might be not quite linear
> module N aliases as described in the ACPI spec (System vs host
> physical addresses I guess).

Well, as long as the cache range does not overlap the MMIO hole. I'm not coming up with an elegant way to enumerate the MMIO hole and looking for ideas/suggestions on how to do it nicely. 

> 
> Had wrong mental model :(
> 
> Ouch.
> 
> 
>>
>> -Tony
>>
> 


