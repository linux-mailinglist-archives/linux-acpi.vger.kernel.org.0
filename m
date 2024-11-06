Return-Path: <linux-acpi+bounces-9348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DB39BDE5B
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 06:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB41F222DB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 05:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F418FDDA;
	Wed,  6 Nov 2024 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icD4pqdq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0E2C80;
	Wed,  6 Nov 2024 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871967; cv=none; b=Vii/tvqy2Hd5sV5EnzrkxYZIQZP8+xaQ4wiHlPOCCugjh1cfF6mZzZ7Pe/L3jvYEIPVSl+EGfgljTaMUFlx2c9/4+fxShfbdXKMO+yucb5/Ac/gh7y+USWK75UfjMiVqZBvz9vCTVQdtxq3H3jmAlvbtNHfBItzk6wwAQ/NyLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871967; c=relaxed/simple;
	bh=KHaZm1BKPo5bIXvGUMESWUYC59KIwDNI0k37DvMlpVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8p7PiTh4kkQXg0rLCCUxjEsEFb5x57Y0a7kooJs2+ZNopSGqWy9YL+R3eFQyKpgIa5tO4uAGb7U6qnNR0dKcaWNn58O6hYjdnk40xYYHhVuUJyJIxEgocDdvNZPGzwK4fePNdVNuqhnXVJI72T2ptX+Q1575FxbS+Y4HOHyZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icD4pqdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324EAC4CECD;
	Wed,  6 Nov 2024 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730871967;
	bh=KHaZm1BKPo5bIXvGUMESWUYC59KIwDNI0k37DvMlpVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=icD4pqdqQbBRzIIcf6NeBCcFIAJSVFiN9TeJxVABG7BURPDCOmZAAPgvIJamzvRtn
	 CGZXA7R79dq1crymNi3cWzswnCh09gVwyPjwfXph1OGTXIaPb0ECVHMnImw7NCqBry
	 MYfGKtiu/w7sQKRH7Je/1IyoHKFxx5XDzTlQYFGFEnWGL1bU3RjYfY4EgOZBHfxT+i
	 7YMfvxB6frG+9OIU8qSEFhE68LFWpavf502hL2zLYAU4RqZMTzQFo+q8KwR85Fb6ot
	 Hn1OrHPPBCl3U7dImAxF8Z0urkoh7q1OI8HBt5yYbhMozB4wKUNavUBrul+P7jGeq7
	 h22INCnYiPRtw==
Message-ID: <a40ef9a8-0589-4070-921e-f3461fa6759c@kernel.org>
Date: Tue, 5 Nov 2024 23:46:02 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/20] ACPI: platform_profile: Add profile attribute
 for class interface
To: Armin Wolf <W_Armin@gmx.de>, Mario Limonciello
 <mario.limonciello@amd.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-13-mario.limonciello@amd.com>
 <dad36f32-5970-48c2-9ee1-78163958bf02@gmx.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <dad36f32-5970-48c2-9ee1-78163958bf02@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/5/24 22:10, Armin Wolf wrote:
> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
> 
>> Reading and writing the `profile` sysfs file will use the callbacks for
>> the platform profile handler to read or set the given profile.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 118 ++++++++++++++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index e1b6569c4ee70..79083d0bb22e3 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -65,6 +65,78 @@ static int _get_class_choices(struct device *dev, 
>> unsigned long *choices)
>>       return 0;
>>   }
>>
>> +/**
>> + * _store_class_profile - Set the profile for a class device
>> + * @dev: The class device
>> + * @data: The profile to set
>> + */
>> +static int _store_class_profile(struct device *dev, void *data)
>> +{
>> +    enum platform_profile_option profile;
>> +    unsigned long choices;
>> +    int *i = (int *)data;
>> +    int err;
>> +
>> +    err = _get_class_choices(dev, &choices);
>> +    if (err)
>> +        return err;
>> +
>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +        struct platform_profile_handler *handler;
>> +
>> +        if (!test_bit(*i, &choices))
>> +            return -EOPNOTSUPP;
>> +
>> +        handler = dev_get_drvdata(dev);
>> +        err = handler->profile_get(handler, &profile);
>> +        if (err)
>> +            return err;
>> +
>> +        err = handler->profile_set(handler, *i);
>> +        if (err) {
>> +            int recover_err;
>> +
>> +            dev_err(dev, "Failed to set profile: %d\n", err);
>> +            recover_err = handler->profile_set(handler, profile);
>> +            if (recover_err)
>> +                dev_err(dev, "Failed to reset profile: %d\n", 
>> recover_err);
>> +        }
> 
> The whole recovery handling seems unnecessary to me. In setting the 
> platform profile fails, then
> we should just return an error. The platform profile handler will tell 
> us the current platform
> profile anyway.

Sure, makes sense.  That also means no need to capture the profile 
before setting it.

> 
>> +        sysfs_notify(&handler->class_dev->kobj, NULL, 
>> "platform_profile");
>> +        kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
> 
> Please avoid sending those events when the platform profile is changed 
> through the class sysfs interface.
> 
>> +    }
>> +
>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
> Please avoid sending this event when the platform profile is changed 
> through the legacy sysfs interface.

In both above cases - why?

* If I change using class interface then that implicitly means that 
legacy interface changes.
* If I change using legacy interface that implicitly means class 
interface changes too.

> 
>> +    return err ? err : 0;
>> +}
>> +
>> +/**
>> + * get_class_profile - Show the current profile for a class device
>> + * @dev: The class device
>> + * @profile: The profile to return
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int get_class_profile(struct device *dev,
>> +                 enum platform_profile_option *profile)
>> +{
>> +    struct platform_profile_handler *handler;
>> +    enum platform_profile_option val;
>> +    int err;
>> +
>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +        handler = dev_get_drvdata(dev);
>> +        err = handler->profile_get(handler, &val);
>> +        if (err) {
>> +            pr_err("Failed to get profile for handler %s\n", handler- 
>> >name);
>> +            return err;
>> +        }
>> +    }
>> +
>> +    if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
>> +        return -EINVAL;
>> +    *profile = val;
>> +
>> +    return 0;
>> +}
>>
>>   /**
>>    * name_show - Show the name of the profile handler
>> @@ -102,12 +174,58 @@ static ssize_t choices_show(struct device *dev,
>>       return _commmon_choices_show(choices, buf);
>>   }
>>
>> +/**
>> + * profile_show - Show the current profile for a class device
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t profile_show(struct device *dev,
>> +                struct device_attribute *attr,
>> +                char *buf)
>> +{
>> +    enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> +    int err;
>> +
>> +    err = get_class_profile(dev, &profile);
>> +    if (err)
>> +        return err;
>> +
>> +    return sysfs_emit(buf, "%s\n", profile_names[profile]);
>> +}
>> +
>> +/**
>> + * profile_store - Set the profile for a class device
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to read from
>> + * @count: The number of bytes to read
>> + * Return: The number of bytes read
>> + */
>> +static ssize_t profile_store(struct device *dev,
>> +                 struct device_attribute *attr,
>> +                 const char *buf, size_t count)
>> +{
>> +    int i, ret;
>> +
>> +    i = sysfs_match_string(profile_names, buf);
>> +    if (i < 0)
>> +        return -EINVAL;
>> +
>> +    ret = _store_class_profile(dev, (void *)(long)&i);
> 
> Please just pass &i.

Ack.

> 
> Thanks,
> Armin Wolf
> 
>> +
>> +    return ret ? ret : count;
>> +}
>>
>>   static DEVICE_ATTR_RO(name);
>>   static DEVICE_ATTR_RO(choices);
>> +static DEVICE_ATTR_RW(profile);
>> +
>>   static struct attribute *profile_attrs[] = {
>>       &dev_attr_name.attr,
>>       &dev_attr_choices.attr,
>> +    &dev_attr_profile.attr,
>>       NULL
>>   };
>>   ATTRIBUTE_GROUPS(profile);
> 


