Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3F79D01A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjILLgL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjILLfo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 07:35:44 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8B10E3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 04:35:40 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44e84fbaab9so2250115137.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694518539; x=1695123339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5x6b26ZdHYHP2N0eDVcAymc3RLuscE6Jeslkj11N9BM=;
        b=VGY7v77bvZ9/BgXEeoczrUauW1FIfTvmVDkiW9DF8+81MAS3yzMne3RMxvf5r+H3yD
         bCVLeaORoZIBiJqiypxkStozPKyk87Q/xlLMiFnZ7j11oQt7gnC6rVEMMCbV98WPljv1
         Muvnufig5bFuuvppDiPao6rrbeN+mL56sYtLuL4I1edqBraH9VXIE8sJ3cmclFQXwbts
         JP4KqMMWWS2Mkz8yRU3uacKBqZZJO7TqQVhQxGwQGsG/bB1rWcNn+EXeD1pKf/SbJcjp
         JeXWTIoUumyu+h80vhIQkti8TSNQ9NSkHg1P+++J8c66Lqa330v6jfgCf259NqDBdan7
         SlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518539; x=1695123339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5x6b26ZdHYHP2N0eDVcAymc3RLuscE6Jeslkj11N9BM=;
        b=fzWEWT5V/1ptrsxOo46Y8Nscdgl1OGUAKl7VtRlWtUBIUqQD9Pi1FdrK48flx/iBGv
         66ugbKAWOlQcGprtlpkOLZJ5Udut7LlSTp5iObMDlZDbf7h066Iraszc8oNRL+Ayd14E
         w9aX2igSnYU+YZHqQ2cgNiprfI6kKiTFN/DZ/M8raqfHfyy/rDNGEyOhFYUbrXfAHR90
         ZHjJOqeiyNZ9WFwiDdcrvrx2HSfmIxHUj6B1sq6h/q2UsDsrbTq/CNdEhxVUsUcEgv0E
         Nny6S3Am56Z5Q95fkj3ynJS2J370uQIJYR/FFM6yxXUSCdAIRkAdJZHg1REDW0WOfdud
         dmGw==
X-Gm-Message-State: AOJu0Yz8Xi9b0rojXYeR7Mh0r7iHhhKFoWN9OGbllDk7EfAXOysUOEGn
        8VOfONaAp8CTG3MTzajOZ+JGmUiPTVCfgLE/hc20nw==
X-Google-Smtp-Source: AGHT+IGiGu2j4VnNM4yVuMWOgEMcK20zHYNH5pPCJMTOYx22h9LgXLT9g+AJY/8Xdl4FqW4Fj38U0UPhspGC8QnGmzY=
X-Received: by 2002:a67:af09:0:b0:44d:453c:a835 with SMTP id
 v9-20020a67af09000000b0044d453ca835mr11834880vsl.2.1694518539089; Tue, 12 Sep
 2023 04:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230912100727.23197-1-brgl@bgdev.pl> <20230912100727.23197-8-brgl@bgdev.pl>
 <ZQBIi3OsUUe+JcoB@smile.fi.intel.com>
In-Reply-To: <ZQBIi3OsUUe+JcoB@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 13:35:28 +0200
Message-ID: <CAMRc=MfS1J38ij4QjTz2SRxXrmxqqz0mQow_HUuC_0WcHZA8Cg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 12, 2023 at 1:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 12:07:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Remove all remaining uses of find_chip_by_name() (and subsequently:
> > gpiochip_find()) from gpiolib.c and use the new
> > gpio_device_find_by_label() instead.
>
> ...
>
> >       for (p =3D &table->table[0]; p->key; p++) {
> > -             struct gpio_chip *gc;
> > +             struct gpio_device *gdev __free(gpio_device_put) =3D NULL=
;
>
> > +             gc =3D gpio_device_get_chip(gdev);
>
> What the heck is this, btw? You have gdev NULL here.
>

Gah! Thanks. I relied on tests succeeding and no KASAN warnings, I
need to go through this line-by-line again.

Bart

> >               /* idx must always match exactly */
> >               if (p->idx !=3D idx)
> > @@ -4004,9 +3996,8 @@ static struct gpio_desc *gpiod_find(struct device=
 *dev, const char *con_id,
> >                       return ERR_PTR(-EPROBE_DEFER);
> >               }
> >
> > -             gc =3D find_chip_by_name(p->key);
> > -
> > -             if (!gc) {
> > +             gdev =3D gpio_device_find_by_label(p->key);
> > +             if (!gdev) {
>
> ...
>
> >               if (gc->ngpio <=3D p->chip_hwnum) {
> >                       dev_err(dev,
> >                               "requested GPIO %u (%u) is out of range [=
0..%u] for chip %s\n",
> > -                             idx, p->chip_hwnum, gc->ngpio - 1,
> > +                             idx, p->chip_hwnum, gdev->chip->ngpio - 1=
,
>
> In other patch you use wrapper to get gdev->chip, why not here?
>
> >                               gc->label);
>
> Is this gc is different to gdev->chip?
>
> >                       return ERR_PTR(-EINVAL);
> >               }
>
> ...
>
> Sorry, but this patch seems to me as WIP. Please, revisit it, make sure a=
ll
> things are done consistently.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
