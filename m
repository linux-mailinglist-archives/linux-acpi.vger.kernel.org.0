Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBF25F909
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIGLK3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgIGK6R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 06:58:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C2C061755
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 03:58:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t13so12112001ile.9
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ka86XCBq/V19GD6GyrylhsG/kDUnrrNEHVjokRO/B1o=;
        b=u6wEcfF4clytfMFn0Q3+4RSrEe5oYy0Eg72vGdNb06r0CxO4wt0j8j6zbN7uNszbq5
         Zn1mzZjmbyJWkWk147E4JJzTuQAOUsccp7NG1VL5akR8xQBzQAXxU8ArfuOEWHRPpPly
         vQKJYOvlUrR2krVgQkYEEGKF6HBwJd1Y+aZX1wd/PoPmFFZytSJ0q8qFxASTfQKd0Ehz
         cGCEdD/ubMHct2jM1yn1B2nk0oLr4QKAXxaoSM7WXgrJwTg8Zgk+2EOfhXxe5uvUZm4U
         RfouBH+2KAsHGY/oCUtPdF9eJr8xDUvPFrWwIqF3HQ1+vu7TrSHnicyx5B6ultfUmDeD
         qDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ka86XCBq/V19GD6GyrylhsG/kDUnrrNEHVjokRO/B1o=;
        b=tHcF4pnZTMIgu3vXXuXrHqNvzSQ6uaiZwHA+akMXwCvaLHw3qgMqw+pi73Qttc2y89
         E6Xs81D1VoY6KUIHsEJ2st4AqPMbppnanIFqFhRybIQuJ9b3j9Xh/iRRuzDb2nSTfin5
         FBNeiifFGR5lKaGt2xKemrSFAtegXnVfgq6cqQSc2yqkunjEsa09gYTc60IsV/LwcS9A
         joW7OdXQ6E2OLXCOp7+SDDadU8QkTACFTTqJiJsIjnI68ch3Nezufe5F/7U31882cB6R
         9R6oiWVxpju0MaDC9A9p83T2z6oWS8VkgeUGn28y14lorj2O2XS6wk0uydatwEgxVZzS
         mQwg==
X-Gm-Message-State: AOAM532i617irWMX2phGiaB0Embbwv/ZJdKdfOUqzEp2nss/nU1MS8Fm
        V4nlYv/E+/4q+aQQ0ISWzSjC3QwEy6d6Tuxu5Z+cPg==
X-Google-Smtp-Source: ABdhPJyNcXQHYQOHmSkHGrSedNl1b2pAVW8V+P3eGn98BQdjrgtp0HrsHhorKZbx6MoDWMtUhO8X6plpcOqKOMQaQiI=
X-Received: by 2002:a92:9604:: with SMTP id g4mr619710ilh.6.1599476295553;
 Mon, 07 Sep 2020 03:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-15-brgl@bgdev.pl>
 <20200904164624.GA1891694@smile.fi.intel.com>
