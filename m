Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F745A0D7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhKWLFm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhKWLFl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 06:05:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807DC061574;
        Tue, 23 Nov 2021 03:02:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so90341140edu.4;
        Tue, 23 Nov 2021 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxuL73v/+l/qxUPRUGkggGaTzo4xIMxkY8L6WJlG4Po=;
        b=h3GClqjgm3FMUNjEdmn0x1LOIrT9wmDkkaldkcgGzxFuIQqYeUF/WxLLmwfYqj++Lr
         Hq2z/L2VwxvMJUFAAaZTkeasGlir/1j1GQT787TAEb9Xga7Y5YKPD8EcxwNoRDDXXCwK
         9NwcVA5QBB4tvTuPOJiGLfThWBCAIGOC89gtFYtwKLeXcLrbR8MfHCaBV+Tmn2wIcPBs
         T6nuT7JUaqKosHeTc0a0RmkdBrZ5SVBH2Lcid3kHZnBRuQ3zmuwSqrqHbaLR04j/aU0p
         wXifWGAC10AoqNa2LQp9Bg+4z+E3ezZsJW0FMNHCwnK2NtOeNJXyDU2YoGaelmDfTYCk
         IdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxuL73v/+l/qxUPRUGkggGaTzo4xIMxkY8L6WJlG4Po=;
        b=S/U7Ydqv2+75Z2OyV9WAUCWKMRmhoAmN639qwTndUhVyaoKtlrf4nUc/usIIr7tRty
         Q4W6mZPtGkCoszoFS3NMlSk6b96l/yPQR/64BiZkvreEz+OKRdaYtTp+z2sMkcZBcACc
         I2edkbx6zFBG45pAjbcObbcj06fI4dWgv0ilhGs4OzwC/RIizjLYk9pbj83bUGoGumL4
         yO9HcheG8wqXN/UaNlf8RxTbMAnqSs0TMaxfMdIYYOO+0yk4HOMTfrdFzc7NS3/8EJR0
         Stk1VYX5wphFjxsnpwC9VpvG0rRO8RpIiAxZUdlZmaI0jtnalx7WpGxR8F0xZj09UGrw
         nVFA==
X-Gm-Message-State: AOAM533wl1Ao9PoGizx8muup87A/XEBugSXFmuJ8N8tCWz8tZ4xglHCa
        BJqvREUzaB8hzfAKxs16yntbN6OH4ch+B3ycRGY=
X-Google-Smtp-Source: ABdhPJwcxiUbNVdW2lSINVPnzKqzOCmafXt5kdAs7BdLCo0EN3+8A1LQQnV1X3NhvfVfc364rO4/iOWyYpBWjP3G0uI=
X-Received: by 2002:a50:9ec9:: with SMTP id a67mr7768925edf.238.1637665351861;
 Tue, 23 Nov 2021 03:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20211122220416.11241-1-hdegoede@redhat.com> <YZy2CiOrEJc+6TRz@smile.fi.intel.com>
 <5afe8a56-b0aa-d063-d6a0-9ec459d138b6@redhat.com>
In-Reply-To: <5afe8a56-b0aa-d063-d6a0-9ec459d138b6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 13:01:54 +0200
Message-ID: <CAHp75VekAC7dMGFG5unWyX5=BUBtZy+UpQ9VxeJuoHOwD4jqEw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Do not set the IRQ type if the IRQ is
 already in use
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 12:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/23/21 10:36, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 11:04:16PM +0100, Hans de Goede wrote:
> >> If the IRQ is already in use, then acpi_dev_gpio_irq_get_by() really
> >> should not change the type underneath the current owner.
> >>
> >> I specifically hit an issue with this an a Chuwi Hi8 Super (CWI509) Bay
> >> Trail tablet, when the Boot OS selection in the BIOS is set to Android.
> >> In this case _STA for a MAX17047 ACPI I2C device wrongly returns 0xf and
> >> the _CRS resources for this device include a GpioInt pointing to a GPIO
> >> already in use by an _AEI handler, with a different type then specified
> >> in the _CRS for the MAX17047 device. Leading to the acpi_dev_gpio_irq_get()
> >> call done by the i2c-core-acpi.c code changing the type breaking the
> >> _AEI handler.
> >>
> >> Now this clearly is a bug in the DSDT of this tablet (in Android mode),
> >> but in general calling irq_set_irq_type() on an IRQ which already is
> >> in use seems like a bad idea.
> >
> > I'm fine with the change, one comment below, though.
> >
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/gpio/gpiolib-acpi.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> >> index 985e8589c58b..24cd86bf2c4c 100644
> >> --- a/drivers/gpio/gpiolib-acpi.c
> >> +++ b/drivers/gpio/gpiolib-acpi.c
> >> @@ -1056,8 +1056,12 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
> >>                      irq_flags = acpi_dev_get_irq_type(info.triggering,
> >>                                                        info.polarity);
> >>
> >> -                    /* Set type if specified and different than the current one */
> >> -                    if (irq_flags != IRQ_TYPE_NONE &&
> >> +                    /*
> >> +                     * If the IRQ is not already in use then set type
> >> +                     * if specified and different than the current one.
> >> +                     */
> >> +                    if (can_request_irq(irq, irq_flags) &&
> >> +                        irq_flags != IRQ_TYPE_NONE &&
> >>                          irq_flags != irq_get_trigger_type(irq))
> >>                              irq_set_irq_type(irq, irq_flags);
> >
> > What about issuing a debug (?) message
> >
> >                       if (can_request_irq(irq, irq_flags) {
> >                               if (irq_flags != IRQ_TYPE_NONE &&
> >                                   irq_flags != irq_get_trigger_type(irq))
> >                                       irq_set_irq_type(irq, irq_flags);
> >                       } else {
> >                               dev_dbg(..., FW_BUG "IRQ %d already in use\n", irq);
> >                       }
> >
> > ?
>
> That is a good idea, I would even be fine with making it a dev_warn, because it
> really is a FW_BUG if we get here. If we turn out to hit this too much we
> can always lower the log level later.
>
> Shall I submit a v2 with your suggestion, but then using a dev_warn ?

Please do, it will be slightly easier for me.

-- 
With Best Regards,
Andy Shevchenko
