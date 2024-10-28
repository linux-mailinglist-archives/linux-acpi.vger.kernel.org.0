Return-Path: <linux-acpi+bounces-9042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60629B2E4F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D994E1C21B39
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F91D966B;
	Mon, 28 Oct 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="gl1TAKl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kmyNWHmA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE91D90AD;
	Mon, 28 Oct 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113339; cv=none; b=oJhrzYead/NK58GYVP2xJCq4DTIYg+BdF/U6yflncIMgw72j4+/s6Tm+dvhiHHRiE+SYdDv7Vq2uJBtwq4kFaeHuBZ827etBcVV4V1KMhZjSww9hR2wIXp1C0auUPChSAyIshEf5FC3nL5U3bS9nEF3E3fBY5uLytRuNj2fRFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113339; c=relaxed/simple;
	bh=G4DEvRIB1hy/Xi0AYjOXvOLiwjdiW56J3Xa8p9tdjWQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PMSx8STs44T7Jjp/7Y1FWzZ5TUBdQ4hzfPwPxQJWTmlIubIVi2YY5XgkmO24ciV9NpoS337ivKOxQ4/tA2TPM1CLRAvdsYpVKRaffaxPz20lHgl/hVr5BT+JFPzzdrX2DgQMmwOkVrm7BT3heuukZLouzQy0MD9lswwkrPc1Em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=gl1TAKl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kmyNWHmA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 451D32540090;
	Mon, 28 Oct 2024 07:02:14 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Mon, 28 Oct 2024 07:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730113334;
	 x=1730199734; bh=O/D+6f3GkJ3PO4skFYQQ3StKkecOTla7RKcV9O6QbpY=; b=
	gl1TAKl3HJOeCJNLbO4XW8ZsOExI+KS2HxxPOPqyxV0I9f80w5fc/8Yqb9CJYSp4
	57PFlNFc7oWZrs1Xp+ScU1+KfTh1gLa2+zvX3hUO7IQ//DvWvEYN88RYwimLYl4Q
	rTibjkYUG6CEtDqCN/AzqEJVpgGZZX227hk56ek48yf2tAVIefuhjqg/T3aSFv4X
	o1/C7GtQwEvni98jv3VMIkrY4AWp1l352W0VCJzBTe6+45EfCgpIxHzLoZSUId7g
	COgmUFLyEU8jZexJ4142BJa6eijOGGnk3wFaXrG1dY1pw+xncvkZgIFtgQ2SZBHm
	yfUJ5PbVmcGWe9oy926row==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730113334; x=
	1730199734; bh=O/D+6f3GkJ3PO4skFYQQ3StKkecOTla7RKcV9O6QbpY=; b=k
	myNWHmAirwhhnkHaf9XO5UYOM4dLW+10QVsQCQ14YXyhXIAgukXsLqVfc/bhM6WD
	YcANeVOLxUZwbFFWccao9e1/MYqRIoQh54PBTmzJfxBaz/iJObKJL6haYTMdl53v
	U3oLAahr/ZG2hT4AnhkXIuLOwufUD+VltgjmsEcCzeLGR9fDIH1FdXWcBuuE7u4h
	QSvX6T9qYbcdu3noQHCqcDHgzYgSnPRODPbrNKbZLcJP1kZ2T/ttodllLfRU/EfW
	sh69DahD0buwHDPrsobfUX3fMzL9QuII6UxNpAIRTNb/UdxJankAYtMvao87N72O
	49kp90orZCaRMNRdreEAw==
X-ME-Sender: <xms:NW8fZ34pneBAaMV_PK7IQkBmPpOKYZiV2g07SEZQ-Tjm_sNPaEPTVg>
    <xme:NW8fZ876T6IMUEKepPazEORH6TLzyI6HIc3PW0JI6uw89FZ5fK8o3EQoObtt1VYO3
    qty7HOq9Uejhg1l4qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejkedgvdduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:NW8fZ-c1q8gRXTDsQYxqGyMatxZMnhyu1xid5NkPZrrRq9i6aRW4Sw>
    <xmx:NW8fZ4LpKovAmhJsNxsv4BTTMDl7SMicWBWd_4X9T2w5hWzrxVdmPQ>
    <xmx:NW8fZ7L8KwtmFi6MCm6wa2l87AYr25Wj8_kFxC7kuEAlKSQVVOfkWQ>
    <xmx:NW8fZxwgwRebr1bcMvzRMQUgRBdENoQN3diT0Y-kWM5x51bbb5kzww>
    <xmx:Nm8fZzKzQtVABJIEyV6Y9LhORHRZ0MCBAauwfRWGo-XLIukJA-fr-2TB>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4D4033C0066; Mon, 28 Oct 2024 07:02:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 07:01:53 -0400
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
Message-Id: <bfafd7c5-6757-42e5-a3cf-d4695b6723cd@app.fastmail.com>
In-Reply-To: <20241025193055.2235-8-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-8-mario.limonciello@amd.com>
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple handlers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Mario,

