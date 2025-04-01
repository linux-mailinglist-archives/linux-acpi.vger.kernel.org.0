Return-Path: <linux-acpi+bounces-12591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE23A77D41
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4CA3AD0AF
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E7204596;
	Tue,  1 Apr 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGm/WBvu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A42036F0
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516547; cv=none; b=SyJGRg8Qm9G7/FUqVbYA8oyodaNymTN8LwuOQtb/6NkJYg3drx6++kYiwECfK4zBarkvfT36dt/Xrup6j4AtKpvaxCFWb3gYLFOWVIFZ5J6HXOJw5mCFkCZdtkVbe/W5ig60JxELO2NEa3/E4SU7mAx4sJAC8a+SS4b2HObUOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516547; c=relaxed/simple;
	bh=BsqWDgL56yVFcjwlgXPms1pHAjm/UTNQif4hE90dF5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+z7+DFOLsOYdraETowdATpBLejOl1SJQ7AJTco74vA8nfWxDrDu3mUhc+j9ykiwEbBiqVckaHMGwotOmPBPBovDocBQXZu5ku5DU4DgiBPhce4r+oTAB4hykRyfH+iworBdF0l+Ec4ynwgo3FHvv3gPqyYJQYGcxkCgZRCfRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGm/WBvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A376CC4CEE4;
	Tue,  1 Apr 2025 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743516545;
	bh=BsqWDgL56yVFcjwlgXPms1pHAjm/UTNQif4hE90dF5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HGm/WBvujQRxz6xvvsezp687I3KfSLH10UGB06kUye345/PrbJ9p56GLn9Wu0J07v
	 9O2JExu8c7x2nKnZ7P1LahY+PTYI5OD9//iegvKyJJqY/z1e5ppkSDs9Rxa4ae50JF
	 ljn6mtlpvhEhnLFz0AZQM+EFtijEFmGe5QexuggNdQyEmOsNm4ZBDDWihu2dfO21Ne
	 ZA90+HV3rZufmUylWHhPkmVPO/ZlT3n34bjOKavzJNaCg2zY5In0M+/YsrSqZW5+1E
	 IrHN2j8Vb0mu/EiB20tpm2FfAkRBBvMlz51SdI6tKkhOjhVk8oYt7YklCUU08yvUjO
	 BgUV1xa7LrzaA==
Message-ID: <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
Date: Tue, 1 Apr 2025 09:09:03 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/2025 7:45 AM, Antheas Kapenekakis wrote:
> On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org> wrote:
>>
>>>> Here are tags for linking to your patch development to be picked up.
>>>>
>>>> Link:
>>>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>>>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>
>>
>> I don't believe that b4 will pick these up, so I will send out a v2 with
>> them and mark this patch as superceded in patchwork so that Rafael
>> doesn't have to pull everything out of this thread manually.

FTR I don't have permission on patchwork for linux-acpi.

I sent out v2 though.

>>
>>>
>>> And to avoid having this conversation again, there is another Legion
>>> Go S [3] patch you nacked and froze the testing for, so you could go
>>> on the manhunt for the real cause of this one. But it will probably be
>>> needed and you will find that as you get TDP controls going. So if you
>>> want me to prepare that in a timely manner, because that one actually
>>> needs rewriting to be posted, now is the time to say so.
>>
>> Can you please propose what you have in mind on the mailing lists to
>> discuss?  It's relatively expensive (in the unit of tech debt) to add
>> quirk infrastructure and so we need to make sure it is the right solution.
>>
>> Derek is working on CPU coefficient tuning in a completely separate
>> driver.  If there are issues with that, I would generally prefer the
>> fixes to be in that driver.
> 
> CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I will
> try to make sure the quirk can be potentially added there, or in any
> driver*.

Yes things like fPPT, sPPT, STAPM, STT limits.

> 
> The idea is to rewrite the patch series to just add a simple delay
> field on the s2idle quirk struct. Then the biggest delay wins and gets
> placed in ->begin. We have been using that series for ~6 months now,
> and it turns out that having a delay system for every call is quite
> pointless. But there are also situations where you might have a device
> such as the Z13 Folio which looks like a USB device but listens to
> s2idle notifications through ACPI, so the hid subsystem might need to
> be able to inject a small delay there.

So the "general" problem with injecting delays is they are typically not 
scalable as they're usually empirically measured and there is no 
handshake with the firmware.

Say for example the EC has some hardcoded value of 200ms to wait for 
something.  IIRC the Linux timer infrastructure can be off by ~13%.  So 
if you put 175ms it might work sometimes.  You get some reports of this, 
so you extend it to 200ms.  Great it works 100% of the time because the 
old hardcoded value in the EC was 200ms.

Now say a new EC firmware comes out that for $REASONS changes it to 
250ms.  Your old empirically measured value stops working, spend a bunch 
of cycles debugging it, measure the new one.  You change it to 250ms, 
but people with the old one have a problem now because the timing changed.

So now you have to add infrastructure to say what version of the 
firmware gets what delay.

Then you find out there is another SKU of that model which needs a 
different delay, so your complexity has ballooned.

What if all these "delays" were FW timeouts from failing to service an 
interrupt?  Or what if they were a flow problem like the device expected 
you to issue a STOP command before a RESET command?

So we need to be /incredibly careful/ with delays and 100% they are the 
right answer to a problem.

> 
> But rewriting the series will take 1-2 weeks, so I need a heads up now
> if you need it for the Go S launch.
> 
> Specifically for the Z13 folio, since I brought that up, it seems like
> all Aura devices including the Ally need a 300ms delay to fade their
> backlights after sleep entry but before D3, but my testing has been
> mixed here because KDE plays with the backlight while i test the
> hid-asus series.
> 
> *for general device stability such as in the Go S, I'd have a slight
> preference for a non-platform quirk though.
> 
> Antheas
> 
>>>
>>> Antheas
>>>
>>> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
>>> [2] https://gitlab.com/evlaV/linux-integration/-/commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
>>> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
>>>
>>>>> Not that I am content with it, which you might have noticed with my
>>>>> absence in the amd/drm issue tracker.
>>>>>
>>>>> So, was it the touchscreen after all? Did you verify this by tweaking
>>>>> its firmware?
>>>>
>>>> Yes it's the touchscreen causing this issue.  It was confirmed by a
>>>> hardware rework.
>>>>
>>>>>
>>>>> Antheas
>>>>>
>>>>> [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>>
>>>>>>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
>>>>>>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>>>>>>>>>      1 file changed, 28 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>>>>>>> index 8db09d81918fb..3c5f34892734e 100644
>>>>>>>>> --- a/drivers/acpi/ec.c
>>>>>>>>> +++ b/drivers/acpi/ec.c
>>>>>>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>>>>>>>>                             DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>>>>>>>>                     },
>>>>>>>>>             },
>>>>>>>>> +       /*
>>>>>>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
>>>>>>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>>>>>> +        */
>>>>>>>>> +       {
>>>>>>>>> +               .matches = {
>>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
>>>>>>>>> +               }
>>>>>>>>> +       },
>>>>>>>>> +       {
>>>>>>>>> +               .matches = {
>>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
>>>>>>>>> +               }
>>>>>>>>> +       },
>>>>>>>>> +       {
>>>>>>>>> +               .matches = {
>>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
>>>>>>>>> +               }
>>>>>>>>> +       },
>>>>>>>>> +       {
>>>>>>>>> +               .matches = {
>>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>>>>>>>>> +               }
>>>>>>>>> +       },
>>>>>>>>>             { },
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> 2.43.0
>>>>>>>>>
>>>>>>
>>>>
>>


