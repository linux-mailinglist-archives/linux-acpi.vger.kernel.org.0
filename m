Return-Path: <linux-acpi+bounces-9622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EF9D058E
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4D8B216BC
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BE1DB366;
	Sun, 17 Nov 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hsfQcNSf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63311CB333;
	Sun, 17 Nov 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731871745; cv=none; b=fYZ2Rk3NGajSvqkAP1B/kVkCGAN5LKPl9tCr4mj932zrcBx7R+tTiF74GQj9RbCi0G2gCf0RGjO82agBO9dWExOSx0e28CmwfjbBBl8rFq/i2PExOGZwDmmmWtvmHRN9M+oH7YgwGqeLsNUa6ja6PkmHHSzlzxfF9Eo6hKk1K5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731871745; c=relaxed/simple;
	bh=WFSi094f4p67vDIBC4yF+wS7+41NYBkUId6VchIXXW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIFE5fLC1BlfrLVb39g5Tq88trmDJnIW3xe3wr/JxoVGHocsgawq4ldjc92W5kZBrpXAMzzmnlTzpOdbRx5tISTZji6Utf2/gPnWV63uHjvUjK1FdPDUDCzndpmAYWySJs1284BjwT1AmCp0AS17iZCfmCikRfDjSbdRTNu2ETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hsfQcNSf; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731871674; x=1732476474; i=w_armin@gmx.de;
	bh=nwnH8rk43zwU8UY7I0DCRWKqoe00ljs13amHr+vNJOE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hsfQcNSfttu/soBVfdkT+zdhvZtmbLFMhrjBNyoEPUIsljCBV3SM/WCyAQPM/Tok
	 XMH1pYzl8v4RY0hA9F/F896iRrUckPnJECI+6rQg/qPovsyisVSVNiObrnJmTFMN4
	 vocpRQSq9VLAZVJFXM/P4zSXQJc9LkIo3BNKkwliVvEucaDFBKww+mTuPNxuDpnC3
	 tmkfO0pMze+MbQzEftYM8t1Izy4pqRMevJ77dfBEHetRGOJu1SQqMUkEdnPZK7mFO
	 uEmkMivrQ6mTyar90yef7aRMJMk7YO/ToUKPsr+NSWeGE1V6CtD8trxZpd3ajSjEo
	 I5KfLBJv1xt8UPVVMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1tAq3f1wTZ-0000fO; Sun, 17
 Nov 2024 20:27:54 +0100
