Return-Path: <linux-acpi+bounces-18922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE6C6184F
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B443B8E06
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A330DD20;
	Sun, 16 Nov 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="l18EySxL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF430DD09;
	Sun, 16 Nov 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309692; cv=none; b=lh0fg9Xv5C0/TSfzpo5KmnCbCODLQ35rnDZ0AOguUL/MqEqaBfL5MMEFOvekQ/1+6NShkdL9ioM4mZW00JmJ/JIT4bu7kn/BhI67LfTZh5q75SZiGBP+9tgrnhpXOcLyjW8XvYpokiw6PXlLfNxZ+Ls6qCyRIRObBssaOtagG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309692; c=relaxed/simple;
	bh=xOu8lPUx+xa60brDbHX6DOoHU4+YYvKvhGWuH1+K6as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1JG1bvDwRBMKVWtroaI3kYkFAnpdd1nXKEGbv7cXU/aHBNj3UodYDxYs/Cf+DEpvYYzxR9zjVcYaYchQmBCfgG0yOhTahSTJCU/Hkt2mN9RFyajDK5oZwQR2KgBY6jrQueVUmEDEKfWWLmto8UqBc3EeMJdvC3/qR/tyBHja+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=l18EySxL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763309686; x=1763914486; i=w_armin@gmx.de;
	bh=7FRFiQ8pY6CizYrKJvhP5HEgg9WCA5l04MEjLNGL5iY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l18EySxLeL4jK8MjyeWB0NCHZ82a6b2oBgbj2f5gJLsxw2xJ+DBJ+Yfee87mI4HN
	 D9iDSX3koxsy6PfVbeGJ/iBhjxb87nMfgnJNnm9N+a3afvTepJk5zemA0UI9jMv4t
	 uOJk0H7WFcaZWfE0v0bbzrwN0XmRLajWOAZ8o8mH+lVuinCEO3rgx+Qr2p+L5iPNC
	 90e+seCKpTnfzS03OLvhYCAQhDB9EeRWnMZtSexlAbd7cELtId/bWV2JbFkvZq2le
	 22FaLfb2wI2CsQ89vdRXFDwBOc+02YzK1ARJ6XDMBLM5hXbOX8vSRq4bZLe4KePWM
	 zV1w6QxzSBLc18Deaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1vE2co0gMS-00EGSy; Sun, 16
 Nov 2025 17:14:46 +0100
Message-ID: <4eb3a81c-fdfb-4fea-8a4d-ae1eee986c95@gmx.de>
Date: Sun, 16 Nov 2025 17:14:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
 <20251113212639.459896-4-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251113212639.459896-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LCwDs8fgudzHzDoYT+0G8iP9xPweFEALjVpKpl6X0GiJJ589ixL
 Ma82sIFqZQ6ni7NsSnggmpQ37gwBdAEg8u2t1JyspDhVDT9/pPob+k8urT0HBs/nPc3TVYN
 bYtCY2ME4GdTZoIMoLzL24jtGLHlFta/ofrTVnfOyOwfi6/tD7JT7qTCgHfGgYMivScV/g2
 2zdPl5qkkQ+T0qE1B9FLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AJaGCx9qOu4=;qFg3y5Xj42IPa97GPsycCWCUnT8
 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
 J6jrbcO4=

Am 13.11.25 um 22:26 schrieb Derek J. Clark:

> Add Legion Go 2 SKU's to the Extreme Mode quirks table.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   drivers/platform/x86/lenovo/wmi-gamezone.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platfo=
rm/x86/lenovo/wmi-gamezone.c
> index df475e52f79d..381836d29a96 100644
> --- a/drivers/platform/x86/lenovo/wmi-gamezone.c
> +++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
> @@ -266,8 +266,23 @@ static const struct dmi_system_id fwbug_list[] =3D =
{
>   		},
>   		.driver_data =3D &quirk_no_extreme_bug,
>   	},
> +	{
> +		.ident =3D "Legion Go 8ASP2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8ASP2"),
> +		},
> +		.driver_data =3D &quirk_no_extreme_bug,
> +	},
> +	{
> +		.ident =3D "Legion Go 8AHP2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8AHP2"),
> +		},
> +		.driver_data =3D &quirk_no_extreme_bug,
> +	},
>   	{},
> -
>   };
>  =20
>   /**

