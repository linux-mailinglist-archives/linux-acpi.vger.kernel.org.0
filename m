Return-Path: <linux-acpi+bounces-9624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F09D0599
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9560B1F21A7C
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F51DB375;
	Sun, 17 Nov 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dYyfPglV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3A1DA11A;
	Sun, 17 Nov 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873438; cv=none; b=LjIaJLQdow/IHj29M7qoIhK4TWFRG1YBMM/DH+qYx1jzSAY10AhU+3OxFgJYg5/NfwBwe6N/cfAILYo0aKJNoUVGItNZrDO5XDLDSa2rwRHDABtM2Y4fhfpPQDju1tbEyFKJzaweNyZFPtA55Cb2bwkL2ondnOZE642MRHUfSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873438; c=relaxed/simple;
	bh=0D0rVlLazk3e9+UzYzAwJMY7U6wVdChYB6C/Cv5RJlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md+Z3jWYbdVCKwb3P5MQr+VVBg2FVBUH2RNlgpbMoK1D+hjnDzV7U7whYwphvy794dxtONFlUKYLmDv37Ea9p6nsPkygzACWY7WOrYp3MqBTFaA+9EGVUSQwVwjbjcJtXkqLOSXPqnHjyuGUIbnBbsJPX2AtQoifqv1lFUkXmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dYyfPglV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731873374; x=1732478174; i=w_armin@gmx.de;
	bh=LpwvtYmMYMG3OMu+ZG7wRaqRDTH2ywal0co5/aDXKFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dYyfPglVGDQY8Rxfd39sK88medIG/xkR0P5eFRGyJjY44im1d6+gYnWv994E4Gej
	 8EWhQcQYO6Ov6ykN4qRlKgjRCf818q1d2UmqA7wtham9erVDhPHqDO2XfNLyBNiSZ
	 DXoCrVFH8X0NVdnLEnIrihFQ4nhMkUmU4qkYyWnDOEb9I9DJb20j19jWGqc+07A3q
	 8Mzxohahh7HRBG9AdmhdJd14rz18+QYpah/zTjwbYyoH9fat7U9q14LGTmtrHY+HN
	 bkrkjhWWE2i66Ly+Iz0fWSsJ0Ft6rUl9+hRFo/UOzCPjm7WUlGqAFBdsVqougD7D7
	 EPEPHw1s3kujRiAO1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1tLFgj0lNL-00TFtG; Sun, 17
 Nov 2024 20:56:14 +0100
