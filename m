Return-Path: <linux-acpi+bounces-11783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644FA4E22F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC12422846
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EBA2777F7;
	Tue,  4 Mar 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drKhzlwP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B8B209F53;
	Tue,  4 Mar 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099928; cv=none; b=DTqeG5H9Ta4YEgH8i2U9aKJP+vB6nDJXGtvYy9bSTqL3H9/ZXvfjcKJZGWMAgvgXWR6vpxPNimBN3bipBte/9kZcwki9JJSf5NdbRQhisTLwG1Fo8RRyYW0HFa7mvQ22U63Vg3ddnioVtQAOImyfUZXKfJOCT3uMNxpftuLkNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099928; c=relaxed/simple;
	bh=wUIJePIEYKEjS6xScJ7j8+ufyhJV9OMKv4x0b5wHua8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHkWiqsSW8s+CaltpSliknZA2CcreMW01qnEj9/mSgjHJn0Y5FJJlQNDxUSbSwV6eU5QjE/Bz7HjvUh8YEuoS95Ib3ufegGc59RWYyGCN+Ic+YTyihVbCOycoLPA4gFy1AVV2lJgUYWilB5Zl9O1zNUTctqqg/i3pcZuGPdyISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drKhzlwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E9EC4CEE5;
	Tue,  4 Mar 2025 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099927;
	bh=wUIJePIEYKEjS6xScJ7j8+ufyhJV9OMKv4x0b5wHua8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drKhzlwPU77aiADK2igVvLWJ2+UfwWnj45R2AX3yW5YP+2TFaGRBf0CGMX2AFOH+D
	 nSlh8d3QlX/ZvKd5YXgCoFRWSAfgVPejIitTkAv/3z3X519rBdMV5S+P3WQQeIkWsq
	 as6ry7LO6Lvc57G2vhLs2Zn6C9HhCZMtkkHsavKR0Qbpned+wL2cd+Ht5BovcW5BcA
	 74b8e2FOWd8nPnh0hk14o/u0DvtUGXwOoRtMqhPZKROFaAxvHiAZmITl2vL4iwoumL
	 jtbOk9BgUl6n/Nblf6sK4hU0VIg4XSjwcPE9Og2uJM0V74IZSy9uMoCdw3Qc+mEhZK
	 WGM5iJtc01ulA==
Message-ID: <71b14dc3-77e1-4fd7-b576-821e3a41ba19@kernel.org>
Date: Tue, 4 Mar 2025 08:52:06 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson
 <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304064745.1073770-1-superm1@kernel.org>
 <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
 <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
 <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/2025 08:08, Rafael J. Wysocki wrote:
> On Tue, Mar 4, 2025 at 1:49 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 3/4/25 02:38, Antheas Kapenekakis wrote:
>>> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> When two drivers don't support all the same profiles the legacy interface
>>>> only exports the common profiles.
>>>>
>>>> This causes problems for cases where one driver uses low-power but another
>>>> uses quiet because the result is that neither is exported to sysfs.
>>>>
>>>> If one platform profile handler supports quiet and the other
>>>> supports low power treat them as the same for the purpose of
>>>> the sysfs interface.
>>>>
>>>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
>>>>    1 file changed, 35 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>>> index 2ad53cc6aae53..d9a7cc5891734 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
>>>>
>>>>           lockdep_assert_held(&profile_lock);
>>>>           handler = to_pprof_handler(dev);
>>>> -       if (!test_bit(*bit, handler->choices))
>>>> -               return -EOPNOTSUPP;
>>>> +       if (!test_bit(*bit, handler->choices)) {
>>>> +               switch (*bit) {
>>>> +               case PLATFORM_PROFILE_QUIET:
>>>> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
>>>> +                       break;
>>>> +               case PLATFORM_PROFILE_LOW_POWER:
>>>> +                       *bit = PLATFORM_PROFILE_QUIET;
>>>> +                       break;
>>>> +               default:
>>>> +                       return -EOPNOTSUPP;
>>>> +               }
>>>> +               if (!test_bit(*bit, handler->choices))
>>>> +                       return -EOPNOTSUPP;
>>>> +       }
>>>>
>>>>           return handler->ops->profile_set(dev, *bit);
>>>>    }
>>>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
>>>>           handler = to_pprof_handler(dev);
>>>>           if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>>>>                   bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
>>>> -       else
>>>> +       else {
>>>> +               /* treat quiet and low power the same for aggregation purposes */
>>>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
>>>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
>>>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>>>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
>>>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
>>>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
>>>>                   bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
>>>> +       }
>>>
>>> So you end up showing both? If that's the case, isn't it equivalent to
>>> just make amd-pmf show both quiet and low-power?
>>>
>>> I guess it is not ideal for framework devices. But if asus devices end
>>> up showing both, then it should be ok for framework devices to show
>>> both.
>>>
>>> I like the behavior of the V1 personally.
>>
>> No; this doesn't cause it to show both.  It only causes one to show up.
> 
> Which may not be the one that was shown before IIUC and that's not good.
> 
> What actually is the problem with the previous version?

Functionally?  Nothing.  This was to demonstrate the other way to do it 
that I preferred and get feedback on it as an alternative.

If you and Ilpo are happy with v1 that's totally fine and we can go with 
that.

