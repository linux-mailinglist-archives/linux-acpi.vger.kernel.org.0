Return-Path: <linux-acpi+bounces-9050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C879B378C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AE81C21922
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93B1DF279;
	Mon, 28 Oct 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Y+DdsZB7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpMyGr+t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1211DEFC8;
	Mon, 28 Oct 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136035; cv=none; b=dkYKirsWt69e4PXp/nFl3NxSCRBh/mn1ZgC9dOeHO5PJU8vImh1m5s43F+2PVPli+v5ZxNB8OleLRWwetWtdvhTJPKmPVLxlwbZjXcYRn51GrPxal6howO5qn9X3BgxbCQHObVfRsbSsDmh5ylNZ+z50Hf5QHHZxJ9xBWOZUzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136035; c=relaxed/simple;
	bh=gLeZv5ir97Yjl1sdt/46HloAxmSGIxtLFIMXVh3T8XM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EQacG21VQJxo+rgTMUxUrSm1S5sySKkTSs/DyMfjXBgXrbdt+jyD2KzG9OyfdQTOZRT1VyUaU1XjVqkHX7qxh/yNFTTRkABD5yXqX/r/o1sZIZqo1dPcnHXCzlvvUQQweCeEA5FOrMNvOpC1ryeGK7Kpvkt9SY9qIDmYOkzuRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Y+DdsZB7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpMyGr+t; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F3181140132;
	Mon, 28 Oct 2024 13:20:29 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 13:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730136029;
	 x=1730222429; bh=W0iPmQesPT1ho4cxae7PXZhUHNnzDttL/+VQgkAzRlU=; b=
	Y+DdsZB7OduXrd1rze1TeqOHxe+A3MLaY/i72gOoxdD5jwzdVM49tkuLLMc6G+56
	uQPKjvPGYkymIfxictfTtg2EevDSEPEAnmh951d+qmprjR1oP+PMlAQcWNsVw9gA
	Un2PfTwLlArCxzgPN0p5C6jxJLxaKPcQQKpQJyArrBSCodQQH+DKBLlyAkrK/ppP
	LJH8nU4+thdVadfJABkqr3mn6Qc/+OWZ+xjLiqLIXC31pHIK69koTOPjQHxOcNPR
	WASkDdXwGiLXUQNGlH3rEdVyer1iqqV3pjELE9WPtz0CZ6lej7JdCdbsgYK6BZTG
	0iiJj9awFOyJsvM/kBpzUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730136029; x=
	1730222429; bh=W0iPmQesPT1ho4cxae7PXZhUHNnzDttL/+VQgkAzRlU=; b=V
	pMyGr+tEK9ck5IIjV9xcb86Hl/EOsyw5rYc1XG+DnAaZ7zax22iyJmyaPxTqId+4
	2f+hgnNpy04+S3GFMG8XCN/30YBUV8wgLTa7lBxePUvQytGVQwCOkUe7rdYc7AqR
	cpj/SEEdX9pVe1t1Raf2AFGJUtvvx3fslzm/kWbTf1J9SrV7n+gwnCLezUucE913
	TI2lhRIEhaocgJtGryjqD5MNW0/iKG9BpnZIwguubfPZI347WRyRDI//WIxv9wIu
	WulFy/OiIEOJuHcgb1S1zmRtDl5AOGrIuUS/E5iJrF/etqFARc4r0ykr5B/nRw3w
	u3U2EAzGrMrs0IFBPXqVA==
