Return-Path: <linux-acpi+bounces-4094-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB3870BC6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 21:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970A2B23504
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F0DDCB;
	Mon,  4 Mar 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVurA7TP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CE6FB5
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585203; cv=none; b=a31NtNkQAxY8ymbrhgoUt2uZGnZF57SWt4tOw+auF3st4IKqEKcTZ5wV+F7UxjZz7zskoSC6MgBbUOM+qc84iI+elURaDMcIi4+nJi5mvCt2qQbXhbmpTTrQoTsYqzJSSMjQ/gk5sYz/293PzYm5lcnU+MgfQhN7KpI+WawwrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585203; c=relaxed/simple;
	bh=+B9GmLJ+L8G8IVVwPRnc/K1G0drsWHuXC4rCG6rPz/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjFZCXXnUakT382pCkFgoAePyLjGrMRJpRwTbc1NM3eIqp7oihrmDOwDQmD4dsXiBl/Q3UVAbRb+nLNPl3CAPpXVxsddd+sCi5NRVtS6WNMN/KIfGtclHsXZtQIjvS0FH0LDfNPnEJDbZYq5jSgi/FQwoU3k/nVAoNlQxVjDDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVurA7TP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709585202; x=1741121202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+B9GmLJ+L8G8IVVwPRnc/K1G0drsWHuXC4rCG6rPz/8=;
  b=VVurA7TPCvi3/pDkixTKr7HSHR9LFXs8Dj8BSnFWtq48db2HWF/6G1jm
   kvrCESF2kDkfrcQc0HBn5EE755QTvF3Jr/bpDGiVC6bKpXcTKeAe95hvM
   8toYsj1lDXeKW+j48C5VN/1reb0gjRVYdrAQhxXJntkMRiQPC689J/U6S
   7lAcj3igHnBpCPzMaryqU9/dAOwFciM6wLiazyOVQrhrA+qrC7XVJCOEp
   SOFGwgUlHPQWcSO68NYnKdbBWlEoP78WvKafvV52dYOggT+vgHQlY64zG
   alrn/9jmOJnPnAIkju9On7iXwPrrxt87dZHwUCHzFR2OrkuYwxTX4E/dz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3962225"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3962225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13782802"
Received: from cryoung-mobl2.amr.corp.intel.com (HELO [10.212.71.160]) ([10.212.71.160])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:46:41 -0800
Message-ID: <b10ddf2f-d6c4-41de-8e62-305f1d7e6e63@linux.intel.com>
Date: Mon, 4 Mar 2024 14:46:39 -0600
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
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <312ff9d7-8b90-428f-b90c-ebb278e029a7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/4/24 14:34, Cezary Rojewski wrote:
> On 2024-03-04 9:22 PM, Pierre-Louis Bossart wrote:
>> On 3/4/24 13:49, Andy Shevchenko wrote:
>>> On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
>>>>> +/* Values for link_type field above */
>>>>> +
>>>>> +#define ACPI_NHLT_LINKTYPE_HDA            0
>>>>> +#define ACPI_NHLT_LINKTYPE_DSP            1
>>>>> +#define ACPI_NHLT_LINKTYPE_PDM            2
>>>>> +#define ACPI_NHLT_LINKTYPE_SSP            3
>>>>> +#define ACPI_NHLT_LINKTYPE_SLIMBUS        4
>>>>> +#define ACPI_NHLT_LINKTYPE_SDW            5
>>>>> +#define ACPI_NHLT_LINKTYPE_UAOL            6
>>>>
>>>> More than half of those values are not used. Is there really any
>>>> benefit
>>>> in exposing them?
>>>
>>> Sometimes a code is the (only) documentation. Since it's a global
>>> header and
>>> part of ACPICA we probably better to expose all bits that are defined.
>>
>> NHLT is an Intel-only solution - no other company uses it.
>> Intel does not have any designs where SlimBus is productized.
>>
>> I fail to see the wisdom of exposing a non-existent option with
>> LINKTYPE_SLIMBUS. It's not because this case was listed in a document
>> that we have to add the information verbatim in a open-source header.
>>
>> Likewise for SoundWire we do NOT use NHLT at all...
>>
>> Options 4 and 5 are completely irrelevant. 0 and 1 most likely as well.
> 
> Hello,
> 
> How relevant or not given field is in LINKTYPE enumeration is..
> irrelevant. Those values are reserved since the dawn of the table.
> Renaming those with range of RESERVED_X(s) is hardly an alternative. On
> top of that, specs which have been publicly shared since 2016 _do_ list
> the non-I2S/PDW constants when describing LINKTYPE.

I maintain that all those values, while spec-defined, should be treated
as not supported. It's not unusual in engineering to change directions
and back-annotate, demote or cleanup initial designs. Change is the only
constant.