On Fri, Oct 25, 2024, at 3:30 PM, Mario Limonciello wrote:
> Multiple drivers may attempt to register platform profile handlers,
> but only one may be registered and the behavior is non-deterministic
> for which one wins.  It's mostly controlled by probing order.
>
> This can be problematic if one driver changes CPU settings and another
> driver notifies the EC for changing fan curves.
>
> Modify the ACPI platform profile handler to let multiple drivers
> register platform profile handlers and abstract this detail from userspace.
>
> From userspace perspective the user will see profiles available across
> both drivers.  However to avoid chaos only allow changing to profiles
> that are common in both drivers.
>
> If any problems occur when changing profiles for any driver, then revert
> back to the previous profile.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
>  1 file changed, 117 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 091ca6941a925..915e3c49f0b5f 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> 
> -static struct platform_profile_handler *cur_profile;
>  static LIST_HEAD(platform_profile_handler_list);
>  static DEFINE_MUTEX(profile_lock);
> 
> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct 
> device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> +	struct platform_profile_handler *handler;
> +	unsigned long seen = 0;
>  	int len = 0;
> -	int err, i;
> -
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> +	int i;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
> +				if (seen & BIT(i))
> +					continue;
> +				if (len == 0)
> +					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +				else
> +					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +				seen |= BIT(i);
> +			}
> +		}
>  	}
> 
> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -		if (len == 0)
> -			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -		else
> -			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
> -	}
>  	len += sysfs_emit_at(buf, len, "\n");
> -	mutex_unlock(&profile_lock);
>  	return len;
>  }
> 
> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
>  					char *buf)
>  {
>  	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
> +	struct platform_profile_handler *handler;
>  	int err;
> 
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> 
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!platform_profile_is_registered())
> +			return -ENODEV;
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_get(handler, &profile);
> +			if (err)
> +				return err;
> +		}
>  	}
> 
> -	err = cur_profile->profile_get(cur_profile, &profile);
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> -
>  	/* Check that profile is valid index */
>  	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>  		return -EIO;
> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> +	struct platform_profile_handler *handler;
> +	enum platform_profile_option profile;
>  	int err, i;
> 
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> -
>  	/* Scan for a matching profile */
>  	i = sysfs_match_string(profile_names, buf);
>  	if (i < 0) {
> -		mutex_unlock(&profile_lock);
>  		return -EINVAL;
>  	}
> 
> -	/* Check that platform supports this profile choice */
> -	if (!test_bit(i, cur_profile->choices)) {
> -		mutex_unlock(&profile_lock);
> -		return -EOPNOTSUPP;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!platform_profile_is_registered())
> +			return -ENODEV;
> +
> +		/* Check that all handlers support this profile choice */
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			if (!test_bit(i, handler->choices))
> +				return -EOPNOTSUPP;
> +
> +			/* save the profile so that it can be reverted if necessary */
> +			err = handler->profile_get(handler, &profile);
> +			if (err)
> +				return err;
> +		}
> +
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, i);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, 
> &platform_profile_handler_list, list) {
> +				if (handler->profile_set(handler, profile))
> +					pr_err("Failed to revert profile for handler %s\n", 
> handler->name);
> +			}
> +			return err;
> +		}
>  	}
> 
> -	err = cur_profile->profile_set(cur_profile, i);
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  	return count;
>  }
> 
> @@ -140,7 +148,8 @@ static const struct attribute_group 
> platform_profile_group = {
> 
>  void platform_profile_notify(void)
>  {
> -	if (!cur_profile)
> +	guard(mutex)(&profile_lock);
> +	if (!platform_profile_is_registered())
>  		return;
>  	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  }
> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
> 
>  int platform_profile_cycle(void)
>  {
> +	struct platform_profile_handler *handler;
>  	enum platform_profile_option profile;
> -	enum platform_profile_option next;
> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> +	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
>  	int err;
> 
> -	err = mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> -
> -	err = cur_profile->profile_get(cur_profile, &profile);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> -		return err;
> -	}
> -
> -	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
> -				  profile + 1);
> -
> -	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		/* first pass, make sure all handlers agree on the definition of 
> "next" profile */
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +
> +			err = handler->profile_get(handler, &profile);
> +			if (err)
> +				return err;
> +
> +			if (next == PLATFORM_PROFILE_LAST)
> +				next = find_next_bit_wrap(handler->choices,
> +							  PLATFORM_PROFILE_LAST,
> +							  profile + 1);
> +			else
> +				next2 = find_next_bit_wrap(handler->choices,
> +							   PLATFORM_PROFILE_LAST,
> +							   profile + 1);
> +
> +			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
> +				return -EINVAL;
> +
> +			if (next2 == PLATFORM_PROFILE_LAST)
> +				continue;
> +
> +			if (next != next2) {
> +				pr_warn("Next profile to cycle to is ambiguous between 
> platform_profile handlers\n");
> +				return -EINVAL;
> +			}
> +			next = next2;
> +		}
> +
> +		/*
> +		 * Second pass: apply "next" to each handler
> +		 * If any failures occur unwind and revert all back to the original 
> profile
> +		 */
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, next);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, 
> &platform_profile_handler_list, list) {
> +				err = handler->profile_set(handler, profile);
> +				if (err)
> +					pr_err("Failed to revert profile for handler %s\n", 
> handler->name);
> +			}
> +		}
>  	}
> 
> -	err = cur_profile->profile_set(cur_profile, next);
> -	mutex_unlock(&profile_lock);
> -
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> 
> -	return err;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> 
> @@ -190,21 +224,19 @@ int platform_profile_register(struct 
> platform_profile_handler *pprof)
>  	int err;
> 
>  	guard(mutex)(&profile_lock);
> -	/* We can only have one active profile */
> -	if (cur_profile)
> -		return -EEXIST;
> 
>  	/* Sanity check the profile handler field are set */
>  	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>  		!pprof->profile_set || !pprof->profile_get)
>  		return -EINVAL;
> 
> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		return err;
> +	if (!platform_profile_is_registered()) {
> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> +		if (err)
> +			return err;
> +	}
>  	list_add_tail(&pprof->list, &platform_profile_handler_list);
> 
> -	cur_profile = pprof;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
> @@ -215,7 +247,6 @@ int platform_profile_remove(struct 
> platform_profile_handler *pprof)
> 
>  	list_del(&pprof->list);
> 
> -	cur_profile = NULL;
>  	if (!platform_profile_is_registered())
>  		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> 
> -- 
> 2.43.0