Message-ID: <22bc5489-e205-405c-a0f5-bc9fc01be99d@gmx.de>
Date: Sun, 17 Nov 2024 20:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/22] ACPI: platform_profile: Allow multiple handlers
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
 <20241109044151.29804-21-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-21-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RStlMmxjrWUqrEgcwGt2nYqTaTwj1K5AqOK4KjEl+tRAFZfHrzY
 3TmIv2EJODOUEa1kn7odVv/l2RLrSNup/7WrIMUBfheTS0CuVVIPmmYuWKnXAsjoM0DCJ2m
 rpfn+qsdgbJnuHfbronFC8nScE2CgvgsnZgmZn8wklSQrJRDVfeyqn51l5YrQnhDicDyL0J
 mn+tnCKg52Oq5COnycEiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7tPl5vNc9mo=;hcEeoMdoPRI0kOQbKSHHt6fJVUX
 C15MOQ2DgkG4cfLJ6yL9oyqyGGMY0v9y6G5DOmzrsPLpMEadpIB0oawbLNdRNcRhtSZOQLeV8
 iHr/WGMogjbtZv7eSzDjDyd0cffUW/JuGwXbol7HWnHHisrNBXQU85e2YzEAmcTuwxIduhcR3
 A78G15utDyYXbW8Ho3ZUwne91OBIz7/tJDIlLD+ImS7ve+QrJRyG4/1tP7H144ERQiNcV781T
 lwWic58wxfja0enVbP5LctUlKoVVuQxI7YVVPpTgbjbJmQARFdUD2Y6eejlMM0PChKqEpwdZK
 AjDo3z6syjN+S+/XDGA7usTqcWGnkxviC1OkoAdOMxQ/F7SCQXVNzzKBkQR4+YLFIiHeUrM6C
 vH9EIlUT0Plk1OyfWlBDDSjqjKnZ+tat2vVwmsx90A4yPT2zU6Gm263z3YroDWDuApDlTNSiD
 OBBtrB+1gluConCL8/UZFeWe/7joRovfT4M8plyEEKKcJCni6c+d4mw6r0ly9fnT1zn+RV5KS
 Msz5erJ0WobX3XrBh76Kux52A1iErea0K/+Mweqv0bQZtPrxNu9ESVriVbfZ5/dDaQgeFeoxl
 f9It1ACeLGJOPwok2Nfw460PtSLu+5fZFDZCRCzwlrk9O38bKs2Rh/qgZbKxHaZZssxmElH9d
 qZnwuc1eJkoOrOOLAillfs/BuXiE2vZQVVOC2J86sIUO1XpLQ/lF/Yw/yl8IYz5CCIzQtKSM6
 8+l5Ti0s/R9aCCUHQgZ3m6St6zOrN3MmCAlCdEgMPYajCiXcOyKUONitXRfqABJBqQ0vcReXq
 yyyn4cYgtsoTflQu3N0FDqfAMX200BzYWbHOtm7XCu/oyYgakfhO0MnWLa2leCTVxRM54YNkN
 HVerL0Sx02/5e5f/ZB/Cs2IAyQJPO3NMLBDEVLmiS+EkviBgQvV2qo/qU

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> Multiple drivers may attempt to register platform profile handlers,
> but only one may be registered and the behavior is non-deterministic
> for which one wins.  It's mostly controlled by probing order.
>
> This can be problematic if one driver changes CPU settings and another
> driver notifies the EC for changing fan curves.
>
> Modify the ACPI platform profile handler to let multiple drivers
> register platform profile handlers and abstract this detail from userspa=
ce.
>
> To avoid undefined behaviors only offer profiles that are commonly
> advertised across multiple handlers.
>
> If any problems occur when changing profiles for any driver, then the
> drivers that were already changed remain changed and the legacy sysfs
> handler will report 'custom'.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * rebase
> v5:
>   * reword commit message
> ---
>   drivers/acpi/platform_profile.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 7ad473982ab11..0a8b86b44e161 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,7 +10,6 @@
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
>
> -static struct platform_profile_handler *cur_profile;
>   static DEFINE_MUTEX(profile_lock);
>
>   static const char * const profile_names[] =3D {
> @@ -415,8 +414,7 @@ static const struct attribute_group platform_profile=
_group =3D {
>
>   void platform_profile_notify(struct platform_profile_handler *pprof)
>   {
> -	if (!cur_profile)
> -		return;
> +	guard(mutex)(&profile_lock);
>   	_notify_class_profile(NULL, pprof);
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
> @@ -480,9 +478,6 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   	}
>
>   	guard(mutex)(&profile_lock);
> -	/* We can only have one active profile */
> -	if (cur_profile)
> -		return -EEXIST;
>
>   	/* create class interface for individual handler */
>   	pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> @@ -498,8 +493,6 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
> -	cur_profile =3D pprof;
> -
>   	err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
>   	if (err)
>   		goto cleanup_cur;
> @@ -507,7 +500,6 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   	return 0;
>
>   cleanup_cur:
> -	cur_profile =3D NULL;
>   	device_unregister(pprof->class_dev);
>
>   cleanup_ida:
> @@ -528,8 +520,6 @@ int platform_profile_remove(struct platform_profile_=
handler *pprof)
>
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
> -	cur_profile =3D NULL;
> -
>   	sysfs_update_group(acpi_kobj, &platform_profile_group);
>
>   	return 0;

