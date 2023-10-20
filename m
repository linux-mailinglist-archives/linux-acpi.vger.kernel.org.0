Return-Path: <linux-acpi+bounces-786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC3E7D0D74
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98039280EB9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511DE17981
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KF328bIS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772912E50
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 09:26:19 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188A19BB
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 02:25:51 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-457e5dec94dso235012137.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697793950; x=1698398750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3n+mlq2jHg9E8YngtT6r3A6TvxLTC271t27uMu4pVM=;
        b=KF328bISD+4M1PB2z/MYZMag637w/BRFhy3SddegTCZdoDgOAD+rY0LnugvHoUD5eI
         ZpFLlwqpwaXiG/xDVkYXhPH4pDbGG9jqKGCU1v1um3vxX/t5GPmC/7mzA7NFge7pLG0V
         rpbDkVG7k2CfW2OJ7lUByWUokEyr/zoBiR8fEpbO68jcp4Vr4K95TXi1GB1TZhbgYGCY
         GKp6hhH80sHfeqjpY5BD75zobu3ucSHGInQwhYnetc5exR9I8G6NPlUIrDu1sXsF9Zw2
         PInbb54lw87LkO0K7ro3qUXxAgxEPiEFlCFcUWqCcg/11MPUrb+fHsQVtGSna8h2k9pC
         cidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793950; x=1698398750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3n+mlq2jHg9E8YngtT6r3A6TvxLTC271t27uMu4pVM=;
        b=nAIgNmlH8NDv1wTN/HKv7KDEWg0DHCMw1HLVOBK/VG1XeCatd/nNLGC+5zdXFXKkAh
         el21VpKdn6yB/76dMr71tcZ78K5DwwKfdgCZ6EqPNdL0ogvcy/V2bvqrPnTMds4+Kqmv
         K4V1PduFsMn7CQFICrmxBj6NxamEVGVKnJ5pdp2v4HU3UEot8wMHPhduTOCPiw7ZfMx/
         FqnPSucK2EjUuSgjra9WWQYaL2/Gn+swwfteM0BpxuXvDQs1KObbDuEdv5ssWguksw+b
         wVD8kFJbVpAiqhQa0gNaZcxADf3OdWQ0/YCPaz9hh6JRrxXX2nS85GuVQbr2N6/1mTD5
         A8uw==
X-Gm-Message-State: AOJu0YysUYUxKHel0+tdRFiSnTv8oaKG956qMA58pFkomGuO8lKc+Zx5
	O2s9k+zNwYSVP58eaDxnJ0RggjCM5RPUZ1lQW4eD3g==
X-Google-Smtp-Source: AGHT+IG78QH4iCELlvODiA2UrDujM1It9T1JK6XJ0sitNznrXFFaz/6tEuwgLLb8ygvnxHc/PCY8Pjkn76SgvSJLisg=
X-Received: by 2002:a67:c00e:0:b0:457:bc94:fc9f with SMTP id
 v14-20020a67c00e000000b00457bc94fc9fmr1330423vsi.13.1697793950031; Fri, 20
 Oct 2023 02:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-2-andriy.shevchenko@linux.intel.com> <ZTGBcJl2flL_HVX_@google.com>
In-Reply-To: <ZTGBcJl2flL_HVX_@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 20 Oct 2023 11:25:39 +0200
Message-ID: <CAMRc=MfnOnkmQJTqrJGeNE3x3yMxbiZAh2r2bjxqjYOwScokiA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Ferry Toth <ftoth@exalondelft.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 9:20=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Oct 19, 2023 at 08:34:55PM +0300, Andy Shevchenko wrote:
> > When refactoring the acpi_get_gpiod_from_data() the change missed
> > cleaning up the variable on stack. Add missing memset().
> >
> > Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> > Fixes: 16ba046e86e9 ("gpiolib: acpi: teach acpi_find_gpio() to handle d=
ata-only nodes")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Although I think it would be better to change
> acpi_gpio_resource_lookup() to take an index and return a gpiod
> descriptor and have a local copy of the lookup structure.
>

I queued it for fixes as this is a bug, we can improve it later.

Bart

> > ---
> >  drivers/gpio/gpiolib-acpi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index fbda452fb4d6..51e41676de0b 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -951,6 +951,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(s=
truct fwnode_handle *fwnode,
> >       if (!propname)
> >               return ERR_PTR(-EINVAL);
> >
> > +     memset(&lookup, 0, sizeof(lookup));
> >       lookup.index =3D index;
> >
> >       ret =3D acpi_gpio_property_lookup(fwnode, propname, index, &looku=
p);
> > --
> > 2.40.0.1.gaa8946217a0b
> >
>
> Thanks.
>
> --
> Dmitry

