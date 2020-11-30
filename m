Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ECA2C8A96
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 18:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgK3RPZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 12:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3RPY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 12:15:24 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF368C0613D2;
        Mon, 30 Nov 2020 09:14:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so10455905pga.7;
        Mon, 30 Nov 2020 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcjX8xJ/mzO5y/RwIA0/U8QFX9nWoqdtSQYRTJvpO4g=;
        b=rouCmimZdLe0JMJoBrQrsENsu+VlOgnXXgexijD6wuH7yGEOYbLsGHB4C/h7atFcE+
         Qc9JXfzYYRZwf83GXPHUA5Ij++71yGgPzIpnOS7I24m2pBLHNpvbSAd5qxXHjQmevsvE
         nWziM2H/8E2xiIUcOI3K4w0rnlayMU1la/waO7LfuKa8tVxlOrh+Wmxlo9HxEuEJ2smV
         mTtsmlRwszid1DmsRypz1NrxTYcFqyZ+q9qbUBnTdU77NpCBlYw8EDf7ZodLEDe1iVGt
         dRkN95LP0Xkq3dNOSN77zvwLajQqWekolNvnH8QbDGzMS5VqouuniwYHe5sbDaHzg8TV
         m1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcjX8xJ/mzO5y/RwIA0/U8QFX9nWoqdtSQYRTJvpO4g=;
        b=eZy0Lk/qvPCqAqajb7X7ApuakY9IiOp67mNYlI43bJ9qe0QxZMjGFyZUEPL3MZp1Q5
         +VZ6EUOkYIfwQMYwug50wtqG5DX50Uh+7Za2vX/1Q4Zf+4imrsT2pkakeOjVKJet1AWM
         oiqk5tVg6KFrj7F9aT4PvBJacc+EkM6g53ALjeHHX9I0aG+5DiuwC5N3m5Pj90SP+u55
         etkfc4KBg8PGBR43pDLRReLfLP0SMs0Gm3mzcaP7pzf0cCcWSwOT3UaEmJKORJaudIu6
         zIhJN55nfhCenVwduw0W8ituQklbN1YQSbvpGQAllkjzayS/850FEteJ2fe/8elhoavY
         4GUg==
X-Gm-Message-State: AOAM5310wBivgJzsSCrwMMJxca1OYkJxb9efQIQy+nG9qMFe708SM/Nd
        xPsUBPAhpOY9iNA/XwRjvxiYERT/wvR/rmI+HzU=
X-Google-Smtp-Source: ABdhPJz60aDGNsmDuMTGO3Hot+tVcwa2ykVMGMRLJRhJoMk597SLELNvn9r5gFsgcCFLBodR6+8WfF9yFB3o3qMFB38=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr19543390pfc.7.1606756484369; Mon, 30
 Nov 2020 09:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor> <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
 <CAMpxmJWq0_ZXsPsWhgWC_93egDm9y2A5P3GiCQ4YTcdGrGTSZQ@mail.gmail.com>
In-Reply-To: <CAMpxmJWq0_ZXsPsWhgWC_93egDm9y2A5P3GiCQ4YTcdGrGTSZQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 19:15:33 +0200
Message-ID: <CAHp75Vec4zaYixJMkMf81+uJFcciGdOhECvTZJrPeQL=MZx39A@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

On Mon, Nov 30, 2020 at 6:51 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Thu, Nov 19, 2020 at 7:46 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 7:08 PM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > > by explicitly adding a break statement instead of letting the code fall
> > > through to the next case.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > > Link: https://github.com/KSPP/linux/issues/115
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib-acpi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > > index 6cc5f91bfe2e..e37a57d0a2f0 100644
> > > --- a/drivers/gpio/gpiolib-acpi.c
> > > +++ b/drivers/gpio/gpiolib-acpi.c
> > > @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
> > >                 default:
> > >                         break;
> > >                 }
> > > +               break;
> > >         default:
> > >                 break;
> > >         }

> Are you taking it through your tree?

I don't  have anything else, so please proceed directly. That's why I
gave the tag.

-- 
With Best Regards,
Andy Shevchenko
