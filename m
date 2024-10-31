Return-Path: <linux-acpi+bounces-9208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA499B84C1
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37AA1F25EA3
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 20:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAD1CC897;
	Thu, 31 Oct 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Wx4K0Qzo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7181CC88C;
	Thu, 31 Oct 2024 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408243; cv=none; b=PI0ZGcjGgnPvSjwcnfB1W+f6FmruvMcwLWaHSP/bb5D34olBzbrK5++h0trZiW5+rrwZ3vIIbhIvaYa9TJ9WiIDiWtjHP+xv3LTOdng/IXAHoCRRXQehkO6CBztPEokYieV2ZU5hAkWHImR01WfUP+NPidYUZ4a7Oe3moAi9hqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408243; c=relaxed/simple;
	bh=QgbSe05f+ATEfG8KM30/iC/kH3Z1TSyBeQwG7cSj8Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgsmTGYkA3kTwduPc20+N3P5TOUq8eNdX7Gi08Dld/qzrv5XaxAsic/AoTI5GYYYaX2ArGfwn7Q/22WySeMMnQu+yA5erT65ngt69i87kpIqnOy3nxgH2M5dKZqW6/uDotiyJFHVajvh3wYzeIf9n3f4ZaCodvR+qBgMdJ5o08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Wx4K0Qzo; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730408163; x=1731012963; i=w_armin@gmx.de;
	bh=P4uDQWrodIz2gl730ysQ/mtbqQ2/NQw4r8MOFCBC0zw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wx4K0QzoE45FgTZ0wWkozSHHwKOBmKtYaOYDS7FLiEx/rHr5VA0HxGBT4Nlur/yc
	 71Q7cheKaNMY4twA4ouIek6JBElw0TS4Ql0ImbhTfGi9qvHZlh7hZg4hdwU1v78Jl
	 QHR/PCCTbz2XQKITGg2TO2vJs2jho9N8JxZO4cEtPz5vBLWLVYUPlg620ZNPSlX+r
	 KlxBV4SRaM6nmbvJ2YUsyj85mja2WEVzLTik1+Pat4Da0W3byE/ovuYAlVnVLt2I5
	 A2mtkxizc6FFNAs/2Flex2tKdP/hjkl7nNSH7bJnh0MMbXKSfIoNFtfNKMMXKLWRt
	 1DBAleBgyv6pemaehA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1tglqJ1MLU-00fuiy; Thu, 31
 Oct 2024 21:56:03 +0100
Message-ID: <9fdcfdb4-bbdd-4f6a-9a69-73dceac7b14b@gmx.de>
Date: Thu, 31 Oct 2024 21:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/22] ACPI: platform_profile: Register class device
 for platform profile handlers
To: Mario Limonciello <mario.limonciello@amd.com>,
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
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-21-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241031040952.109057-21-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HUGvg3BSIktPNY0AM823fcuE7w7XZEIY4m2FaPR6+cmAYWEI8z8
 eEzUydwAMi5wfzDi1tt1f5Sza3kb+zAPMUjksn41u/5I126vDhWlbqkkDos4oISP4VVJHAJ
 XTgFdxOUr8HcqUUKufyBS/s9555glhCnVico66dRTYbB5SSjsT4TbAJ8JTDv4YZTgjKfXEr
 aYRn9MTxtsz6NhWG38sVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PJR475ov+SI=;AQQnA4pBdgULPm7RTkSBdLQ6MwI
 boRlOagFvlRkx8Gv8US6dY1RKwu3FpTdl0xuH5YWD+mUDUN66iVa/dBPdlZXkp9tzKDnRy+eM
 ndFj0mbwH93F1wxHUbh56XM8MicCizjp2rqXhGp68pxwyVGS73psIFcm4BDOYSe+K1uqKzNZp
 9t/0S0q7HdiAb86hZ/X4ml7SCc0SQ4o7BzR1evma0WrmQl6lNX52kT0Fb1s2y7jaYs+ZgB9Jh
 tlXsL9XORe1VOvy3pQ5MP3nRhVRENhfdeGBFQAgUFHEpbRRUq+PLYfhGCFtLfgCUaoZO8vvPt
 4ZFQQwBPaonN+YOOezvxH73H03V8DWYrjNYzPzioF6Ut746ijbmGqFLG81O50+H5tJPvqTLXX
 4DgFotd90vQ7mbcUJY4Wf8z7nsgzZ513kJEPj0nH30jp/NCM15MreCUPTS4v9ejXb2a2u7VbI
 UAyTFE2XBTNmgPecqBHNMWawfh+H2POlwWQvcOY2mu5LXv176w8fm8YSarMSW6sPLljFYFrRN
 4ugjccbYkR2tNyPYnONkG+HYahZ1EV5eW2vGnmyrPYdkG6YYcqz5cxAfs/7Dme1OK0q+m1sKb
 f+inEDBDfCGc0N1OqIH2kY3Fbfoh39VRpdIW/RHWwwjqDUhJPXmQ1+vDcy+FDtLtS39KIqEXo
 g0kJwVRCgWFFSaPddrwL2i09zKPr382ZhZzz2SHWBwAoTVMaErjRQ3axci5CEwMF2WMUy57Gm
 UaF0aD24PkpoBIlnZPlxXCcffCIZ77dpjqlBO4XXHqmt1CtgscuYsxhrXhNw9ld10rjiTBeiF
 QV7IvY9gLoeyyCqDO9K46D2eL5YItzxEHfGEkPqdTG+VU=

