Return-Path: <linux-acpi+bounces-4142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A05873C49
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 17:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C538EB22ABF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745A137931;
	Wed,  6 Mar 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbX843BV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AE8004B
	for <linux-acpi@vger.kernel.org>; Wed,  6 Mar 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742620; cv=none; b=FrDFTGeIieFUHBbCZ0filXiIkEuDNzuFCaXveyYY2c2QMTIpxDTl0ICs8qd1/OkYDNUHZHRLQZR4z/bTglxInl0KlTYkqAJ8lA1x2yY5yg26/tpFQhsnEbJ3xKVcpFE0xdXzev7hHtt4jpUEId51gBjWMNzDXAJYvWfooYrcLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742620; c=relaxed/simple;
	bh=ZX+x8Loog5/ZauzAzuqgUjmagbLEgPQfhcH7oa7WCyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwRQdnqaY0yZEpffsmxOWFqVRWBZmr8ySUligF/hbbytW4wHcSYAcTfyCxDB3XV9A7QLORkLpv78m1FBoGwPIhpmm/glfXMtwygAf27etYfw2UAcMi9lWlFYcNLdJGhv2QqVwxOSnS0QLjrtUXTL4SOSLSjXjhd16yS49hx7TcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbX843BV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709742619; x=1741278619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZX+x8Loog5/ZauzAzuqgUjmagbLEgPQfhcH7oa7WCyE=;
  b=fbX843BV4l1mNd8sundoDXpfMTX8LfVNa2p6bdLBA4T/a2r1DNxl+Z3K
   YoHjGifqg9DA1gWebd2paFQlMcjfpduFCzuk97d6/S7EyHGNWEtJ+k0Yl
   3S7CwP1ElPylDKzxdAwPK8YUMQjI6+6Q+VXmJERMVT4Iz7Hydil3nPTLT
   YlMgK1kKXFEM8+9B9FMiG8E+NUFbOb0sEXuxNpf6dBy+i1g14xqld3YKR
   B4CraFp3GtLCzoREzzQyP0KzoAKRRb9bfnplTpjDoUpSzwyNHGIck8ZbT
   5GcVMO9BBpaPaOZb4e5/34uKx7nIYsMrfyycvMGLmEs6Q5YMJyyE39hF5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4251363"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4251363"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9673743"
Received: from pmatthew-mobl2.amr.corp.intel.com (HELO [10.213.169.105]) ([10.213.169.105])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:30:17 -0800
Message-ID: <f6edf0bc-5b8e-49df-afd6-fab19d253d97@linux.intel.com>
Date: Wed, 6 Mar 2024 10:30:16 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists
 of
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com,
 amadeuszx.slawinski@linux.intel.com
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
 <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
 <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
 <17d55fd0-8884-4f05-99f7-abccdda0e174@linux.intel.com>
 <312ff9d7-8b90-428f-b90c-ebb278e029a7@intel.com>
 <b10ddf2f-d6c4-41de-8e62-305f1d7e6e63@linux.intel.com>
 <5b615397-2c9e-44cb-8f2f-6f763f0643e9@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <5b615397-2c9e-44cb-8f2f-6f763f0643e9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/24 10:17, Cezary Rojewski wrote:
> On 2024-03-04 9:46 PM, Pierre-Louis Bossart wrote:
>> On 3/4/24 14:34, Cezary Rojewski wrote:
>>> On 2024-03-04 9:22 PM, Pierre-Louis Bossart wrote:
>>>> On 3/4/24 13:49, Andy Shevchenko wrote:
>>>>> On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
>>>>>>> +/* Values for link_type field above */
>>>>>>> +
>>>>>>> +#define ACPI_NHLT_LINKTYPE_HDA            0
>>>>>>> +#define ACPI_NHLT_LINKTYPE_DSP            1
>>>>>>> +#define ACPI_NHLT_LINKTYPE_PDM            2
>>>>>>> +#define ACPI_NHLT_LINKTYPE_SSP            3
>>>>>>> +#define ACPI_NHLT_LINKTYPE_SLIMBUS        4
>>>>>>> +#define ACPI_NHLT_LINKTYPE_SDW            5
>>>>>>> +#define ACPI_NHLT_LINKTYPE_UAOL            6
>>>>>>
>>>>>> More than half of those values are not used. Is there really any
>>>>>> benefit
>>>>>> in exposing them?
>>>>>
>>>>> Sometimes a code is the (only) documentation. Since it's a global
>>>>> header and
>>>>> part of ACPICA we probably better to expose all bits that are defined.
>>>>
>>>> NHLT is an Intel-only solution - no other company uses it.
>>>> Intel does not have any designs where SlimBus is productized.
>>>>
>>>> I fail to see the wisdom of exposing a non-existent option with
>>>> LINKTYPE_SLIMBUS. It's not because this case was listed in a document
>>>> that we have to add the information verbatim in a open-source header.
>>>>
>>>> Likewise for SoundWire we do NOT use NHLT at all...
>>>>
>>>> Options 4 and 5 are completely irrelevant. 0 and 1 most likely as well.
>>>
>>> Hello,
>>>
>>> How relevant or not given field is in LINKTYPE enumeration is..
>>> irrelevant. Those values are reserved since the dawn of the table.
>>> Renaming those with range of RESERVED_X(s) is hardly an alternative. On
>>> top of that, specs which have been publicly shared since 2016 _do_ list
>>> the non-I2S/PDW constants when describing LINKTYPE.
>>
>> I maintain that all those values, while spec-defined, should be treated
>> as not supported. It's not unusual in engineering to change directions
>> and back-annotate, demote or cleanup initial designs. Change is the only
>> constant.
> 
> What's the proposal here? Would comment suffice or there is something
> else you have in mind?

I would be fine with a comment along the lines of 'defined in spec, not
used' and 'used on all SKL+ platforms'.

