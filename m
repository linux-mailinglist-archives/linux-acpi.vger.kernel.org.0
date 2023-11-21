Return-Path: <linux-acpi+bounces-1715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBA7F378C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 21:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E1F2822BC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B0A487BC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636B19B;
	Tue, 21 Nov 2023 11:49:38 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-587af6285c0so550692eaf.1;
        Tue, 21 Nov 2023 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596177; x=1701200977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FRB8L2BFXCqVe1FSVyDwiIP934VPN4CvJ7Olvn+VsE=;
        b=DZLsoeuOeRQH9uA+J1JXkdNuArCgvCcEmucICo0mCyBr4OAW6Fl2Wv3l6rT4MJJCOJ
         r+hsFZ1gZT6wcLn+jf/AbMmay09KVNkGVJSOdyH5btOD9ZaIUaZkwYAQS0FPn5UbiM9S
         531uiG/3jGvuHaX22mw6HgxcAU5qMHrM7Y0Ft1FFtFFntA52C4DHceXcXBEVMueXKeJ1
         mg0kjTMVKkx6Oi+AV4vyOpTmRboFWe4hlLwDCJCE+vMS8WDdXY8/rzAEtyJ09QTlv3hK
         pMDbN/LKnCXNZiyG4c1UQIEYYAN7oJlVtIaagHZ/AgpWM+fHkfjqihLz4T6DZDQ4XJBh
         GpMw==
X-Gm-Message-State: AOJu0Yx2OBBZu4tJ7dELl9uTu1j0XwRofV/HSX8jVTfMTsF7yzoIVWtd
	Yg5nj/CcEcTdsSINoGGqrMDpbO0hQfGHvd3SqBfdXla5
X-Google-Smtp-Source: AGHT+IHszKON8c3K4slOi0TCGKHAR8YZMBGl01M49UO3RTDfMtrN2AMKaO/S2C3+gqH+beTHNY3LUeme1NyEwF8c/Jc=
X-Received: by 2002:a4a:d0b6:0:b0:586:abc4:2c18 with SMTP id
 t22-20020a4ad0b6000000b00586abc42c18mr512137oor.0.1700596177577; Tue, 21 Nov
 2023 11:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
In-Reply-To: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Nov 2023 20:49:26 +0100
Message-ID: <CAJZ5v0h8GhHDguSuO2v05k15uQyYvNqUpO=Ott=t8-QdoueW4g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: check for error while searching for backlit
 device parent
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 2:49=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.ru=
> wrote:
>
> If acpi_get_parent called in acpi_video_dev_register_backlight fails
> (for example, acpi_ut_acquire_mutex fails inside acpi_get_parent),
> this can lead to incorrect (uninitialized) acpi_parent handler being
> passed to acpi_get_pci_dev for detecting parent pci device.
>
> Check acpi_get_parent result and set parent device only in case of succes=
s.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 9661e92c10a9 ("acpi: tie ACPI backlight devices to PCI devices if
> possible")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpi_video.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 0b7a01f38b65..1d550887349a 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1717,12 +1717,12 @@ static void
> acpi_video_dev_register_backlight(struct acpi_video_device *device)
>                 return;
>         count++;
>   -     acpi_get_parent(device->dev->handle, &acpi_parent);
> -
> -       pdev =3D acpi_get_pci_dev(acpi_parent);
> -       if (pdev) {
> -               parent =3D &pdev->dev;
> -               pci_dev_put(pdev);
> +       if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_paren=
t))) {
> +               pdev =3D acpi_get_pci_dev(acpi_parent);
> +               if (pdev) {
> +                       parent =3D &pdev->dev;
> +                       pci_dev_put(pdev);
> +               }
>         }
>         memset(&props, 0, sizeof(struct backlight_properties));
> --

Applied as 6.8 material with some minor adjustments in the subject and
changeolog, but please note that your mailer garbles the patch context
lines.

Thanks!

