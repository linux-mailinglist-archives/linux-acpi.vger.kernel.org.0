Return-Path: <linux-acpi+bounces-9009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AEC9B17E1
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 14:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2028A28252A
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2024 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE461D31A0;
	Sat, 26 Oct 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="J17BAxU7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B19217F3B;
	Sat, 26 Oct 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945073; cv=none; b=lsmNg3940R+FctIKRJL/ugu+eLiF5QawmQ7fqCtFQJVgRe8qWEkpaeRBqiGW/tNmDIHIMuXBCQ2yTNvHLUNoclj5W3kWqgDFxDkMBwFq4f9NmBXYeAXqcNxdkn/0nPYm8u1RB7/0DAabpewNTGHj4Gw0+8hEEvuVmvI5s3Az3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945073; c=relaxed/simple;
	bh=Ab2Xiose1NAtovMdfL6OU+552L9KDsgru/6OovBq8H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXbNgr7c5KtchKZRLH65lfws0JFvlykIF08oTti4AYGENefhWZ6HCL381XdDmGNX5guaKz8fqdirLf0TiOx1YPdPLv2d1pZwdtBvhvMOYz7rqNYl4Pnm7eEx7P6zux2Z1wGORPxYXj0UR5G3iiV73XO5Rf0YUCZL83BLsfDWPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=J17BAxU7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729944995; x=1730549795; i=w_armin@gmx.de;
	bh=OhBnA6UBWYUUTh2D7d0QXDqNx+XR7XGGT5oet3kUs3g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J17BAxU7YuwG0VXJLXWAp12f43QI+lUCYqCJTpKayykM8D0Zwt6FGlMNOhlyuwab
	 /qcBefneJkMooXWUZUfe5MAH5DYrhO6wioEL6wzo1XYTKkO4+uNZ2QPUCFufpBxYm
	 5WryGCRS0/FjbM5HDTSsHgY0JWjLhIaB7z3an91e83NGEgr5tvCUt+k5ywdY2EbaP
	 gNeGfLSI3oAPVgh7oV/1VCSLwfCThY5Hjr+7A1GAYLB2jWu5+U0LHbVhNa1K5yEC3
	 kCREYGaZaBq1mnEXPe70VlN+fsx4gQP+4NTuttMBW2QJZaScW/XE4InQGhE0plJ0y
	 QYWWsDdmOC5Tn353oQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1syJw336Gv-00FzgP; Sat, 26
 Oct 2024 14:16:34 +0200
Message-ID: <d33aaae0-8707-44e8-a6f5-e3144b9360e2@gmx.de>
Date: Sat, 26 Oct 2024 14:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] ACPI: platform_profile: Add support for multiple
 handlers
To: Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
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
 <bcf83d6a-2e8d-4829-9c38-17459a2687ed@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <bcf83d6a-2e8d-4829-9c38-17459a2687ed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DauJxE9Dd2sr551ci4stCKotjhJcwm/sK/DFskGJkktw7d+yPEc
 DRrfVYHR6UO5rkZNZkl4qF61EO9WOXBE186cVXwtdQd1cVlgFNGXH60nhmHvYMbIDLf8WHV
 cT3qnc8CGwlG+FNUQB5nuxv7NcXh/JBcOb5M37sUXIg+U9YJnlkBFQOg8ATe8uck0QJ2tUi
 rVSS8w89k/WqTaBQC2lSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YdDSgKxFFMk=;gGnIe6SnaJtVcWZj0Xi/CZm4UmK
 zeRamJ/viYIoBMUp+0IguHZ7HdNE9yxDNDS5LYCdtIVCaqMPro7ilTnneUUYHuSxyew0SnO3y
 HyIiiodQumyh1whz9kcj2Bbrds0JfGALiCPFLhBcPnJS2+92BFPKKhWRz7g3+1KkU+srPXrDX
 rO8kZQdXu7QF9dV3Ajwn9wEzwI9BZestYSd2JMFtwHOnWFqaVS4x4ya1465xF+68GGLEPhWr7
 4F3fQIXTblabXKrgwAbG8laUWBhlnhK8+vi7ZnwQ5FYFQgjQnCSu2TafbTgQx5UKVqGHttqZ1
 z2zRiFTEWIhfOBVEYSlxNmL5OHQdQZ9+ohfSZNs6nfJ6091+TduFzGZLUKgrsjHLJwKnEeSQI
 Iwvy7NeNUz5b+HKvHZ6zjWDk2HCxn3KJSD/50u/ToWaMUmWKcCRUktqsKBdey6zmZ7KRVbaXh
 ECrmKFsCSbviDgWLScT3AoiYf9L5d53G451mLNl4L24MNk2v1liOd5609JShP0+I2WN6CWJ9N
 EVA0dhQT9LqJZOtLyo//+ggZs/LjuJHrHzmSnrT9TUw7qr+wn2jFb9580oe6qwO86yVRdNC8s
 wOP1HSqOYBH83EqCfp1CY/pb7j0zte9rVR7laboQo2LYBmekcrChQf1+Xc/WUobiqgb8DQvUV
 VIV7n05NOurHXVD5i83VKW9p1MLNxI+zlS2gK9ODoMfpd10GdaImoRSuVWXOjgApgoiAyYa0w
 10EJqiOYKxVFK4ThoqaDtEiS+MPgAfEdRZsPkmcD5YDD3qVJko/fFEd4338OvVwBazRMGFZaj
 mekXIPjnbcRP4HqEAgdq4Jnw==

