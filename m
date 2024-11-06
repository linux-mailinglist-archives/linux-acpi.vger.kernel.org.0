Return-Path: <linux-acpi+bounces-9369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD229BF77F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8692812A7
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF1212177;
	Wed,  6 Nov 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cn9I1PMX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8520A5E7;
	Wed,  6 Nov 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922129; cv=none; b=KVRyErZf226kHFwFWGbnKLBdwu0dl2pc+Efw/fwbxWBUflQ7+eVRamb4Y0ycXgUN1gDZeyN0VUq9wg561qmM9sNEUaJsUhzkwyqY0FqrR4kcy3k7hZu+SCQBsvqYMZb5P3FlQ32yFsM4/38AXe7y8+2jAiETLGfaCaURGi981hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922129; c=relaxed/simple;
	bh=TrRB9eSTMFshhVTv54i6FklYb4hcLhMhyrTLUXbCYb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/vRAm78k28wMBqTFW78ncEhctUqJVzgdlokb1zpetPLlek6Ii0Fb0xWovuPvqxyPrGhl4bIAcPEXLWsFFzoPdYmlUwYRG/L9oRQsNJtWOIAUXzUo4IEmvHHVcXYYnqraPrsTLuGp0UIG87tQfUs4cHbwVrjgMlN1S+05REHG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cn9I1PMX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730922059; x=1731526859; i=w_armin@gmx.de;
	bh=DCy943Ap99JCQNFdm0+DrFWqO4siN0FVVrtUH3Cmqb0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cn9I1PMXTWvAu4phxywmPf/m9ks4C1VZJ2QBxhRZg3zOxa1KNerYb6J5OIjWVYBS
	 KFqgyxnS9Ao0qwqxfTOHMpYpMvVWP6VRVF6iQJUQS+GYFRqmEe99XylYTJ2wlqUOh
	 7Y4cALA1Q9+qYCp7w1+hYHZdlZkAffAXS9lVb/p1p/wUJGzt1FdxlRNHqpiRiy6Cn
	 1y5woUbBeHtv86dbSXg3cGMFd6LwluxkZ4oMe/QMszGerFc2i273cN9X5AWE7BMzB
	 CvDFN/+4Os9EN2Q7+nc7I7il47XAuMbwIzGFfk3TXxUlVVZSXDzfutjNkS7pjyuuM
	 l1o8udD+i4Jn83zFKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1tjmfy1ruz-00dkrk; Wed, 06
 Nov 2024 20:40:59 +0100
Message-ID: <5ad884fc-886e-4924-8c5b-e537846fda60@gmx.de>
Date: Wed, 6 Nov 2024 20:40:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/20] ACPI: platform_profile: Notify change events on
 register and unregister
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
 <20241105153316.378-14-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-14-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vlnhW5LMU6Ayoooc9g0qe3Bp9Bn3R8Tfu9irIjl4OZGIWzIDjjS
 nn4rRsdFqvckepg1Pel8ebZxiM0sgEvah/ZhH59a4zDPPzlXhiA0vqfqzTm5n4kqZwa+wwN
 1E9PO9g/ZkABJ/ykVjGRDx+B0ghGlA8SdUET8+FvUK0rZOWofIYtwPz+YthocFiZrpUgXFX
 UfIvM2i0cHtW63IqeSsbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3au15zX7OoY=;aZJQfMNWusAewP/Zhxn0OPND9pI
 bbaGQ9IjM/H1e/rPvrEjKgHkqD6B9o1qswtltx61w1KVdJICYwKtvIJuODpl3sk5EpTh363tf
 JXWKPmg1GxRWeAqVH6UsYmG4zJJeF4/p5/lgflYHHMRnf7YmTVeZSAuZt6X/vto24ETmaOTtm
 TKLygOSV2SlXxmtbDzLb6nNugkeZ2EWp5+C8Y1oKw3khO1QyQHf0DxuTTaaHBEHkZXPXlmecH
 AhRPZOfmHiKWS4dcEHpBkGTJypQwPD6qB/L2eATjPIIrz/OpvbQY9DPyUCb1i/ME8XS1n3Kk/
 t+UiwfZdk+yjy4bA554uHxWHTMLeyAmAvjDAEwzKWDSGkzvWJ/w3Cs8KEe1XIFXEEI7AQkdZF
 SeBo4AzblZlHapw3aZzYUs8ga1cgB7ZA2wUkgGXfahXZRhaQKtu+4XGMeivx/9jC/aB/uceni
 yvuUNKex17rdXQ7hM8hJraEjwCxogkbX3KacgeIqRPRyk2BCxZNcrbU2sIMUd7AHVX4F5gCVp
 vqUXMYMHGroYWnIUTWBv4jh1D+3eIQF3CESzmmaAvUJnbh5pF8bnsSyulohYN8kP7RMRsIFDs
 UUJehw94J1Symdc31+uPYbeQat0WYdvm35S294FsBysapRU2INELk158jyYSpGBLbc0cMcWqJ
 M/4YY1ZXEDDbwzoa46yxDfQRKM6pxAqSFk85/GYQF2+KSAgjI3nXg83IH3zuNinJJhZMBH+aE
 A5BOPuP8euwB5nj/fV0dyCvJpVET2rTDzMyGQ2tyfLF4tk/6i/YD9B4BjXNunOyrstex2AeQ7
 qSTB5x3JnUYCVacHjP61udIszXROlollmOG9lyXuFxsqRLi7QH2+UykFT4ra6L7TlVc4AiR3C
 URjhOayORfhzR5jZ0dyQogJyy6/yI/inBm3CEl5vnVKhSkYBP5OBjwN7V

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> As multiple platform profile handlers may come and go, send a notificati=
on
> to userspace each time that a platform profile handler is registered or
> unregistered.
>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 79083d0bb22e3..c9917daf683cb 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -404,6 +404,7 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   	if (IS_ERR(pprof->class_dev))
>   		return PTR_ERR(pprof->class_dev);
>   	dev_set_drvdata(pprof->class_dev, pprof);
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
>   	cur_profile =3D pprof;
>   	return 0;
> @@ -419,7 +420,9 @@ int platform_profile_remove(struct platform_profile_=
handler *pprof)
>   {
>   	guard(mutex)(&profile_lock);
>
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);

When do we remove platform_profile_group now?

Thanks,
Armin Wolf

> +	cur_profile =3D NULL;
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
>   	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>

