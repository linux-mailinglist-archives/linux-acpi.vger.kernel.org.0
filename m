Return-Path: <linux-acpi+bounces-9007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFAA9B170F
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690D7B21F6B
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32411D095C;
	Sat, 26 Oct 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXKgIXbm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE551632D8
	for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938612; cv=none; b=bLxPSSM50JLnNrco3J9d28Cxd5j3diKdkRcia0+Nc1etjwSUf9sETLDl/Z6Wh0fHBvrWT49hTGOEnfB3boBiQzYvGkHayQFs2IgfaFDDtIBUNapNcBP19T8g9pIYsdM23iWtJ2N2SQAySw/GGMTpYUkqa40Cyj6FbgO36kOhYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938612; c=relaxed/simple;
	bh=NxOXEe0foHSAXrRFK0GPtB9fsfJ6AN2mC8K1jBY6tJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIzIw0uT8Ryl7fi3Oxd3wS7B/RSJyATzanXutm53+COsTzUCWK7lNGqB70NRymNWhqOPtWecoOF0WHI+eG2Hil6VpzfwZwOzILkZpXix+cbkCMjZHy0URjj5uSfKC7r8frYr0+xqxBkdL4wC1Nrl/m883/pn7C0AwUY0Qj2JO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXKgIXbm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729938608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eAcll/GbuhmxSQ0AC5//ynEg6Ydw9YGmEuIHqlE+MUI=;
	b=CXKgIXbmH1LOqfi64zABUl5axv5b6aikLbvPIlXec9v5wa1h4nLsl6cAg9H/77dMutu8pm
	oz5OClqEu6etutUoHqSeU11bAPRtNp+aaDi41INs2EmRVcayD7dPO+m4BEctJTMLMflwdv
	dN4ydxeKV248AdXCBtgWNpoABRTqeNs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-czbnqsmkOh-dc5KbUUjkow-1; Sat, 26 Oct 2024 06:30:06 -0400
X-MC-Unique: czbnqsmkOh-dc5KbUUjkow-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99cb787d2cso210818666b.2
        for <linux-acpi@vger.kernel.org>; Sat, 26 Oct 2024 03:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729938605; x=1730543405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAcll/GbuhmxSQ0AC5//ynEg6Ydw9YGmEuIHqlE+MUI=;
        b=bguvdc/SM30sog/dBxPcWT4hOzH5cg42pBDlrIiXw/awwX7/7rh/xvKQWgOEtlPx7x
         1YTBitGCgi9bqf6iHEMxWbwglFHeSVnyn2ohaOJGdx1ognVATSIzlN/kt3gAP3Yn+hcS
         cAr361ODYckru1Q8zxYYNcx45hH0n2gz4j/KZa4Pr0WmT48YjLOZQwwNqV48kMJCGhjW
         DS0EikheWAgUjANmn7pgvsMyt0h6NBJxTMq5KrBul6SVV6Dq7Di987jbWQAOxYwHRXW5
         6UMtLddZjYt+JbvG27oi8ppAAEU0kMK7TgXWQ2SqD5zO/uwA05Xd8tyU+lw++5PkNTGD
         V63Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbIvX1pNkVzKpwtTUQyO5j00Q4Jn/fX7uD3ME2/oOccv/6VDbrFs30Flfperr0F/JpIOegNRCfkcAo@vger.kernel.org
X-Gm-Message-State: AOJu0YzQluKUSR2wONQDp5pVVfEeCOTpD83ePDnX3poFNMM8tfZZ5e4P
	G4+6iL6X3iJkv5DO4WiSCwMDXelIc9UWFr7aIV90xYsodNMTDpTlQnpuemHGZarBGACNWi8jsZr
	M1um2vHcvE6UP3R1jYuOlRWKN7QeItfXfEwQKxeldOTW9UT+eiCHH9QLcITA=
X-Received: by 2002:a17:906:f5a3:b0:a9a:61d:7084 with SMTP id a640c23a62f3a-a9de615f82amr149980466b.50.1729938605390;
        Sat, 26 Oct 2024 03:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaiatCGjTBn7qZNMoQTinlg9kse4Dblmgk8YaMr/rZi1epzMBQ+2rYzED2AzoeAKDif3BHAg==
