Return-Path: <linux-acpi+bounces-12585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D9A77B02
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622E916C246
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA006202F90;
	Tue,  1 Apr 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXh/ZBf8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582A20127A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510596; cv=none; b=ZhqXkRN2zdbYQNh10nyQ6PAtPYuEfRt9o0PYyUwddtIc55rq64kJcaooR0WKj72usWM4WDMygGEnf2jZHtXL9Hgk5ay6ufqOQit3Dt+Fqo1mBkTZelaYYGtd6zNtbBY29vgLI87Of4xepflsfo1LLbmnyjQymnAubs4r5ZAO+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510596; c=relaxed/simple;
	bh=NqGvZLGR7lS4enl2T3f7s9J1GTTonTpa8qiKliSr1hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBuJJAu40ik7BxXyzexWEscXpmFaCh4n8KH3EYEmWcD6tkXC4O9WC5FLScAbIhbG/gCAx6wNlhuuCHI+UqOboOY6tvtRWLr09LPhrqcTkwzYgXXeAez9/VPk9J/55wV2vZB5uwbD2D2oOhdkoTbBiCd956OAbyJiyqMuROI83fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXh/ZBf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B97C4CEE4;
	Tue,  1 Apr 2025 12:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743510595;
	bh=NqGvZLGR7lS4enl2T3f7s9J1GTTonTpa8qiKliSr1hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nXh/ZBf88BwLp2lx25XxSskF5v5WYGDgVTOtAec0tGhHMsQxleMVr61XQhJJ19s3B
	 YFUWpRCW+pO/LaKdhURXpHQT1llaxVzCJoYdEjWhMGxsKRby1j89gpWD5kOddFtoMZ
	 I6niShh3EUXlp1EzvcYX0ivqbCUH2h6O9VgNtZr3XjawV7fYvZKeYi1djDOQSUQDyx
	 XpHnSryJGN/apqxx5reMNwO0nLvihhJVytH6Vv6M79P1HEytK/FMVqr66eZXLWcUJN
	 exSTQc0qZiSTzkOZIkFArL8F2gljbX2m4RowMOgvfWEKz40uEBB7g/K9nUPARyyyJy
	 L+8SNMpr6OOJQ==
Message-ID: <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
Date: Tue, 1 Apr 2025 07:29:51 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Here are tags for linking to your patch development to be picked up.
>>
>> Link:
>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> 

I don't believe that b4 will pick these up, so I will send out a v2 with 
them and mark this patch as superceded in patchwork so that Rafael 
doesn't have to pull everything out of this thread manually.

> 
> And to avoid having this conversation again, there is another Legion
> Go S [3] patch you nacked and froze the testing for, so you could go
> on the manhunt for the real cause of this one. But it will probably be
> needed and you will find that as you get TDP controls going. So if you
> want me to prepare that in a timely manner, because that one actually
> needs rewriting to be posted, now is the time to say so.

Can you please propose what you have in mind on the mailing lists to 
discuss?  It's relatively expensive (in the unit of tech debt) to add 
quirk infrastructure and so we need to make sure it is the right solution.

Derek is working on CPU coefficient tuning in a completely separate 
driver.  If there are issues with that, I would generally prefer the 
fixes to be in that driver.

> 
> Antheas
> 
> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> [2] https://gitlab.com/evlaV/linux-integration/-/commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
> 
>>> Not that I am content with it, which you might have noticed with my
>>> absence in the amd/drm issue tracker.
>>>
>>> So, was it the touchscreen after all? Did you verify this by tweaking
>>> its firmware?
>>
>> Yes it's the touchscreen causing this issue.  It was confirmed by a
>> hardware rework.
>>
>>>
>>> Antheas
>>>
>>> [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
>>>
>>>
>>>> Thanks,
>>>>
>>>>>>
>>>>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
>>>>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>> ---
>>>>>>>     drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 28 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>>>>> index 8db09d81918fb..3c5f34892734e 100644
>>>>>>> --- a/drivers/acpi/ec.c
>>>>>>> +++ b/drivers/acpi/ec.c
>>>>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>>>>>>                            DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>>>>>>                    },
>>>>>>>            },
>>>>>>> +       /*
>>>>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
>>>>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>>>>>> +        */
>>>>>>> +       {
>>>>>>> +               .matches = {
>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
>>>>>>> +               }
>>>>>>> +       },
>>>>>>> +       {
>>>>>>> +               .matches = {
>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
>>>>>>> +               }
>>>>>>> +       },
>>>>>>> +       {
>>>>>>> +               .matches = {
>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
>>>>>>> +               }
>>>>>>> +       },
>>>>>>> +       {
>>>>>>> +               .matches = {
>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>>>>>>> +               }
>>>>>>> +       },
>>>>>>>            { },
>>>>>>>     };
>>>>>>>
>>>>>>> --
>>>>>>> 2.43.0
>>>>>>>
>>>>
>>


