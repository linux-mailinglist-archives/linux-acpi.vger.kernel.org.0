Return-Path: <linux-acpi+bounces-13847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE900AC035E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 06:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976AD9455DB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EC13C3C2;
	Thu, 22 May 2025 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XtS+lnhu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582051754B;
	Thu, 22 May 2025 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747888479; cv=none; b=Dko5ux9BKefqrvxZhjeJQRdfmT453CvtDyFJaqSc8eFWANwOnZJ7nEix+xbJQJBiTqKIedj2qYHBgupmjDxBwyEcz2+uSlhVggUA+Ww5cIO9SG3PUJoyuRrd5yAJ12CvfRd3JI0BG+2ECisGgSmnUowaZQ/u55AhCQCests4q9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747888479; c=relaxed/simple;
	bh=+MAbHI6nKFmeUN70mQufBzxvpMfwhpLjVumeLrGJOoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMNJ1GK41NuApMnudFhGTFXEE3oDd5jynz9I3yYTIWO6rWvTTFzaOxLQekd6VbYZcePv32Mcne/UtZ1wfLC3d1H58NfORDLnwrwLjYDcdGsq3ekKMzxidLvSduzR6/c6trEaCuPTNokKToGNZfA/fdy+CWxlu0jvkT2X9G6ljwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XtS+lnhu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747888474; x=1748493274; i=w_armin@gmx.de;
	bh=7S9zDix78zdIHYEeVE26+vKjzjcXgCv6jfO4FBk30B8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XtS+lnhuZ03FzBITEYG3B+FC/bsTyc4rFbQ5ZmpGR9BF8zP1qd9enxl9BbcBNqcb
	 W4nqE6ZViLdvEX+hFpzxuORrxcQ1OVPTttR2yVsiNvyh5oGZP0tAmisay30u9jAXX
	 Zd/3lUun7djRP6nvK0gVYVFEcxzjpGbWYgUFQBD9OruMY3E4/xsfTncTrEBByt4lE
	 2XBYZig0SDjpXvGAfvXWA9gzAsrCkuWiNRvz8ouEuCeHIAAbCaZFzzzyuPQSZo7Bc
	 zOWIcWlo2xYupiM6jN2xPB6a3QVE6SbBncd1xsNRMyBRpEJUiq5+Jq/+idLMLJkQA
	 EEOIbfc9MO8NCBbGxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1u664q3zUD-001c53; Thu, 22
 May 2025 06:34:34 +0200
Message-ID: <a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de>
Date: Thu, 22 May 2025 06:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI
 platforms
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, j@jannau.net, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250518185111.3560-1-W_Armin@gmx.de>
 <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lsz04gt4JN4aL9AwrQjEXmCup17Dka+frZ+12hLASA9LBupKlwf
 r7dIk2/H46ukLM87mvjXjNacZ4rDpo1/UYytn2VwzOy2hOM9uTDUdD7wNJDEOYA5eTo6OdR
 d6N8jMJKoB7P4+XFyNV8acEPJgLfJco8dp1asgVJJJSLMPDZZBwits4Uy3hzJ0nZjCLiILx
 xPlGIF0p/2ifGX26gFMBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uvk8Im9ek/M=;kozBUdOolWCeEkOzCk9nzvVX3Wg
 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

Am 21.05.25 um 22:17 schrieb Rafael J. Wysocki:

> On Sun, May 18, 2025 at 8:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Currently the platform profile subsystem assumes that all supported
>> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
>> However some ARM64 notebooks do not support ACPI and are instead
>> using devicetree for booting.
>>
>> Do not register the legacy sysfs interface on such devices as it
>> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
>> are encouraged to use the new platform-profile class interface
>> instead.
> So how does it work in this case?
>
The platform profile subsystem also exposes a more modern class-based sysf=
s interface,
see Documentation/ABI/testing/sysfs-class-platform-profile for details.

This interface does not depend on /sys/firmware/acpi being present, so use=
rspace
programs can still control the platform profiles using the class-based int=
erface.

This will become very important once we have platform profile drivers not =
depending on
some sort of ACPI interface. I suspect that sooner or later some drivers f=
or the embedded
controllers on ARM64 notebooks (devicetree!) will register with the platfo=
rm profile subsystem.

