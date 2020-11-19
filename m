Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A812B9ADC
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 19:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgKSSqM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgKSSqM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Nov 2020 13:46:12 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22447C0613CF;
        Thu, 19 Nov 2020 10:46:12 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t21so5039952pgl.3;
        Thu, 19 Nov 2020 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81c71i5dO4kP419lzpy1jsGyR1x4EYOTkNO5ZXs8xA4=;
        b=RY/0VieMtwbooEEqoeNmP9YX+YSQZZVjswBdIVye9H6Ocr89tfv3dGIj5rSfHpgKs2
         J74kUXhjmN02SK5PUudKM40zKos7/50/wqMADgaNwAgdBMzYRp8hyhAbmxeUg+onr0rv
         rQVmcLbGpLazYMKi/G8jir9p+I9idPZeZjXleSxSAzsrd9sOatbCNUYLeCrHcitsIbtx
         S9rUrIpdbRHxhSYU5utzfra5S90GObx18aUpJ8qerqPSOAiYK8g6Pe5+4PVpRavET5Oy
         F/tu3PxiAkh2+VwYbRQZYBRTMH6aZ6AsxK6ob6XrHHb5Mr9cSgnyL5KBb5Rf+HrfMMK1
         AXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81c71i5dO4kP419lzpy1jsGyR1x4EYOTkNO5ZXs8xA4=;
        b=Z0rh+Wq2KfPQ7U/4AEZNs60y3wXnRaaVkXUEG2KMfsRKoUvzExlSlTmpDQvMT6J/JA
         13WqRZaWOJTqANqpZ8u6b0w8/1X8NzvsSumMrYU0vwhHKxqaMXmUSgolYMlpFqPVjTvV
         PZ8Gbpjm0J+2SsYfZcUemH8Au1KiITi/Xyp0m4Ezhtw29fiwcI8E/AlzXdh51eQCGdgb
         A+KkaXW3fZLnobQXYMqLWA6iwaaNX8/YBmEnzPwy1cTSbH7INu2WMtmU4Sp24Od3b4/u
         21FQcpe8ZkHmgh3iMU4GH0fJD9raIK4YqnN3ikvklXwrcfROBDGQhkKVjF34S64GbzsF
         SrZA==
X-Gm-Message-State: AOAM532Umk616pKDeCxpbgIjBBMVU4IG/RD8t/OgEiigUIHqW9o3DAci
        VUmdBXzfvdmx12QhKfg4e97K+HSWu1DqiScPyjU=
X-Google-Smtp-Source: ABdhPJxkkFDCifiaHA1UjuO9zoWlYT44l5SrPQZw3HAQAX8iOvl8P3pi4wXBgM0Dhz2kvQBh86rcXn0pNCndX8djTYU=
X-Received: by 2002:a62:7c95:0:b029:18c:5002:a1ab with SMTP id
 x143-20020a627c950000b029018c5002a1abmr10085635pfc.40.1605811571629; Thu, 19
 Nov 2020 10:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor>
In-Reply-To: <20201119170739.GA22665@embeddedor>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Nov 2020 20:47:00 +0200
Message-ID: <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 7:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpio/gpiolib-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 6cc5f91bfe2e..e37a57d0a2f0 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
>                 default:
>                         break;
>                 }
> +               break;
>         default:
>                 break;
>         }
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