X-ME-Sender: <xms:28cfZzAIT4cMpLsw3HylBRNasIcSvz0Bxw9LJyH5hnYcqGDffSRVJg>
    <xme:28cfZ5i4NxIwNPY0oX8NgYlqK0QThnGQXbyX03KtKwMwkd2qkw2a7j893pxoJtfrc
    vVnAMAyipl2GJPNWOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdeh
    tdevheduvdejjefggfeijedvgeekhfefleehkeehvdffheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhhhigrmhdqshhunhgurghrrdhsqdhksegrmhgurdgtohhmpdhr
    tghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtph
    htthhopehikhgvrdhprghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoheprghl
    vgigsggvlhhmgeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghorhgvnhhtihhnrd
    gthhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuiihmrgigihhmihhlihgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdprh
    gtphhtthhopehsohihvghrsehirhhlrdhhuhdprhgtphhtthhopehlvghnsgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:28cfZ-mAEsWbKI51UqfLgYMLMSHnoYgqSbhjb8-nwckgPM5ZR2pPIQ>
    <xmx:28cfZ1ylYbLqq3xQGAseKWbAVoec4w8dY5S8-pg2xSL0uCj5ygG_vw>
    <xmx:28cfZ4TUNyNtX6MzodjItDgTvTNoJZg82gDMrz2yZ3LQ-Qxm1EqokA>
    <xmx:28cfZ4awSgp7vI2aqmzuoI6EMtWnaK52X1WcwXZUqR8Da9ht1by-6Q>
    <xmx:3ccfZxRLhypQqzSxv9gyn6-o37nfjZlSREBixzUNEUpo7SvapGyJrMiw>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 241463C0066; Mon, 28 Oct 2024 13:20:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 13:20:06 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
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
Message-Id: <93160eab-8b19-4b21-8539-85cf1c2a2dce@app.fastmail.com>
In-Reply-To: <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-8-mario.limonciello@amd.com>
 <bfafd7c5-6757-42e5-a3cf-d4695b6723cd@app.fastmail.com>
 <f6b937ba-3e6c-400a-8fd0-de776c78f0cd@amd.com>
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks Mario,

