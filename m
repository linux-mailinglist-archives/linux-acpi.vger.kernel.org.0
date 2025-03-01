Return-Path: <linux-acpi+bounces-11662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A4AA4A840
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 04:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7D6177910
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 03:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A51AC88B;
	Sat,  1 Mar 2025 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/IDfKql"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CB1CD15;
	Sat,  1 Mar 2025 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740799165; cv=none; b=JGZTqFT5zDD2vCC6ont+/gOWeMyw75vxmbRx1rAqGhlwfMCE0P+KL4OmzfUYU8CdhfdKseC0PIe8IZ++NDVSNrcU6rPxQoXKgxJE2IvRPzuhMH2OackMKjMZ5wUajkl4OGNaXDQGX5BQBXhtby3VN70iVrL7vgGZKIjkBLfVMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740799165; c=relaxed/simple;
	bh=lXFbo+xebaWaz7QOpw2/VTgRUhFSs4wztLMasViZqZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCdrk40R19YcELbG/hUUFMdkjzK9HYCA3QLP8O5SDAM4EWKSsaxPaW6XNy+Bt24a1/A08BET1AsjGcb9tY9CNUrjscs73Dfx7+4aSzdeMMQnxws0BOpO1c/saTeD1f3ywlx+Q/xuE+zhx4sQW9sXsoBM+qS6UVzb5EChR42Xr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/IDfKql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3183C4CED6;
	Sat,  1 Mar 2025 03:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740799165;
	bh=lXFbo+xebaWaz7QOpw2/VTgRUhFSs4wztLMasViZqZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y/IDfKqlQ1eziUuyagJNGzLMnpvXItT4S82p5Nk0/IXYoobxnEduBbDtVKkGsugO2
	 ejm0Q8JCEroQLHgFAcsj7TKsTRgUgqCWmP9knK8LONepjsJILOyYz2Pus2QQI2Sxs1
	 aI7zqI0vTk202FeXq2+UiuMgeHEt9EvcxJoUF6SdRJOvR7IhI4QYGK4bReeD7BiIpC
	 JpMjEby9nKAa0HuwtQ4mOXVmjFHnNGrHR2mGkgO85avN03JHeouzDy8yrIMUCc/spo
	 hLAfFMx/0jATx+MQ4tjFMwehwqsSQgU2kT5IKzLcMoP438uy7JZG3um86MKmllErE6
	 po5nd0xoq2ctg==
