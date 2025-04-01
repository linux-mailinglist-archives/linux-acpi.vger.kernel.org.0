Return-Path: <linux-acpi+bounces-12598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE481A77ED5
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330B816BED5
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A102054FF;
	Tue,  1 Apr 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6vZccWn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B363F381A3
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521051; cv=none; b=p7OkjVYSjYp2E+B28zzJnIzH6ypWOZwJVTOCZ/f1GmDHv5e82bJCinicU9PhodwcOEwLZap9gpNOA22+ErSZBUDioc1+12rJhu1oRy4EvdOJqI4/H55v5ODl6Zc6UFbhuxtccdz0Nfu2l9ax0ND3A5z/ChcDRBKZrqAjGs/11xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521051; c=relaxed/simple;
	bh=v97U7JZUx+dWXoWXmWQK5gynGHoB2IxRq/JLszuPdFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcYdWKXOkY1otrJgEbOrBiAmMOxj14z4q9hls2G++P4Zl/0iUF9Azew1ewg+LOwfOHhjxMwsTOwvVsYf5Qc3ABQwfeTPUgrDCnrMuVxbcupQv8OPo4wNSh7KPTFAlDoCvrZQRVL3b2mqsLQKpbY/6xzcP+iYwcU4R4bKSaaB0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6vZccWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73603C4CEE4;
	Tue,  1 Apr 2025 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521051;
	bh=v97U7JZUx+dWXoWXmWQK5gynGHoB2IxRq/JLszuPdFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6vZccWnP445Xcm4LiJmPcBD5QpRSBdVdVjvFPnU5jy+S9c36eBW8Mma0zgDc3zBT
	 UTJesAEd0piN4+hDzF9FiusypOa/gwXfv7wjV+2bO2w90JNyWlH/pGjx/RDCrSzsgW
	 wCPVDF+oApy02QfxTUzJCFAcVG1wDctwaqBed6nzy7sK4z361Hvg4VBiSAUTcaduoO
	 2BCcJogqT/9xiwy8n73vKa0tyL8mrLg9H+xy/v0C3HU7CZV4wHstSZRcTikwS0TFsN
	 5tAE2IhhvEOiPo0gefx8Q7X+NI3lY0HhMQq4AV8d0udiKZcviqli4cDDapnhx8xcux
	 e5D6nmj4Cho1g==
Message-ID: <dc2ae336-6a26-4e3e-a901-15afbe7fc611@kernel.org>
Date: Tue, 1 Apr 2025 10:24:09 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
 Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
 "derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
 <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
 <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/2025 10:03 AM, Antheas Kapenekakis wrote:
