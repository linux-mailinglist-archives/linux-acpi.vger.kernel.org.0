Return-Path: <linux-acpi+bounces-9261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 705109BA31F
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Nov 2024 00:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973581C210DC
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 23:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1D1ABEB1;
	Sat,  2 Nov 2024 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cT1q3gwq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7C166308;
	Sat,  2 Nov 2024 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730591267; cv=none; b=t021WPfliL0bWjS0L+2s66Erdnk+cykNcpK66g6j5xPF8THVteZCmvygcu+9y8jySjwpR4KPY1M/2bU4HpdZBD/0Dr+23ohBn3SuqYBWb/3nKNkJRtzm6iAo9wQdYZ8DwKlFuiv0LB1f/Ua07dyzGnHcuyKXGXI4pslzTagyeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730591267; c=relaxed/simple;
	bh=YGz4WHLmqDpakuTpmzfQX5ddHFGIlUonn0mfCNzpBGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+bMPiP20GYMpwvmNLRRs6HHWFlCGeL0d1yhgxHr9qtwNd/eZxVff0NqQjTH7s+OR2DW5/NNZVdg+AvUbHH/b1ZMjECoB5cz7w7sF487NJhJYjJAKPHK70pWaiKt1CJ+KecVYZj1Kifa048AD+TIwFImHw7G/WJkJ1qpChKqvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cT1q3gwq; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730591192; x=1731195992; i=w_armin@gmx.de;
	bh=Lj9Hh825+xQE8fUTQEg5cu6JSl5Nju91eRTzM35durg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cT1q3gwqhCMFg+gkjgS2V2p/kyFelKnth8x8c0P8U6RtenEY1tJLbwcafqjeTAiK
	 Rd+WoHu9UswVdievNMHlHzwAkM6xA2eUc1Kqmj0c06SKjDKYiTwcIXz/yRStC3RdR
	 989DC7P2fEIMtabM8KNmkYQY6L3QdIkajdoiHFgF18yrN3h3i6v97CooFOnjtflHu
	 vs52vCvqxUp8Q728taKBZHBI1UPgAmInE7PbUkQMLaRu88V+n2uCvelgvtaJBBtwD
	 QWyIUce0xAPl2UP6NE2sTpZXYByoBmBODYcySGIibDBvlWH8N7eEbewy8waCO9/Xy
	 5WOSwjGS7k2lX8ChSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1tZWiJ0pad-00oOI4; Sun, 03
 Nov 2024 00:46:32 +0100
Message-ID: <64f7e3d3-e746-4b4b-aafb-3939cd46b0c0@gmx.de>
Date: Sun, 3 Nov 2024 00:46:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device
 for platform profile handlers
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-21-mario.limonciello@amd.com>
 <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
 <4bacaf7f-669e-4bb2-9d28-00b3fe275c94@app.fastmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4bacaf7f-669e-4bb2-9d28-00b3fe275c94@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:a0y+GMvkENsX3BrvjY0axJohl/f6S04AjO8BSOrWCJjD1Q+2ZHY
 qF0UK3Njvii5AHg7CLqXT/K66jV4hBzxSTsIm1ShXS8xrzMJ8/6liIA+y8+wGFwYWGeEELd
 /d8+JR0UEpCyXWcy0s6wSxiSjY86257Izw+YTNlzDb4hHpoRhEqU6iZcDQEg7fu+VUKQUjD
 QR2+HbWswMEDgvvu5LhMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pSRtWwRJLg8=;cP5UzgfAKybPvR7j4BlnoeLd0Da
 wWzUidF1Q7/LzohIjUe+6UVPt03dkXvePCvUWrbcrMqvKPzGwK/WZLPVawyj+1vZhCn9ev+4h
 2SBH4MNXa8vbwrVGBI5xorRJXbY1HpAeL/ZzycrRF2qZ5NAxONdGSp1X+M80srBh7qTbzqr4W
 DgTMEfH6eh8aS6LuPqFWVkUrbBK4cpMDqRg4HRi5nXdCZHjgqi4aH0IWynz3ibi7oXQOoUB+O
 iJCpj2sAS50rE2HovL7gZ5yMGE05dvc9ZaRX7kNbWpFdnTRwGgimftB2dut9yjahKgoNS6n7Q
 KAzkhLurF4B/pGh3YW+ir5wNbWdY2ugdNUbiElQTdQEBMvjV73IJal7u9HkY5WDjw34FJcYdy
 5cedOvgdUhGotymPKxKbEpb86GOg4JsazoH51ksdluVSd/rw2b73j+qP9FENvCyNQMuCvEu+S
 w2TXf9pQ2CjkiFmSME4AhqT6/XaVAZPHaDk1M2/Nu1OhlO91qT8sHx1/DVESlfyPm/1Ffoj4U
 5eVjDPoYxE2Nqu1CtgikR0TlFj1az6qoNAOeb45Wnjh9vCAfE/XamEhcMGr7Klc+LUX06WLdV
 K5M+9lzAzcBS+mrRAC+vKAqvXYabZZzk2+uPK8qyCTaaVlYEFqEl1fOMLQ25dz/Lh7BGpM2sQ
 lUpDjXSWdthZhrOeUD3CyTqjMLJaARUxB8jczWhSGh2RfSd1/k0/xfGCT6Th+RwyH6Pr7sl0j
 yWtriFbSpNX1OiS+uzzoDxqyIaZFIzT+r/HU/qXNP2inZdGa/GQwB4GXvG5KsitmDze2lgmNg
 UOOBowXevJ+GEIiuMhAO4tAw==

