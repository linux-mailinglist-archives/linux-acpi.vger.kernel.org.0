Return-Path: <linux-acpi+bounces-11655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FCA4A5AB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 23:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C9D188DE5C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC31DE2CB;
	Fri, 28 Feb 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF9KjJwT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE81DE2BE;
	Fri, 28 Feb 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780508; cv=none; b=u0Lges5cDSnHuyGfU1Vt/FczmjLtp6FOxHiTRyINBGV52jaUj+KE890J9AUki6/JKZJP8W57P5NO38CsOp94J5H5/dlOVwUxmajVd7IvhJHP3o383Uk8gtlmJ+jp33eu1Sr/PVeqQ+rhcRrJPqYXbyTvbfkJot2IsAL7uL/qGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780508; c=relaxed/simple;
	bh=f4Bc/MWmC/dqVCeSDp0Ud/04jI6q7V+IzLEi+AZUEUE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=H5PWRPOJs9TuSHmKXJjmolczq0dYICp6/5ZXPd5mc5TpDKv0o6qcbPP7yyq8jjKBcvA/pH9BugseGX0fYVoLHV9Zk2nh6ETbA2ECRJUZs2Vh4nrsZvflLO77wV10qGrQee6Ah+s9m0sNcKZONUOdOutFmxLLFTuw4AcMa0VAB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF9KjJwT; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb181331bso1245962e0c.0;
        Fri, 28 Feb 2025 14:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740780505; x=1741385305; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUZVfpfsHtJY4UqsRu1LYnMdDReHY1TY44Rd5wY2z6U=;
        b=LF9KjJwTrye24bzkAx+HCVyH/aUrVqrkbauwxtG3fIWerTBrq0Jde2H/Wbzj3ajkpo
         BdEdRJHZ2Uis1RuMkr5FRYAVwJNgVsEq6eFhrkOVi5owO6WX6nPuEXtHJrX0BUY+JV7B
         IldrBPb76MHg0H4hPyAUa1ANVojSriWXTr9zBb8t3zvvFKyHo3+daugPpDDEmcjMA9cN
         kiQzlT4C1lVqKAa2Geait25o3JtsR4UgSqSIHIW+UKC3MYZnWE5Dn4DOu0ye7moiiQAa
         EnKyOeosrsoF03Ru2o/bSg+9FGJIcv+hlZ5gSBCYdfP30qxYgstPzD9KfciBXepVzuL4
         opqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740780505; x=1741385305;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUZVfpfsHtJY4UqsRu1LYnMdDReHY1TY44Rd5wY2z6U=;
        b=GVPdAB6o8dqt/FFgmZBbloqSNMSBIAydI4pyHVVVnjN6RYBAno63nZXVHrvXRcbxU6
         Culp2dwiWbrqCFbJUkWwd++eZiqZr03p2kTL8Sd1iV4Mjy/HxkZeQ8kH33WQWkvWOOXH
         FIgpqN0dJXyXqs22Thfk73tTzufCJ4ns6ZQ4Eh2N19aj3a5Wf3w3mb6rq/marTX8ncus
         Drdg9GCCtZhFHUIkqny29if+KBwj73zH3uCB/lZrsSl5zwO2+wQ2iZRM46dA4p42jJ+t
         OE8ae24G1eohUDIKM+nW0bmKBEIh6CejmErr3FcPs+yR+3FpuuOH3ZpS4WlznQhRl16K
         3OJA==
X-Forwarded-Encrypted: i=1; AJvYcCV+czFZYJtMaxlZJ2OSH2073DRGXMhkdLfBd3lyj9kUE7hAEA+s/FdUrNWxKFfS1U5L6FRUs5hlSkeb@vger.kernel.org, AJvYcCXeDpecicHtw4/FejBbrSS+Vlo8sJdHaNh0Ql5Dbb33lSQcuNuh3rmB4jlku8YFNS54KvBxMBs0tcO24gwk@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfjPUIHIVbhvhO8o1AnxFAnbx6p+HX9+C5L9uwCRkev/dZp07
	7ibADNSTOSdA02wG90ZnRAV28M6I4yiFPTkHmu5tjMLzAhZjdyG5
