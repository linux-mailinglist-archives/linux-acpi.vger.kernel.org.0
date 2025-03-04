Return-Path: <linux-acpi+bounces-11764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA29A4DE48
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FB63B0A91
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881E20408C;
	Tue,  4 Mar 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAJj4ufg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D620371A;
	Tue,  4 Mar 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092544; cv=none; b=HGsdGbYu7w1/Q+KDTtk3jQWprySZJHV4K/LtalV0gLKgawGcldIJZQjy2Y8ytewo/CHOJDYJUlrgyTtojxOHjguPdvti0pb8g+OJcE+drxVILmXeuMYiBtsqte0o4yB3XWnFFzNrF8qd6TPoYNZc4CNZNzgPSsw+F56JebkncHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092544; c=relaxed/simple;
	bh=0FZFdC1tRdwLVtrDbtDFNISFcCK7ikk1PXNFfS1nJDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itfW+fz3B9aJtC2cVKKlriVIbtxrfPy6WskmppAzbczRK9jWAQEuGNz2X2jGkesS2Y+KSm+DnZA51YRvZAI05KsSanxDuov76lwZwC1/miwdo+QahcVQRhGL9Jd6anQHVD9XMDFNMco55DTgFrghD8VGTS1yyF97xqkG2Byn/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAJj4ufg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0CC4CEE5;
	Tue,  4 Mar 2025 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092543;
	bh=0FZFdC1tRdwLVtrDbtDFNISFcCK7ikk1PXNFfS1nJDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAJj4ufgzSzxtIpa4ko/ukacAix4o+ZMrI5LWbYxWTskM5pJjJZ9DQEd8+S8fUPYK
	 /IiLm28nt1Bj8TJeWNIDHWVfo4CNRmjRF3kfLK5tNI/KEi2yLbvMtx264zRYQipkYz
	 7vF+sleT7+uGP6WBj3vcIAKFfg7tY7dy5voiH+wqaOt1J/W+bE5MS5CGub8vfji6Ce
	 L1/okvWZ8EmNrzbKCKlzP4h8SpbY7VneT+2fbOkzxgzC4fmWyDnCuKOUA8+6cya1q1
	 V/rrJheHMkOwp1X+YkNzu3wchDPiB46nrhljv0AAlKm0tKmG5+DL7Vkmr7DrA1ywhJ
	 k7Pcbil7VSjNQ==
Message-ID: <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
Date: Tue, 4 Mar 2025 06:49:00 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250304064745.1073770-1-superm1@kernel.org>
 <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/25 02:38, Antheas Kapenekakis wrote:
> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When two drivers don't support all the same profiles the legacy interface
>> only exports the common profiles.
>>
>> This causes problems for cases where one driver uses low-power but another
>> uses quiet because the result is that neither is exported to sysfs.
>>
>> If one platform profile handler supports quiet and the other
>> supports low power treat them as the same for the purpose of
>> the sysfs interface.
>>
>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
>>   1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 2ad53cc6aae53..d9a7cc5891734 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
>>
>>          lockdep_assert_held(&profile_lock);
>>          handler = to_pprof_handler(dev);
>> -       if (!test_bit(*bit, handler->choices))
>> -               return -EOPNOTSUPP;
>> +       if (!test_bit(*bit, handler->choices)) {
>> +               switch (*bit) {
>> +               case PLATFORM_PROFILE_QUIET:
>> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
>> +                       break;
>> +               case PLATFORM_PROFILE_LOW_POWER:
>> +                       *bit = PLATFORM_PROFILE_QUIET;
>> +                       break;
>> +               default:
>> +                       return -EOPNOTSUPP;
>> +               }
>> +               if (!test_bit(*bit, handler->choices))
>> +                       return -EOPNOTSUPP;
>> +       }
>>
>>          return handler->ops->profile_set(dev, *bit);
>>   }
>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
>>          handler = to_pprof_handler(dev);
>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
>> -       else
>> +       else {
>> +               /* treat quiet and low power the same for aggregation purposes */
>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
>>                  bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
>> +       }
> 
> So you end up showing both? If that's the case, isn't it equivalent to
> just make amd-pmf show both quiet and low-power?
> 
> I guess it is not ideal for framework devices. But if asus devices end
> up showing both, then it should be ok for framework devices to show
> both.
> 
> I like the behavior of the V1 personally.

No; this doesn't cause it to show both.  It only causes one to show up. 
I confirmed it with a contrived situation on my laptop that forced 
multiple profile handlers that supported a mix.


# cat /sys/firmware/acpi/platform_profile*
low-power
low-power balanced performance

# cat /sys/class/platform-profile/platform-profile-*/profile
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
quiet
low-power

> 
>>          return 0;
>>   }
>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
>>          if (err)
>>                  return err;
>>
>> +       /* treat low-power and quiet as the same */
>> +       if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
>> +            val == PLATFORM_PROFILE_QUIET) ||
>> +           (*profile == PLATFORM_PROFILE_QUIET &&
>> +            val == PLATFORM_PROFILE_LOW_POWER))
>> +               *profile = val;
>> +
>>          if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
>>                  *profile = PLATFORM_PROFILE_CUSTOM;
>>          else
>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>>                  dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
>>                  return ERR_PTR(-EINVAL);
>>          }
>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
>> +               dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
>> +               return ERR_PTR(-EINVAL);
>> +       }
> 
> Can you avoid failing here? It caused a lot of issues in the past (the
> WMI driver bails). a dev_err should be enough. Since you do not fail
> maybe it can be increased to dev_crit.
> 
> There is at least one driver that implements both currently, and a fix
> would have to precede this patch.

Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?

> 
>>
>>          guard(mutex)(&profile_lock);
>>
>> --
>> 2.43.0
>>