Am 26.10.24 um 12:30 schrieb Hans de Goede:

> Hi Mario,
>
> On 25-Oct-24 9:30 PM, Mario Limonciello wrote:
>> Multiple drivers may attempt to register platform profile handlers,
>> but only one may be registered and the behavior is non-deterministic
>> for which one wins.  It's mostly controlled by probing order.
>>
>> This can be problematic if one driver changes CPU settings and another
>> driver notifies the EC for changing fan curves.
>>
>> Modify the ACPI platform profile handler to let multiple drivers
>> register platform profile handlers and abstract this detail from usersp=
ace.
>>
>>  From userspace perspective the user will see profiles available across
>> both drivers.  However to avoid chaos only allow changing to profiles
>> that are common in both drivers.
>>
>> If any problems occur when changing profiles for any driver, then rever=
t
>> back to the previous profile.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 203 ++++++++++++++++++-------------=
-
>>   1 file changed, 117 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
>> index 091ca6941a925..915e3c49f0b5f 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -9,7 +9,6 @@
>>   #include <linux/platform_profile.h>
>>   #include <linux/sysfs.h>
>>
>> -static struct platform_profile_handler *cur_profile;
>>   static LIST_HEAD(platform_profile_handler_list);
>>   static DEFINE_MUTEX(profile_lock);
>>
>> @@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct=
 device *dev,
>>   					struct device_attribute *attr,
>>   					char *buf)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	unsigned long seen =3D 0;
>>   	int len =3D 0;
>> -	int err, i;
>> -
>> -	err =3D mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> +	int i;
>> +
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
>> +				if (seen & BIT(i))
>> +					continue;
>> +				if (len =3D=3D 0)
>> +					len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> +				else
>> +					len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> +				seen |=3D BIT(i);
>> +			}
>> +		}
>>   	}
> Since only choices that are available in all registered handlers will be=
 accepted,
> should the output not be limited to only those choices ?
>
> E.g.:
>
> 	unsigned long choices =3D 0;
> 	bool first =3D true;
>
> 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> 		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> 			if (first) {
> 				choices =3D handler->choices;
> 				first =3D false;
> 			} else {
> 				choices &=3D handler->choices;
> 			}
> 		}
> 	}
>
> 	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
> 		if (len =3D=3D 0)
> 			len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> 		else
> 			len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> 	}
>    	len +=3D sysfs_emit_at(buf, len, "\n");
>    	return len;
> }
>
> ?
>
> Also this means that choices can change now as drivers get loaded /
> removed. I believe that power-profiles-daemon matches has some hotplug
> handling for the sysfs files showing up? How would that work with choice=
s
> changing ?
>
> Or am I misremembering and does p-p-d simply assume all drivers are load=
ed
> when it starts ?

After a quick glance at the source code i think it basically assumes that =
the
sysfs file is present during startup if platform profiles are supported. I=
f the
sysfs file disappears afterwards, the code will simply return an error.

For handling changing choices, sending a poll notification using sysfs_not=
ify()
to the choices file will be the easiest solution.