Am 31.10.24 um 05:09 schrieb Mario Limonciello:

> The "platform_profile" class device has the exact same semantics as the
> platform profile files in /sys/firmware/acpi/ but it reflects values onl=
y
> present for a single platform profile handler.
>
> The expectation is that legacy userspace can change the profile for all
> handlers in /sys/firmware/acpi/platform_profile and can change it for
> individual handlers by /sys/class/platform_profile/*.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c  | 93 ++++++++++++++++++++++++++++----
>   include/linux/platform_profile.h |  2 +
>   2 files changed, 85 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 9b681884ae324..1cc8182930dde 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -24,13 +24,24 @@ static const char * const profile_names[] =3D {
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
>
> +static DEFINE_IDR(platform_profile_minor_idr);
> +
> +static const struct class platform_profile_class =3D {
> +	.name =3D "platform-profile",
> +};
> +
>   static bool platform_profile_is_registered(void)
>   {
>   	lockdep_assert_held(&profile_lock);
>   	return !list_empty(&platform_profile_handler_list);
>   }
>
> -static unsigned long platform_profile_get_choices(void)
> +static bool platform_profile_is_class_device(struct device *dev)
> +{
> +	return dev && dev->class =3D=3D &platform_profile_class;
> +}
> +
> +static unsigned long platform_profile_get_choices(struct device *dev)
>   {
>   	struct platform_profile_handler *handler;
>   	unsigned long aggregate =3D 0;
> @@ -40,6 +51,9 @@ static unsigned long platform_profile_get_choices(void=
)
>   	list_for_each_entry(handler, &platform_profile_handler_list, list) {
>   		unsigned long individual =3D 0;
>
> +		/* if called from a class attribute then only match that one */
> +		if (platform_profile_is_class_device(dev) && handler->dev !=3D dev->p=
arent)
> +			continue;

I do not like how the sysfs attributes for the platform-profile class are =
handled:

