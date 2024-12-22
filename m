Return-Path: <linux-acpi+bounces-10272-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E341D9FA866
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 23:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405641882C0B
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 22:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66772191F68;
	Sun, 22 Dec 2024 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JABr6vhI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009A2B2CF;
	Sun, 22 Dec 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734905613; cv=none; b=NdJFcKOMILcZ8gP6heDn/+hlpoOpUHV8qWciAkIfi1K4BsbPceRkDMOqAZhYQXLMYTNHO9GfyLw1jebXRBg4V8RkIaznsifQSt3RUbwsGcVUDXtoCnyuawsAd17KXUy/Agqo2CB5zt29ECg+oE8NJU899wUKFlW27AXItYSNzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734905613; c=relaxed/simple;
	bh=1UPm4fiIzlhVb2H56fgXxTIPT+PYczdegzEGJDdOaGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O64ntZ9O8WEEWmwTFdTx7mRL7u4ZTyHhBebyPmlwsbH2Jxn2WCQXEyQa4azd50ahKAy6NqcPJ4NftJs+Oo38TH2eombjYSGGa9RtUKkWmdeLFM4DWCwx1+OYaQOsM50UVKwnNiWw1eIuokVfOq5sekon12KERT7IWaWs3RTQvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JABr6vhI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734905564; x=1735510364; i=w_armin@gmx.de;
	bh=lEBbXi1WrH9fKTLSx2dIlKkkhZMMuyo3GmA10w+rMug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JABr6vhIsSKxoxlQDUaz4w60OneIwsF8hWU+3Bk24r9t6ctsphmvGuOMNmjvhkbB
	 czqciIQIKJD68WRbFBCuE03j6mZVYEPBUPWEVcKtckyrTViApBiXUs94rE2GJWqxl
	 2cD1qameHTKCqoZo66ocPJKN+eccIbrPY2nnoXbnCAUytjiLesSCqFCf078ExzmLm
	 GDKINPKFdjYPJ6XD8w6HNt8Ew5kx3XZQSbNbC3ZFuKMfUKuAAVlLp+/L9DrnRPXwu
	 v3bfLh8GrHOOma7UbhW2ukK9PgN46QNULE/9pXFk9x96OB5beHUTh/CG+/6g65xCL
	 9QUfi5xT+5I9DY+yqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1t6ZSS3zlD-00IiXD; Sun, 22
 Dec 2024 23:12:44 +0100
Message-ID: <3924cdc3-0833-4cde-8473-6cde8513fe27@gmx.de>
Date: Sun, 22 Dec 2024 23:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] alienware-wmi: Use devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241221070817.3764-2-kuurtb@gmail.com>
 <20241221070817.3764-5-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241221070817.3764-5-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5DgTJ/GWuvGTbJj5ZwTw4xSQ6LKVl/xMoNgEFkFVQJ8OdH7h4lZ
 he4lfxmiU2jXoKMhxfVHT9Yw0MyFZ3K8rwxJAd8gLLqMetdXaiS/H5crKP6UX7tjFSBJBsz
 d4x4BhzykJTO2ez3IOr5oErjD3GDbIvhAxV+mWPMCAYdcezAfyMRA+Up/3VeJt/RIhxkSZ2
 +pOQF5chre6jyBJ31Lmpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j0aFrzsHxnk=;lm94DWojAjri3lRJ97ztJ/CVvwq
 2gVzdxuXxihVqvOXkIZIFl7CabtWL5l5zy9I2eNsnH+2VKi3kdJCVKI9mkTI45awmDjqhhnFQ
 ijYi7PALOP6kErshL1K1meyg0tvRkvLFsZqEc62o+cSKoHzdc5rN2MwmzXUvmEJv7DblMo0SI
 Nlkc73OaRknfBuQJBqtgbBPhdbgoEBl00nhe3N2Qh2i58AL1hnIZg2FHxaxpG/qjciO1Lffgz
 sXQeOQlwq8Z3g5sTCPdfp5QCqLP4m3Agta1TBbhhTDxtqKVRyO8lIxFlaijQzF7jDiO52wQGx
 bP0Fif3yLSEwUiDjOyvXTP0Bq8M6xD3VxMfOTP41hoDf2LYZ7dS2WqmMFQ7iTpDikBjk/DBb1
 xepHluRfo6Ow/g5rbz7VdsN2gxxWHiyeEhntR5NwroLH+Gr3GVTwVsmekvbMYC5tSna7TOo+t
 kjX1al+DwYLTnSYaA6I2Vy9jipFMUJEfjET5yGr7VrivvFDZCU6lhd4ui0gZVHwQvrfuwWvoW
 pikVPAyic8JzEWVN3UBp2IIRel6i/9sxImn9exyz/tlo6ENGkZpCuIGq5aYM+J+BHWnV90HbC
 UVurFQ+Bw3JJjScfbXr+U1TCPJir1jb1c4qzG7s/QvyaVt928NiITTV1QmI7+6NEvyhptv+Th
 0tDLZ/YSG4UHap5+eDAaPQw3FRiI+getciknJZ/lLnyX2THAF89FtnaNWSB4kFnhH40/lNZQc
 8YiTg55oOpq3imP7p4klyqaHmyOiv4Gxk+i/34isWHjWdIM8uCKsNeKpBkT0znsG4aUxjhmnP
 E0CM0ruV+Cb9Esrzt9nZf85DGuyCqMiuW22jvjJDxEizZQSNAA8FFceEmxs/ZS6gRrnUTxGpr
 1S86F7GRM2Mfg4Or9gmeb73J/zBwxUpGE11uYkA+OXi2CnzdzA1SWojcmYsmMMKnBzC7E6AxS
 OMWEp1IffLJZwPcYoaLn43f4DxzSLMO7WpXSRFJmqNUY4YT+kwH+MKu1lJqxzrwRG7ATL4vVG
 qlkki/IGegS9cDzlPnZmcpq69sIuZOCq1X00HCaynUaL1xr0aMGYhHhjJP6JSDMjwwLHGGWQ8
 JIRD5fV5/nkio3y12XXsvT57PG6PuV

Am 21.12.24 um 08:08 schrieb Kurt Borja:

> Replace platform_profile_register() with it's device managed version.
> Drop remove_thermal_profile() because it's no longer needed.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index e95d22c7b60c..7b3ee2d6a23d 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -1159,13 +1159,7 @@ static int create_thermal_profile(struct platform=
_device *platform_device)
>   	pp_handler.name =3D "alienware-wmi";
>   	pp_handler.dev =3D &platform_device->dev;
>
> -	return platform_profile_register(&pp_handler);
> -}
> -
> -static void remove_thermal_profile(void)
> -{
> -	if (quirks->thermal)
> -		platform_profile_remove(&pp_handler);
> +	return devm_platform_profile_register(&pp_handler);
>   }
>
>   static int __init alienware_wmi_init(void)
> @@ -1239,7 +1233,6 @@ static int __init alienware_wmi_init(void)
>
>   fail_prep_zones:
>   	alienware_zone_exit(platform_device);
> -	remove_thermal_profile();
>   fail_prep_thermal_profile:
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
> @@ -1260,7 +1253,6 @@ static void __exit alienware_wmi_exit(void)
>   	if (platform_device) {
>   		alienware_zone_exit(platform_device);
>   		remove_hdmi(platform_device);
> -		remove_thermal_profile();
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}