X-Gm-Gg: ASbGncv9X+NVxpZhsre/Y0WW36o02UCmWcdSvC8UHPk9fAsPuapjNECwW4Wkr28sc35
	0iJOUfaeknxlaoNR3oMMy4Ee0Cod+bcMTQHxMnZXrfCKqGri/b4ddlJC0H8t0yfBR/f0c6DyZA1
	EuNKa1cmxTrW+SqQ9IzVWoJAwkak9N3Ucx/365Gg7IutBp3yn49ogw7TWhB/44C70HmqZhgYFmg
	qiLDbG1CGs3DNenfiUmkWFZGigCfoMgIUdFv4v+Hf3n5EOWWHY3Fr3n0+38Co5Yo0sufbxgWmTl
	kFanGwl6SCFILilFvCc=
X-Google-Smtp-Source: AGHT+IGgvpQI0Ia8A0gypaBOny1zZAYK1HAXzodX1Ma1DazN+jgpEVvHK7Oev7mqDbTvh7F9oW+XFg==
X-Received: by 2002:a05:6122:3382:b0:51f:3e67:75df with SMTP id 71dfb90a1353d-5235b8cc4d0mr3785391e0c.10.1740780505028;
        Fri, 28 Feb 2025 14:08:25 -0800 (PST)
