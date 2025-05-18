Return-Path: <linux-acpi+bounces-13785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED553ABB121
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D13A6B44
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3421D3F1;
	Sun, 18 May 2025 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="r2c/F5jb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540712CDBE;
	Sun, 18 May 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747590388; cv=none; b=awfaBus0A7cbtali/t4CGY12P+uOVyGRzxs2Lko6puZlUQBsl+tB9K001y0F553gXOwOyRpNm5uGtk3hFKzyiR5OrWqoXrDRzxFZYKMO0XIYN0NqVC2VnLQTznHpU4x1AXzrNwO6H7Nt9Uysh6KsMAt3J6tZ0N7DXy+18rSekgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747590388; c=relaxed/simple;
	bh=MKxU4FFxfUMYFM9K/j7LO/V4H/bEqGP/GAlCJy9CA3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX+Q1AO5OD6Nd2zn//OR1riE4196V0Nrtiee/8OHGT9RJ5m+6EVt8jOZoGa603l7noytaU8pXogO89jgP13kkKLkYNG3aNgBKfKBtjIVZmzYZrne0C4tO0HMTWyjp3LTZFvQ8AMq/co7qPXMPRljwkh0fQV7Q2MghcBK6CzzKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=r2c/F5jb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747590374; x=1748195174; i=w_armin@gmx.de;
	bh=I7IK5ECjWd9nplphgrQo+Hveys8NTa0a5CWuKNr3WNY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r2c/F5jbsYelKCYLI+11HjROL6xigNkAqxI6sWuZKVId6tUW5P7xdsgyKgCzEwk3
	 QBUToLHUtLCe7xynUUUIYPT+lNwh9oRMsQ4JB19tCZ5u5vJAKD8b0zsYg02S0hkmZ
	 76YKKagFYOtKzq5qPMz8AQGShkH7woqs7DG5IkoW7JhZxR54zKmYQTFIq0uavmhF6
	 Cf1Q7IzVY461qI0w34fgiZfd2WEea9324HBunTD4vj1UoP1Sw/gfBIA+MeINrWKix
	 8pLL/Q4UCE/lDrDeO91WzFCJWmxzr9JvvLMw0JsE8HupaAmbvmbXT0B5l07UByM5h
	 /wC1yuVM+NFe1GRWCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1uIst41q1I-007Bi0; Sun, 18
 May 2025 19:46:14 +0200
Message-ID: <79124489-0a2f-42ca-85ae-6f442e42e2d3@gmx.de>
Date: Sun, 18 May 2025 19:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
To: Janne Grunau <j@jannau.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Vishnu Sankar <vishnuocv@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
 <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
 <20250515230537.GA1556976@robin.jannau.net>
 <b3536162-44aa-40af-861e-07371497ef30@gmx.de>
 <20250518094353.GB1556976@robin.jannau.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250518094353.GB1556976@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5gw4QP79TBBrrzA6OPK9UqK46HbwUInur45ziCIq3oCeYHBTVv3
 tF3qeF3JkUwTt1FygSddpG6YzGcdHqADqtimR9EwsAvGCGnix7T0uw+alu7poM8NkGDtDZ6
 evzSNoxO5AESiFLY+nIVbNUGBUUqCj4195CGl665ok3ARFcW62O+lUwXExALbjgl4+d6zik
 Wh2RfLGAwlur4pCUPjTPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9iNik3bY4/0=;QHPEmVvfdQ8zjZVRXjSa5p+YhHs
 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

Am 18.05.25 um 11:43 schrieb Janne Grunau:

> Hej,
>
> On Sat, May 17, 2025 at 05:58:24PM +0200, Armin Wolf wrote:
>> Am 16.05.25 um 01:05 schrieb Janne Grunau:
>>
>>> On Fri, May 16, 2025 at 12:05:11AM +0200, Armin Wolf wrote:
>>>> Am 12.05.25 um 23:55 schrieb Janne Grunau via B4 Relay:
>>>>
>>>>> From: Janne Grunau <j@jannau.net>
>>>>>
>>>>> Commit 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 =
Kbd
>>>>> Fn keys") added a dependency on ACPI_PLATFORM_PROFILE to cycle throu=
gh
>>>>> power profiles. This breaks USB and Bluetooth keyboards on non-ACPI
>>>>> platforms since platform_profile_init() fails. See the warning below=
 for
