Return-Path: <linux-acpi+bounces-9249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC129B9C22
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682DB1C20F76
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606524D8DA;
	Sat,  2 Nov 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Azr1aXfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyY8S4Az"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58C1BC41;
	Sat,  2 Nov 2024 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513615; cv=none; b=ghDExoVFJehO2lU+w3vG/29EQFbIacmdIORrYKupZlWHTxAkxl3krWU1XixC/sG5Rk1FDKEwrGUbPfVBCAzwzOq0/wjbvSI1/1ZIsPEvP2WaVRd9BmZ/hdCLkH3qEZuGst5WQBg+gYjG15p8RJtGfk6hzrHOFp0FRBZvSOV+0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513615; c=relaxed/simple;
	bh=F6MTUi8y9N3/h/CAzgp9PLK6GDYMo2DW/CVnA4tCCNE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kOci1CEqqcyVAunhglutHP1jisdhHoFacQb5YLbDp3iTk0gogregmz8WBu3ZzxCZzgXRBJ4YEHw9+CMIEYJDVOnWkfG4ou1ou8kuDXDxJtaGa56th9KO0icTbcgkRNYyUFSJYJwSvooW1cQtCwjq/kHzq03LU+V52996e0rG5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Azr1aXfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LyY8S4Az; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 64B5D114007C;
	Fri,  1 Nov 2024 22:13:30 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Fri, 01 Nov 2024 22:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730513610;
	 x=1730600010; bh=OM1slH1if0obPl3NBjTz6RaabyKz0Okwd4nVmIqFSmc=; b=
	Azr1aXfLgr+QZEwm65EpXJhAyJn/hGIhWV5a5/mAUJlz6f7WFOS4OJbERAY0tgCw
	ZIDXDZLC4ZDSJCKXJm77tCa9eVeSBQzv0TMAWUXEBLzLPGJw0NpepjCrPFNQK9Fd
	gVlV6MpNwxq2MlAjJFjKeRvLTscdWV1YI7sDiEbJCiPoqIAeiV9NH+fjSbyfglGC
	oO01A9tVLzJv82H98JIr7UO2cPjgWDpVzqUTbdMmxQD9yJkoYKPCoY/A0Yok1YKP
	WrJwl4pYPjralDD4OtzFZz4x7twPzijovB/S2Mw0bawbI4U2+H5AASMMFNm8kwSy
	wP3sQMUK3varu9NV7QmGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730513610; x=
	1730600010; bh=OM1slH1if0obPl3NBjTz6RaabyKz0Okwd4nVmIqFSmc=; b=L
	yY8S4AzyCqoY9wMYssT49K4j66j9nKf1mhAuEfO0sCCcwM84VxADvH5GX62chqly
	XYyMBIo3YfGrSDiRcLEJ8lqMxOM0D9VfSXo/oQLVKgALfPgUlEcJO2SSVbXtHFqj
	9gMCqSV6qJatVZzgLum5fEPCneELdJgAAoIAtvhhbdrrU6o1kHH7E41tyw0tZiMk
	UpufaucX6ZTaXZr7RJl/wT9X0AzimFigUOycKgrqO8jrWUkv2DNjQ4o8FTB5zLD2
	7SYa86/jbeGSFcdQcd2CDJDhYdzLmtAxn+F/iYgJ65XltKtU1eJcfrfHBMRXPnut
	kZeBkdswXvbvxDNgW02TA==
X-ME-Sender: <xms:xoolZ3rqt-eSy7UzkZhBxRRIpOcmDs_LKmEqEksm6bQkbWB135zF6A>
    <xme:xoolZxqOZiIfXToo5WX8xj6wtw2VvgphJVgXSnhxQG08M4EH4oaLVHP0aNWkBFOTA
    jug5gyPQWjjKPU7C-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvgdprh
    gtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprhgtphhtthhopehsohihvghrsehi
    rhhlrdhhuh
X-ME-Proxy: <xmx:xoolZ0M1rkz_GYAkxuddd3zTzEYAHU2UzjL5OxwHtAOhP0osETGPcQ>
    <xmx:xoolZ65LrqJqK_nJZx0gtMbPbs2Wp159WweYgEwrL1JFkAuE4bG5pg>
    <xmx:xoolZ25R4MBVKX8jLfxFA-Ew2RAbgR_5Rhf_RTGmT7cbEUjFn6WFeQ>
    <xmx:xoolZygc-p4tR9262klIDcBPXN1BQBkjSJml40s-Xhdl8jpPhog41Q>
    <xmx:yoolZzRJWdhD-OPOX-rYUmeenfFbyfI4ZA8W1Saz-mvgh8b7ciOX0BVG>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDD033C0066; Fri,  1 Nov 2024 22:13:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Nov 2024 22:13:02 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Armin Wolf" <W_Armin@gmx.de>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Maximilian Luz" <luzmaximilian@gmail.com>, "Lee Chun-Yi" <jlee@suse.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Ike Panhc" <ike.pan@canonical.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Alexis Belmonte" <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Ai Chao" <aichao@kylinos.cn>, "Gergo Koteles" <soyer@irl.hu>,
 "open list" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <4bacaf7f-669e-4bb2-9d28-00b3fe275c94@app.fastmail.com>
