Return-Path: <linux-acpi+bounces-19663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A388ECCB67E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BA64301A713
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB1332EB6;
	Thu, 18 Dec 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8NCQRZ0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F793321A1;
	Thu, 18 Dec 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053999; cv=none; b=OThdphWmWBW1DvVrLqCBI5FNyJIZjpkO9ZGDbhYeNZQzjAWskwxtZjbaH4DXP2Mx2NwdJXN34SJz77Xwxk6KEKYu0H9wH8rcxlpt0qdS07WDkA7fw+H9PMlyxV/PHwFshEGE5EV+RRrgAiWGQ3lFem4Bb5uBALr2vjTQnFKYpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053999; c=relaxed/simple;
	bh=skIvvXN07qvYfaK6UHfMPbtyuznCiAiYd7zPINp94oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os5mIDIuDKhhjTEUSMOfov3722KFywPgd3WlAucJhqD4LaN0fxA/AeglFwC1FDezoyTmyDuQzOJRMkNs/T0MgCA8UCvpI3yQV9IDpxn8Istlzdz6w6b98HXwpFtUF57ZaBFMUYY5F5UXruidgdtYdClHnVKiBskxOvDCXRH0/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8NCQRZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D2EC116D0;
	Thu, 18 Dec 2025 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766053998;
	bh=skIvvXN07qvYfaK6UHfMPbtyuznCiAiYd7zPINp94oU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r8NCQRZ0lmcz3qsAg7BJ26MIYdk6j2BqV+lBp9AgjYepdp9M6kJMKXj6Acdnm5+Ds
	 dyOVe6ouY+GgSX3pICEhCS/OI5x2elvwzwIPtry1q6s2d7LbtwfAR9MsPlrXo8fsfV
	 C/KvlKQnPgrP7/5KIjzpgsHlMn4gGqPa3t4efRA+4/5nSRbuqlRCzBQy32+zFrUqc5
	 TSITbzi+vzT94KSjlMg/AEHHn/rM3AjSyf0DrlzcI3pbLRj2wwdMw86l40y4Lq3GUR
	 iXyD+31xbWb05mtZjt/EafamTaBekwJOMdYQxGJy1xwUGNoSa1MkoyGdFxrL65teVG
	 9UK0URaDm5+Rw==
Message-ID: <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
Date: Thu, 18 Dec 2025 11:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "westeri@kernel.org" <westeri@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
 <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
 <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
 <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
 <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>
 <20251218063954.GT2275908@black.igk.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251218063954.GT2275908@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Dec-25 07:39, Mika Westerberg wrote:
> On Wed, Dec 17, 2025 at 07:19:56PM +0000, Francesco Lauritano wrote:
>> On Wednesday, December 17th, 2025 at 7:01 PM, Mario Limonciello <superm1@kernel.org> wrote:
>>
>>> On 12/17/25 10:57 AM, Francesco Lauritano wrote:
>>>
>>>> On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano francesco.lauritano1@protonmail.com wrote:
>>>>
>>>>> The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
>>>>>
>>>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@21,AMDI0030:00@24
>>>>>
>>>>> This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()
>>>>
>>>> Traced it further. HNC0(pin, 0) takes the Else branch and calls:
>>>> ATKM(0xC0)
>>>> ADTM(Zero)
>>>>
>>>> ADTM calls NOD2(), which is the actual culprit:
>>>>
>>>> While ((Arg0 != RDNT))
>>>> {
>>>> If ((Local0 >= 0x0F)) { Break }
>>>> Notify (^^GPP0.PEGP, Arg0)
>>>> Local0++
>>>> Sleep (Local0 * 0x64)
>>>> }
>>>>
>>>> It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per iteration.
>>>> Max 15 loops = ~12s per pin. GPU doesn't respond at boot so it maxes out.
>>>>
>>>> Two pins, ~12s each, ~24-36s total.
>>>>
>>>> Francesco
>>>
>>>
>>> Any idea why isn't the dGPU responding? I would have expected
>>> https://git.kernel.org/torvalds/c/4d4c10f763d78 sets up policy that it's
>>> in D0.
>>>
>>> Is the dGPU turned off in BIOS or through some reverse engineered
>>> tool/API or something?
>>
>> dmesg without the workaround:
>> [    1.005184] pci 0000:01:00.0: PME# supported from D0 D3hot
>> [    1.288811] pci 0000:01:00.0: vgaarb: VGA device added
>> [   38.250139] nvidia: loading out-of-tree module taints kernel.
>> [   38.369358] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
>> [   39.744421] NVRM: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheInit
>>
>> GPU is in D0 from 1.0s. nvidia loads at 38.2s after the GPIO hang completes.
>>
>> No weird tools/APIs besides userspace utils (asusctl/supergfxctl). 
>>
>> No changes to BIOS factory defaults other than disabling Fast Boot.
>> dGPU is active, Display Mode is Dynamic (hybrid).
>>
>> Traced RDNT - it's set by GPS function 19 in the ACPI tables:
>> Case (0x13)
>> {
>>     Debug = "GPS fun 19"
>>     \_SB.PCI0.SBRG.RDNT = (Local1 + 0xD1)
>> }
>>
>> As far as I can understand GPIO initcall blocks at late_initcall_sync, preventing nvidia 
>> from loading in time to respond. Based on the timing, GPU is awake but nothing can 
>> register a handler while kernel is stuck at NOD2 polling loop.
> 
> I wonder if you could try with the nouveau driver so that it's built-in to
> the kernel proper? Then it should be ready at the time these events
> trigger.

That is not really a workable solution though.

I think either we need to DMI quirk the 2 models with this issue;

Or perhaps it is time to rethink the whole running of edge handlers
on boot thing.

Based on the existing DMI quirks, which fix some much more serious
breakage (breaking HDMI out port DCC, causing a USB-A port to not
get 5V out) I would say it is safe to say that Windows does not do
this.

As for the original reasons mentioned in the commit message
introducing this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca876c7483b6

The BYT tabled ID pin handling has been sowewhat controversial. Some
people actually liked that many BYT BIOSes leave the USB data pins in
host mode even when a charger is connected as this allows using
a USB-otg-charging HUB charging and being in host mode at the same time.

That just leaves the original LID handling on microsoft surface 3
tablets case as somewhat of a problem.

But we can just pick an initial LID state of LID not closed there,
booting up with the LID closed is unusual and if done, the user
likely does *not* want to suspend right away which would happen
when reporting the LID as closed.

I still have a Surface 3 and I can check if that is the default and
if not this could be fixed with a quirk in the ACPI LID handling code.

TL;DR: I think this is a case where we can fix things by ripping
out a whole bunch of code + quirks and stop running edge event
handlers on boot.

Regards,

Hans



