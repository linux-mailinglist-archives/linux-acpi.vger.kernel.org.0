Return-Path: <linux-acpi+bounces-4092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D9870B76
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 21:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF4A1C222BA
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B07A159;
	Mon,  4 Mar 2024 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCUqywOH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC967A15C
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583752; cv=none; b=cevlDy0AIOyhL4YPBe3Dtks6Us2Bz3NPz+UxKMOF7C34xwoLtAoT11jJoJp6vNnhVKF85xEQ4Lcw/hz2cvf0E9XGe41gh5BuQSBldO+YMqNiwspWchbOfMHLdwov1ieSlowOPUm2W/GwA/WzrT/MPXFXnFkTmpDDdhGSZUI55eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583752; c=relaxed/simple;
	bh=XoWdSfFKz/brUzs0tEbdMrwLGNpMq/FqK5ZIuUMx3mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH2q+p0Uh89rG+HuSp9264Ls76BmV+hDo01zfBqmEB9G8ePJOmFNeyYFvGIzDGmhjQOfjJHjZiyqcEq/2vpghtZmxTqoVh5WGJ3qZ+JtytWbu4ToOfdEdeEOCCIshdxgi9VS8davEJp3G5sV/3UiY0S/6qvYnYl3T3mi+NoCv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCUqywOH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709583751; x=1741119751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XoWdSfFKz/brUzs0tEbdMrwLGNpMq/FqK5ZIuUMx3mY=;
  b=kCUqywOH+an2kHD6djrcrHVWqmEYhy9dhfZuicdLdV/z599HFDcMNC6/
   CoDUA5ucyWfKrsru4v8kq4bRuyuocln/lY+FQurERyQvPkvX41qIGYNgq
   5ZQLxgnNj6vYqmXgi1BMrRXc0sWZoBWRlFRvZ/fLblIplHxUi/bDaPGQ0
   bEJ+RM8USvLCkazqY0b6SDgoQjdiZUOS8JVpoi6Wc3KkVH0r0vfD/WWvp
   EviGJ4J4WkkBvbDei6lSOyOVEKZf4G3UsmxEMXlamkM5v1wQJN9ZWzDMX
   K0BlGZD/IGAlaPyN3GM8NjRKRR4ucyFR25NR7Mv8UDazGhujuVFv4RPCg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15245589"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="15245589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13685214"
Received: from cryoung-mobl2.amr.corp.intel.com (HELO [10.212.71.160]) ([10.212.71.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:22:29 -0800
Message-ID: <17d55fd0-8884-4f05-99f7-abccdda0e174@linux.intel.com>
Date: Mon, 4 Mar 2024 14:22:28 -0600
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, rafael@kernel.org,
 linux-acpi@vger.kernel.org, robert.moore@intel.com,
 amadeuszx.slawinski@linux.intel.com
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
 <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
 <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/24 13:49, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
>>> +/* Values for link_type field above */
>>> +
>>> +#define ACPI_NHLT_LINKTYPE_HDA			0
>>> +#define ACPI_NHLT_LINKTYPE_DSP			1
>>> +#define ACPI_NHLT_LINKTYPE_PDM			2
>>> +#define ACPI_NHLT_LINKTYPE_SSP			3
>>> +#define ACPI_NHLT_LINKTYPE_SLIMBUS		4
>>> +#define ACPI_NHLT_LINKTYPE_SDW			5
>>> +#define ACPI_NHLT_LINKTYPE_UAOL			6
>>
>> More than half of those values are not used. Is there really any benefit
>> in exposing them?
> 
> Sometimes a code is the (only) documentation. Since it's a global header and
> part of ACPICA we probably better to expose all bits that are defined.

NHLT is an Intel-only solution - no other company uses it.
Intel does not have any designs where SlimBus is productized.

I fail to see the wisdom of exposing a non-existent option with
LINKTYPE_SLIMBUS. It's not because this case was listed in a document
that we have to add the information verbatim in a open-source header.

Likewise for SoundWire we do NOT use NHLT at all...

Options 4 and 5 are completely irrelevant. 0 and 1 most likely as well.

