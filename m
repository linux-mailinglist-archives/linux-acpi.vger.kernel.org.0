Return-Path: <linux-acpi+bounces-2965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C2835DA1
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jan 2024 10:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47146B21188
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jan 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7538FAD;
	Mon, 22 Jan 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FqAtyt4T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1893839A
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jan 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914383; cv=none; b=kCT24LuSSnxa6QQybJSpGaVfTIFEzQW0rKUjCqQETYOTYSzz1EpjrVvHdI80VZ6hOGtkcGTLVL5kjg9OGQAblmKtAsSHLY8iHQBaFi//JJKIUFxqKjPKpMUA7eIusbNWTf0i8e0O5mpImRh346I5Wwrq0DqtDhnHWJ/urobvLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914383; c=relaxed/simple;
	bh=Ohy0ZGwqVFZ2Ynmb7PAYjwQ1AwA+GNIglKipPv38KOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTYFl0PnBxsmk6KIh0JFZqDJLTGK8hbrElZtZbfH/Eys0rtkNsZtAyv4NcsEmoGnTS1yNpqDv53pIBxbTL+qkpdpLTpRhQju+zCQfxWmRN2fwWIs6M3YPVRCEK9TYnCt7hoFQVOPj9Irz5VbsaQ3OUShaYu7odUqsTsjrGYnhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FqAtyt4T; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2de2cc440so153133241.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jan 2024 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705914381; x=1706519181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=FqAtyt4T5z2R4h3yKIT8Q8g+SIEah/KSfX4E3GL29mSUBgH7KlL3jDyU/FMDBUNVJG
         Q+p99BTjC2Wz2G4XJCQvUJZSwR7K2PflT3SFRaDhQNR3iZr2QcTJYQJI9u59vX6YPm+m
         OL00+6Qd0w6VwS3LwcsbHKHjX0kW1eMSDAb1OQfGNN8QRBg0xT/UaszAO7PZ04AIzLRW
         8A/2Fss21nwRpIOnVtjHV2iXkatseMBi0LkXsnAu38DgeomRb6LcIN57Zi0yugjw9gWh
         t2v8BjcdQWAyitzXnBiLzZEvHIO6zBz443+QWhIcfX9+C1nB2Hj+ssj255k0VkPVLR0Z
         UYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914381; x=1706519181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=qQxWfSE3z7eOb/zDFzh/xJf4IJPqsOmukWOQoOBEvoqVbe2nfoFVh+GRxPOyEIda8T
         sFHEKo26fuveQw0E64ZwmcOmQcVNrGmfsrE9fU+JwZ7opozrBLpbpfIPoRCPnes5uOdT
         tmMHMCQkReRhjyRiWh2ijoXcv43wp339EHasnKoVxwsiD2P41HO5e8y5FaKA4iLJbcO1
         ggu90i4VTt8tF733zFqnO6DKhhkWX0uiNDawvqazlAtr2TfxJGZB4qw8CkXrwsps2LNk
         4oSWYKCuLMF1cPf56bJ45vDh1zSWypyREXeVhu+45YGWb/oPv1w4VutKr+iqtr8fb/Mh
         XouA==
X-Gm-Message-State: AOJu0Yx6DzBGqKSgeBOXATaQVcmZqN7j3Y2RierWrv2aaeTr3y0r5/bg
	L0LWzqNTAoaoRKFj1u6YmMCsQUgTvrb/WStbBFvgqUtaa4/in6B2UnO0d6TXBeVu2rcmuwAY57j
	FCfnA1/xQ3jVVXE+FXveYd+jeJ7ox4Es7UI7MCw==
X-Google-Smtp-Source: AGHT+IFfrOIr9bAUFkITg4Xb0WVWPc4vGtm9WQHIVP2Np7ndI6gmd4BUBnYr0dkPWJxnfhMP9tfiz9rZimSYJWdhN5M=
X-Received: by 2002:a05:6102:419e:b0:469:b52c:cdac with SMTP id
 cd30-20020a056102419e00b00469b52ccdacmr398531vsb.5.1705914381000; Mon, 22 Jan
 2024 01:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117142942.5924-1-mario.limonciello@amd.com>
In-Reply-To: <20240117142942.5924-1-mario.limonciello@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:06:10 +0100
Message-ID: <CAMRc=MeUr6UYdWUudsF+6RvoCXsYxBDtw+2k2oJANvpNsBHPAg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org, 
	George Melikov <mail@gmelikov.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:29=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Spurious wakeups are reported on the GPD G1619-04 which
> can be absolved by programming the GPIO to ignore wakeups.
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: George Melikov <mail@gmelikov.ru>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 88066826d8e5..cd3e9657cc36 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1651,6 +1651,20 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
>                         .ignore_interrupt =3D "INT33FC:00@3",
>                 },
>         },
> +       {
> +               /*
> +                * Spurious wakeups from TP_ATTN# pin
> +                * Found in BIOS 0.35
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +               },
> +               .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> +                       .ignore_wake =3D "PNP0C50:00@8",
> +               },
> +       },
>         {} /* Terminating entry */
>  };
>
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart

