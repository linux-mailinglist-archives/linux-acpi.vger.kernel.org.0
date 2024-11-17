Return-Path: <linux-acpi+bounces-9618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578699D0558
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD06B21A4C
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA01DA61B;
	Sun, 17 Nov 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="I3Pcr1/G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DB1D0E36;
	Sun, 17 Nov 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870178; cv=none; b=fEopw9oy7BikPn1GmqALDmr6iSxfCBEyrVz8SZKGmiUBkjIKiOOMzyOBpoBh30uwQnQxN8qi5ctRUk1x8vyiiDfS1KyxLwoOQQLwFl8jYx/m3PcsM62eNEAL8Wv+xnmXjvie2EyWDXqMrwPxTKZ7Zy4fgWDcG1/JITTvWSuLzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870178; c=relaxed/simple;
	bh=Lw3hEkaqvUudB4ytkanOU1jp71QB+fTzhzxvZmxS3Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJrGDEQGuXQG8VwZZCf4aPIi0pkZJqrAtBfntoSz/MjyUGKQqeP3qx9ealWB0Y920b0uvNkUnxFrc1spyYKngAnYlYD5BfGTWTkTOe7NGAMG/2NSaq58yB6keT4Sdz5RaaDZtIp3O/Lw92ZVmMYawYSO25jsPH/Uqa+ODFRlMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=I3Pcr1/G; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731870087; x=1732474887; i=w_armin@gmx.de;
	bh=nRIITVM0WFkzB4GZFMCk0cmnjt/A2DrmRHjtImEvYs0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I3Pcr1/GX2gJGCM3+akXON0nQhIXhw9EIN3UcMWSQNGB1wFHZlrXoGHILCT3UkmS
	 FB88kkVsxbCpmv0VKLmp/uxehUtjr1xa+l5rbPXuSQO4pH942QxJiE0pw7S5VmvM+
	 FOnEtdjTwIDQZP3zrr3BPX39uYIwMbezcVsie48w1sNAsZGTV8EyRUAlZL/89BzK9
	 G8g9VNMLooEk+d5fB8L67mWysa2iGWstTx7HMBdX8lrHvkz6OZsytdR9H2ZRJEXf/
	 FYofo7hEeO3hxq69omz7oIFJjnI0TEUPIBV08lXekje+GdGgZeP6ST9gAtJBk+mYZ
	 rlyC6Ohj+wZnXZxFOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4axq-1tDIUC3oxC-0048Ca; Sun, 17
 Nov 2024 20:01:27 +0100
