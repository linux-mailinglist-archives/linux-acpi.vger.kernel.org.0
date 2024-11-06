Return-Path: <linux-acpi+bounces-9342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDE9BDDB3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 04:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5213A1C21CEA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 03:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099A19047A;
	Wed,  6 Nov 2024 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BbpXquoa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671E190468;
	Wed,  6 Nov 2024 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864314; cv=none; b=W9vdhrvkArDqLcl4EEI0qen6Wkt7uLmLgJ3vTCHAokpwuX2j1XPJivjt3QHBBTUa8wKeuLp2gaMOX5hEJZL6iBzWnfIL1Kyjmfc4dURay1uVJ314u8slZLddtuI6YjHgz6mYRccWpAp4QyEQwUqJVRc5YlLpRb83SPL++aFe8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864314; c=relaxed/simple;
	bh=ko7ZAAicDgrNAs6yMid5aylS1uJgEAAC4ypSv/+ka8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZGGWG2b09f0nHOKVaRdvBgfnFkryaY0/m3QxFa643sWo9DgBtGG1XgU8YS5cFfKqBmUzjwjfMRYHastpJFad7yh5ppYEaLXvpzFqXDs+TCq1U5+D3kZ4KW+7MENa2fHftY6zQr53Ar44A0MXZ6XjkmLIBLkyBemsL2kF+/TKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BbpXquoa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730864240; x=1731469040; i=w_armin@gmx.de;
	bh=yIns49Q8Setw9RDJC70feaKzOofvNaCgsq98AZRF7UM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BbpXquoa2XG6ILECOGzSdD0SvxVibA3pVmHhC85xde/A7t15KYAXLG5NTg6vuwRm
	 WqTMHmoBP2lQZej8AQmigid7SmfU7yEX49upGXLvNgzCWNWTVrSWVrtxVDADRWFd8
	 B6cqafEdYtgkShmqTf4R2Eh3F5bwME5RAZODnGRT0H4jeLJq0v3HXB3k2IJa50R+1
	 LcU9aBGo5XuuNFy522GmUEYNzI9VaNrONV0Ykznj/IGAaIlgM++tXf4Lct95yQdWe
	 Gcj/NgrL2NzPxbxvWPVypaL4AoxRslEsH1brT5V2dLKZHcTz/Q5Mj39CyBQz6y1xL
	 fXEovpPY03aV7F0P7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1tN0tR23hF-00Ijqn; Wed, 06
 Nov 2024 04:37:20 +0100
Message-ID: <9f75db2f-6d41-4a5f-84e2-ebe183cb4016@gmx.de>
Date: Wed, 6 Nov 2024 04:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/20] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-8-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2P14AvhDFsbi26CeC4gs/qF+bu9pxeO2DNpRgJXbzTIXpng8Tm2
 meNrFUZWZ+z8x66XQj1AVp3ccwYv/bbg9/sp3p03MRhknWCnI9dbJbpl/5bNJ/JlGPPGlgP
 rI9Xw7UD3BFcMzpittxkIdTE3dY0AZEuFUFIHabv9BeqqnnZ/hbsJxAZTRIXQPu5Zqj2J8e
 FE8XmZ52L+q9pgcPql91g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:462k/n9Dv10=;tBAJxaAwOwCpaJzAl7QsKt9ZSJb
 vkyaHTDpLSttOKZ4CkInrKZ5jD6REJZSNcOkDmZwrWryLjy303HNCRHmmRw0OZDIe3hhinUpA
 VZgwlz03dHgznL/DdM9hicuk1YZQQ8DOqq/9r6RAkodWYl0Hn6lXcyWIODChSVous0TZoGGU7
 OP/jhxsWqWOpRCknNYadbBUcZg+nT3tkhTXu4hHgO7fCgCcULQ87dExCDII3TuAWp0XGFjYX0
 uxfWDbPpWMH6C6IBGDlzQ6eWzmkNOQgofclsOxi6ONzZjdTiKmj23NfSJaAeTYWTKq57rSqaR
 wtuGPTwRvdKgwi8Sp8JuaHqIKKIqpsVyfQrZ+cJmajSlDR1Nbd8oLbZ7zaoUxhTlSm+6cSAzo
 b37E0228n/Bl/2cEHOFKXZxySYQ/dgCx4vpdbJGAofuBeJoU4hvnOZIiqbSbRUc4r+Ab9PhbF
 6m0p83V/fq/2A+6KzXBkeVqji63CpaihfxpmO1OC7lBOFniimFaSGD5bPoaIhu2/XepvtgT8F
 HapfV+afJU7THQdEkv6pgIKMCfbcJUZ9JpZ8x8Wn82AdMHtWcgOlCIjalgguX3FzHAJwKY1tF
 NY9bYCCEwQfvXhy3w8AKZwTeYqECx8GIGZaBzf/TjA/6fkvKQrc2VqU12VQnUlsPQQDImJmn9
 aCXNEPXhvfgRv2Pyt2XW9DIk4p8j5dWHuETs9Tj7VXIri88Iyn7mX4iQ7S7c31q4ypVp+rZfI
 IGuIS9XK09EjSYtJXl4xe2Esxf4+VD29IOTQ/Nbr+42XZBn7gyEc6a4Nr2XSN611wtT96ZflR
 aATq/wX8kUvtH+whtjjfankXDMZWJARVZJbc83DPpyYFM=

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> guard(mutex) can be used to automatically release mutexes when going
> out of scope.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 70e7f1ba68676..4454c4a903c8f 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -188,32 +188,26 @@ int platform_profile_register(struct platform_prof=
ile_handler *pprof)
>   		return -EINVAL;
>   	}
>
> -	mutex_lock(&profile_lock);
> +	guard(mutex)(&profile_lock);
>   	/* We can only have one active profile */
> -	if (cur_profile) {
> -		mutex_unlock(&profile_lock);
> +	if (cur_profile)
>   		return -EEXIST;
> -	}
>
>   	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err) {
> -		mutex_unlock(&profile_lock);
> +	if (err)
>   		return err;
> -	}
>
>   	cur_profile =3D pprof;
> -	mutex_unlock(&profile_lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
>   int platform_profile_remove(struct platform_profile_handler *pprof)
>   {
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	guard(mutex)(&profile_lock);
>
> -	mutex_lock(&profile_lock);
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);
>   	cur_profile =3D NULL;
> -	mutex_unlock(&profile_lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_remove);