Message-ID: <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
Date: Fri, 28 Feb 2025 21:19:21 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Kurt Borja <kuurtb@gmail.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/2025 16:08, Kurt Borja wrote:
> Hi Mario,
> 
> On Fri Feb 28, 2025 at 12:01 PM -05, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When two drivers don't support all the same profiles the legacy interface
>> only exports the common profiles.
>>
>> This causes problems for cases where one driver uses low-power but another
>> uses quiet because the result is that neither is exported to sysfs.
>>
>> To allow two drivers to disagree, add support for "hidden choices".
>> Hidden choices are platform profiles that a driver supports to be
>> compatible with the platform profile of another driver.
>>
>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: "Luke D. Jones" <luke@ljones.dev>
>>   drivers/acpi/platform_profile.c  | 94 +++++++++++++++++++++++++-------
>>   include/linux/platform_profile.h |  3 +
>>   2 files changed, 76 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 2ad53cc6aae53..ef9444482db19 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -21,9 +21,15 @@ struct platform_profile_handler {
>>   	struct device dev;
>>   	int minor;
>>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> +	unsigned long hidden_choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>   	const struct platform_profile_ops *ops;
>>   };
>>   
>> +struct aggregate_choices_data {
>> +	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> +	int count;
>> +};
>> +
>>   static const char * const profile_names[] = {
>>   	[PLATFORM_PROFILE_LOW_POWER] = "low-power",
>>   	[PLATFORM_PROFILE_COOL] = "cool",
>> @@ -73,7 +79,7 @@ static int _store_class_profile(struct device *dev, void *data)
>>   
>>   	lockdep_assert_held(&profile_lock);
>>   	handler = to_pprof_handler(dev);
>> -	if (!test_bit(*bit, handler->choices))
>> +	if (!test_bit(*bit, handler->choices) && !test_bit(*bit, handler->hidden_choices))
>>   		return -EOPNOTSUPP;
>>   
>>   	return handler->ops->profile_set(dev, *bit);
>> @@ -239,21 +245,44 @@ static const struct class platform_profile_class = {
>>   /**
>>    * _aggregate_choices - Aggregate the available profile choices
>>    * @dev: The device
>> - * @data: The available profile choices
>> + * @arg: struct aggregate_choices_data
>>    *
>>    * Return: 0 on success, -errno on failure
>>    */
>> -static int _aggregate_choices(struct device *dev, void *data)
>> +static int _aggregate_choices(struct device *dev, void *arg)
>>   {
>> +	unsigned long tmp[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> +	struct aggregate_choices_data *data = arg;
>>   	struct platform_profile_handler *handler;
>> -	unsigned long *aggregate = data;
>>   
>>   	lockdep_assert_held(&profile_lock);
>>   	handler = to_pprof_handler(dev);
>> -	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>> -		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
>> +	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
>> +	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
>> +		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
>>   	else
>> -		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
>> +		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
>> +	data->count++;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * _remove_hidden_choices - Remove hidden choices from aggregate data
>> + * @dev: The device
>> + * @arg: struct aggregate_choices_data
>> + *
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int _remove_hidden_choices(struct device *dev, void *arg)
>> +{
>> +	struct aggregate_choices_data *data = arg;
>> +	struct platform_profile_handler *handler;
>> +
>> +	lockdep_assert_held(&profile_lock);
>> +	handler = to_pprof_handler(dev);
>> +	bitmap_andnot(data->aggregate, handler->choices,
>> +		      handler->hidden_choices, PLATFORM_PROFILE_LAST);
>>   
>>   	return 0;
>>   }
>> @@ -270,22 +299,31 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>>   					     struct device_attribute *attr,
>>   					     char *buf)
>>   {
>> -	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> +	struct aggregate_choices_data data = {
>> +		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
>> +		.count = 0,
>> +	};
>>   	int err;
>>   
>> -	set_bit(PLATFORM_PROFILE_LAST, aggregate);
>> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>   		err = class_for_each_device(&platform_profile_class, NULL,
>> -					    aggregate, _aggregate_choices);
>> +					    &data, _aggregate_choices);
>>   		if (err)
>>   			return err;
>> +		if (data.count == 1) {
>> +			err = class_for_each_device(&platform_profile_class, NULL,
>> +						    &data, _remove_hidden_choices);
>> +			if (err)
>> +				return err;
>> +		}
>>   	}
>>   
>>   	/* no profile handler registered any more */
>> -	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
>> +	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
>>   		return -EINVAL;
>>   
>> -	return _commmon_choices_show(aggregate, buf);
>> +	return _commmon_choices_show(data.aggregate, buf);
>>   }
>>   
>>   /**
>> @@ -373,7 +411,10 @@ static ssize_t platform_profile_store(struct device *dev,
>>   				      struct device_attribute *attr,
>>   				      const char *buf, size_t count)
>>   {
>> -	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> +	struct aggregate_choices_data data = {
>> +		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
>> +		.count = 0,
>> +	};
>>   	int ret;
>>   	int i;
>>   
>> @@ -381,13 +422,13 @@ static ssize_t platform_profile_store(struct device *dev,
>>   	i = sysfs_match_string(profile_names, buf);
>>   	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
>>   		return -EINVAL;
>> -	set_bit(PLATFORM_PROFILE_LAST, choices);
>> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>   		ret = class_for_each_device(&platform_profile_class, NULL,
>> -					    choices, _aggregate_choices);
>> +					    &data, _aggregate_choices);
>>   		if (ret)
>>   			return ret;
>> -		if (!test_bit(i, choices))
>> +		if (!test_bit(i, data.aggregate))
>>   			return -EOPNOTSUPP;
>>   
>>   		ret = class_for_each_device(&platform_profile_class, NULL, &i,
>> @@ -453,12 +494,15 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>    */
>>   int platform_profile_cycle(void)
>>   {
>> +	struct aggregate_choices_data data = {
>> +		.aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
>> +		.count = 0,
>> +	};
>>   	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>   	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> -	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>   	int err;
>>   
>> -	set_bit(PLATFORM_PROFILE_LAST, choices);
>> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>   		err = class_for_each_device(&platform_profile_class, NULL,
>>   					    &profile, _aggregate_profiles);
>> @@ -470,14 +514,14 @@ int platform_profile_cycle(void)
>>   			return -EINVAL;
>>   
>>   		err = class_for_each_device(&platform_profile_class, NULL,
>> -					    choices, _aggregate_choices);
>> +					    &data, _aggregate_choices);
>>   		if (err)
>>   			return err;
>>   
>>   		/* never iterate into a custom if all drivers supported it */
>> -		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
>> +		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
>>   
>> -		next = find_next_bit_wrap(choices,
>> +		next = find_next_bit_wrap(data.aggregate,
>>   					  PLATFORM_PROFILE_LAST,
>>   					  profile + 1);
>>   
>> @@ -532,6 +576,14 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>> +	if (ops->hidden_choices) {
>> +		err = ops->hidden_choices(drvdata, pprof->hidden_choices);
>> +		if (err) {
>> +			dev_err(dev, "platform_profile hidden_choices failed\n");
>> +			return ERR_PTR(err);
>> +		}
>> +	}
>> +
>>   	guard(mutex)(&profile_lock);
>>   
>>   	/* create class interface for individual handler */
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> index 8ab5b0e8eb2c1..8c9df7dadd5d3 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -33,6 +33,8 @@ enum platform_profile_option {
>>    * @probe: Callback to setup choices available to the new class device. These
>>    *	   choices will only be enforced when setting a new profile, not when
>>    *	   getting the current one.
>> + * @hidden_choices: Callback to setup choices that are not visible to the user
>> + *		    but can be set by the driver.
>>    * @profile_get: Callback that will be called when showing the current platform
>>    *		 profile in sysfs.
>>    * @profile_set: Callback that will be called when storing a new platform
>> @@ -40,6 +42,7 @@ enum platform_profile_option {
>>    */
>>   struct platform_profile_ops {
>>   	int (*probe)(void *drvdata, unsigned long *choices);
>> +	int (*hidden_choices)(void *drvdata, unsigned long *choices);
>>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>>   	int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>>   };
> 
> This approach works really well for the PMF driver because the
> profile_get callback retrieves the raw profile that the profile_set
> callback cached. However this is not the case for quite a few drivers,
> which usually just retrieve the current profile from WMI for example.
> 
> This means that writing a profile to the legacy platform_profile
> attribute, which a driver has selected as a "hidden choice" may result
> in the operation succeeding, but if the user were to immediately read
> from platform_profile it would display "custom", because the profiles
> for different handlers may be unsynchronized.

I guess we need to think about how many other drivers would really need 
hidden choices added.

Is it just PMF?

> 
> This makes me wonder if the added complexity this patch brings, is
> really worth it.
> 
> IMHO we should do what Armin suggested in the patch proposed by Antheas.
> In fact, I would suggest an even simpler version:
> 
>    1. The legacy platform_profile_choices should aggregate `choices`
>       with bitmap_or instead of bitmap_and. i.e. It should display all
>       available choices
>    2. When writing a profile to the legacy platform_profile, if a handler
>       doesn't support it, we simply ignore it without failing and
>       continue to the next
> 
> I believe this works well with power-profiles-daemon, but I'm not
> entirely sure. Maybe you know more about it.
> 
> This of course has the problem that profiles would be unsync and
> platform_profile might display "custom" immediately after setting a
> profile, but this patch has the same "issue".
> 
> For me this "custom" issue, is not really an issue. The legacy interface
> should be deprecated in favor of the class interface, and new/old
> user-space tools should use/migrate to that instead.
> 
> Let me know what you think!

I don't really like that profiles can get out of sync, this is asking 
for a non-deterministic behavior that can be difficult to diagnose 
issues and also difficult for userspace to work with.