In-Reply-To: <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-21-mario.limonciello@amd.com>
 <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device for
 platform profile handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 31, 2024, at 4:55 PM, Armin Wolf wrote:
> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
>
>> The "platform_profile" class device has the exact same semantics as the
>> platform profile files in /sys/firmware/acpi/ but it reflects values only
>> present for a single platform profile handler.
>>
>> The expectation is that legacy userspace can change the profile for all
>> handlers in /sys/firmware/acpi/platform_profile and can change it for
>> individual handlers by /sys/class/platform_profile/*.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c  | 93 ++++++++++++++++++++++++++++----
>>   include/linux/platform_profile.h |  2 +
>>   2 files changed, 85 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 9b681884ae324..1cc8182930dde 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -24,13 +24,24 @@ static const char * const profile_names[] = {
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>>
>> +static DEFINE_IDR(platform_profile_minor_idr);
>> +
>> +static const struct class platform_profile_class = {
>> +	.name = "platform-profile",
>> +};
>> +
>>   static bool platform_profile_is_registered(void)
>>   {
>>   	lockdep_assert_held(&profile_lock);
>>   	return !list_empty(&platform_profile_handler_list);
>>   }
>>
>> -static unsigned long platform_profile_get_choices(void)
>> +static bool platform_profile_is_class_device(struct device *dev)
>> +{
>> +	return dev && dev->class == &platform_profile_class;
>> +}
>> +
>> +static unsigned long platform_profile_get_choices(struct device *dev)
>>   {
>>   	struct platform_profile_handler *handler;
>>   	unsigned long aggregate = 0;
>> @@ -40,6 +51,9 @@ static unsigned long platform_profile_get_choices(void)
>>   	list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>   		unsigned long individual = 0;
>>
>> +		/* if called from a class attribute then only match that one */
>> +		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
>> +			continue;
>
> I do not like how the sysfs attributes for the platform-profile class 
> are handled:
>
> 1. We should use .dev_groups instead of manually registering the sysfs 
> attributes.
> 2. Can we name the sysfs attributes for the class a bit differently 
> ("profile_choices" and "profile")
>     and use separate store/show functions for those?
> 3. Why do we still need platform_profile_handler_list?
>
> This would allow us to get rid of platform_profile_is_class_device().
>
>>   		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>>   			individual |= BIT(i);
>>   		if (!aggregate)
>> @@ -51,7 +65,7 @@ static unsigned long platform_profile_get_choices(void)
>>   	return aggregate;
>>   }
>>
>> -static int platform_profile_get_active(enum platform_profile_option *profile)
>> +static int platform_profile_get_active(struct device *dev, enum platform_profile_option *profile)
>>   {
>>   	struct platform_profile_handler *handler;
>>   	enum platform_profile_option active = PLATFORM_PROFILE_LAST;
>> @@ -60,6 +74,8 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
>>
>>   	lockdep_assert_held(&profile_lock);
>>   	list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +		if (platform_profile_is_class_device(dev) && handler->dev != dev->parent)
>> +			continue;
>>   		err = handler->profile_get(handler, &val);
>>   		if (err) {
>>   			pr_err("Failed to get profile for handler %s\n", handler->name);
>> @@ -69,6 +85,10 @@ static int platform_profile_get_active(enum platform_profile_option *profile)
>>   		if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
>>   			return -EINVAL;
>>
>> +		/*
>> +		 * If the profiles are different for class devices then this must
>> +		 * show "custom" to legacy sysfs interface
>> +		 */
>>   		if (active != val && active != PLATFORM_PROFILE_LAST) {
>>   			*profile = PLATFORM_PROFILE_CUSTOM;
>>   			return 0;
>> @@ -90,7 +110,7 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>>   	int i;
>>
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
>> -		choices = platform_profile_get_choices();
>> +		choices = platform_profile_get_choices(dev);
>>
>>   	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>>   		if (len == 0)
>> @@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct device *dev,
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>   		if (!platform_profile_is_registered())
>>   			return -ENODEV;
>> -		err = platform_profile_get_active(&profile);
>> +		err = platform_profile_get_active(dev, &profile);
>>   		if (err)
>>   			return err;
>>   	}
>> @@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct device *dev,
>>   		if (!platform_profile_is_registered())
>>   			return -ENODEV;
>>
>> -		/* Check that all handlers support this profile choice */
>> -		choices = platform_profile_get_choices();
>> +		/* don't allow setting custom to legacy sysfs interface */
>> +		if (!platform_profile_is_class_device(dev) &&
>> +		     i == PLATFORM_PROFILE_CUSTOM) {
>> +			pr_warn("Custom profile not supported for legacy sysfs interface\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* Check that applicable handlers support this profile choice */
>> +		choices = platform_profile_get_choices(dev);
>>   		if (!test_bit(i, &choices))
>>   			return -EOPNOTSUPP;
>>
>>   		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			if (platform_profile_is_class_device(dev) &&
>> +			    handler->dev != dev->parent)
>> +				continue;
>>   			err = handler->profile_set(handler, i);
>>   			if (err) {
>>   				pr_err("Failed to set profile for handler %s\n", handler->name);
>> @@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct device *dev,
>>   		}
>>   		if (err) {
>>   			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
>> +				if (platform_profile_is_class_device(dev) &&
>> +				    handler->dev != dev->parent)
>> +					continue;
>>   				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
>>   					pr_err("Failed to revert profile for handler %s\n",
>>   					       handler->name);
>> @@ -194,11 +227,11 @@ int platform_profile_cycle(void)
>>   	int err;
>>
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -		err = platform_profile_get_active(&profile);
>> +		err = platform_profile_get_active(NULL, &profile);
>>   		if (err)
>>   			return err;
>>
>> -		choices = platform_profile_get_choices();
>> +		choices = platform_profile_get_choices(NULL);
>>
>>   		next = find_next_bit_wrap(&choices,
>>   					  PLATFORM_PROFILE_LAST,
>> @@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>
>>   int platform_profile_register(struct platform_profile_handler *pprof)
>>   {
>> +	bool registered;
>>   	int err;
>>
>>   	/* Sanity check the profile handler */
>> @@ -250,14 +284,49 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>>   	if (cur_profile)
>>   		return -EEXIST;
>>
>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +	registered = platform_profile_is_registered();
>> +	if (!registered) {
>> +		/* class for individual handlers */
>> +		err = class_register(&platform_profile_class);
>> +		if (err)
>> +			return err;
>
> Why do we need to unregister the class here? From my point of view, 
> having a empty class if no
> platform profiles are registered is totally fine.
>
>> +		/* legacy sysfs files */
>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +		if (err)
>> +			goto cleanup_class;
>> +
>> +	}
>> +
>> +	/* create class interface for individual handler */
>> +	pprof->minor = idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, GFP_KERNEL);
>> +	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
>> +					 MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
>> +					 pprof->name);
>
> I would suggest that the name of the class devices should not contain 
> the platform profile name,
> as this would mean that two platform profile handlers cannot have the 
> same name.
>
> Maybe using "platform-profile-<minor>" would be a better solution here? 
> The name can instead be
> read using an additional sysfs property.
>
> Thanks,
> Armin Wolf
>

I'm still getting my head around this patch (it's late and I'm a bit brain-dead this evening) - but isn't it a good thing to force the different profile handlers to have different names?

I like the platform-profile-<name> approach, it makes it simpler for users to know if they're changing a platform vendors profile, a CPU vendors profile, or something else. If profiles have the same name it would become quite confusing.

Mark

>> +	if (IS_ERR(pprof->class_dev)) {
>> +		err = PTR_ERR(pprof->class_dev);
>> +		goto cleanup_legacy;
>> +	}
>> +	err = sysfs_create_group(&pprof->class_dev->kobj, &platform_profile_group);
>>   	if (err)
>> -		return err;
>> +		goto cleanup_device;
>> +
>>   	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>>   	cur_profile = pprof;
>>   	return 0;
>> +
>> +cleanup_device:
>> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>> +
>> +cleanup_legacy:
>> +	if (!registered)
>> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +cleanup_class:
>> +	if (!registered)
>> +		class_unregister(&platform_profile_class);
>> +
>> +	return err;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>>
>> @@ -270,6 +339,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>>   	cur_profile = NULL;
>>
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +
>> +	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
>> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>> +
>>   	if (!platform_profile_is_registered())
>>   		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> index da009c8a402c9..764c4812ef759 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -30,6 +30,8 @@ enum platform_profile_option {
>>   struct platform_profile_handler {
>>   	const char *name;
>>   	struct device *dev;
>> +	struct device *class_dev;
>> +	int minor;
>>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>   	struct list_head list;
>>   	int (*profile_get)(struct platform_profile_handler *pprof,

