Return-Path: <linux-acpi+bounces-19639-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA6CC9358
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5193052B07
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1B1E32D6;
	Wed, 17 Dec 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC9ZWahp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEAFBF6;
	Wed, 17 Dec 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994493; cv=none; b=H9fGrsrR8jKHdtCG6stJQF23BvBzlDG+F6LgyMgnRhPEWIAHFJyCldM4rSt3xaMgKoZaHDqAoywXBWxGsX7T7cRgWnrif7LX1QAeycRHNreXypEdc7W6qZe1xKTWf8L6jHee1s/sIP15Hcdj1Q35ZuhtBWw4Em49dWI7AtLRYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994493; c=relaxed/simple;
	bh=ByYDIGFIc39NsBzbgJzyTH5j3VfbDcVXPAOd7CUkT0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIMZGapg+E/w0H6lba7CIaPW6VwPJbze4ZYN67dvo74ToRQxhRcvqx0LQjBtIVQ6LZO3Us4SDHU9OX4CshElswdUyA3wThJz3VzSSDyUTDL2Il3fE8kiOAbeoNZvNe5eyeLUY34zkNotcKua/gHfwsdSXRYtso48aaYtjg56SdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC9ZWahp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD644C4CEF5;
	Wed, 17 Dec 2025 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765994493;
	bh=ByYDIGFIc39NsBzbgJzyTH5j3VfbDcVXPAOd7CUkT0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HC9ZWahpbyFxJt41Rgk1xIgegCGDVhknCJZUaxh1Rq9bwdjGjxwOWzbAZewGg1mGX
	 Su7hS0L7PpM+ImlTu6hew8zPz679vb0CZB4dwy0y18iIXxsB1acxANZ6WPgnquf3nz
	 ar2t8gOBCvtKVnA2FQ+LLdBqSczCFTNFks3e/q4vdiR/5GNc30O3cNC1o8AHAfXZ3u
	 MqqhNDOd6d3YxNS899ewagwh0pWYa1p/1AduVKVrXcIHyjsumXRoW4i/N3TmmUTIHh
	 qD6u1sMkeBZzx0zt5FSDyvOApcbgLfpGReJ6ySRTWJHAJTJjprun7t8u7go6zkMeB2
	 PjtW7nNztnj2g==
Message-ID: <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
Date: Wed, 17 Dec 2025 12:01:32 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
To: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
 <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
 <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 10:57 AM, Francesco Lauritano wrote:
> On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano <francesco.lauritano1@protonmail.com> wrote:
> 
>> The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
>>
>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@21,AMDI0030:00@24
>>
>> This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()
> 
> Traced it further. HNC0(pin, 0) takes the Else branch and calls:
> ATKM(0xC0)
> ADTM(Zero)
> 
> ADTM calls NOD2(), which is the actual culprit:
> 
> While ((Arg0 != RDNT))
> {
>      If ((Local0 >= 0x0F)) { Break }
>      Notify (^^GPP0.PEGP, Arg0)
>      Local0++
>      Sleep (Local0 * 0x64)
> }
> 
> It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per iteration.
> Max 15 loops = ~12s per pin. GPU doesn't respond at boot so it maxes out.
> 
> Two pins, ~12s each, ~24-36s total.
> 
> Francesco

Any idea why isn't the dGPU responding?  I would have expected 
https://git.kernel.org/torvalds/c/4d4c10f763d78 sets up policy that it's 
in D0.

Is the dGPU turned off in BIOS or through some reverse engineered 
tool/API or something?