I'm still going thru the code changes - but I'm a bit unsure on the implementation itself.

I'd expect that one of the advantages of having different profile handlers register is that you could support extra & new profiles that might be wanted. For example the recent discussion of the AMD handler providing better tools to tweak advanced system settings for gaming etc. Won't this approach limit that? You'll only be able to have common settings.

I find having a common profile and two different handlers a bit tricky on how to handle. My concern is it can easily lead to conflict in settings. 
If two handlers are doing different operations to provide the same effect - then neither handler is (probably) providing what they think is required. With your CPU vs EC example, the EC will often set CPU clock thresholds and the CPU profile handler will be changing that. If this is done I think it should be explicit to the user (admittedly I'm doing this with my Lenovo hat on - but we certify our platforms with our EC profile handler)

I could see providing two separate handlers. e.g. balanced-A and balanced-B (for driver-A and driver-B) and the user maybe choosing which one they want (or both - though the user interface for that is definitely tricky) 
But choosing one option for two different drivers seems confusing and with unknown side-effects. I appreciate it's complicated by your example wanting to add CPU and EC - I know how much work you've been doing on the AMD CPU front which benefits all systems.

Another concern - would this mean that another driver could limit the options available? For instance if someone wrote a new 'mega-turbo' only profile driver and it loaded - it would then mean no profiles were available for anything as no profiles matched?

Let me know if I've misunderstood the architecture. I didn't fully get how the ASUS and Framework platforms were impacted in the intro I'm afraid.

Thanks!
Mark