Received: from localhost ([2800:bf0:61:1288:2be8:bc29:ad13:842f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234c08d934sm721074e0c.31.2025.02.28.14.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Feb 2025 17:08:21 -0500
Message-Id: <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mario Limonciello" <superm1@kernel.org>, "Shyam Sundar S K"
 <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Hans
 de Goede" <hdegoede@redhat.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>
Cc: "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, "Antheas Kapenekakis" <lkml@antheas.dev>,
 <me@kylegospodneti.ch>, "Denis Benato" <benato.denis96@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Armin Wolf" <W_Armin@gmx.de>
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
In-Reply-To: <20250228170155.2623386-2-superm1@kernel.org>

Hi Mario,

On Fri Feb 28, 2025 at 12:01 PM -05, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers don't support all the same profiles the legacy interface
> only exports the common profiles.
>
> This causes problems for cases where one driver uses low-power but anothe=
r
> uses quiet because the result is that neither is exported to sysfs.
>
> To allow two drivers to disagree, add support for "hidden choices".
> Hidden choices are platform profiles that a driver supports to be
> compatible with the platform profile of another driver.
>
> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-92=
57-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: "Luke D. Jones" <luke@ljones.dev>
>  drivers/acpi/platform_profile.c  | 94 +++++++++++++++++++++++++-------
>  include/linux/platform_profile.h |  3 +
>  2 files changed, 76 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 2ad53cc6aae53..ef9444482db19 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -21,9 +21,15 @@ struct platform_profile_handler {
>  	struct device dev;
>  	int minor;
>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	unsigned long hidden_choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	const struct platform_profile_ops *ops;
>  };
> =20
> +struct aggregate_choices_data {
> +	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	int count;
> +};
> +
>  static const char * const profile_names[] =3D {
>  	[PLATFORM_PROFILE_LOW_POWER] =3D "low-power",
>  	[PLATFORM_PROFILE_COOL] =3D "cool",
> @@ -73,7 +79,7 @@ static int _store_class_profile(struct device *dev, voi=
d *data)
> =20
>  	lockdep_assert_held(&profile_lock);
>  	handler =3D to_pprof_handler(dev);
> -	if (!test_bit(*bit, handler->choices))
> +	if (!test_bit(*bit, handler->choices) && !test_bit(*bit, handler->hidde=
n_choices))
>  		return -EOPNOTSUPP;
> =20
>  	return handler->ops->profile_set(dev, *bit);
> @@ -239,21 +245,44 @@ static const struct class platform_profile_class =
=3D {
>  /**
>   * _aggregate_choices - Aggregate the available profile choices
>   * @dev: The device
> - * @data: The available profile choices
> + * @arg: struct aggregate_choices_data
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -static int _aggregate_choices(struct device *dev, void *data)
> +static int _aggregate_choices(struct device *dev, void *arg)
>  {
> +	unsigned long tmp[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	struct aggregate_choices_data *data =3D arg;
>  	struct platform_profile_handler *handler;
> -	unsigned long *aggregate =3D data;
> =20
>  	lockdep_assert_held(&profile_lock);
>  	handler =3D to_pprof_handler(dev);
> -	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> -		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> +	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROF=
ILE_LAST);
> +	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> +		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
>  	else
> -		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LA=
ST);
> +		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAS=
T);
> +	data->count++;
> +
> +	return 0;
> +}
> +
> +/**
> + * _remove_hidden_choices - Remove hidden choices from aggregate data
> + * @dev: The device
> + * @arg: struct aggregate_choices_data
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int _remove_hidden_choices(struct device *dev, void *arg)
> +{
> +	struct aggregate_choices_data *data =3D arg;
> +	struct platform_profile_handler *handler;
> +
> +	lockdep_assert_held(&profile_lock);
> +	handler =3D to_pprof_handler(dev);
> +	bitmap_andnot(data->aggregate, handler->choices,
> +		      handler->hidden_choices, PLATFORM_PROFILE_LAST);
> =20
>  	return 0;
>  }
> @@ -270,22 +299,31 @@ static ssize_t platform_profile_choices_show(struct=
 device *dev,
>  					     struct device_attribute *attr,
>  					     char *buf)
>  {
> -	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	struct aggregate_choices_data data =3D {
> +		.aggregate =3D { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] =3D =
~0UL },
> +		.count =3D 0,
> +	};
>  	int err;
> =20
> -	set_bit(PLATFORM_PROFILE_LAST, aggregate);
> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>  		err =3D class_for_each_device(&platform_profile_class, NULL,
> -					    aggregate, _aggregate_choices);
> +					    &data, _aggregate_choices);
>  		if (err)
>  			return err;
> +		if (data.count =3D=3D 1) {
> +			err =3D class_for_each_device(&platform_profile_class, NULL,
> +						    &data, _remove_hidden_choices);
> +			if (err)
> +				return err;
> +		}
>  	}
> =20
>  	/* no profile handler registered any more */
> -	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
> +	if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
>  		return -EINVAL;
> =20
> -	return _commmon_choices_show(aggregate, buf);
> +	return _commmon_choices_show(data.aggregate, buf);
>  }
> =20
>  /**
> @@ -373,7 +411,10 @@ static ssize_t platform_profile_store(struct device =
*dev,
>  				      struct device_attribute *attr,
>  				      const char *buf, size_t count)
>  {
> -	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +	struct aggregate_choices_data data =3D {
> +		.aggregate =3D { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] =3D =
~0UL },
> +		.count =3D 0,
> +	};
>  	int ret;
>  	int i;
> =20
> @@ -381,13 +422,13 @@ static ssize_t platform_profile_store(struct device=
 *dev,
>  	i =3D sysfs_match_string(profile_names, buf);
>  	if (i < 0 || i =3D=3D PLATFORM_PROFILE_CUSTOM)
>  		return -EINVAL;
> -	set_bit(PLATFORM_PROFILE_LAST, choices);
> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>  		ret =3D class_for_each_device(&platform_profile_class, NULL,
> -					    choices, _aggregate_choices);
> +					    &data, _aggregate_choices);
>  		if (ret)
>  			return ret;
> -		if (!test_bit(i, choices))
> +		if (!test_bit(i, data.aggregate))
>  			return -EOPNOTSUPP;
> =20
>  		ret =3D class_for_each_device(&platform_profile_class, NULL, &i,
> @@ -453,12 +494,15 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>   */
>  int platform_profile_cycle(void)
>  {
> +	struct aggregate_choices_data data =3D {
> +		.aggregate =3D { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] =3D =
~0UL },
> +		.count =3D 0,
> +	};
>  	enum platform_profile_option next =3D PLATFORM_PROFILE_LAST;
>  	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> -	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  	int err;
> =20
> -	set_bit(PLATFORM_PROFILE_LAST, choices);
> +	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>  	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>  		err =3D class_for_each_device(&platform_profile_class, NULL,
>  					    &profile, _aggregate_profiles);
> @@ -470,14 +514,14 @@ int platform_profile_cycle(void)
>  			return -EINVAL;
> =20
>  		err =3D class_for_each_device(&platform_profile_class, NULL,
> -					    choices, _aggregate_choices);
> +					    &data, _aggregate_choices);
>  		if (err)
>  			return err;
> =20
>  		/* never iterate into a custom if all drivers supported it */
> -		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> +		clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
> =20
> -		next =3D find_next_bit_wrap(choices,
> +		next =3D find_next_bit_wrap(data.aggregate,
>  					  PLATFORM_PROFILE_LAST,
>  					  profile + 1);
> =20
> @@ -532,6 +576,14 @@ struct device *platform_profile_register(struct devi=
ce *dev, const char *name,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	if (ops->hidden_choices) {
> +		err =3D ops->hidden_choices(drvdata, pprof->hidden_choices);
> +		if (err) {
> +			dev_err(dev, "platform_profile hidden_choices failed\n");
> +			return ERR_PTR(err);
> +		}
> +	}
> +
>  	guard(mutex)(&profile_lock);
> =20
>  	/* create class interface for individual handler */
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index 8ab5b0e8eb2c1..8c9df7dadd5d3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -33,6 +33,8 @@ enum platform_profile_option {
>   * @probe: Callback to setup choices available to the new class device. =
These
>   *	   choices will only be enforced when setting a new profile, not when
>   *	   getting the current one.
> + * @hidden_choices: Callback to setup choices that are not visible to th=
e user
> + *		    but can be set by the driver.
>   * @profile_get: Callback that will be called when showing the current p=
latform
>   *		 profile in sysfs.
>   * @profile_set: Callback that will be called when storing a new platfor=
m
> @@ -40,6 +42,7 @@ enum platform_profile_option {
>   */
>  struct platform_profile_ops {
>  	int (*probe)(void *drvdata, unsigned long *choices);
> +	int (*hidden_choices)(void *drvdata, unsigned long *choices);
>  	int (*profile_get)(struct device *dev, enum platform_profile_option *pr=
ofile);
>  	int (*profile_set)(struct device *dev, enum platform_profile_option pro=
file);
>  };

This approach works really well for the PMF driver because the
profile_get callback retrieves the raw profile that the profile_set
callback cached. However this is not the case for quite a few drivers,
which usually just retrieve the current profile from WMI for example.

This means that writing a profile to the legacy platform_profile
attribute, which a driver has selected as a "hidden choice" may result
in the operation succeeding, but if the user were to immediately read
from platform_profile it would display "custom", because the profiles
for different handlers may be unsynchronized.

This makes me wonder if the added complexity this patch brings, is
really worth it.

IMHO we should do what Armin suggested in the patch proposed by Antheas.
In fact, I would suggest an even simpler version:

  1. The legacy platform_profile_choices should aggregate `choices`
     with bitmap_or instead of bitmap_and. i.e. It should display all
     available choices
  2. When writing a profile to the legacy platform_profile, if a handler
     doesn't support it, we simply ignore it without failing and
     continue to the next

I believe this works well with power-profiles-daemon, but I'm not
entirely sure. Maybe you know more about it.

This of course has the problem that profiles would be unsync and
platform_profile might display "custom" immediately after setting a
profile, but this patch has the same "issue".

For me this "custom" issue, is not really an issue. The legacy interface
should be deprecated in favor of the class interface, and new/old
user-space tools should use/migrate to that instead.

Let me know what you think!

--=20
 ~ Kurt


