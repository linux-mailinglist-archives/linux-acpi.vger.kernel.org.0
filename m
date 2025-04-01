Return-Path: <linux-acpi+bounces-12578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D60A772CB
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D68188C41C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2476171E43;
	Tue,  1 Apr 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ6m9y4K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89E59B71
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475207; cv=none; b=BdVksBm+IIxfTzppFlAnQpUtb7uDZsY8u68Dzk33cmWThOs/Z54JmGDJ3LvQ55tHG7Fg44mkMUgcvyCHEMa43+RoDQVZILzlVTkE2SpsAbk0ZMed/i/n4unX5NZfgelKe7F0L02BN9CGp7gCPlFZckf0UITWzFXwBnX8KSrk0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475207; c=relaxed/simple;
	bh=2/iVLWxPsNXbr+FpWUkZ+jvfMexCT9KLWfb8I9XeNVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHkLUYFae4xaFgZGwHDxnmz7BAblztLqnHhX8IsF97SKBrviGMUC0GmxO7Et/iCqgBnuJgNZn9u2ddRP/etOQthIZp299t5mPUPQuJwAcLAHAKWu5RCJVOtlC5QgfR9ym4zkrGZEkGQQsS1OjEU1AkY//TiwLQxQkjfaeAjtPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ6m9y4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82469C4CEE3;
	Tue,  1 Apr 2025 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743475206;
	bh=2/iVLWxPsNXbr+FpWUkZ+jvfMexCT9KLWfb8I9XeNVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PJ6m9y4K/Dx7FtbjJ5x/J4p2QIBQeIzZy/Y5iBov5OrH9ycilPcrYiyk/iKCCA7F7
	 urnoj5xBHRgVo5AvJnt3ZQ1r2d9Ae8ZXWQCtxiyaphhn9Qyi0ET+wGGhTsrlVIQcnp
	 Di/imaPtUFqMXdsd6vosgH2JcjtAEEaKRsdWoa6CMFdt5ZxgXqb2QgVbATft0ti7Fj
	 VS2kqMPHH7tPbAAaSbtTEgoxlLZj70idYyMFCVrOKCvnvnlOMAK0Vw/AIlqa4lFrAb
	 UxRUZv282CPLTOvuA5CPLGQF6n+2Lqv0UmLaeqGBKi9JoDY11pPVngmq/hg2Z0jL/J
	 /B0ahuRi/ncvA==
Message-ID: <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
Date: Mon, 31 Mar 2025 21:40:04 -0500
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
 Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/2025 4:16 PM, Antheas Kapenekakis wrote:
> On Mon, 31 Mar 2025 at 22:55, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 3/31/2025 3:53 PM, Antheas Kapenekakis wrote:
>>> On Mon, 31 Mar 2025 at 22:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>
>>>> On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
>>>>>
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> When AC adapter is unplugged or plugged in EC wakes from
>>>>> HW sleep but APU doesn't enter back into HW sleep.
>>>>>
>>>>> The reason this hapens is that when APU exits HW sleep the power
>>>>> rails the EC controls will power up the TCON.  The TCON has a
>>>>> GPIO that will be toggled during this time.  The GPIO is not marked
>>>>> as a wakeup source however GPIO controller still has an unserviced
>>>>> interrupt and it will block entering HW sleep again. Clearing the
>>>>> GPIO doesn't help, the TCON raises it again until it's been initialized
>>>>> by i2c-hid.
>>>>>
>>>>> Fixing this would require TCON F/W changes and it's already broken
>>>>> in the wild on production hardware.
>>>>>
>>>>> To avoid triggering this issue add a quirk to avoid letting EC wake
>>>>> up system at all.  The power button still works properly on this system.
>>>>
>>>> Hi Mario,
>>>> I reported this issue to you early in January, did all the debugging
>>>> for it, found the cause, made this patch, tested it, and finally
>>>> deployed it as well. Then sent it to Xino.
>>>>
>>>> Then you pushed back for perfectly valid reasons, and we had a
>>>> multi-week long back and forth trying to find the proper cause for
>>>> this.
>>>>
>>>> So from my side I do not get why I am just a reported-by here. This is
>>>> my patch. We also had a discussion about this out of band.
>>>>
>>>> Antheas
>>>
>>> It is interesting you ended up finding the cause. Which makes
>>> attributing this a bit murkier.
>>>
>>> Antheas
>>
>> Hi Antheas,
>>
>> FWIW - you and I separately created very similar patches.
> 
> There is only one way to write a no_ec_wakeup patch after I reported
> to you that it fixes it, here [1] mine is the same, even the DMI order
> is the same.

You mean the same order as my patch for GoS that applied to acp-6x?

commit b9a8ea185f3f8 ("ASoC: acp: Support microphone from Lenovo Go S")

> 
>> There has been more debugging that is not public (as you can see from
>> the content of this commit message).
>>
>> What tag would you like in this case?
> 
> I think co-developed-by since you also worked very hard on fixing
> this. I do not know if b4 picks up co-developed tags.
> 

Here are tags for linking to your patch development to be picked up.

Link: 
https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

> Not that I am content with it, which you might have noticed with my
> absence in the amd/drm issue tracker.
> 
> So, was it the touchscreen after all? Did you verify this by tweaking
> its firmware?

Yes it's the touchscreen causing this issue.  It was confirmed by a 
hardware rework.

> 
> Antheas
> 
> [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> 
> 
>> Thanks,
>>
>>>>
>>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
>>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>    drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>>>>>    1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>>> index 8db09d81918fb..3c5f34892734e 100644
>>>>> --- a/drivers/acpi/ec.c
>>>>> +++ b/drivers/acpi/ec.c
>>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>>>>                           DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>>>>                   },
>>>>>           },
>>>>> +       /*
>>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
>>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>> +        */
>>>>> +       {
>>>>> +               .matches = {
>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
>>>>> +               }
>>>>> +       },
>>>>> +       {
>>>>> +               .matches = {
>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
>>>>> +               }
>>>>> +       },
>>>>> +       {
>>>>> +               .matches = {
>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
>>>>> +               }
>>>>> +       },
>>>>> +       {
>>>>> +               .matches = {
>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>>>>> +               }
>>>>> +       },
>>>>>           { },
>>>>>    };
>>>>>
>>>>> --
>>>>> 2.43.0
>>>>>
>>


