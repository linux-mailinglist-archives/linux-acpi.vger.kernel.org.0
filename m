Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C526440E9B
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Oct 2021 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJaNSW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNSW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Oct 2021 09:18:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C258C061570;
        Sun, 31 Oct 2021 06:15:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e2so24940544ljg.13;
        Sun, 31 Oct 2021 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PD41efnyktLHVkqJ0TVfwzxxHD0nZAcOYiom746hjGQ=;
        b=GwWyzVHloam8hOV0kUaZxK5hzO1YMmURf/lyKVRA1v0OxXchX6D4NZ0XcggUMjtCzf
         naB6Lkpkpf7VPU2vFHY8wUIwVme3pMykWZKKr+zFq9v6JMkC9ZIvvjS82w/3BfZveg++
         XR5+70Lh3ow8eWRR0giUTCrjMm6FYazKCFRVpZuGzNS140U8YPH3YNibym1UroeJdH5F
         k2BiPe1qrGZ0ZYFHW63vdoQ1T5CPw1+p7Vdm23m3/FvcZeE0noSmqU8h+rRQB51HeOhX
         OlCimI8A20gfSAJ5uyjXhaHZKXg3sRjBc+/uCiHJD2Fiz2eKv6uCg0NPeeKq9ensRAiW
         0JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PD41efnyktLHVkqJ0TVfwzxxHD0nZAcOYiom746hjGQ=;
        b=JgX3YLCxRYjjOi+9Mm3k3TX3i8Kq7FD8CiMjuG6REsuC87Gd1HN8OgIxfICqH39FMp
         wk+CSm8ONzNiPY9db65F2TytdukoWSDujo+EBLUL7KWZGljetH8/Y/Ud15QmR1YIiMTD
         91qtK3b++UW7QImhM/4lPpKusy9OEfm7TrTTDpWkqsj8J1YDx9IvMfgJucGFipVRUSle
         q9Al9u/aGV3oPBQLaodNrlPes0zv8Zm3/Fn8H/E9fNzfkP/XYCwIpl1Tyydv+zGgEqjc
         PoXIn1qBnoxnXcsHDcmwpwvBm8uYeNdh7MtlvqQ7d724OlLkZWpTkAQgVRFUM1sZjIkt
         +CiQ==
X-Gm-Message-State: AOAM5336cB4SaMeR4Jc9hbfq4urrqwOXzW8apI7Ryh3p31/sZaY2d4zi
        TBTPZCBAM+nOd8Y/q0z0wiCMTp8v1zPW5+W3O7g=
X-Google-Smtp-Source: ABdhPJyFY5myPudPlEIk0GekoyOBXszKfOf23/qHuuqxvTKdHopkZdc2Dj43lMvN4+oDUYFTNkQSNdIo6Cki9a1bP/k=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr25689897lji.107.1635686148557;
 Sun, 31 Oct 2021 06:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211029204017.8223-1-mario.limonciello@amd.com> <20211029204017.8223-2-mario.limonciello@amd.com>
In-Reply-To: <20211029204017.8223-2-mario.limonciello@amd.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 15:15:12 +0200
Message-ID: <CAHp75VfOBBpt84aQYGOW32kKqeNH5gZUbJtqf1sPP7O-ZZkW+g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with SCI
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        stable@kernel.org, Joerie de Gram <j.de.gram@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 29, 2021 at 11:42 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some Lenovo AMD Gen2 platforms the IRQ for the SCI and pinctrl drivers
> are shared.  Due to how the s2idle loop handling works, this case needs
> an extra explicit check whether the interrupt was caused by SCI or by
> the GPIO controller.
>
> To fix this rework the existing IRQ handler function to function as a
> checker and an IRQ handler depending on the calling arguments.
>
> Cc: stable@kernel.org
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1738
> Reported-by: Joerie de Gram <j.de.gram@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

...

> +static bool _amd_gpio_irq_handler(int irq, void *dev_id)

I know Linus does not like leading _* in the function names, what
about 'do_' instead?

...

> +                       /* called from resume context on a shared IRQ, just
> +                        * checking wake source.
> +                        */

Is this comment aligned with the style used elsewhere in the driver code?

...

> +                               dev_dbg(&gpio_dev->pdev->dev,
> +                                       "Waking due to GPIO %ld: 0x%x",
> +                                       (long)(regs + i - ((u32 __iomem *)gpio_dev->base)), regval);

Oy vey, these castings are ugly. The rule of thumb is that if one does
such a thing for printf() it means something is really wrong (in 99%
of the cases).

AFAICS you may simply use 'irqnr + i' as the other message does.

...

>         platform_set_drvdata(pdev, gpio_dev);
> +       acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
>
>         dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
>         return ret;
> @@ -1021,6 +1045,7 @@ static int amd_gpio_remove(struct platform_device *pdev)
>         gpio_dev = platform_get_drvdata(pdev);
>
>         gpiochip_remove(&gpio_dev->gc);
> +       acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);

Thinking about making this in the generic GPIO library code, but this
is out of scope of the patch...

-- 
With Best Regards,
Andy Shevchenko
