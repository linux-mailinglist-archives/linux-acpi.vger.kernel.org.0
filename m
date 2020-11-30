Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479E62C89EF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 17:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgK3QwB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 11:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgK3QwA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 11:52:00 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB94C0613D6
        for <linux-acpi@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so17097160edl.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=Zye/yjDqWPYGyg/QE0koGvl0I2eHLXcxFBm4sXkIAKcAllxFfCM8VhOKsbeI3vqS5q
         WJynbjNDVCg5tCp8TZzl46m0pdFE+emZQsOSzDR3n1Z9O0Z4KzEyprZ2N56f/VKa6qr5
         FxAkySIInHUZpy3Si5S8ztkqnlIwnnl+7xiwCRvLeHgnaLPxJaYJ4vcca1DoiMXyqK/e
         qhM+eiUXY5aMq6kr4DSF2ghhgxdJzkPPQLxsiONl3BEctySuXBtUjKggjYyyOimhxKRn
         Li7SFb8adwSPzQ9upKTgl2WnnSLw93Bq7Z3az1xpjsh+zZ0Zb2d3xY18mLqPe+ZUtDFR
         SMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=hSMFXhVzvSCQC538GzCmuHlpE6Eph76FHFK05i77GTqjE7fYVq1u8MZFpqsyPcr5w8
         2I23ZifLsd+K3di+9g0deYkPnOt0L+UMDw9+IcgJFWDT/Ild+XcyZtMuhQJaHFPAR2zd
         FD0LIhwBNhH+ARK1DcNHk77IZc70CnYkLRlUGVHZEtfKoDqdvSXbF1rPHbpsr7e5sWF5
         a+FvEFV6OE+YZIJRLzXP8fI62znTGIjihvZT37BKYACPq37WZMwmyycmmpO67XF/BbBY
         cwLAUsVQm9pJO3YNMY3dmZy6K22TkYNHiDfYGMQvrvoHUg8IHPhAeYrk39FdTmWvb1Gm
         vDBg==
X-Gm-Message-State: AOAM531ToxJgjlb7T9my3YmG/gzU3j9HED5cw8dvddl+V33CbnkjUMBE
        9mI29m0ud321gmtlfUZhDDVJx4lg0KslMy8CPq6c9A==
X-Google-Smtp-Source: ABdhPJyOKnMrgBQxB4k8Qm92X/QZ93uux4mg7bXxBB+nV6g8s1tY4J8qFCSFmU/yEs/ngBHyxDuQrTMnx9skThFF/XI=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr15528179edx.59.1606755073013;
 Mon, 30 Nov 2020 08:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor> <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
In-Reply-To: <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 30 Nov 2020 17:51:02 +0100
Message-ID: <CAMpxmJWq0_ZXsPsWhgWC_93egDm9y2A5P3GiCQ4YTcdGrGTSZQ@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 7:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 7:08 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-acpi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index 6cc5f91bfe2e..e37a57d0a2f0 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
> >                 default:
> >                         break;
> >                 }
> > +               break;
> >         default:
> >                 break;
> >         }
> > --
> > 2.27.0
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko

Are you taking it through your tree?

Bartosz
