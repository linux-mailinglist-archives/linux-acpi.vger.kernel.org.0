Return-Path: <linux-acpi+bounces-14662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F208EAE911D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 00:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C35A17ED
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA02F94B1;
	Wed, 25 Jun 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dN5O3BaP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EF214A9B;
	Wed, 25 Jun 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890658; cv=none; b=nbvBXbW/8Wl3icAXXgFI1QdltlshAolw4nGX+TYJCIfDmsnq2RD1A/KzExgwoJ4rb9duyZ6kQTt1rUuNrDNlohhDc73Dr7JJqSg5vCu+dbUaXDV8MAT/8BFQX9a5Slc8r+/vzhrWNJU40QEIQP9ZCf2DS0rB4xFodCvJMJ5iGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890658; c=relaxed/simple;
	bh=es2pAC8UJ6aAZOOo64AymW+sUCvL5KpwNeTvHXR6GyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etl8jC676z/6+BYBzAYFYdez+KXZvUtK/z6bz9zgGlDAIAnsHGSLvBBgrIK93gdUVEoZRd0WTJmuNEMH2Nd2MUMDE6ORjQKoaZvaeb62iVwqTO29ZEXhTcKLWfBQVa1SdFepSDt1zjkfq4Y9jXlFEteOsmojRx6WySrAKPRvCyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dN5O3BaP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750890657; x=1782426657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=es2pAC8UJ6aAZOOo64AymW+sUCvL5KpwNeTvHXR6GyQ=;
  b=dN5O3BaPwcolxkWW8YDYhWql6hkRrRO7aqmt3uVSUDb850GbuLOODRWY
   NzA9FEq5T0QiZklqMqMDUhn01i8QRZAREuDqzN7UPVD7eF2kjKv09+S1Z
   P1w/7qcLE6J/LWHmQdRVoT9ptKKAxKUWBRo78GB/jgVj1h6xMuEGhvq0G
   rcApgyThDa6VQmxDmskRU6osdFzpXeoJqcsl/WI4ASS3pnFLv/JGN89Js
   hE9qajLu0gNj4f9DGd3USs21PB6MISzdqQI/jHV2invC0v3lPE0VrXn20
   5X4FF0bhzAhNkIPCD+Z4hvtN1rW0Bw/T2cPFriDvcEBu33+44zhYrQM4c
   w==;
X-CSE-ConnectionGUID: oXxDcL1fSza7Cj4yxjo9Jw==
X-CSE-MsgGUID: udCOUSlRQmuR3WvkI/dICA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="63773812"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="63773812"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:30:56 -0700
X-CSE-ConnectionGUID: FVV2R/ABSsWS5xlvDo6ZMw==
X-CSE-MsgGUID: S21WJEC/SjiWb3gJmRXOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="151955300"
Received: from tmukhopa-mobl.amr.corp.intel.com (HELO [10.125.98.185]) ([10.125.98.185])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:30:56 -0700
Message-ID: <daa7eb83-7413-4b6e-a241-84d306db0d43@linux.intel.com>
Date: Wed, 25 Jun 2025 15:30:47 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
To: Dan Carpenter <dan.carpenter@linaro.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, Benjamin.Cheatham@amd.com,
 Jonathan.Cameron@huawei.com, dakr@kernel.org, dan.j.williams@intel.com,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org,
 sudeep.holla@arm.com, Kees Cook <kees@kernel.org>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-25 08:20, Dan Carpenter wrote:
> On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
>> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> Great writeup, but as Miguel says, this isn't needed at all, the kernel
>>> relies on the compiler to be sane :)
>>
>> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
>> e.g. I see a similar case with discussion at:
>>
>>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
>>
>> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
>> Move a variable assignment behind a null pointer check").
> 
> Putting the declarations at the top was always just a style preference.

No, "const" and variable scopes are not just "style", please do a
bit of research. For instance...

> Putting declarations at the top causes issues for __cleanup magic and...

https://stackoverflow.com/questions/368385/implementing-raii-in-pure-c
https://en.wikipedia.org/wiki/Resource_acquisition_is_initialization#Compiler_%22cleanup%22_extensions

Not just "style" either:
- Automagically avoiding exploits like TUN https://lwn.net/Articles/342330/
- The unusual flag -fno-delete-null-pointer-checks and incompatibility
  with other analyzers and compilers
- All the complex compiler discussions around those.

Declaration-after-statement was an important (and obviously: optional)
C99 feature that let C catch up with every other language. Forbidding it
just for "style" would be a serious misunderstanding of that feature. I
don't know any yet but there has to be some more important reason(s)
than "style".

From https://lore.kernel.org/lkml/4d54e4f6-0d98-4b42-9bea-169f3b8772bb@sabinyo.mountain/
> Btw, this is testing dereferences where the kernel code is doing pointer math.

Compiler optimizations may or may not care about that difference.  It
seems gcc and clang both do care... for now (and even if that changes
then I guess -fno-delete-null-pointer-checks would still be enough)