> On Tue, 1 Apr 2025 at 16:09, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 4/1/2025 7:45 AM, Antheas Kapenekakis wrote:
>>> On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>>>> Here are tags for linking to your patch development to be picked up.
>>>>>>
>>>>>> Link:
>>>>>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>>>>>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>
>>>>
>>>> I don't believe that b4 will pick these up, so I will send out a v2 with
>>>> them and mark this patch as superceded in patchwork so that Rafael
>>>> doesn't have to pull everything out of this thread manually.
>>
>> FTR I don't have permission on patchwork for linux-acpi.
>>
>> I sent out v2 though.
>>
>>>>
>>>>>
>>>>> And to avoid having this conversation again, there is another Legion
>>>>> Go S [3] patch you nacked and froze the testing for, so you could go
>>>>> on the manhunt for the real cause of this one. But it will probably be
>>>>> needed and you will find that as you get TDP controls going. So if you
>>>>> want me to prepare that in a timely manner, because that one actually
>>>>> needs rewriting to be posted, now is the time to say so.
>>>>
>>>> Can you please propose what you have in mind on the mailing lists to
>>>> discuss?  It's relatively expensive (in the unit of tech debt) to add
>>>> quirk infrastructure and so we need to make sure it is the right solution.
>>>>
>>>> Derek is working on CPU coefficient tuning in a completely separate
>>>> driver.  If there are issues with that, I would generally prefer the
>>>> fixes to be in that driver.
>>>
>>> CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I will
>>> try to make sure the quirk can be potentially added there, or in any
>>> driver*.
>>
>> Yes things like fPPT, sPPT, STAPM, STT limits.
>>
>>>
>>> The idea is to rewrite the patch series to just add a simple delay
>>> field on the s2idle quirk struct. Then the biggest delay wins and gets
>>> placed in ->begin. We have been using that series for ~6 months now,
>>> and it turns out that having a delay system for every call is quite
>>> pointless. But there are also situations where you might have a device
>>> such as the Z13 Folio which looks like a USB device but listens to
>>> s2idle notifications through ACPI, so the hid subsystem might need to
>>> be able to inject a small delay there.
>>
>> So the "general" problem with injecting delays is they are typically not
>> scalable as they're usually empirically measured and there is no
>> handshake with the firmware.
>>
>> Say for example the EC has some hardcoded value of 200ms to wait for
>> something.  IIRC the Linux timer infrastructure can be off by ~13%.  So
>> if you put 175ms it might work sometimes.  You get some reports of this,
>> so you extend it to 200ms.  Great it works 100% of the time because the
>> old hardcoded value in the EC was 200ms.
>>
>> Now say a new EC firmware comes out that for $REASONS changes it to
>> 250ms.  Your old empirically measured value stops working, spend a bunch
>> of cycles debugging it, measure the new one.  You change it to 250ms,
>> but people with the old one have a problem now because the timing changed.
>>
>> So now you have to add infrastructure to say what version of the
>> firmware gets what delay.
>>
>> Then you find out there is another SKU of that model which needs a
>> different delay, so your complexity has ballooned.
>>
>> What if all these "delays" were FW timeouts from failing to service an
>> interrupt?  Or what if they were a flow problem like the device expected
>> you to issue a STOP command before a RESET command?
>>
>> So we need to be /incredibly careful/ with delays and 100% they are the
>> right answer to a problem.
> 
> I do get your points. In this case though we sideskirt through a lot
> of the points because of where the delay is placed.
> 
> If the instrumentation is in-place, this delay happens before sleep
> after the screen of the device has turned off (due to early DPMS), the
> keyboard backlight has turned off (DIsplay off call), and the suspend
> light pulses (Sleep Entry). So it does not affect device behavior and
> you can be quite liberal. The user has left the device alone.
> 
> If the device needs e.g., 250ms you will not put 250ms, you will put
> 500ms. Still unsure, you bump it to 750ms. Also, even if the
> manufacturer comes up with a new firmware that fixes this issue, you
> can keep the delay for the life of the product, because keeping it
> does not affect device behavior, and writing kernel patches takes time.
> 
> This is how I think about it, at least. A universal delay might be
> needed eventually. But for now, limiting the scope to some devices and
> seeing how that goes should be enough.
> 
> Antheas

My take is that "universal" delays are never popular.  IE hardware that 
"previously" worked perfectly is now slower.  So if there /must/ be a 
delay it should be as narrow as possible and justified.

Let me give you an example of another case I'm *actively considering* a 
delay.

I have an OEM's system that if you enter and exit s0i3 too quickly you 
can trigger the over voltage protection (OVP) feature of the VR module.
When OVP is tripped the system is forced off immediately. This *only 
happens* on the VR module in that vendor's systems. "Normal" Linux 
userspace suspend/resume can't trip it.  But connecting a dock "does" 
trip it.

If you look on a scope you can see SLP_S3# pin is toggling faster than 
spec says it should.  Naïvely you would say well the easy solution is to 
add a delay somewhere so that SLP_S3# stays in spec.  I have a patch 
that does just that.

diff --git a/drivers/platform/x86/amd/pmc/pmc.c 
b/drivers/platform/x86/amd/pmc/pmc.c
index e6124498b195f..97387ddb281e1 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -724,10 +724,20 @@ static void amd_pmc_s2idle_check(void)
         struct smu_metrics table;
         int rc;

-       /* CZN: Ensure that future s0i3 entry attempts at least 10ms 
passed */
-       if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, 
&table) &&
-           table.s0i3_last_entry_status)
-               usleep_range(10000, 20000);
+       if (!get_metrics_table(pdev, &table) && 
table.s0i3_last_entry_status) {
+               switch (pdev->cpu_id) {
+               /* CZN: Ensure that future s0i3 entry attempts at least 
10ms passed */
+               case AMD_CPU_ID_CZN:
+                       usleep_range(10000, 20000);
+                       break;
+               /* PHX/HPT: Ensure enough time to avoid VR OVP */
+               case AMD_CPU_ID_PS:
+                       msleep(2500);
+                       break;
+               default:
+                       break;
+               }
+       }

This stops all the failures, but it also has an impact that any time the 
EC SCI is raised for any reason (like plug in power adapter) the system 
will take 2.5s to go back into s0i3.

Digging further - the intended behavior by the EC and BIOS was to wake 
the system when the dock is connected.

That is the reason this happens is because the EC SCI is raised when the 
dock is connected, but the Notify() the EC sent wasn't received by any 
driver.  I've got a patch I'll be sending out soon that adds support for 
the correct driver to wake up on this event.

This prevents the case of the OVP and now we don't *need* to penalize 
everyone to wait 2.5s after EC SCI events and going back to s0i3.  If I 
find out there are other ways to trip the problem I still have that 
option though.

