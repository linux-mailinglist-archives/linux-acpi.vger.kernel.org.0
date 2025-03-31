Return-Path: <linux-acpi+bounces-12574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4CA76FB3
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 22:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B3F3A4EA7
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 20:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695D21A955;
	Mon, 31 Mar 2025 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R921NsFH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D81E0E0B
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454508; cv=none; b=FFAbJDHxsYt92Iy6ibBiq6GVZP1hkm7RaQwewde5tlRaLSpZmCKhcqYO/VbYqslxniWFfiGFmcwuOe8xnYNMzWRMMHae9h+bid2SZXKEDIbjGDMIKcneKwbSu0y/lUhPQHXru6+BpwRM4VBCHzxWea5KBxRsZsqCn6H0XJY9Wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454508; c=relaxed/simple;
	bh=9rFvU1LE7UenV/ALzrgvy6TTGIseFS3Uf7sBp2erTWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA/klBvJCVuN8SureLiH5bUiILKJxMkyamLnm8DPj1pw95I18gQS3O3PShu8Cz4fy9XfBDilX2N1Sd11W4ep2aX/aZ6vhPqZLSvDmE9l7qycg/4LtpADn61Lez4yvu6FaNid+yheWyQHVC5Z9w7WF+u4JEMX+AHojXZY6YZOvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R921NsFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2943C4CEE3;
	Mon, 31 Mar 2025 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454506;
	bh=9rFvU1LE7UenV/ALzrgvy6TTGIseFS3Uf7sBp2erTWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R921NsFHCEvE8xivuysbT/k1XYMAaLoOybWg+kizR+UmdKvxUXgNxsZ6kcwMCw9yM
	 BmdY+YdUuK1+OJveUE6s61sHm8GRHjiEsiHv5FLcXawxQk0w7X4YUR76EQ3s8xtAFW
	 7ftf2VZ8IQWPuADKRzqEXN2Tnov/epT4i9JE96KE5sp3TFxb9XnwOZuuF37mIuSpcL
	 JUGhqAockRQjGGxObAxUvQV/ktU1Nd3Y5Ul5DzCcp/qvq/wwnwKdCf9NCcLPjdFGyA
	 tS8sxRlOy+3ibG4D+LlwrrRo1fLmLul4Mw+6OR4dnWm0ubKxxTkQFLlANXV0fRjr+K
	 XegIsT91lgnag==
Message-ID: <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
Date: Mon, 31 Mar 2025 15:55:05 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/2025 3:53 PM, Antheas Kapenekakis wrote:
> On Mon, 31 Mar 2025 at 22:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
>>>
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> When AC adapter is unplugged or plugged in EC wakes from
>>> HW sleep but APU doesn't enter back into HW sleep.
>>>
>>> The reason this hapens is that when APU exits HW sleep the power
>>> rails the EC controls will power up the TCON.  The TCON has a
>>> GPIO that will be toggled during this time.  The GPIO is not marked
>>> as a wakeup source however GPIO controller still has an unserviced
>>> interrupt and it will block entering HW sleep again. Clearing the
>>> GPIO doesn't help, the TCON raises it again until it's been initialized
>>> by i2c-hid.
>>>
>>> Fixing this would require TCON F/W changes and it's already broken
>>> in the wild on production hardware.
>>>
>>> To avoid triggering this issue add a quirk to avoid letting EC wake
>>> up system at all.  The power button still works properly on this system.
>>
>> Hi Mario,
>> I reported this issue to you early in January, did all the debugging
>> for it, found the cause, made this patch, tested it, and finally
>> deployed it as well. Then sent it to Xino.
>>
>> Then you pushed back for perfectly valid reasons, and we had a
>> multi-week long back and forth trying to find the proper cause for
>> this.
>>
>> So from my side I do not get why I am just a reported-by here. This is
>> my patch. We also had a discussion about this out of band.
>>
>> Antheas
> 
> It is interesting you ended up finding the cause. Which makes
> attributing this a bit murkier.
> 
> Antheas

Hi Antheas,

FWIW - you and I separately created very similar patches.

There has been more debugging that is not public (as you can see from 
the content of this commit message).

What tag would you like in this case?

Thanks,

>>
>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>> index 8db09d81918fb..3c5f34892734e 100644
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>>                          DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>>                  },
>>>          },
>>> +       /*
>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
>>> +        */
>>> +       {
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
>>> +               }
>>> +       },
>>> +       {
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
>>> +               }
>>> +       },
>>> +       {
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
>>> +               }
>>> +       },
>>> +       {
>>> +               .matches = {
>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
>>> +               }
>>> +       },
>>>          { },
>>>   };
>>>
>>> --
>>> 2.43.0
>>>