Message-ID: <24ece4b8-62f6-4962-8704-f052fd8a1362@gmx.de>
Date: Sun, 17 Nov 2024 20:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/22] ACPI: platform_profile: Pass the profile handler
 into platform_profile_notify()
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
 <20241109044151.29804-6-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JUrtsGwTEjPUVs6MkcJMt9YBkXnc1EhoYVfODZ2MhuBsi+wcElP
 Ljmuh35XB9KxVTHF+zMJ/rOq50w/Sx+uXRtTqmO+QHvGIb71XEXJvBLSeuQmLishhfd4p52
 AnBkpiAX4DRaA9msy4IUzc+wtFAbzWoovvqEKa/BicAwkOI+7eoU2yJCq/yiqlvaNYwkcOa
 fEv1j26dzspt/GV6cJIrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hKKfV50YLSM=;iMbgT0GG8Y5mszBX1ysiVgjOjk2
 4QwRzCHseKn+5gdavyu7bxoNmUEzp71bOyh3WgjX2DYfPCc3sLwBmkAwNc9/RGT5HFOKbMYoa
 UzkHCqkvGIc2tWczjyozSNUC7G5ufboUJc9GUg+slZTxyUN0SsBfUC6y9i7BZ/0zZS8d1ZKGv
 xYKYWQRAwd3CHr5Ocv+fy9d05GQ28dftNLrxFwsj+8+LDym+MX1Rx2ZXin16mKYkyTNWIBICj
 AFQTr7gRPhKIXjPVRniM+uK7UR8bY6xXN0PVqnVsygppGqiHvRCqjyA54uYpoJbIxWITlIQ6a
 ChHB1N+AuQxep2JQt+2bDO6md+Bxqz6he/Ibz2ZJ1gNw72xm9fhqwnGI8JQdJXWCLKLYxuQkM
 4mP59j7/30/p5PsGXSazv3ToHGxNi1e2ZoXWwM1madTKygLAIptBLQ7pjqJ2fK/tq37lR0OeU
 Wpoh4IuToQTfafTggo11QvcwOoR8Vtc6VV7AHlJLj+4xHkMmc7nBqC05bn5OlAJDzfsv7Cm06
 vgPI9+Q0NAoQwav68I4XdI0VcAmU0ISebaLZxErvhjCIMn4k4Y+KDsITysMbrV+It0+PgrRO8
 4pT4/T9jZLpSaDcaY+mibQ67AqlupL5TTQp8vPBaXxF7ZXV+n1W4ClYDH6wnsxyr1bA0NBaa2
 NFZ+cV8SqvaoSB8K4WEdHubEDZ0UXjFEfvmkU/tNtCRNJqKvc613iX1DXS7XUgE1RTS9qE/Fw
 5qCRBKT82knW+sW0HhlIHeFA0gexPbeQCy5LkF9a725aLAxV0FsVik6jq8Nb+2UuJXlV+kgqH
 i3A0JtB5rJqFrTe3YbHUwo6ZPE7hE0IaBJ5Qqf+PZ9wK2HUufoOrBWI7wD6M52ImsxUxDOnnK
 CDXZRKIgiROVijmuuV+FPYB6XJ8uJGq4st4+cVAiZQNy5hM9pJmCugGb9

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> The profile handler will be used to notify the appropriate class
> devices.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c       |  2 +-
>   drivers/platform/x86/acer-wmi.c       |  2 +-
>   drivers/platform/x86/asus-wmi.c       |  4 ++--
>   drivers/platform/x86/ideapad-laptop.c |  2 +-
>   drivers/platform/x86/thinkpad_acpi.c  | 14 +++++++-------
>   include/linux/platform_profile.h      |  2 +-
>   6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index c24744da20916..927a2f7456c9a 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -128,7 +128,7 @@ static const struct attribute_group platform_profile=
_group =3D {
>   	.attrs =3D platform_profile_attrs
>   };
>
> -void platform_profile_notify(void)
> +void platform_profile_notify(struct platform_profile_handler *pprof)
>   {
>   	if (!cur_profile)
>   		return;
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer=
-wmi.c
> index b12965d9fcdb7..0018818258070 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1988,7 +1988,7 @@ static int acer_thermal_profile_change(void)
>   		if (tp !=3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
>   			last_non_turbo_profile =3D tp;
>
> -		platform_profile_notify();
> +		platform_profile_notify(&platform_profile_handler);
>   	}
>
>   	return 0;
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index 0750e2fe65325..2a8d789ee05cf 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -3754,7 +3754,7 @@ static int throttle_thermal_policy_switch_next(str=
uct asus_wmi *asus)
>   	 * Ensure that platform_profile updates userspace with the change to =
ensure
>   	 * that platform_profile and throttle_thermal_policy_mode are in sync=
.
>   	 */
> -	platform_profile_notify();
> +	platform_profile_notify(&asus->platform_profile_handler);
>
>   	return 0;
>   }
> @@ -3793,7 +3793,7 @@ static ssize_t throttle_thermal_policy_store(struc=
t device *dev,
>   	 * Ensure that platform_profile updates userspace with the change to =
ensure
>   	 * that platform_profile and throttle_thermal_policy_mode are in sync=
.
>   	 */
> -	platform_profile_notify();
> +	platform_profile_notify(&asus->platform_profile_handler);
>
>   	return count;
>   }
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x8=
6/ideapad-laptop.c
> index 80797c6ae8b0b..79c65c24b433a 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1041,7 +1041,7 @@ static void dytc_profile_refresh(struct ideapad_pr=
ivate *priv)
>
>   	if (profile !=3D priv->dytc->current_profile) {
>   		priv->dytc->current_profile =3D profile;
> -		platform_profile_notify();
> +		platform_profile_notify(&priv->dytc->pprof);
>   	}
>   }
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86=
/thinkpad_acpi.c
> index 13798c6d5fcf3..8539cac042be8 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10516,6 +10516,12 @@ static int dytc_profile_set(struct platform_pro=
file_handler *pprof,
>   	return err;
>   }
>
> +static struct platform_profile_handler dytc_profile =3D {
> +	.name =3D "thinkpad-acpi",
> +	.profile_get =3D dytc_profile_get,
> +	.profile_set =3D dytc_profile_set,
> +};
> +
>   static void dytc_profile_refresh(void)
>   {
>   	enum platform_profile_option profile;
> @@ -10544,16 +10550,10 @@ static void dytc_profile_refresh(void)
>   	err =3D convert_dytc_to_profile(funcmode, perfmode, &profile);
>   	if (!err && profile !=3D dytc_current_profile) {
>   		dytc_current_profile =3D profile;
> -		platform_profile_notify();
> +		platform_profile_notify(&dytc_profile);
>   	}
>   }
>
> -static struct platform_profile_handler dytc_profile =3D {
> -	.name =3D "thinkpad-acpi",
> -	.profile_get =3D dytc_profile_get,
> -	.profile_set =3D dytc_profile_set,
> -};
> -
>   static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>   {
>   	int err, output;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index bcaf3aa39160f..8ec0b8da56db5 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -39,6 +39,6 @@ struct platform_profile_handler {
>   int platform_profile_register(struct platform_profile_handler *pprof);
>   int platform_profile_remove(struct platform_profile_handler *pprof);
>   int platform_profile_cycle(void);
> -void platform_profile_notify(void);
> +void platform_profile_notify(struct platform_profile_handler *pprof);
>
>   #endif  /*_PLATFORM_PROFILE_H_*/