In-Reply-To: <20200904164624.GA1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 12:58:04 +0200
Message-ID: <CAMRc=MdDPQGtDVjwdVCuNESTqguXDUGZzo_eT-OHwnNJtnmCWQ@mail.gmail.com>
Subject: Re: [PATCH 14/23] gpio: mockup: use the generic 'gpio-line-names' property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 4, 2020 at 6:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:38PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > GPIO line names are currently created by the driver from the chip label.
> > We'll want to support custom formats for line names (for instance: to
> > name all lines the same) for user-space tests so create them in the
> > module init function and pass them to the driver using the standard
> > 'gpio-line-names' property.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/gpio/gpio-mockup.c | 70 +++++++++++++++++++++-----------------
> >  1 file changed, 38 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> > index ce83f1df1933..96976ba66598 100644
> > --- a/drivers/gpio/gpio-mockup.c
> > +++ b/drivers/gpio/gpio-mockup.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/slab.h>
> > +#include <linux/string_helpers.h>
> >  #include <linux/uaccess.h>
> >
> >  #include "gpiolib.h"
> > @@ -378,29 +379,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
> >       return;
> >  }
> >
> > -static int gpio_mockup_name_lines(struct device *dev,
> > -                               struct gpio_mockup_chip *chip)
> > -{
> > -     struct gpio_chip *gc = &chip->gc;
> > -     char **names;
> > -     int i;
> > -
> > -     names = devm_kcalloc(dev, gc->ngpio, sizeof(char *), GFP_KERNEL);
> > -     if (!names)
> > -             return -ENOMEM;
> > -
> > -     for (i = 0; i < gc->ngpio; i++) {
> > -             names[i] = devm_kasprintf(dev, GFP_KERNEL,
> > -                                       "%s-%d", gc->label, i);
> > -             if (!names[i])
> > -                     return -ENOMEM;
> > -     }
> > -
> > -     gc->names = (const char *const *)names;
> > -
> > -     return 0;
> > -}
> > -
> >  static void gpio_mockup_dispose_mappings(void *data)
> >  {
> >       struct gpio_mockup_chip *chip = data;
> > @@ -468,12 +446,6 @@ static int gpio_mockup_probe(struct platform_device *pdev)
> >       for (i = 0; i < gc->ngpio; i++)
> >               chip->lines[i].dir = GPIO_LINE_DIRECTION_IN;
> >
> > -     if (device_property_read_bool(dev, "named-gpio-lines")) {
> > -             rv = gpio_mockup_name_lines(dev, chip);
> > -             if (rv)
> > -                     return rv;
> > -     }
> > -
> >       chip->irq_sim_domain = devm_irq_domain_create_sim(dev, NULL,
> >                                                         gc->ngpio);
> >       if (IS_ERR(chip->irq_sim_domain))
> > @@ -524,6 +496,27 @@ static void gpio_mockup_unregister_devices(void)
> >       }
> >  }
> >
> > +static __init char **gpio_mockup_make_line_names(const char *label,
> > +                                              unsigned int num_lines)
> > +{
> > +     unsigned int i;
> > +     char **names;
> > +
> > +     names = kcalloc(num_lines + 1, sizeof(char *), GFP_KERNEL);
> > +     if (!names)
> > +             return NULL;
> > +
> > +     for (i = 0; i < num_lines; i++) {
> > +             names[i] = kasprintf(GFP_KERNEL, "%s-%u", label, i);
> > +             if (!names[i]) {
> > +                     kfree_strarray(names, i);
> > +                     return NULL;
> > +             }
> > +     }
> > +
> > +     return names;
> > +}
> > +
> >  static int __init gpio_mockup_init(void)
> >  {
> >       struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
> > @@ -531,6 +524,7 @@ static int __init gpio_mockup_init(void)
> >       struct gpio_mockup_device *mockup_dev;
> >       int i, prop, num_chips, err = 0, base;
> >       struct platform_device_info pdevinfo;
> > +     char **line_names;
> >       u16 ngpio;
> >
> >       if ((gpio_mockup_num_ranges < 2) ||
> > @@ -563,6 +557,7 @@ static int __init gpio_mockup_init(void)
> >               memset(properties, 0, sizeof(properties));
> >               memset(&pdevinfo, 0, sizeof(pdevinfo));
> >               prop = 0;
> > +             line_names = NULL;
> >
> >               snprintf(chip_label, sizeof(chip_label),
> >                        "gpio-mockup-%c", i + 'A');
> > @@ -578,9 +573,18 @@ static int __init gpio_mockup_init(void)
> >                                : gpio_mockup_range_ngpio(i) - base;
> >               properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
> >
> > -             if (gpio_mockup_named_lines)
> > -                     properties[prop++] = PROPERTY_ENTRY_BOOL(
> > -                                             "named-gpio-lines");
> > +             if (gpio_mockup_named_lines) {
> > +                     line_names = gpio_mockup_make_line_names(chip_label,
> > +                                                              ngpio);
> > +                     if (!line_names) {
> > +                             err = -ENOMEM;
> > +                             goto err_out;
> > +                     }
> > +
> > +                     properties[prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
> > +                                             "gpio-line-names",
> > +                                             line_names, ngpio);
> > +             }
>
> Indentation here looks quite deep. Maybe introduce a helper in between where
> you assign properties?
>

No need for that - this gets flattened later on in the series.

Bart
