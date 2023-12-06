Return-Path: <linux-acpi+bounces-2187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9B80796A
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8F61C20B3D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C54B143
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 20:34:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37BD6D;
	Wed,  6 Dec 2023 12:01:05 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58de9deec94so15618eaf.0;
        Wed, 06 Dec 2023 12:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892865; x=1702497665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voGLwO6rmAuNQZR2QcfhsiCq3DHL2t4UHHcQfpvAbW0=;
        b=NM4IN/LmkHLHJ/IkolKy1R7HucHdKLugHmgif2OFxHu/aPGlFQNstTb4fz3yfLEmtL
         +TpT8OmVvQXWWX1FT4YcUbNz7JrpIVo/57gDm1eHrGcedhJBepLFFrzV2ZOpxnqeMlM0
         KTiVVm/erU/CEJMfHYGht/kwBsbSFXciwO8o6T+KTJrYOUgW58/V6KFSR1m/jsmkHjMs
         BfvOGaC/0IZXpOWS6o5jtTuPteXtP149teRdUtS1HKRImF+fbORlSCJwnier/QUVzUut
         wvbHhbXB0pfsGzL1UC7AlCEtIcxatY4TaFgmI7Ac8CSFTEBREW+x8flrcaWQcQ0/Dwio
         aEVg==
X-Gm-Message-State: AOJu0YyqTi05xfwU0+PguamtHujs84CIC9/ESq6tF9wZLcMGYOnoivsy
	YPMYnXlCWN0j6SX8oKGIp73q8vurB6a/Z0N1kr0=
X-Google-Smtp-Source: AGHT+IHOjxMQIim+NAH4ehno9AKpR5Nu9pb7TM8dBQKiP/cNoCb67G/rcPvqa1hkAJ3Vf35k3jgyTa4Y4dYwrw3R6eY=
X-Received: by 2002:a05:6870:35ce:b0:1fa:60b0:9d9 with SMTP id
 c14-20020a05687035ce00b001fa60b009d9mr2792857oak.1.1701892865078; Wed, 06 Dec
 2023 12:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OS3P286MB1951B46E88AB4A91E47A2696BDBEA@OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB1951B46E88AB4A91E47A2696BDBEA@OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:00:53 +0100
Message-ID: <CAJZ5v0gR3v3rs5nk5B61TjY8+sYeOGWD_uNBY4SKXEL0Qi4jZQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/video: Add quirk for the Colorful X15 AT 23 Laptop
To: Yuluo Qiu <qyl27@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 3:00=E2=80=AFPM Yuluo Qiu <qyl27@outlook.com> wrote=
:
>
> The Colorful X15 AT 23 ACIP video-bus device report spurious
> ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
> events being reported to userspace (and causing trouble there) when
> an external screen plugged in.
>
> Add a quirk setting the report_key_events mask to
> REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
> events will be ignored, while still reporting brightness up/down
> hotkey-presses to userspace normally.
>
> Signed-off-by: Yuluo Qiu <qyl27@outlook.com>
> Co-developed-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index d321ca7160d9..c54a364ffff3 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -503,6 +503,15 @@ static const struct dmi_system_id video_dmi_table[] =
=3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
>                 },
>         },
> +       {
> +        .callback =3D video_set_report_key_events,
> +        .driver_data =3D (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENT=
S),
> +        .ident =3D "COLORFUL X15 AT 23",
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
> +               },
> +       },
>         /*
>          * Some machines change the brightness themselves when a brightne=
ss
>          * hotkey gets pressed, despite us telling them not to. In this c=
ase
> --

Applied as 6.8 material, thanks!