On Mon, Oct 28, 2024, at 10:10 AM, Mario Limonciello wrote:
> On 10/28/2024 06:01, Mark Pearson wrote:
>> Hi Mario,
>> 
>> On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
>>> Multiple drivers may attempt to register platform profile handlers,
>>> but only one may be registered and the behavior is non-deterministic
>>> for which one wins.  It's mostly controlled by probing order.
>>>
>>> This can be problematic if one driver changes CPU settings and another
>>> driver notifies the EC for changing fan curves.
>>>
>>> Modify the ACPI platform profile handler to let multiple drivers
>>> register platform profile handlers and abstract this detail from userspace.
>>>
>>>  From userspace perspective the user will see profiles available across
>>> both drivers.  However to avoid chaos only allow changing to profiles
>>> that are common in both drivers.
>>>
>>> If any problems occur when changing profiles for any driver, then revert
>>> back to the previous profile.
>>>
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
>>>   1 file changed, 117 insertions(+), 86 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>>> index 091ca6941a925..915e3c49f0b5f 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -9,7 +9,6 @@
>>>   #include <linux/platform_profile.h>
>>>   #include <linux/sysfs.h>
>>>
>>> -static struct platform_profile_handler *cur_profile;
>>>   static LIST_HEAD(platform_profile_handler_list);
>>>   static DEFINE_MUTEX(profile_lock);
>>>
>>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct
>>> device *dev,
>>>   					struct device_attribute *attr,
>>>   					char *buf)
>>>   {
>>> +	struct platform_profile_handler *handler;
>>> +	unsigned long seen = 0;
>>>   	int len = 0;
>>> -	int err, i;
>>> -
>>> -	err = mutex_lock_interruptible(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	if (!cur_profile) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -ENODEV;
>>> +	int i;
>>> +
>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
>>> +				if (seen & BIT(i))
>>> +					continue;
>>> +				if (len == 0)
>>> +					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>> +				else
>>> +					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>> +				seen |= BIT(i);
>>> +			}
>>> +		}
>>>   	}
>>>
>>> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
>>> -		if (len == 0)
>>> -			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>>> -		else
>>> -			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>>> -	}
>>>   	len += sysfs_emit_at(buf, len, "\n");
>>> -	mutex_unlock(&profile_lock);
>>>   	return len;
>>>   }
>>>
>>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
>>>   					char *buf)
>>>   {
>>>   	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>>> +	struct platform_profile_handler *handler;
>>>   	int err;
>>>
>>> -	err = mutex_lock_interruptible(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>>
>>> -	if (!cur_profile) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -ENODEV;
>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> +		if (!platform_profile_is_registered())
>>> +			return -ENODEV;
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			err = handler->profile_get(handler, &profile);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>>   	}
>>>
>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>> -	mutex_unlock(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>> -
>>>   	/* Check that profile is valid index */
>>>   	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>>>   		return -EIO;
>>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
>>>   			    struct device_attribute *attr,
>>>   			    const char *buf, size_t count)
>>>   {
>>> +	struct platform_profile_handler *handler;
>>> +	enum platform_profile_option profile;
>>>   	int err, i;
>>>
>>> -	err = mutex_lock_interruptible(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	if (!cur_profile) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -ENODEV;
>>> -	}
>>> -
>>>   	/* Scan for a matching profile */
>>>   	i = sysfs_match_string(profile_names, buf);
>>>   	if (i < 0) {
>>> -		mutex_unlock(&profile_lock);
>>>   		return -EINVAL;
>>>   	}
>>>
>>> -	/* Check that platform supports this profile choice */
>>> -	if (!test_bit(i, cur_profile->choices)) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -EOPNOTSUPP;
>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> +		if (!platform_profile_is_registered())
>>> +			return -ENODEV;
>>> +
>>> +		/* Check that all handlers support this profile choice */
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			if (!test_bit(i, handler->choices))
>>> +				return -EOPNOTSUPP;
>>> +
>>> +			/* save the profile so that it can be reverted if necessary */
>>> +			err = handler->profile_get(handler, &profile);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>> +
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			err = handler->profile_set(handler, i);
>>> +			if (err) {
>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>> +				break;
>>> +			}
>>> +		}
>>> +		if (err) {
>>> +			list_for_each_entry_continue_reverse(handler,
>>> &platform_profile_handler_list, list) {
>>> +				if (handler->profile_set(handler, profile))
>>> +					pr_err("Failed to revert profile for handler %s\n",
>>> handler->name);
>>> +			}
>>> +			return err;
>>> +		}
>>>   	}
>>>
>>> -	err = cur_profile->profile_set(cur_profile, i);
>>> -	if (!err)
>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> -
>>> -	mutex_unlock(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>   	return count;
>>>   }
>>>
>>> @@ -140,7 +148,8 @@ static const struct attribute_group
>>> platform_profile_group = {
>>>
>>>   void platform_profile_notify(void)
>>>   {
>>> -	if (!cur_profile)
>>> +	guard(mutex)(&profile_lock);
>>> +	if (!platform_profile_is_registered())
>>>   		return;
>>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>   }
>>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>>
>>>   int platform_profile_cycle(void)
>>>   {
>>> +	struct platform_profile_handler *handler;
>>>   	enum platform_profile_option profile;
>>> -	enum platform_profile_option next;
>>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>> +	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>>>   	int err;
>>>
>>> -	err = mutex_lock_interruptible(&profile_lock);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	if (!cur_profile) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -ENODEV;
>>> -	}
>>> -
>>> -	err = cur_profile->profile_get(cur_profile, &profile);
>>> -	if (err) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return err;
>>> -	}
>>> -
>>> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
>>> -				  profile + 1);
>>> -
>>> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
>>> -		mutex_unlock(&profile_lock);
>>> -		return -EINVAL;
>>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>>> +		/* first pass, make sure all handlers agree on the definition of
>>> "next" profile */
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +
>>> +			err = handler->profile_get(handler, &profile);
>>> +			if (err)
>>> +				return err;
>>> +
>>> +			if (next == PLATFORM_PROFILE_LAST)
>>> +				next = find_next_bit_wrap(handler->choices,
>>> +							  PLATFORM_PROFILE_LAST,
>>> +							  profile + 1);
>>> +			else
>>> +				next2 = find_next_bit_wrap(handler->choices,
>>> +							   PLATFORM_PROFILE_LAST,
>>> +							   profile + 1);
>>> +
>>> +			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>>> +				return -EINVAL;
>>> +
>>> +			if (next2 == PLATFORM_PROFILE_LAST)
>>> +				continue;
>>> +
>>> +			if (next != next2) {
>>> +				pr_warn("Next profile to cycle to is ambiguous between
>>> platform_profile handlers\n");
>>> +				return -EINVAL;
>>> +			}
>>> +			next = next2;
>>> +		}
>>> +
>>> +		/*
>>> +		 * Second pass: apply "next" to each handler
>>> +		 * If any failures occur unwind and revert all back to the original
>>> profile
>>> +		 */
>>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>>> +			err = handler->profile_set(handler, next);
>>> +			if (err) {
>>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>>> +				break;
>>> +			}
>>> +		}
>>> +		if (err) {
>>> +			list_for_each_entry_continue_reverse(handler,
>>> &platform_profile_handler_list, list) {
>>> +				err = handler->profile_set(handler, profile);
>>> +				if (err)
>>> +					pr_err("Failed to revert profile for handler %s\n",
>>> handler->name);
>>> +			}
>>> +		}
>>>   	}
>>>
>>> -	err = cur_profile->profile_set(cur_profile, next);
>>> -	mutex_unlock(&profile_lock);
>>> -
>>> -	if (!err)
>>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>>
>>> -	return err;
>>> +	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>>
>>> @@ -190,21 +224,19 @@ int platform_profile_register(struct
>>> platform_profile_handler *pprof)
>>>   	int err;
>>>
>>>   	guard(mutex)(&profile_lock);
>>> -	/* We can only have one active profile */
>>> -	if (cur_profile)
>>> -		return -EEXIST;
>>>
>>>   	/* Sanity check the profile handler field are set */
>>>   	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>>   		!pprof->profile_set || !pprof->profile_get)
>>>   		return -EINVAL;
>>>
>>> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>> -	if (err)
>>> -		return err;
>>> +	if (!platform_profile_is_registered()) {
>>> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>>   	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>>
>>> -	cur_profile = pprof;
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct
>>> platform_profile_handler *pprof)
>>>
>>>   	list_del(&pprof->list);
>>>
>>> -	cur_profile = NULL;
>>>   	if (!platform_profile_is_registered())
>>>   		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>>
>>> -- 
>>> 2.43.0
>> 
>> I'm still going thru the code changes - but I'm a bit unsure on the implementation itself.
>
> FYI, I split it up in v2 to make each chunk and intent behind it more 
> manageable to review instead of patch 7 being "so" big.
>
> V2 covers some of the points below as well based on some feedback from 
> Hans and Armin.
>

