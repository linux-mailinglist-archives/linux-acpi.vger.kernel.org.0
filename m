Return-Path: <linux-acpi+bounces-10309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7C9FCAF6
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B0E1882FF0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Dec 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362E31D4605;
	Thu, 26 Dec 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="fdjEFYpx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C01D416B;
	Thu, 26 Dec 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735216160; cv=none; b=pD6xGMmF6aF6CGvb/ELET7GEclxnCE0OPtA1bUf1/Qn222pnnp+JqQu3CvxFkJsuVeRWn1XbIIj2OKG9ASDPbRXrpq5bvumgrxhzwKeNURUgGu7HgQK3m5ydcyxXSE1CtE5flLqiyfVKpC5wW7ZA+XcIHtiq6BNkOgB93/L3PfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735216160; c=relaxed/simple;
	bh=HgPTb3LOTRkHnpcTm/hPvSnOhZx/f+9kcrrTOI1ni20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W563rdwQrupH07sp44Y6O0g2Rx1YMEeMZZORd53FXgkazRKCUk0SWb3qyC8j8C7U3CIKhdJnG/SP5LLnvrWLWRa22X8fzZ+qvh1L1Zd6IxjbrakHT1DhMJItyQWo/94esIhWgPBtN+dWT5WvpQwwQabTUt3eZe5IiXvRfuAJcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=fdjEFYpx; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1735216155;
	bh=HgPTb3LOTRkHnpcTm/hPvSnOhZx/f+9kcrrTOI1ni20=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fdjEFYpxCIe6/bpy3Wr6m2faS/mi5snJ2rWO8nUJulcEch5K5TBCYRJ0g5vmhMS7U
	 AxN/KMVKuQ6KBQtpxyqoktOac4CUN3gx/OXqejYtBVF9PGBPbwpFqvk/4ooANeunOn
	 6YDgJYb+WXFJlDVdmQ7s9+5ameh7DhfpJymHeo43ihHdSNck/qSdv7yKBZeqNYCFDE
	 t2UKveihHIBEdzKBqKhYLbzuR5UXTHJZy1BTkgCtWLirT44T5MEYrzsALA4Ba7pQ1+
	 S1zdEGer9BVVHr2ffWlpgEjI+nMFDDU5bhc94Wjn5EtdLCsh4Qq+2DPDkHXGaAwvfM
	 aU3IWk5arDd9w==
Received: from [192.168.2.10] (58-32-133-N4.customer.vsm.sh [170.133.32.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 8C772206CD;
	Thu, 26 Dec 2024 13:29:15 +0100 (CET)
Message-ID: <319c2913-78fa-4b35-828e-7d4d1d691a93@math.uni-bielefeld.de>
Date: Thu, 26 Dec 2024 13:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
Content-Language: en-US
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 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
 JRHWPGCL3BhOxQ==
In-Reply-To: <Z2yw_eJwR5ih1Npr@debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/26/24 02:27, Chris Bainbridge wrote:

> On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
>> Hi Chris!
>>
>> On 12/26/24 00:09, Chris Bainbridge wrote:
>>
>>> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
>>> available for eDP") added function dm_helpers_probe_acpi_edid, which
>>> fetches the EDID from the BIOS by calling acpi_video_get_edid.
>>> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
>>> not originate from kmalloc - it is actually the internal "pointer" field
>>> from an acpi_buffer struct (which did come from kmalloc).
>>> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
>>> resulting in memory corruption which leads to random, intermittent
>>> crashes (e.g. 4% of boots will fail with some Oops).
>>>
>>> Fix this by allocating a new array (which can be safely freed) for the
>>> EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
>> Hmm, maybe I'm missing something here. But shouldn't it suffice to just
>> remove the kfree call in dm_helpers_probe_acpi_edid()?
> Yes, that would work to fix the bad kfree, but there would be a small
> memory leak of the acpi_buffer struct. It's not a huge problem since
> this code is rarely run, and the Nouveau code has never tried to free
> the edid buffer and apparently nobody noticed, but it would be better to
> do the correct thing.

OK, thanks for explaining. I didn't immediately understand that 
something was leaking memory. Only that we were freeing something that 
we are not supposed to free.

> One other curiosity is this comment in the code that allocates the
> memory:
>
> case ACPI_ALLOCATE_BUFFER:
> 	/*
> 	 * Allocate a new buffer. We directectly call acpi_os_allocate here to
> 	 * purposefully bypass the (optionally enabled) internal allocation
> 	 * tracking mechanism since we only want to track internal
> 	 * allocations. Note: The caller should use acpi_os_free to free this
> 	 * buffer created via ACPI_ALLOCATE_BUFFER.
> 	 */
>
> Which makes me wonder if all the calls to kfree on acpi_buffer structs
> with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
> acpi_os_free instead? I used kfree just for consistency with the
> existing code.

Wouldn't it make more sense to do the memdup handling in 
acpi_video_device_EDID()? This way you have both alloc and free in the 
same function. But I'm no expert when it comes to the ACPI kernel code. 
Just my two cents :-D

With best wishes,
Tobias