>> @@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device =
*dev,
>>   					char *buf)
>>   {
>>   	enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
>> +	struct platform_profile_handler *handler;
>>   	int err;
>>
>> -	err =3D mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>>
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		if (!platform_profile_is_registered())
>> +			return -ENODEV;
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err =3D handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +		}
>>   	}
> Hmm this just goes with the platform returned by the last handler
> called ?
>
> Maybe compare results and log some warning if there are different
> results between handlers ?
>
> And maybe also:
>
> 1. New patch enforcing that all handlers must support plain balanced
> at registration time.
>
> 2. Check that all handlers agree when a new handler gets registered
> and if not then force all handlers to balanced, together with
> a sysfs_notify() ?

I begin to wonder why we even need the profile_get callback anyway. The dr=
ivers
are already required to:

	"NOT ... let userspace know about any sub-optimal conditions which are im=
peding
	 reaching the requested performance level."

So what exactly is the reason to read the platform profile from hardware?

>>
>> -	err =3D cur_profile->profile_get(cur_profile, &profile);
>> -	mutex_unlock(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>>   	/* Check that profile is valid index */
>>   	if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names)=
)))
>>   		return -EIO;
>> @@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device=
 *dev,
>>   			    struct device_attribute *attr,
>>   			    const char *buf, size_t count)
>>   {
>> +	struct platform_profile_handler *handler;
>> +	enum platform_profile_option profile;
>>   	int err, i;
>>
>> -	err =3D mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> -	}
>> -
>>   	/* Scan for a matching profile */
>>   	i =3D sysfs_match_string(profile_names, buf);
>>   	if (i < 0) {
>> -		mutex_unlock(&profile_lock);
>>   		return -EINVAL;
>>   	}
>>
>> -	/* Check that platform supports this profile choice */
>> -	if (!test_bit(i, cur_profile->choices)) {
>> -		mutex_unlock(&profile_lock);
>> -		return -EOPNOTSUPP;
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		if (!platform_profile_is_registered())
>> +			return -ENODEV;
>> +
>> +		/* Check that all handlers support this profile choice */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			if (!test_bit(i, handler->choices))
>> +				return -EOPNOTSUPP;
>> +
>> +			/* save the profile so that it can be reverted if necessary */
>> +			err =3D handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +		}
> Same issue as before, you are only saving the profile of the last handle=
r called here,
> which might even be a profile not supported by all handlers...
>
> Might be easiest to just enforce all handlers support plain balanced
> as I suggested above and then on errors revert all handlers to balanced.
>
> This may seem like it is not nice to do, but errors should not happen
> so I think this is ok. And if errors do happen then we need to fix
> the errors :)
>
>> +
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err =3D handler->profile_set(handler, i);
>> +			if (err) {
>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>> +				break;
>> +			}
>> +		}
>> +		if (err) {
>> +			list_for_each_entry_continue_reverse(handler, &platform_profile_han=
dler_list, list) {
>> +				if (handler->profile_set(handler, profile))
>> +					pr_err("Failed to revert profile for handler %s\n", handler->name=
);
>> +			}
>> +			return err;
>> +		}
>>   	}
>>
>> -	err =3D cur_profile->profile_set(cur_profile, i);
>> -	if (!err)
>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -
>> -	mutex_unlock(&profile_lock);
>> -	if (err)
>> -		return err;
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>   	return count;
>>   }
>>
>> @@ -140,7 +148,8 @@ static const struct attribute_group platform_profil=
e_group =3D {
>>
>>   void platform_profile_notify(void)
>>   {
>> -	if (!cur_profile)
>> +	guard(mutex)(&profile_lock);
>> +	if (!platform_profile_is_registered())
>>   		return;
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>   }
>> @@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>
>>   int platform_profile_cycle(void)
>>   {
>> +	struct platform_profile_handler *handler;
>>   	enum platform_profile_option profile;
>> -	enum platform_profile_option next;
>> +	enum platform_profile_option next =3D PLATFORM_PROFILE_LAST;
>> +	enum platform_profile_option next2 =3D PLATFORM_PROFILE_LAST;
>>   	int err;
>>
>> -	err =3D mutex_lock_interruptible(&profile_lock);
>> -	if (err)
>> -		return err;
>> -
>> -	if (!cur_profile) {
>> -		mutex_unlock(&profile_lock);
>> -		return -ENODEV;
>> -	}
>> -
>> -	err =3D cur_profile->profile_get(cur_profile, &profile);
>> -	if (err) {
>> -		mutex_unlock(&profile_lock);
>> -		return err;
>> -	}
>> -
>> -	next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
>> -				  profile + 1);
>> -
>> -	if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST)) {
>> -		mutex_unlock(&profile_lock);
>> -		return -EINVAL;
>> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +		/* first pass, make sure all handlers agree on the definition of "ne=
xt" profile */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +
>> +			err =3D handler->profile_get(handler, &profile);
>> +			if (err)
>> +				return err;
>> +
>> +			if (next =3D=3D PLATFORM_PROFILE_LAST)
>> +				next =3D find_next_bit_wrap(handler->choices,
>> +							  PLATFORM_PROFILE_LAST,
>> +							  profile + 1);
>> +			else
>> +				next2 =3D find_next_bit_wrap(handler->choices,
>> +							   PLATFORM_PROFILE_LAST,
>> +							   profile + 1);
>> +
>> +			if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST))
>> +				return -EINVAL;
>> +
>> +			if (next2 =3D=3D PLATFORM_PROFILE_LAST)
>> +				continue;
>> +
>> +			if (next !=3D next2) {
>> +				pr_warn("Next profile to cycle to is ambiguous between platform_pr=
ofile handlers\n");
>> +				return -EINVAL;
>> +			}
>> +			next =3D next2;
>> +		}
> Hmm, this seems complicated, I would suggest to factor out the code
> to "and" together all the handler's choices which I suggested above
> for platform_profile_choices_show() into a helper (with the locking
> to be done by the caller) and then call that helper here to get
> a choices which is the result if all the choices and-ed together and
> simply call find_next_bit_wrap() on the resulting and-ed value ?
>
> Ah I guess another issue is that the handlers may also differ on
> which profile they return from handler->profile_get(), so same
> issue as in platform_profile_show(). I think this requires
> another factored out helper to get a single consistent profile
> value for all handlers. Then this helper can be used both in
> platform_profile_show() and here to get a "truth" value for the
> current active profile and show that / use that as base to pick
> the next value.
>
> Note the above approach definitely is going to have issues
> if handlers mismatch on which profiles are supported since
> you do not skip choices which are only available in one of
> the handlers.
>
>> +
>> +		/*
>> +		 * Second pass: apply "next" to each handler
>> +		 * If any failures occur unwind and revert all back to the original =
profile
>> +		 */
>> +		list_for_each_entry(handler, &platform_profile_handler_list, list) {
>> +			err =3D handler->profile_set(handler, next);
>> +			if (err) {
>> +				pr_err("Failed to set profile for handler %s\n", handler->name);
>> +				break;
>> +			}
>> +		}
>> +		if (err) {
>> +			list_for_each_entry_continue_reverse(handler, &platform_profile_han=
dler_list, list) {
>> +				err =3D handler->profile_set(handler, profile);
> Same issue as before, profile contains the profile of the last handler
> in the list only.
>
>
>> +				if (err)
>> +					pr_err("Failed to revert profile for handler %s\n", handler->name=
);
>> +			}
>> +		}
>>   	}
>>
>> -	err =3D cur_profile->profile_set(cur_profile, next);
>> -	mutex_unlock(&profile_lock);
>> -
>> -	if (!err)
>> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>> -	return err;
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>
>> @@ -190,21 +224,19 @@ int platform_profile_register(struct platform_pro=
file_handler *pprof)
>>   	int err;
>>
>>   	guard(mutex)(&profile_lock);
>> -	/* We can only have one active profile */
>> -	if (cur_profile)
>> -		return -EEXIST;
>>
>>   	/* Sanity check the profile handler field are set */
>>   	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>>   		!pprof->profile_set || !pprof->profile_get)
>>   		return -EINVAL;
>>
>> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>> -	if (err)
>> -		return err;
>> +	if (!platform_profile_is_registered()) {
>> +		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +		if (err)
>> +			return err;
>> +	}
>>   	list_add_tail(&pprof->list, &platform_profile_handler_list);
>>
>> -	cur_profile =3D pprof;
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_register);
>> @@ -215,7 +247,6 @@ int platform_profile_remove(struct platform_profile=
_handler *pprof)
>>
>>   	list_del(&pprof->list);
>>
>> -	cur_profile =3D NULL;
>>   	if (!platform_profile_is_registered())
>>   		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>>
>
> Regards,
>
> Hans
>
>
>