>>>>> the visible symptom but cause is the dependency on the platform_prof=
ile
>>>>> module.
> [...]
>
>>>> i think we can fix that. We just have to skip the compat stuff if acp=
i_kobj is NULL (means that ACPI is not used).
>>>> The modern platform profile interface is generic enough to also work =
on non-ACPI systems.
>>>>
>>>> Can you test a patch?
>>> I can easily test patches
>> Nice, i attached the necessary patch. Please keep in mind that this pat=
ch is compile-tested only.
>>
>> From: Armin Wolf <W_Armin@gmx.de>
>> Date: Sat, 17 May 2025 17:45:09 +0200
>> Subject: [PATCH] ACPI: platform_profile: Add support for non-ACPI platf=
orms
>>
>> Currently the platform profile subsystem assumes that all supported
>> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
>> However some ARM64 notebooks do not support ACPI and are instead
>> using devicetree for booting.
>>
>> Do not register the legacy sysfs interface on such devices as it
>> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
>> are encouraged to use the new platform-profile class interface
>> instead.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/platform_profile.c | 68 ++++++++++++++++++++++++++------=
-
>>   1 file changed, 55 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
>> index ffbfd32f4cf1..c5a5da7d03f1 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -190,6 +190,20 @@ static ssize_t profile_show(struct device *dev,
>>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>>   }
>>  =20
>> +/**
>> + * profile_notify_legacy - Notify the legacy sysfs interface
>> + *
>> + * This wrapper takes care of only notifying the legacy sysfs interfac=
e
>> + * if it was registered during module initialization.
>> + */
>> +static void profile_notify_legacy(void)
>> +{
>> +	if (!acpi_kobj)
>> +		return;
>> +
>> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +}
>> +
>>   /**
>>    * profile_store - Set the profile for a class device
>>    * @dev: The device
>> @@ -215,7 +229,7 @@ static ssize_t profile_store(struct device *dev,
>>   			return ret;
>>   	}
>>  =20
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	profile_notify_legacy();
>>  =20
>>   	return count;
>>   }
>> @@ -435,7 +449,7 @@ static ssize_t platform_profile_store(struct kobjec=
t *kobj,
>>   			return ret;
>>   	}
>>  =20
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	profile_notify_legacy();
>>  =20
>>   	return count;
>>   }
>> @@ -472,6 +486,22 @@ static const struct attribute_group platform_profi=
le_group =3D {
>>   	.is_visible =3D profile_class_is_visible,
>>   };
>>  =20
>> +/**
>> + * profile_update_legacy - Update the legacy sysfs interface
>> + *
>> + * This wrapper takes care of only updating the legacy sysfs interface
>> + * if it was registered during module initialization.
>> + *
>> + * Return: 0 on success or error code on failure.
>> + */
>> +static int profile_update_legacy(void)
>> +{
>> +	if (!acpi_kobj)
>> +		return 0;
>> +
>> +	return sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +}
>> +
>>   /**
>>    * platform_profile_notify - Notify class device and legacy sysfs int=
erface
>>    * @dev: The class device
>> @@ -481,7 +511,7 @@ void platform_profile_notify(struct device *dev)
>>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
>>   		_notify_class_profile(dev, NULL);
>>   	}
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	profile_notify_legacy();
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>>  =20
>> @@ -529,7 +559,7 @@ int platform_profile_cycle(void)
>>   			return err;
>>   	}
>>  =20
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	profile_notify_legacy();
>>  =20
>>   	return 0;
>>   }
>> @@ -603,9 +633,9 @@ struct device *platform_profile_register(struct dev=
ice *dev, const char *name,
>>   		goto cleanup_ida;
>>   	}
>>  =20
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	profile_notify_legacy();
>>  =20
>> -	err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +	err =3D profile_update_legacy();
>>   	if (err)
>>   		goto cleanup_cur;
>>  =20
>> @@ -639,8 +669,8 @@ void platform_profile_remove(struct device *dev)
>>   	ida_free(&platform_profile_ida, pprof->minor);
>>   	device_unregister(&pprof->dev);
>>  =20
>> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -	sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +	profile_notify_legacy();
>> +	profile_update_legacy();
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>>  =20
>> @@ -692,16 +722,28 @@ static int __init platform_profile_init(void)
>>   	if (err)
>>   		return err;
>>  =20
>> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>> -	if (err)
>> -		class_unregister(&platform_profile_class);
>> +	/*
>> +	 * The ACPI kobject can be missing if ACPI was disabled during bootin=
g.
>> +	 * We thus skip the initialization of the legacy sysfs interface in s=
uch
>> +	 * cases to allow the platform profile class to work on ARM64 noteboo=
ks
>> +	 * without ACPI support.
> I wouldn't say work as I'd expect that there are 0 registered
> platform_profile class devices.

Just as expected, currently all drivers registering with the platform prof=
ile subsystem are
depending on ACPI. In the future this might change.

>> +	 */
>> +	if (acpi_kobj) {
>> +		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>> +		if (err < 0) {
>> +			class_unregister(&platform_profile_class);
>> +			return err;
>> +		}
>> +	}
>>  =20
>> -	return err;
>> +	return 0;
>>   }
>>  =20
>>   static void __exit platform_profile_exit(void)
>>   {
>> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +	if (acpi_kobj)
>> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +
>>   	class_unregister(&platform_profile_class);
>>   }
>>   module_init(platform_profile_init);
> thanks, patch works on the affected system and the HID device for the
> Lenovo keyboard probes successfully. We still need to stub
> platform_profile_cycle() to get rid of the ACPI Kconfig dependency. I'll
> send that out separately.
>
> Reviewed-by: Janne Grunau <j@jannau.net>
> Tested-by: Janne Grunau <j@jannau.net>
>
Alright, i will send this patch to the ACPI mailing list ASAP. Please keep=
 in mind
that merely stubbing out the affected functions is not enough, as the plat=
form profile code
needs to be moved out of drivers/acpi/ as well.

Thanks,
Armin Wolf