Ack - sorry for that, on PTO this week/last week and not checking email very often. Saw the v2 after I sent the comments on v1 (my inbox is a little bit out of control right now).
I've just started looking thru that - let me know if better to move that conversation there

>> 
>> I'd expect that one of the advantages of having different profile handlers register is that you could support extra & new profiles that might be wanted. For example the recent discussion of the AMD handler providing better tools to tweak advanced system settings for gaming etc. Won't this approach limit that? You'll only be able to have common settings.
>
> Well that RFC it turns out won't really be scalable because SPS is done 
> differently in AMD Strix and newer.  I haven't revisited it yet.
>
> But yes this approach would conceptually limit that idea because common 
> settings are all that is presented.
>
>> 
>> I find having a common profile and two different handlers a bit tricky on how to handle. My concern is it can easily lead to conflict in settings.
>> If two handlers are doing different operations to provide the same effect - then neither handler is (probably) providing what they think is required. With your CPU vs EC example, the EC will often set CPU clock thresholds and the CPU profile handler will be changing that. If this is done I think it should be explicit to the user (admittedly I'm doing this with my Lenovo hat on - but we certify our platforms with our EC profile handler)
>> 
>> I could see providing two separate handlers. e.g. balanced-A and balanced-B (for driver-A and driver-B) and the user maybe choosing which one they want (or both - though the user interface for that is definitely tricky)
>> But choosing one option for two different drivers seems confusing and with unknown side-effects. I appreciate it's complicated by your example wanting to add CPU and EC - I know how much work you've been doing on the AMD CPU front which benefits all systems.
>> 
>
> Thinking through your comments I guess another way to approach this 
> would be "per-driver" sysfs knobs.  Here's my thought.
>
> 1) /sys/firmware/acpi/platform_profile_choices would contain only things 
> that are common and if there is something NOT common then also the 
> string "custom".
>
> 2) /sys/firmware/acpi/platform_profile would accept writes for 
> everything in platform profile choices except "custom".
>
> 3) Each driver handler would also export it's own sysfs files to 
> represent the driver state.
>
> 3) If the user changed the main knob at 
> /sys/firmware/acpi/platform_profile then it would change all driver 
> handlers.
>
> 4) If the user changed sysfs for any driver individually then the main 
> knob /sys/firmware/acpi/platform_profile would export "custom".