Message-ID: <c3fda59b-11c2-40ed-aa64-66c10805f74b@gmx.de>
Date: Sun, 17 Nov 2024 20:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-10-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1://Vaf54lrdOn3E1YeZLvLbuxO6gyb+3fHRAE4h76tkHQz1Tgy7+
 MaT2snJnBA36FJ5mEZH/DogJZbbg6k4RLXzjXnUefk2lJ4GQacInAXDPh5yE1gWj5miZ1c9
 1Ei8Z9tGMJgjq7sUWFZmVmk6bAlpElPZoL7KOP9IYh89kM9Br4Gx0LWH+1mym6PH0m1nhI4
 1ulOyLnlL9TYlOqQLGynA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cst14HlcA94=;oAgdpRj4miV2YIFQwWIUfxciMb6
 WGyjKaabbucOGbkaKzci+Kt0mpg425TnKrtcX9sHmDOieLbfTU89Pai+1S2iAgt7vGlt9H7aH
 x40fo/sLS4DqVn+Z6PVan3mS539BnQXVfvPMziLLAWtvxaOW8CtDF/3V1KBcEef32ImNjqj91
 ydmkpdaj9W8ataf2NLdQJjaPW6pHsO8jcP/SD8H5jDm0C0MqtEonXQ/NpfculPJ5f2/oyvnQb
 Mn5y8TDbsBjWP4fG+Fjlzv0VEkHQi2fGdc0hjcrJ5XF2SnMOeW+IQpWXQLfdpKpabZgZcYpwB
 td+zCx3nwhrcoqB5rwRijUq06WO9h1LHUA7sxrREm5//zsKO5No7yDU8zXZUq9xF3trcl/5Pg
 b/8YyzuOWZoXTg8rmUisNhO5ogiCw9QLsuclUt/4CKMB1oHQd4p77nCyinvnlqJ+CmKwSyJuu
 QKvy332OzfCto55elJMZWp/1eLPRlPgrGd5BP6bpoX7Z0HOswOjjaWsKPX4J4acgs5/iZEqaa
 rxkewd3AS4k4ZK8L5X28W0w3tC2JW97nNk6E+fptPyCY1tz9xNncUKV+OCESjssc4iVNS0dfe
 hZxhk7ardz2FMe3LPevVOGmZ4j3yAAVTTQmHPx9ywlE0zZEDyJJbjabl1kdV8OhjgXVIdR2ci
 bbfQ/73OiIdlypAJONs5ZyVTrzLk7/BKE1/wxnpYAAJIo8EVbljzumov7RdHunOHljORKV7jJ
 mqVOqCe7WTIbLfn/jarxDGXbF2LEhH29O5q45dxntWhnp/vTVFMgTvCjSm+lolaC6jFYfAAxj
 8hW7AtHLuLtp0DhBbmUPfGZh01OdF+0R9I9NzsTaaloiVggOe8OiJr+W5rriTiFwIfG1JIo+B
 ViiX3NYoKw23GtaLAYd0hplU+zt7g128meGC2RxFo9iBtOkzu15PB5qKd

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> Migrate away from using an interruptible mutex to scoped_cond_guard
> in all functions. While changing, move the sysfs notification
> used in platform_profile_store() outside of mutex scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 111 +++++++++++++-------------------
>   1 file changed, 43 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 9729543df6333..32affb75e782d 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -27,25 +27,20 @@ static ssize_t platform_profile_choices_show(struct =
device *dev,
>   					char *buf)
>   {
>   	int len =3D 0;
> -	int err, i;
> -
> -	err =3D mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> -
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> -
> -	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -		if (len =3D=3D 0)
> -			len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -		else
> -			len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +	int i;
> +
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
> +		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> +			if (len =3D=3D 0)
> +				len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +			else
> +				len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +		}
>   	}
>   	len +=3D sysfs_emit_at(buf, len, "\n");
> -	mutex_unlock(&profile_lock);
> +
>   	return len;
>   }
>
> @@ -56,20 +51,15 @@ static ssize_t platform_profile_show(struct device *=
dev,
>   	enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
>   	int err;
>
> -	err =3D mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
>
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> +		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		if (err)
> +			return err;
>   	}
>
> -	err =3D cur_profile->profile_get(cur_profile, &profile);
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
> -
>   	/* Check that profile is valid index */
>   	if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names))=
))
>   		return -EIO;
> @@ -88,28 +78,21 @@ static ssize_t platform_profile_store(struct device =
*dev,
>   	if (i < 0)
>   		return -EINVAL;
>
> -	err =3D mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
>
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> +		/* Check that platform supports this profile choice */
> +		if (!test_bit(i, cur_profile->choices))
> +			return -EOPNOTSUPP;
>
> -	/* Check that platform supports this profile choice */
> -	if (!test_bit(i, cur_profile->choices)) {
> -		mutex_unlock(&profile_lock);
> -		return -EOPNOTSUPP;
> +		err =3D cur_profile->profile_set(cur_profile, i);
> +		if (err)
> +			return err;
>   	}
>
> -	err =3D cur_profile->profile_set(cur_profile, i);
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
> -	mutex_unlock(&profile_lock);
> -	if (err)
> -		return err;
>   	return count;
>   }
>
> @@ -140,36 +123,28 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option next;
>   	int err;
>
> -	err =3D mutex_lock_interruptible(&profile_lock);
> -	if (err)
> -		return err;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +		if (!cur_profile)
> +			return -ENODEV;
>
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> +		err =3D cur_profile->profile_get(cur_profile, &profile);
> +		if (err)
> +			return err;
>
> -	err =3D cur_profile->profile_get(cur_profile, &profile);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> -		return err;
> -	}
> +		next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
> +					  profile + 1);
>
> -	next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAS=
T,
> -				  profile + 1);
> +		if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST))
> +			return -EINVAL;
>
> -	if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST)) {
> -		mutex_unlock(&profile_lock);
> -		return -EINVAL;
> +		err =3D cur_profile->profile_set(cur_profile, next);
> +		if (err)
> +			return err;
>   	}
>
> -	err =3D cur_profile->profile_set(cur_profile, next);
> -	mutex_unlock(&profile_lock);
> -
> -	if (!err)
> -		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
> -	return err;
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>

