Return-Path: <linux-acpi+bounces-9727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF69D5587
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11214B23A94
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB701DE2C5;
	Thu, 21 Nov 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ibkaTQ4O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646541DE2B4;
	Thu, 21 Nov 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228366; cv=none; b=gvGi9AcgjlR7uVfYwFHREza/XUmV2Nd9yao9PsrFDcO2T3uEEDl0WTLtBydMMoTN/yXoIbShcXQ53dxogzYoumsnziV/D5jqSQco6/oMd7bPgJBCgO2SuywONobDNulxW6qo/5fFoxH1iVRCDZdOyeOF9aIFcXYPJ+J0c9gLGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228366; c=relaxed/simple;
	bh=yLXcD7EcMzw9xT0WwrAiCg8Ub8pkccyUlE0tO5U6joU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wcz3UUWi8B6j/2FD2DwRH0BvtG1I9glui6ECO8ri6FUhKt9rTdYJVeuSJ7vyxLQAqlvz/8B5Tof//IFuxvCtKpH2bfo+AsA1XYtx42wpJ6SPFdUHPb0Re7o0PYXT6lijAm8AembppELk9IueM/fPnMlNG9lw/IF5QbBNfzOYTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ibkaTQ4O; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732228290; x=1732833090; i=w_armin@gmx.de;
	bh=14fUGPbX8Lv0O9UwgU8VqOQ9m/mAK/lhmr5W67lQWz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ibkaTQ4OIDjR0k7SdfSzPbQ/oyl2XHYBGRien0O/Z8/VHruz/0JlNmxSiAQw6Cgf
	 I2wRYLI2fILyfh6ZggnGWb2JwByynmeW9jg6vsHfsSP8Ywk2W+jwd+Fe1xSBapNEn
	 NCz493GsbBqQTIsekJ5NSsKkv1HXsd6y3o1LKT5LZtR3orGOmHaQ8a+LfAAVt7Q5R
	 YzTjBNAaTJsiRHwgWnZW/AnWKvywAfai2itDWUtAqOme960YILQOJNsWVZzRoQ06B
	 APev0uQ1LPyheoBjOiWixT5Snh8mA4rg0sMqsCt0KMAp+xmqrJsj22XgM64k089b3
	 R3ayKXorc2ErhbF8GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.129.90] ([176.6.148.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1tnJPV2fSa-00alXh; Thu, 21
 Nov 2024 23:31:29 +0100
Message-ID: <180cce53-d778-4ab6-b54c-41c13b4929d3@gmx.de>
Date: Thu, 21 Nov 2024 23:31:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/22] ACPI: platform_profile: Notify class device from
 platform_profile_notify()
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
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-20-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241119171739.77028-20-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AJQAyobA8wZvDwtD5ZtJ2PZxsr6E9H/CUsQZRmspXpyB3/OU3RU
 jGhhWUpWNvBaJYALNVV3jqCF2kWcLncHKz8JopjlWEbQfEY18yIEYcQywsJ/wx0wR3q+toj
 IxacUruA50C42EAS+GA7kxogvWhMWrodI0Y+i0korI0tXMHyGvXXENIenqeIcK3+NJSCWmk
 ETwLmpKIMlC8tLArntZVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xfZz7REQkaY=;Unlox4losSV9H6k6t21x1MxYp+X
 YBvt26xCqHDUN7JVSC5KJEgMhm+yDkgEk2z4gZATXftmwpx4CR5+b6hUBypCu5Dpj3rUQOYex
 7l2vbcTmiQf8ncwOlq4ZyovVixeC/7lH97gTCS+yv6uEwZovsjTyQPlUh/mOZgShq4Iz/Vn3X
 ZSOLUWnRm3FehBwPT6bQ667LePGmWQDqst/TsDKZQ+LG0iPH10Ca8/7vrAwBRtcVif3r6oB+h
 iGsg6mq2Iq5pG1JR6DylnC/AxDeHf1PJjrot4pKR1piYfULei0CujSC4oW5IjEVhg4u2OrQHP
 9ko5e+taO/DmoFTKUhg4fdAnuQpxaMVHTSm2LMqb3HTiSKGZRUlxqW37wAb0koppeAQ2slctN
 u/OB2GgGGpUo85tZo+agYU2718GDw14se0L7JkBMjBtCHLYcAugO6Btn/G0Kwbh+RtAUBPqV0
 VEPTC+AxsDb76JNp+XZMI8gLsdemknwU8XU7YnNfy63oZIBP2KBktQEtPCCHGm8LEbgRg4dab
 HPWZKwe81G3BRGrGO1wNiedxH247znG1C0qy2xXDJvalNs/BkrULdZK6elzA7IwQX1k3D4Z5d
 MyrJdo70OuqZdYDAV9dQu7O2tT+NY1rCSXcs7ecMTTGQez2F81AbsedwkLE031PMmCV9W3Xcf
 2bge4tX/s8cUjITQ6ilxfYAziAaYZ0GQVc1X4/WoXi/Hd/zIeFZhD9GCKR6biTrmpQVzzPXIK
 gxkV8ZyZiK3HQ86WfX1Ec7TDKmAd3brlmrMn33UP17IaiAN0LMO8vep4K7GV14ocB84FLlarV
 YB9fAmWZoyVDpNZy2cLCvfZp04w0n9YXK+k/fn1kyS74ZWsngmGLXfTZrxr4mraHbm7BEsjRM
 4iMyNg3zCj+O1czGqK6+rf4YxUUxi2OlNZKXjCDBD0Iwelw77LOCTGbrv

Am 19.11.24 um 18:17 schrieb Mario Limonciello:

> When a driver has called platform_profile_notify() both the legacy sysfs
> interface and the class device should be notified as userspace may listen
> to either.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>   * Use class_for_each_device
> ---
>   drivers/acpi/platform_profile.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index ca997f4e9a5cb..e88b355a72112 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -402,6 +402,10 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
>   {
>   	if (!cur_profile)
>   		return;
> +	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> +		class_for_each_device(&platform_profile_class, NULL, NULL,
> +				      _notify_class_profile);

I think that using class_for_each_device() is a bit overblown here. He only want to notify a single platform profile,
so using class_for_each_device() is a bit too much. Using _notify_class_profile() is enough.

With that being fixed:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +	}
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);