Am 02.11.24 um 03:13 schrieb Mark Pearson:

>
> On Thu, Oct 31, 2024, at 4:55 PM, Armin Wolf wrote:
>> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
>>
>>> The "platform_profile" class device has the exact same semantics as the
>>> platform profile files in /sys/firmware/acpi/ but it reflects values only
>>> present for a single platform profile handler.
>>>
>>> The expectation is that legacy userspace can change the profile for all
>>> handlers in /sys/firmware/acpi/platform_profile and can change it for
>>> individual handlers by /sys/class/platform_profile/*.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    drivers/acpi/platform_profile.c  | 93 ++++++++++++++++++++++++++++----
>>>    include/linux/platform_profile.h |  2 +
>>>    2 files changed, 85 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>> index 9b681884ae324..1cc8182930dde 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -24,13 +24,24 @@ static const char * const profile_names[] = {
>>>    };
>>>    static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>>>
>>> +static DEFINE_IDR(platform_profile_minor_idr);
>>> +
>>> +static const struct class platform_profile_class = {
>>> +	.name = "platform-profile",
>>> +};
>>> +
>>>    static bool platform_profile_is_registered(void)
>>>    {
>>>    	lockdep_assert_held(&profile_lock);
>>>    	return !list_empty(&platform_profile_handler_list);
>>>    }
>>>
>>> -static unsigned long platform_profile_get_choices(void)
>>> +static bool platform_profile_is_class_device(struct device *dev)
>>> +{
>>> +	return dev && dev->class == &platform_profile_class;
>>> +}
>>> +
>>> +static unsigned long platform_profile_get_choices(struct device *dev)
>>>    {
>>>    	struct platform_profile_handler *handler;
>>>    	unsigned long aggregate = 0;
>>> @@ -40,6 +51,9 @@ static unsigned long platform_profile_get_choices(void)
>>>    	list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>>    		unsigned long individual = 0;
>>>
>>> +		/* if called from a class attribute then only match that one */
>>> +		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
>>> +			continue;
>> I do not like how the sysfs attributes for the platform-profile class
>> are handled:
>>
>> 1. We should use .dev_groups instead of manually registering the sysfs
>> attributes.
>> 2. Can we name the sysfs attributes for the class a bit differently
>> ("profile_choices" and "profile")
>>      and use separate store/show functions for those?
>> 3. Why do we still need platform_profile_handler_list?
>>
>> This would allow us to get rid of platform_profile_is_class_device().
>>
>>>    		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>>>    			individual |= BIT(i);
>>>    		if (!aggregate)
>>> @@ -51,7 +65,7 @@ static unsigned long platform_profile_get_choices(void)
>>>    	return aggregate;
>>>    }
>>>
>>> -static int platform_profile_get_active(enum platform_profile_option *profile)
>>> +static int platform_profile_get_active(struct device *dev, enum platform_profile_option *profile)
>>>    {
>>>    	struct platform_profile_handler *handler;
>>>    	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
>>> @@ -60,6 +74,8 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
>>>
>>>    	lockdep_assert_held(&profile_lock);
>>>    	list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
>>> +			continue;
>>>    		err = handler->profile_get(handler, &val);
>>>    		if (err) {
>>>    			pr_err("Failed to get profile for handler %s\n", handler->name);
>>> @@ -69,6 +85,10 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
>>>    		if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
>>>    			return -EINVAL;
>>>
>>> +		/*
>>> +		 * If the profiles are different for class devices then this must
>>> +		 * show "custom" to legacy sysfs interface
>>> +		 */
>>>    		if (active != val && active != PLATFORM_PROFILE_LAST) {
>>>    			*profile = PLATFORM_PROFILE_CUSTOM;
>>>    			return 0;
>>> @@ -90,7 +110,7 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>>>    	int i;
>>>
>>>    	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
>>> -		choices = platform_profile_get_choices();
>>> +		choices = platform_profile_get_choices(dev);
>>>
>>>    	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>>>    		if (len == 0)
>>> @@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct device *dev,
>>>    	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>>    		if (!platform_profile_is_registered())
>>>    			return -ENODEV;
>>> -		err = platform_profile_get_active(&profile);
>>> +		err = platform_profile_get_active(dev, &profile);
>>>    		if (err)
>>>    			return err;
>>>    	}
>>> @@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct device *dev,
>>>    		if (!platform_profile_is_registered())
>>>    			return -ENODEV;
>>>
>>> -		/* Check that all handlers support this profile choice */
>>> -		choices = platform_profile_get_choices();
>>> +		/* don't allow setting custom to legacy sysfs interface */
>>> +		if (!platform_profile_is_class_device(dev) &&
>>> +		     i == PLATFORM_PROFILE_CUSTOM) {
>>> +			pr_warn("Custom profile not supported for legacy sysfs interface\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		/* Check that applicable handlers support this profile choice */
>>> +		choices = platform_profile_get_choices(dev);
>>>    		if (!test_bit(i, &choices))
>>>    			return -EOPNOTSUPP;
>>>
>>>    		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			if (platform_profile_is_class_device(dev) &&
>>> +			    handler->dev != dev->parent)
>>> +				continue;
>>>    			err = handler->profile_set(handler, i);
>>>    			if (err) {
>>>    				pr_err("Failed to set profile for handler %s\n", handler->name);
>>> @@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct device *dev,
>>>    		}
>>>    		if (err) {
>>>    			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
>>> +				if (platform_profile_is_class_device(dev) &&
>>> +				    handler->dev != dev->parent)
>>> +					continue;
>>>    				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
>>>    					pr_err("Failed to revert profile for handler %s\n",
>>>    					       handler->name);
>>> @@ -194,11 +227,11 @@ int platform_profile_cycle(void)
>>>    	int err;
>>>
>>>    	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> -		err = platform_profile_get_active(&profile);
>>> +		err = platform_profile_get_active(NULL, &profile);
>>>    		if (err)
>>>    			return err;
>>>
>>> -		choices = platform_profile_get_choices();
>>> +		choices = platform_profile_get_choices(NULL);
>>>
>>>    		next = find_next_bit_wrap(&choices,
>>>    					  PLATFORM_PROFILE_LAST,
>>> @@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>
>>>    int platform_profile_register(struct platform_profile_handler *pprof)
>>>    {
>>> +	bool registered;
>>>    	int err;
>>>
>>>    	/* Sanity check the profile handler */
>>> @@ -250,14 +284,49 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>>>    	if (cur_profile)
>>>    		return -EEXIST;
>>>
>>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>> +	registered = platform_profile_is_registered();
>>> +	if (!registered) {
>>> +		/* class for individual handlers */
>>> +		err = class_register(&platform_profile_class);
>>> +		if (err)
>>> +			return err;
>> Why do we need to unregister the class here? From my point of view,
>> having a empty class if no
>> platform profiles are registered is totally fine.
>>
>>> +		/* legacy sysfs files */
>>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>> +		if (err)
>>> +			goto cleanup_class;
>>> +
>>> +	}
>>> +
>>> +	/* create class interface for individual handler */
>>> +	pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, GFP_KERNEL);
>>> +	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
>>> +					 MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
>>> +					 pprof->name);
>> I would suggest that the name of the class devices should not contain
>> the platform profile name,
>> as this would mean that two platform profile handlers cannot have the
>> same name.
>>
>> Maybe using "platform-profile-<minor>" would be a better solution here?
>> The name can instead be
>> read using an additional sysfs property.
>>
>> Thanks,
>> Armin Wolf
>>
> I'm still getting my head around this patch (it's late and I'm a bit brain-dead this evening) - but isn't it a good thing to force the different profile handlers to have different names?
>
> I like the platform-profile-<name> approach, it makes it simpler for users to know if they're changing a platform vendors profile, a CPU vendors profile, or something else. If profiles have the same name it would become quite confusing.
>
> Mark
>
I agree the different handlers should have different names, but including the name inside the device name will:

- make users depend on the device name, which usually causes problems later
- cause a WARN() (if i remember correctly) should two handlers accidentally have the same name

Especially the last point can happen sooner than you think, for example if the same driver is instantiated twice.

Thanks,
Armin Wolf

>>> +	if (IS_ERR(pprof->class_dev)) {
>>> +		err = PTR_ERR(pprof->class_dev);
>>> +		goto cleanup_legacy;
>>> +	}
>>> +	err = sysfs_create_group(&pprof->class_dev->kobj, &platform_profile_group);
>>>    	if (err)
>>> -		return err;
>>> +		goto cleanup_device;
>>> +
>>>    	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>>    	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>>    	cur_profile = pprof;
>>>    	return 0;
>>> +
>>> +cleanup_device:
>>> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>>> +
>>> +cleanup_legacy:
>>> +	if (!registered)
>>> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>> +cleanup_class:
>>> +	if (!registered)
>>> +		class_unregister(&platform_profile_class);
>>> +
>>> +	return err;
>>>    }
>>>    EXPORT_SYMBOL_GPL(platform_profile_register);
>>>
>>> @@ -270,6 +339,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>>>    	cur_profile = NULL;
>>>
>>>    	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> +
>>> +	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
>>> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>>> +
>>>    	if (!platform_profile_is_registered())
>>>    		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>>
>>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>>> index da009c8a402c9..764c4812ef759 100644
>>> --- a/include/linux/platform_profile.h
>>> +++ b/include/linux/platform_profile.h
>>> @@ -30,6 +30,8 @@ enum platform_profile_option {
>>>    struct platform_profile_handler {
>>>    	const char *name;
>>>    	struct device *dev;
>>> +	struct device *class_dev;
>>> +	int minor;
>>>    	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>>    	struct list_head list;
>>>    	int (*profile_get)(struct platform_profile_handler *pprof,

