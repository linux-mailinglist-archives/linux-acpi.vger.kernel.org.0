Return-Path: <linux-acpi+bounces-9362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770399BF619
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B2228409C
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA57F20721C;
	Wed,  6 Nov 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Fi8yQtHD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6492010EC;
	Wed,  6 Nov 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920615; cv=none; b=YQu/nZciYLoaitgXGjcWy5BZuZHr3uKTDtF0hHfMeQWQI8rpzHD3wuUWY3dasLaCpIPnZXC6HOzBNyqXRKTTI6/Mi9N+mEadKkM2Y16TNLs39s8nO6mP95lm0KpM7rxJvvyVwCT6l4LKBw5brPB+KXJUdkh5B+QCfZieCeqTAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920615; c=relaxed/simple;
	bh=45IBkLdgPom9EszYKHRj8rzKHuzELQT3qobEO5iN7lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoAHXkzMS9rWpvFfIGZB5Katul8/Un+XgCy76Q0ZA1IjhOTllFyb6FBCYLSqeemS9nP1UorQ4xdXirSw6JUG8fhKZr7U+78cBg1GwiBTn6sgPYbZpl6C6pnG/R3p1ULMc208l0HkyjPOupHJDQOSALBhgMa5KCmbEHa78bsOngE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Fi8yQtHD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730920542; x=1731525342; i=w_armin@gmx.de;
	bh=45IBkLdgPom9EszYKHRj8rzKHuzELQT3qobEO5iN7lY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fi8yQtHD99Hr5oXDWrpT0/IkwH6hxXAy8jSGFRee5WvvLmBK/SZAD27+kV+cASve
	 FRjbELWGqF8bm6zOsRKxkBKZhXZOs3yc7pOf0OHYiJHZxxxeE/XZfQORoar3aIeoM
	 87ez2105xj3Wctwkg6KufqrHUJNASE56vDgvKZtemjp43FLk/CQnJy3nqmnGzWHn6
	 QlMb0J9YUmzhUWKcdYH8lXUh2VCJP0ft3ps8EoOH4bu+wK742d63B5+3U+G/Fn95Q
	 zgDObTFofY5rkyK81sgI7+kVEmWvO04HP/tTdQKF3d9GgvDTg++O/educs7vAbC+c
	 L5BjME7vJ50M3SyLCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1tJCwm2FcQ-00VkMb; Wed, 06
 Nov 2024 20:15:42 +0100
Message-ID: <9035b49c-d276-484c-9eb0-a4a5c0f62bc8@gmx.de>
Date: Wed, 6 Nov 2024 20:15:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/20] ACPI: platform_profile: Add profile attribute
 for class interface
To: Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
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
 <a40ef9a8-0589-4070-921e-f3461fa6759c@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <a40ef9a8-0589-4070-921e-f3461fa6759c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Ph9JVeiXOJ6dPyBPkko9/eP3ZzDIzfHDRdc/BDPzWiOU4uQu4/
 cfSpxs8bjkViC73B6AbKS6+nxerecul8iy+K5fKXYosJKEJAP7pgiACLBOONYdq/HkQXPvG
 cmnOKbIK28TzIARt/LbWB8IT7TS9HPCTMYzISD8/TziwaEL2W0kPDeBgjNn5NO5I8ZZfBRV
 B8kxoTpZbz/X9sXd1UknQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h7//S2SCueo=;iU7Xr3rkHgTgKaYh7KGohRyt0Tf
 DY+d3kc1q4PA0IBN4N6tk3JeBaSCFB5qe21meyuq+7DKdrvGvP9UpDFKBDth5PDLbZbJ5YW+u
 lkbJ4tXZ1V6m91tWV0+b9TWMuAxvxBQC4u9pXZ0qV86SyVKWc+wCmv7U34WVm4nYBEn8cnTss
 iv7qv91OjZnS27MWUb3QXPt9heA5qC8QC8erRrUR7aKHcGAWVnSPoou6cx+TMjyLkFQXIsXfk
 19/Aq0EyoNUm3pkZKOkELYm++o1NO9TegSMb3m863fF5NQl6L5NGKwaL0TWxrNPXf1OpMKSFU
 e08kEuY0OGiQqvCKce5qS3zCo3t/7iw1K+flh7grGtPTwahI5iFmFXmAIS6yiqDlpXfemmnG2
 eRmLi08yuks1/y2Aor1OwCOa16tD5M7wla3xmIOPfA4AFKKOZkfns7Gbtg9hgUroqMTLz6H2h
 fYlj94MYVi7htTbYBWYZwkdQhpvfEVFh5EUIJZMegycxYc+uAfLk9gwAtBkz1oOh4EOb5kAqj
 pbgL7r9oCyxgWNVhNs8nhC6unnHl8n9uJO61u4TF9wztGdFor7zZK8oz/QaaYtsXV8xZQlJYZ
 Yxl7JBBdj2PgTYnRDIsKhxqN0ncwE0Y8gzZyDlN6wudF+Dc0nUSS8pEE2b9eQxPWSRlica8Cn
 MNGkIOtTUFL/A+r/OZ5171Vf/oFcdrAWpMR9RFP3scoWjFwgFEu42Su9Q5lOockDStRBZQ0WB
 RErTUIC1ZNhkIHGXDsvKfnpB2eKaBe9YiB1J/VBxYmfZEqJ2CkdQTaHiUz+4uASSkOOwl1ejE
 x6k5OOZswptcj3Z3FPKMnRWzEvKRssl2B/QeNR/UFF1km07Da4zgrdBDQtv166UUcqIJg680J
 mpnQA1SWIWh8gIGD7S+gCUiUrkFuK0NSpVm+2NBMqdmXENXAqh5Tv0/Ft