Apart from that this allows input drivers using platform_profile_cycle() t=
o work on non-ACPI
platforms (like ARm64 devices using devicetree).

Thanks,
Armin Wolf

>> Reviewed-by: Janne Grunau <j@jannau.net>
>> Tested-by: Janne Grunau <j@jannau.net>
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
>>          return sysfs_emit(buf, "%s\n", profile_names[profile]);
>>   }
>>
>> +/**
>> + * profile_notify_legacy - Notify the legacy sysfs interface
>> + *
>> + * This wrapper takes care of only notifying the legacy sysfs interfac=
e
>> + * if it was registered during module initialization.
>> + */
>> +static void profile_notify_legacy(void)
>> +{
>> +       if (!acpi_kobj)
>> +               return;
>> +
>> +       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +}
>> +
>>   /**
>>    * profile_store - Set the profile for a class device
>>    * @dev: The device
>> @@ -215,7 +229,7 @@ static ssize_t profile_store(struct device *dev,
>>                          return ret;
>>          }
>>
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +       profile_notify_legacy();
>>
>>          return count;
>>   }
>> @@ -435,7 +449,7 @@ static ssize_t platform_profile_store(struct kobjec=
t *kobj,
>>                          return ret;
>>          }
>>
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +       profile_notify_legacy();
>>
>>          return count;
>>   }
>> @@ -472,6 +486,22 @@ static const struct attribute_group platform_profi=
le_group =3D {
>>          .is_visible =3D profile_class_is_visible,
>>   };
>>
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
>> +       if (!acpi_kobj)
>> +               return 0;
>> +
>> +       return sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +}
>> +
>>   /**
>>    * platform_profile_notify - Notify class device and legacy sysfs int=
erface
>>    * @dev: The class device
>> @@ -481,7 +511,7 @@ void platform_profile_notify(struct device *dev)
>>          scoped_cond_guard(mutex_intr, return, &profile_lock) {
>>                  _notify_class_profile(dev, NULL);
>>          }
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +       profile_notify_legacy();
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>>
>> @@ -529,7 +559,7 @@ int platform_profile_cycle(void)
>>                          return err;
>>          }
>>
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +       profile_notify_legacy();
>>
>>          return 0;
>>   }
>> @@ -603,9 +633,9 @@ struct device *platform_profile_register(struct dev=
ice *dev, const char *name,
>>                  goto cleanup_ida;
>>          }
>>
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +       profile_notify_legacy();
>>
>> -       err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +       err =3D profile_update_legacy();
>>          if (err)
>>                  goto cleanup_cur;
>>
>> @@ -639,8 +669,8 @@ void platform_profile_remove(struct device *dev)
>>          ida_free(&platform_profile_ida, pprof->minor);
>>          device_unregister(&pprof->dev);
>>
>> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -       sysfs_update_group(acpi_kobj, &platform_profile_group);
>> +       profile_notify_legacy();
>> +       profile_update_legacy();
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>>
>> @@ -692,16 +722,28 @@ static int __init platform_profile_init(void)
>>          if (err)
>>                  return err;
>>
>> -       err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
>> -       if (err)
>> -               class_unregister(&platform_profile_class);
>> +       /*
>> +        * The ACPI kobject can be missing if ACPI was disabled during =
booting.
>> +        * We thus skip the initialization of the legacy sysfs interfac=
e in such
>> +        * cases to allow the platform profile class to work on ARM64 n=
otebooks
>> +        * without ACPI support.
>> +        */
>> +       if (acpi_kobj) {
>> +               err =3D sysfs_create_group(acpi_kobj, &platform_profile=
_group);
>> +               if (err < 0) {
>> +                       class_unregister(&platform_profile_class);
>> +                       return err;
>> +               }
>> +       }
>>
>> -       return err;
>> +       return 0;
>>   }
>>
>>   static void __exit platform_profile_exit(void)
>>   {
>> -       sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +       if (acpi_kobj)
>> +               sysfs_remove_group(acpi_kobj, &platform_profile_group);
>> +
>>          class_unregister(&platform_profile_class);
>>   }
>>   module_init(platform_profile_init);
>> --
>> 2.39.5
>>
>>

