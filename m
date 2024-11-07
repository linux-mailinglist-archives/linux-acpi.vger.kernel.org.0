Return-Path: <linux-acpi+bounces-9412-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25879C0079
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36301C20DF6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCFE1DD546;
	Thu,  7 Nov 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="de3waknc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C421DE8BF;
	Thu,  7 Nov 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969686; cv=none; b=q3FOuZ14p9+9cfIRwyyaeX09h4iZCJ+LJLHkrkkOPQ7iLR6L5k3tovmKrQyalbbUWwd8u3Zl7Lz6+rB/N4mXU69J5PjM+iI1UILG2f5DWDYp/lo55m6FZ/QabAXleVz5p6ATXHA0QM2gi5NukrXOiPHs1Q3E+/UK/GkWDHCtXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969686; c=relaxed/simple;
	bh=pTrhZGMux4w9HEGZVkA06OEz8j6sM7RTcepx+960yOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDWU86pIMyUYFTxqIm9zxVZ2HEOPJhXuXNB5QE8JWcWI0zDWyGxzpBMo71Hc+gkyVNzF8SIreE/Y1GceBvLDy/wmAFMGVMDvp9O0dOZNBveYm3ubjdmhK0KLcTtW/n/fHg91k+5qZjY8+Tp5UAFniiGW7dgdjqvhETHANkZY5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=de3waknc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730969611; x=1731574411; i=w_armin@gmx.de;
	bh=qaw7uMu2t3EIqtccwJknlcS0bifyYBg0bVt7fGnR0ys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=de3wakncUUngdBJQ7jXy+NWXAclXKZotZf5RGrE1zArbtuMBEFtBOoV0PHwomJjs
	 4LOo8q5DiDB2j0mLfk46JPjaHgEbQ+GWnZFfD3DV+tKUZGFhnHug8ohG+1aw8u1vc
	 O3AmVIQa0KBhs+O420tgy/rAipkAMR5KicbjcUddvoO10CozlFH2ynpgliZy8XJYy
	 Xwee5IpMXVD3b2pXaqSSb7O5e9ibG91Zyx/ZJveg1xhi2NVZV7WiIcRWJv1rST4UF
	 XX/HyjHvPzGPq6HmQUq1hwL3o+VTnQ5fkdQC9gXpjwHlO6Rm/AR28cWj9wPC+ELLa
	 O0V4XJsCuXOYzPqG5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1szO1v3xsz-00C8zN; Thu, 07
 Nov 2024 09:53:31 +0100