X-Received: by 2002:a17:906:f5a3:b0:a9a:61d:7084 with SMTP id a640c23a62f3a-a9de615f82amr149974966b.50.1729938604903;
        Sat, 26 Oct 2024 03:30:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0277b7sm161957966b.50.2024.10.26.03.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 03:30:03 -0700 (PDT)
Message-ID: <bcf83d6a-2e8d-4829-9c38-17459a2687ed@redhat.com>
Date: Sat, 26 Oct 2024 12:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple
 handlers
To: Mario Limonciello <mario.limonciello@amd.com>,
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
References: <20241025193055.2235-1-mario.limonciello@amd.com>
 <20241025193055.2235-8-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241025193055.2235-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mario,

On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
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
> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct device *dev,
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

Since only choices that are available in all registered handlers will be accepted,
should the output not be limited to only those choices ?

E.g.:

	unsigned long choices = 0;
	bool first = true;

	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
		list_for_each_entry(handler, &platform_profile_handler_list, list) {
			if (first) {
				choices = handler->choices;
				first = false;
			} else {
				choices &= handler->choices;
			}
		}
	}

	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
		if (len == 0)
			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
		else
			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
	}
  	len += sysfs_emit_at(buf, len, "\n");
  	return len;
}

?

Also this means that choices can change now as drivers get loaded /
removed. I believe that power-profiles-daemon matches has some hotplug
handling for the sysfs files showing up? How would that work with choices
changing ?

Or am I misremembering and does p-p-d simply assume all drivers are loaded
when it starts ?

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

Hmm this just goes with the platform returned by the last handler
called ?

Maybe compare results and log some warning if there are different
results between handlers ?

And maybe also:

1. New patch enforcing that all handlers must support plain balanced
at registration time.

2. Check that all handlers agree when a new handler gets registered
and if not then force all handlers to balanced, together with
a sysfs_notify() ?


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

Same issue as before, you are only saving the profile of the last handler called here,
which might even be a profile not supported by all handlers...

Might be easiest to just enforce all handlers support plain balanced
as I suggested above and then on errors revert all handlers to balanced.

This may seem like it is not nice to do, but errors should not happen
so I think this is ok. And if errors do happen then we need to fix
the errors :)

> +
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, i);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
> +				if (handler->profile_set(handler, profile))
> +					pr_err("Failed to revert profile for handler %s\n", handler->name);
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
> @@ -140,7 +148,8 @@ static const struct attribute_group platform_profile_group = {
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
> +		/* first pass, make sure all handlers agree on the definition of "next" profile */
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
> +				pr_warn("Next profile to cycle to is ambiguous between platform_profile handlers\n");
> +				return -EINVAL;
> +			}
> +			next = next2;
> +		}

Hmm, this seems complicated, I would suggest to factor out the code
to "and" together all the handler's choices which I suggested above
for platform_profile_choices_show() into a helper (with the locking
to be done by the caller) and then call that helper here to get
a choices which is the result if all the choices and-ed together and
simply call find_next_bit_wrap() on the resulting and-ed value ?

Ah I guess another issue is that the handlers may also differ on
which profile they return from handler->profile_get(), so same
issue as in platform_profile_show(). I think this requires
another factored out helper to get a single consistent profile
value for all handlers. Then this helper can be used both in
platform_profile_show() and here to get a "truth" value for the
current active profile and show that / use that as base to pick
the next value.

Note the above approach definitely is going to have issues
if handlers mismatch on which profiles are supported since
you do not skip choices which are only available in one of
the handlers.

> +
> +		/*
> +		 * Second pass: apply "next" to each handler
> +		 * If any failures occur unwind and revert all back to the original profile
> +		 */
> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			err = handler->profile_set(handler, next);
> +			if (err) {
> +				pr_err("Failed to set profile for handler %s\n", handler->name);
> +				break;
> +			}
> +		}
> +		if (err) {
> +			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
> +				err = handler->profile_set(handler, profile);

Same issue as before, profile contains the profile of the last handler
in the list only.


> +				if (err)
> +					pr_err("Failed to revert profile for handler %s\n", handler->name);
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
> @@ -190,21 +224,19 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
> @@ -215,7 +247,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
>  
>  	list_del(&pprof->list);
>  
> -	cur_profile = NULL;
>  	if (!platform_profile_is_registered())
>  		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  


Regards,

Hans



