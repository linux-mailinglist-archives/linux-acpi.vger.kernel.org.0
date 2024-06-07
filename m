Return-Path: <linux-acpi+bounces-6273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6C900D08
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 22:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B921F260AE
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C5155314;
	Fri,  7 Jun 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK69SKU3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F81143864;
	Fri,  7 Jun 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792391; cv=none; b=Wd7VPJHAHNEYb76OXF3ZNDBUZLYzVysNsb4I8LZyjrpf76YjN5j2alqY4L5q0kuKBD1ud/pRCbATSunj4Dhwkyw3AdkG3aBqE8muLfzLTDrT+KvJKujAORqmqrQk0dW+/GKG+sD5aNPMAkc0kTdhO4wZ04DE4L2N9bHMoGtPF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792391; c=relaxed/simple;
	bh=Fnt6K3uNOuwdkEaQGPZrVRbO15Hft9pX9EtzPGoc/w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwXcQ3B5j50pGOakTSaAHH0m9oXf/1B63LwgwrGatyY3YeQY3djfE72LCSr167fIpO84QxTySKNetEca9kW3NTdFxeFMyu2/j2f2gU42hDG0dYnAWb1TwBSCefIp/Zhf3LM6rpl7v1vshFqVehy5r4B/6glInSGOU8cW1+W6Nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK69SKU3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717792390; x=1749328390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fnt6K3uNOuwdkEaQGPZrVRbO15Hft9pX9EtzPGoc/w4=;
  b=JK69SKU37cNN284rVEGVQPQuzN1ttUuHK8IsbywIszaFaapqv8icu6dV
   dxsY24VNH0Ndu3wHxCzEo98tplZr2vMMUobIoC3wfzS8Nveqs3CmKYH3Y
   KCyhbJayjtrZ9jn4lNHWZZLAoEDIk1A2OiEUGUtMO6jAUZTqgJA6oCkQ0
   PkQQ4kXgarFYx8EWf99gbvHoVzjG/YYXKvyq0OkhC1VLfQgSEXktdXZv9
   Djuit+MPFnxsS9gwVWegZ5aPEZZQU/3ek12bfjW//8/UtMJSnTjqId0j2
   +UENz6lf/gcC9XMRtrufVlkk2bUlCqvOX63Ud5ZsfRlq95lceemPZ0mnQ
   w==;
X-CSE-ConnectionGUID: zvCVbCfdQNKPyZInCw+RJA==
X-CSE-MsgGUID: 8OEYPdGASPi5FGbud0KC+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14330795"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14330795"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 13:33:06 -0700
X-CSE-ConnectionGUID: k8Y8d7iASWKQGzFmPu82mA==
X-CSE-MsgGUID: GfukGivKSW+dJV/+ru+DeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="42990284"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.75]) ([10.245.246.75])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 13:33:02 -0700
Message-ID: <998d53cf-c22b-4706-93af-ab38802dc531@linux.intel.com>
Date: Fri, 7 Jun 2024 22:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: utils: introduce acpi_get_local_u64_address()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 broonie@kernel.org, vkoul@kernel.org, andriy.shevchenko@linux.intel.com,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Len Brown <lenb@kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
 <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/7/24 20:51, Rafael J. Wysocki wrote:
> On Tue, May 28, 2024 at 9:29 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> The ACPI _ADR is a 64-bit value. We changed the definitions in commit
>> ca6f998cf9a2 ("ACPI: bus: change _ADR representation to 64 bits") but
>> some helpers still assume the value is a 32-bit value.
>>
>> This patch adds a new helper to extract the full 64-bits. The existing
>> 32-bit helper is kept for backwards-compatibility and cases where the
>> _ADR is known to fit in a 32-bit value.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> Do you want me to apply this or do you want me to route it along with
> the rest of the series?
> 
> In the latter case feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks Rafael. I think it's easier if Mark Brown takes the series in
ASoC, I have additional ASoC patches that use the u64 helper.

Mark?


>>
>> +int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
>> +{
>> +       acpi_status status;
>> +
>> +       status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, addr);
>> +       if (ACPI_FAILURE(status))
>> +               return -ENODATA;
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(acpi_get_local_u64_address);
> 
> I'd prefer EXPORT_SYMBOL_GPL() here unless you absolutely cannot live with it.

I don't mind, but the existing helper was using EXPORT_SYMBOL so I just
copied. It'd be odd to have two helpers that only differ by the argument
size use a different EXPORT_ macro, no? Not to mention that the
get_local address uses EXPORT_SYMBOL but would become a wrapper for an
EXPORT_SYMBOL_GPL. That gives me a headache...


This was the original code:

int acpi_get_local_address(acpi_handle handle, u32 *addr)
{
	unsigned long long adr;
	acpi_status status;

	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
	if (ACPI_FAILURE(status))
		return -ENODATA;

	*addr = (u32)adr;
	return 0;
}
EXPORT_SYMBOL(acpi_get_local_address);