Message-ID: <8a8a4c32-3c96-4c55-ac78-daffa00f87e3@gmx.de>
Date: Thu, 7 Nov 2024 09:53:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/20] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-17-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-17-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G8J596hrcutVzCbvzNy11SEyrqvV3B7gg6KtP8RzAJ+KG3n23uk
 VQCefGZUF/rkE+kDfHKweJQkKCSBVX1U/rmE+jgzHblafjGUFw2tgGd7yGiuHqOS5wCaMy5
 fVCCKAE33qnBs/XBZmsyFPM/HX7ffdCTsjwwHsM9QNGVsdI4PNCjVWQwc1LeWvZyXHKzD8S
 ByV2jGCXBDfxkEzdp0alQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8d2RQsrA56A=;hBY2AYwN1A+sP37Kpr/ZjG2XnnL
 wtiLCBnDM4obfKHG6AKonNAMPo8asuqP4Fd4Cg9A91KIsPBFTm510T5U3FW/2nLynFAvOETXo
 G3iTwUqjZV/BUehlFhqyOiUvnp0qxUms9zsmcQIYLi35wGmq1b5MlTm9TNyRGxApX+Cr0T3n5
 xBnlFNuZmFFEkHEnLpH1Q8BgQj7UAc+LJESCmKQKpGU5d8vZRyRoxo9yM48nnLWCqqTz6vi/M
 9UPbmwiOvLZKeonOqrsogkqa62FoZ2ogwTi3weIRcj15Nkk/9KGh9JmqM2tDhUkwHenH63ONh
 He1tbDgazgu4dIc5B/WisbJryAfj0P5Tj7tKtVLs9viyOWzJGKeKVCPv1DUZ/47JXQP1Djege
 fz5YRTI8iHY+UD6QxrS89Plx9zkYnVGLN3gR4P2eHOYiYyZ7SJXrMoX77qj0WbCOmUSWCuCZg
 NU99o97N+jKxBm02c8NRfAja1ylDZDoiNyfVXHadJ3q3Hv6sr0ZK1G4I6mTo0GycJTxSnS4RY
 JKoBa9Y8vtKsYylq7uzGXz482DZE39SOIFSFkIqLoDRQ1whsrmcw7D8vN1iGFolAOJF/69Gao
 fbKh5q3+RD70hlA6aJohwh1X4lXY6m/Sa+v4uNOz8Vlm7cQbEN6t2kIZEGsO2BNKKr3gJLo5+
 4bfcsqTtjO9LyGbkh4T1JosUKJR+6kyvJIOiyzLHlWzjFJIyJkwB3xZ7t3/lLb5gr3SWSznSu
 v3HY4YjvfGifu9VBbhWkp0iIAf2aQB9yAPseg7K1cGt2J/oT3z3L5ikedSZUNpIBFrSEUqDGI
 cUtsFXRYZWMjtC1HbTKK2z1IjczxMterEYOchJ39gwDsA4VuB5Ck/3foYAAU+Ux4FGGdowIBR
 X0AOIOzWhPRL6n4QM4nqVGBIQuGAMmQZ1xZLBO5MuAy81O+z1o2ScOl4o

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> If for any reason multiple profile handlers don't agree on the profile
> return the custom profile.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Notify class profile of change to legacy interface
>   * Don't show warning when writing custom string, document in last patc=
h
>     instead.
>   * Adjust mutex use
> ---
>   drivers/acpi/platform_profile.c | 101 ++++++++++++++++++++++++--------
>   1 file changed, 76 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index b6f3388b4eef9..7f302ac4d3779 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -94,6 +94,22 @@ static int _store_class_profile(struct device *dev, v=
oid *data)
>   	return err ? err : 0;
>   }
>
> +/**
> + * _notify_class_profile - Notify the class device of a profile change
> + * @dev: The class device
> + * @data: Unused
> + */
> +static int _notify_class_profile(struct device *dev, void *data)
> +{
> +	struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +	lockdep_assert_held(&profile_lock);
> +	sysfs_notify(&handler->class_dev->kobj, NULL, "platform_profile");
> +	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
> +
> +	return 0;
> +}
> +
>   /**
>    * get_class_profile - Show the current profile for a class device
>    * @dev: The class device
> @@ -284,54 +300,89 @@ static ssize_t platform_profile_choices_show(struc=
t device *dev,
>   	return _commmon_choices_show(aggregate, buf);
>   }
>
> +/**
> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs interf=
ace
> + * @dev: The device
> + * @data: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_profiles(struct device *dev, void *data)
> +{
> +	enum platform_profile_option *profile =3D data;
> +	enum platform_profile_option val;
> +	int err;
> +
> +	err =3D get_class_profile(dev, &val);
> +	if (err)
> +		return err;
> +
> +	if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
> +		*profile =3D PLATFORM_PROFILE_CUSTOM;
> +	else
> +		*profile =3D val;
> +
> +	return 0;
> +}
> +
> +/**
> + * platform_profile_show - Show the current profile for legacy sysfs in=
terface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
>   static ssize_t platform_profile_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> +				     struct device_attribute *attr,
> +				     char *buf)
>   {
> -	enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
> +	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
>   	int err;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		err =3D class_for_each_device(&platform_profile_class, NULL,
> +					    &profile, _aggregate_profiles);
>   		if (err)
>   			return err;
>   	}
>
> -	/* Check that profile is valid index */
> -	if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names)))=
)
> -		return -EIO;
> +	/* no profile handler registered any more */
> +	if (profile =3D=3D PLATFORM_PROFILE_LAST)
> +		return -EINVAL;
>
>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>   }
>
> +/**
> + * platform_profile_store - Set the profile for legacy sysfs interface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + * Return: The number of bytes read
> + */
>   static ssize_t platform_profile_store(struct device *dev,
> -			    struct device_attribute *attr,
> -			    const char *buf, size_t count)
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
>   {
> -	int err, i;
> +	int ret;
> +	int i;
>
>   	/* Scan for a matching profile */
>   	i =3D sysfs_match_string(profile_names, buf);
> -	if (i < 0)
> +	if (i < 0 || PLATFORM_PROFILE_CUSTOM)

This condition looks a bit weird.

>   		return -EINVAL;
>
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -		if (!cur_profile)
> -			return -ENODEV;
> -
> -		/* Check that platform supports this profile choice */
> -		if (!test_bit(i, cur_profile->choices))
> -			return -EOPNOTSUPP;
> -
> -		err =3D cur_profile->profile_set(cur_profile, i);
> -		if (err)
> -			return err;
> +		ret =3D class_for_each_device(&platform_profile_class, NULL, &i,
> +					    _store_class_profile);
> +		if (ret)
> +			return ret;
> +		ret =3D class_for_each_device(&platform_profile_class, NULL, NULL,
> +					    _notify_class_profile);

Please rework _store_class_profile()  and _notify_class_profile() into:

- platform_profile_store(struct platform_profile_handler,enumplatform_prof=
ile_option option),
   which is called by profile_store() while holding profile_lock.

- platform_profile_class_store(struct device *dev, void *data), which is u=
sed with class_for_each_device()
   and internally calls platform_profile_store() and issues an notificatio=
n on the "profile" (not "platform_profile"!)
   class attribute and an uevent.

This allows you to avoid having to iterate through all platform profile ha=
ndlers twice.

Thanks,
Armin Wolf

> +		if (ret)
> +			return ret;
>   	}
>
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   	return count;
>   }
>