1. We should use .dev_groups instead of manually registering the sysfs att=
ributes.
2. Can we name the sysfs attributes for the class a bit differently ("prof=
ile_choices" and "profile")
    and use separate store/show functions for those?
3. Why do we still need platform_profile_handler_list?

This would allow us to get rid of platform_profile_is_class_device().

>   		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>   			individual |=3D BIT(i);
>   		if (!aggregate)
> @@ -51,7 +65,7 @@ static unsigned long platform_profile_get_choices(void=
)
>   	return aggregate;
>   }
>
> -static int platform_profile_get_active(enum platform_profile_option *pr=
ofile)
> +static int platform_profile_get_active(struct device *dev, enum platfor=
m_profile_option *profile)
>   {
>   	struct platform_profile_handler *handler;
>   	enum platform_profile_option active =3D PLATFORM_PROFILE_LAST;
> @@ -60,6 +74,8 @@ static int platform_profile_get_active(enum platform_p=
rofile_option *profile)
>
>   	lockdep_assert_held(&profile_lock);
>   	list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +		if (platform_profile_is_class_device(dev) && handler->dev !=3D dev->p=
arent)
> +			continue;
>   		err =3D handler->profile_get(handler, &val);
>   		if (err) {
>   			pr_err("Failed to get profile for handler %s\n", handler->name);
> @@ -69,6 +85,10 @@ static int platform_profile_get_active(enum platform_=
profile_option *profile)
>   		if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
>   			return -EINVAL;
>
> +		/*
> +		 * If the profiles are different for class devices then this must
> +		 * show "custom" to legacy sysfs interface
> +		 */
>   		if (active !=3D val && active !=3D PLATFORM_PROFILE_LAST) {
>   			*profile =3D PLATFORM_PROFILE_CUSTOM;
>   			return 0;
> @@ -90,7 +110,7 @@ static ssize_t platform_profile_choices_show(struct d=
evice *dev,
>   	int i;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
> -		choices =3D platform_profile_get_choices();
> +		choices =3D platform_profile_get_choices(dev);
>
>   	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>   		if (len =3D=3D 0)
> @@ -113,7 +133,7 @@ static ssize_t platform_profile_show(struct device *=
dev,
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		if (!platform_profile_is_registered())
>   			return -ENODEV;
> -		err =3D platform_profile_get_active(&profile);
> +		err =3D platform_profile_get_active(dev, &profile);
>   		if (err)
>   			return err;
>   	}
> @@ -138,12 +158,22 @@ static ssize_t platform_profile_store(struct devic=
e *dev,
>   		if (!platform_profile_is_registered())
>   			return -ENODEV;
>
> -		/* Check that all handlers support this profile choice */
> -		choices =3D platform_profile_get_choices();
> +		/* don't allow setting custom to legacy sysfs interface */
> +		if (!platform_profile_is_class_device(dev) &&
> +		     i =3D=3D PLATFORM_PROFILE_CUSTOM) {
> +			pr_warn("Custom profile not supported for legacy sysfs interface\n")=
;
> +			return -EINVAL;
> +		}
> +
> +		/* Check that applicable handlers support this profile choice */
> +		choices =3D platform_profile_get_choices(dev);
>   		if (!test_bit(i, &choices))
>   			return -EOPNOTSUPP;
>
>   		list_for_each_entry(handler, &platform_profile_handler_list, list) {
> +			if (platform_profile_is_class_device(dev) &&
> +			    handler->dev !=3D dev->parent)
> +				continue;
>   			err =3D handler->profile_set(handler, i);
>   			if (err) {
>   				pr_err("Failed to set profile for handler %s\n", handler->name);
> @@ -152,6 +182,9 @@ static ssize_t platform_profile_store(struct device =
*dev,
>   		}
>   		if (err) {
>   			list_for_each_entry_continue_reverse(handler, &platform_profile_han=
dler_list, list) {
> +				if (platform_profile_is_class_device(dev) &&
> +				    handler->dev !=3D dev->parent)
> +					continue;
>   				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
>   					pr_err("Failed to revert profile for handler %s\n",
>   					       handler->name);
> @@ -194,11 +227,11 @@ int platform_profile_cycle(void)
>   	int err;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		err =3D platform_profile_get_active(&profile);
> +		err =3D platform_profile_get_active(NULL, &profile);
>   		if (err)
>   			return err;
>
> -		choices =3D platform_profile_get_choices();
> +		choices =3D platform_profile_get_choices(NULL);
>
>   		next =3D find_next_bit_wrap(&choices,
>   					  PLATFORM_PROFILE_LAST,
> @@ -228,6 +261,7 @@ EXPORT_SYMBOL_GPL(platform_profile_cycle);
>
>   int platform_profile_register(struct platform_profile_handler *pprof)
>   {
> +	bool registered;
>   	int err;
>
>   	/* Sanity check the profile handler */
> @@ -250,14 +284,49 @@ int platform_profile_register(struct platform_prof=
ile_handler *pprof)
>   	if (cur_profile)
>   		return -EEXIST;
>
> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +	registered =3D platform_profile_is_registered();
> +	if (!registered) {
> +		/* class for individual handlers */
> +		err =3D class_register(&platform_profile_class);
> +		if (err)
> +			return err;

Why do we need to unregister the class here? From my point of view, having=
 a empty class if no
platform profiles are registered is totally fine.

> +		/* legacy sysfs files */
> +		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +		if (err)
> +			goto cleanup_class;
> +
> +	}
> +
> +	/* create class interface for individual handler */
> +	pprof->minor =3D idr_alloc(&platform_profile_minor_idr, pprof, 0, 0, G=
FP_KERNEL);
> +	pprof->class_dev =3D device_create(&platform_profile_class, pprof->dev=
,
> +					 MKDEV(0, pprof->minor), NULL, "platform-profile-%s",
> +					 pprof->name);

I would suggest that the name of the class devices should not contain the =
platform profile name,
as this would mean that two platform profile handlers cannot have the same=
 name.

Maybe using "platform-profile-<minor>" would be a better solution here? Th=
e name can instead be
read using an additional sysfs property.

Thanks,
Armin Wolf

> +	if (IS_ERR(pprof->class_dev)) {
> +		err =3D PTR_ERR(pprof->class_dev);
> +		goto cleanup_legacy;
> +	}
> +	err =3D sysfs_create_group(&pprof->class_dev->kobj, &platform_profile_=
group);
>   	if (err)
> -		return err;
> +		goto cleanup_device;
> +
>   	list_add_tail(&pprof->list, &platform_profile_handler_list);
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
>   	cur_profile =3D pprof;
>   	return 0;
> +
> +cleanup_device:
> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
> +
> +cleanup_legacy:
> +	if (!registered)
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +cleanup_class:
> +	if (!registered)
> +		class_unregister(&platform_profile_class);
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
> @@ -270,6 +339,10 @@ int platform_profile_remove(struct platform_profile=
_handler *pprof)
>   	cur_profile =3D NULL;
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +	sysfs_remove_group(&pprof->class_dev->kobj, &platform_profile_group);
> +	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
> +
>   	if (!platform_profile_is_registered())
>   		sysfs_remove_group(acpi_kobj, &platform_profile_group);
>
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index da009c8a402c9..764c4812ef759 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -30,6 +30,8 @@ enum platform_profile_option {
>   struct platform_profile_handler {
>   	const char *name;
>   	struct device *dev;
> +	struct device *class_dev;
> +	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	struct list_head list;
>   	int (*profile_get)(struct platform_profile_handler *pprof,