Am 06.11.24 um 06:46 schrieb Mario Limonciello:

>
>
> On 11/5/24 22:10, Armin Wolf wrote:
>> Am 05.11.24 um 16:33 schrieb Mario Limonciello:
>>
>>> Reading and writing the `profile` sysfs file will use the callbacks fo=
r
>>> the platform profile handler to read or set the given profile.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> =C2=A0 drivers/acpi/platform_profile.c | 118
>>> ++++++++++++++++++++++++++++++++
>>> =C2=A0 1 file changed, 118 insertions(+)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/
>>> platform_profile.c
>>> index e1b6569c4ee70..79083d0bb22e3 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -65,6 +65,78 @@ static int _get_class_choices(struct device *dev,
>>> unsigned long *choices)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +/**
>>> + * _store_class_profile - Set the profile for a class device
>>> + * @dev: The class device
>>> + * @data: The profile to set
>>> + */
>>> +static int _store_class_profile(struct device *dev, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long choices;
>>> +=C2=A0=C2=A0=C2=A0 int *i =3D (int *)data;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D _get_class_choices(dev, &choices);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct platform_profile_ha=
ndler *handler;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(*i, &choices=
))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EOPNOTSUPP;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdat=
a(dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D handler->profile_g=
et(handler, &profile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D handler->profile_s=
et(handler, *i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t recover_err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "Failed to set profile: %d\n", err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
cover_err =3D handler->profile_set(handler, profile);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (recover_err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to reset profile: %d\n",
>>> recover_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The whole recovery handling seems unnecessary to me. In setting the
>> platform profile fails, then
>> we should just return an error. The platform profile handler will
>> tell us the current platform
>> profile anyway.
>
> Sure, makes sense.=C2=A0 That also means no need to capture the profile
> before setting it.
>
>>
>>> + sysfs_notify(&handler->class_dev->kobj, NULL, "platform_profile");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kobject_uevent(&handler->c=
lass_dev->kobj, KOBJ_CHANGE);
>>
>> Please avoid sending those events when the platform profile is
>> changed through the class sysfs interface.
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysfs_notify(acpi_kobj, NULL, "platform_profile");
>>
>> Please avoid sending this event when the platform profile is changed
>> through the legacy sysfs interface.
>
> In both above cases - why?
>
> * If I change using class interface then that implicitly means that
> legacy interface changes.
> * If I change using legacy interface that implicitly means class
> interface changes too.
>
I meant that:
- if the profile is changed using the class interface then only the legacy=
 interface should be notified
- if the profile is changed using the legacy interface then only the class=
 interface should be notified

Thanks,
Armin Wolf

>>
>>> +=C2=A0=C2=A0=C2=A0 return err ? err : 0;
>>> +}
>>> +
>>> +/**
>>> + * get_class_profile - Show the current profile for a class device
>>> + * @dev: The class device
>>> + * @profile: The profile to return
>>> + * Return: 0 on success, -errno on failure
>>> + */
>>> +static int get_class_profile(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct platform_profile_handler *handler;
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option val;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>> &profile_lock) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handler =3D dev_get_drvdat=
a(dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D handler->profile_g=
et(handler, &val);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
_err("Failed to get profile for handler %s\n",
>>> handler- >name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 *profile =3D val;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>>
>>> =C2=A0 /**
>>> =C2=A0=C2=A0 * name_show - Show the name of the profile handler
>>> @@ -102,12 +174,58 @@ static ssize_t choices_show(struct device *dev,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return _commmon_choices_show(choices, b=
uf);
>>> =C2=A0 }
>>>
>>> +/**
>>> + * profile_show - Show the current profile for a class device
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to write to
>>> + * Return: The number of bytes written
>>> + */
>>> +static ssize_t profile_show(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char *buf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile =3D PLATFORM_=
PROFILE_LAST;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 err =3D get_class_profile(dev, &profile);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\n", profile_names[profi=
le]);
>>> +}
>>> +
>>> +/**
>>> + * profile_store - Set the profile for a class device
>>> + * @dev: The device
>>> + * @attr: The attribute
>>> + * @buf: The buffer to read from
>>> + * @count: The number of bytes to read
>>> + * Return: The number of bytes read
>>> + */
>>> +static ssize_t profile_store(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i, ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 i =3D sysfs_match_string(profile_names, buf);
>>> +=C2=A0=C2=A0=C2=A0 if (i < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D _store_class_profile(dev, (void *)(long)&i=
);
>>
>> Please just pass &i.
>
> Ack.
>
>>
>> Thanks,
>> Armin Wolf
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ret ? ret : count;
>>> +}
>>>
>>> =C2=A0 static DEVICE_ATTR_RO(name);
>>> =C2=A0 static DEVICE_ATTR_RO(choices);
>>> +static DEVICE_ATTR_RW(profile);
>>> +
>>> =C2=A0 static struct attribute *profile_attrs[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_name.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &dev_attr_choices.attr,
>>> +=C2=A0=C2=A0=C2=A0 &dev_attr_profile.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>>> =C2=A0 };
>>> =C2=A0 ATTRIBUTE_GROUPS(profile);
>>
>