I need to think about it a bit more - I still have some concerns about two drivers doing the same thing. In some cases they can complement each other nicely, but in other cases they will treat on each others toes.

Just to throw another idea on the pile:

 - If only one profile then it can have low-power, balanced, performance as currently
 - If two or more profiles, belonging as an example to driverA and driverB, their profile names become balanced-driverA and balanced-driverB. You could choose specifically if you wanted to activate one of them by using the driver name
 - Each driver would have a priority. I'm biased here, but a vendor platform driver would have priority 1, a CPU vendor driver priority 2, etc. This would be used to determine which driver version would be used for the cases where multiple options are present and user chooses, for example, just balanced. If two drivers of the same priority compete then first driver loaded wins.

So as an example: if we have the case where we have thinkpad_acpi (priority 1) and amd (priority 2) profile drivers offering all three profiles then:

/sys/blah/platform_profile_choices would offer:
lower-power, balanced, performance, low-power-thinkpad_acpi, balanced-thinkpad_acpi, performance-thinkpad_acpi, low-power-amd, balanced-amd, performance-amd.

If the user chooses balanced - it would activate the balanced-thinkpad_acpi profile as it has the higher priority.
The user could then also activate balanced-amd separately if they choose. Multi balanced profiles are OK.

Initially this would all be from command line, but I'm sure some nice user space GUI can be done to allow you to choose which profiles are available and active/in-active.

Maybe also add an option under platform-profiles to have an "enable all matching profiles" to override the priority implementation? In this case choosing balanced would enable all balanced profiles available (in priority order?)

Would that work for the ASUS case or not?

>
> Hans what do you think?
>

>> Another concern - would this mean that another driver could limit the options available? For instance if someone wrote a new 'mega-turbo' only profile driver and it loaded - it would then mean no profiles were available for anything as no profiles matched?
>
> Yes.  I don't think it's a problem in practice right now (as we only 
> just recently have two drivers vying for this position), but it /could/ 
> be something that happens.
>

I'd certainly like to leave the window open so that there could be, for instance, a 'gaming' profile option that does some high-performance mode with maybe power shifting towards the GPU and some other graphics only tuning things? 
I wouldn't like to shut down the ability to have options for things like that.

>> 
>> Let me know if I've misunderstood the architecture. I didn't fully get how the ASUS and Framework platforms were impacted in the intro I'm afraid.
>> 
>> Thanks!
>> Mark
>
> Framework isn't affected, it was just showing that there are platforms 
> that use the BIOS/EC notification concept and not just SPS values that 
> the driver programs so it can't "go away" to solve this issue.
>
> ASUS is the only thing affected right now.

