Return-Path: <linux-acpi+bounces-9621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF09D058B
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BF11F21A71
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CA1DB349;
	Sun, 17 Nov 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KLzS0lCK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDF1CB333;
	Sun, 17 Nov 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731871642; cv=none; b=hy7Kle5uLQyNt+2Zw+5mO7TfVNsxNvBqWtUqeB1r3wnf1JGHvvibBENPPxBlkwdFQDPhHsJTys+zJOE88KRlKoVj6nIXCZgI2xVeQe+P39vdsuxtIL1UDcwSIy96DrhcMo5/oxXMpj2BZI41Nxt8x3GnZOx0veuLkWRE2kfPX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731871642; c=relaxed/simple;
	bh=bTKIc8osfkMRcgNNhba4axJRGgbyk6QiluPyLW+tzck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXjq1LaUQbcHuq0HjUq5gQlMum146uFdMZjCsW0LCoRQi3TdJ9sV+K7+vBXm2O62YKeuR2LZIhf11PIwbNFb7BZynBgBSPGiGW+QM8R5O1aRGwELAA1AEeFGwqUhR/cIwPCAXUyvUJlEyDYrxHeuoKRAmTDJPgjIat8WpP1edXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KLzS0lCK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731871569; x=1732476369; i=w_armin@gmx.de;
	bh=0yJeSLMlouZ0d4ujB92mnLWqBgIH6KEj5Tu7SYni7V8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KLzS0lCKDukAkHhATEFnieyjeONhpVU8EkzHP7nZBG16OG2d1wYICeZdy8ZdiCtb
	 0UDvrC4MRbk6o8dM9gmk3WITN4RjgWkZeGC5Q6UjV2ptFBSRTVSjdZHykbfFM+y6g
	 EyOuaBp1FLHq/bSc6Hvb3fjYBKfZPseqqdqlaqLI67WYgJ7/ipDPaJzeakzlmdMQU
	 kWcbdMNOJWAf7M+hVD3EejcRWMXInyDlPpVNOI99nmfYZYKGxVndOOg5L49WBNOZq
	 /TbbjbHY8lYox2G0UFMNJVdYyrcK/5yZIx8khv9P2IctcFd60ih7ujFTFLKVQVtm7
	 ki0J9afYACyE69wjFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1t7YmC2o1d-005X1v; Sun, 17
 Nov 2024 20:26:09 +0100
Message-ID: <fe48ea0e-daf1-4458-bf84-f5590fc96ebf@gmx.de>
Date: Sun, 17 Nov 2024 20:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] ACPI: platform_profile: Notify class device from
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
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-20-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-20-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dvm/mbvdv8NXur5nvMFX8ZJBpGckSgbLEskEfUoPRkba+yXkrmK
 2EMTZAybGDXNpvw7Bu4BmPxFOgBE1krqVrItfg2ul95f917onOykCOKS9x+DKxLTP09rcym
 XssLaRpMBrj8N5m3sycYvapo9GJVwIQ1FbXWyBeKCOBknJy98thXZ0St/4uIGOqBZ5w8pG8
 UgwoSyXUewXVNB7Ck09Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FTEsjTrGLTY=;+sB7f1KZolpJpC3pkIMkNpADbnH
 zIhtR5In28Pp5MxeUmDnVoaECTlpqD08UPxyWFuDdt4coiI8C6DRclzO6W0oyoaAaRVgEscf/
 chFjBJ3WKOAdf24kOm1sxf5zNJwAzVkwo2zeaZxhuAJDPfZAXRUNWQwQKMAkN9epfS4KJUT+I
 A31DamZptHIX+8yEo2VKOa+SADazR2gkIawvY9U/grV2/eKoIReLi+YxBfu1cTlrlkhYJFOHN
 vQz71we4f6XHK3pfW4l2z0iwM5Y2ApZq+8YWZcSftn5Bnl/gE4E3tQ9suIdGaaarXf8CsLVKp
 EhNulKpCWO8KM07yvass2JeiuSm9yvBs5Ec/uxMMyNkvho6ONiNi9iSJN+I0kUGzJ1FzBJvuk
 MkghH31n5bC5vFPwYYZ/1/I3rmTL+/Ybzfus8PinMcw3I9ZoelMghelD/BPefSuHo3HoVK0JI
 Q1Ixxe+uZrVVImg63R5df8+/eemvxpWiMYDyKCGJ704731jk0cPaNRSH/4NJaz8mP19U3j00G
 wwWXDRPHP3oE9hR88kJIL6HqhYWhaxp9TDx9VdymCcGauwfKAOtWXtdKUVTNsq80L+TI0t+Pz
 Fa5wA43hygRI2T2cPdNOVzybZpBGct4f8cwRLQw4rBvOPF079ZQ1oi0eczp6MS89+p6eoWFXP
 CSYmTpuyaPr2g/m0bd1SfTXFb75yCTwQmVxRw7VjNObsoX8RPu+cXAnVipOWYkaTC8xKcXKjv
 QsjOmTvpWjjFNE9b2EDMV29slNRVe8RSG4RSeGP6wZnuK7rume4B/B+rDq6z56I9KU/9yMVZc
 KqWPKMtb8vBRBWnq+MGUk9SVpL0tPpggjgj/r/thWMMEB/XmrX+8xIzdibNW7VNvF7BGHxatY
 QTmowtom4SYiHSNZQm+ONRnmSi7KDX8pVWvOyM+coEXys0axu7fkrUbhO

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> When a driver has called platform_profile_notify() both the legacy sysfs
> interface and the class device should be notified as userspace may listen
> to either.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c574483be4fd1..7ad473982ab11 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -417,6 +417,7 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
>   {
>   	if (!cur_profile)
>   		return;
> +	_notify_class_profile(NULL, pprof);

You will need to supply the first argument ("dev") here or _notify_class_profile() will crash.

Thanks,
Armin Wolf

>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);

