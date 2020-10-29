Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62A929F3D5
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 19:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJ2SKJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJ2SKG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 14:10:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3832C0613D2
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 11:10:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x203so3931441oia.10
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baxZPWBaI3mgJK17htQYs6QNkJcd1AoLPEP3SIpgux4=;
        b=sTXYZLcJU7aTrNeIYGm20sqABLnbOXu6IvnchI1ofm+e5jocswq+TN9xTBx7c07ji6
         jJtfgfl/4y2RlQESdyWH1vhD8/Jj7RdVZN5CUiXHNl+1uLkAf2FTQl//FudX95G/Evjc
         lOpgc3ckG0UBHOVpZTm3u1/gw0uZlFjCVJ4s5rmg3XcW2z38zBJzaGF1LO/DW0TtC1fi
         KuPGvHVWcbDZfsqeM92/VP6sf397BR0vSiyUZ7vLOuCNeBHoTyFazoYblBOfmJLhmodq
         pNoFZpeLC0nAB/M8Eu1PUd95EP+/aI/T3RYK5vDRhGaFDsJTDuxVIFqiLQd3Es1hJZOI
         gvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baxZPWBaI3mgJK17htQYs6QNkJcd1AoLPEP3SIpgux4=;
        b=lWrq000bIEtcAhoZ+LLWWK9UN01vBLZmX8tQL76VwnPU+zVxcRlojs9euiBZnoZ6PI
         jzZHgocKm3s64pfkjg8KQcqONBE6PNUxG7XDd0pDxz5eog+iJFxvJWVCaLLHnYLnOIJ/
         3n7BAuq7m94aETwEp/bDsvp9N1nrwYqyMLXjiUmFvC/pWgntcHUczZi1TpzG1HXFOGbL
         DcIZCiGkbiRY29JNV8P1+9D+iRguZlbpEicdXfDfrkudQvT8vVelC5uHx90oOBSCiUte
         9nS4biLmz/uptPQq3jXdj+/AqYKnlNjtQ2HWTyVDdlkXl59yDwC6Sis8RLvm37fVPcn1
         xbdQ==
X-Gm-Message-State: AOAM532xLaHQEt/rGLrU5N9ilYfyucgQkMFpfP71fttAgZSIDgPdmOxm
        KXG6+YQ9aDhf0vaWrSm+01nmJSvsnkR4Hd9hdVr4Og==
X-Google-Smtp-Source: ABdhPJyl2ukrRTzp1IQJQVNIVqPRMmwk9WxqOoAjFGNEKSU/hBwHb3kqGSAVzPSDgJC7rAKV3s9odQ9+fjtCU0o5D74=
X-Received: by 2002:a05:6808:602:: with SMTP id y2mr652138oih.11.1603995006006;
 Thu, 29 Oct 2020 11:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
 <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
 <CAHp75Vd+doPgSZQEOSAW4oRoAqPUdJyoivtNvbO5d1q-e280Eg@mail.gmail.com> <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com>
In-Reply-To: <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@google.com>
Date:   Thu, 29 Oct 2020 19:09:53 +0100
Message-ID: <CANiDSCuJv258cXYgxcWBUVpvQm8tYy0Lrd426e63PHQJAnLYwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

(clicked on reply instead of reply all sorry)

On Thu, Oct 29, 2020 at 6:32 PM Ricardo Ribalda <ribalda@google.com> wrote:
>
> Hi Andy
>
> On Thu, Oct 29, 2020 at 6:26 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 7:20 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 7:17 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Oct 29, 2020 at 4:55 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > > > > On Thu, Oct 29, 2020 at 3:45 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:
> > > >
> > > > ...
> > > >
> > > > > > ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
> > > > > > Resource Descriptor Macro).
> > > > > >
> > > > > > > Without using the active_low, how can we describe  a pin that is
> > > > > > > active low and has to trigger an irq on both edges?
> > > > > >
> > > > > > This is nonsense.
> > > > > > What does it mean?
> > > > >
> > > > > Let me try to explain myself again:
> > > > >
> > > > > I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
> > > > >
> > > > > The problem is that the value of that pin is inverted: Low means 1 and
> > > > > high means 0.
> > > > >
> > > > > How can I describe that the pin "is inverted" without using the _DSD field?
> > > >
> > > > "Both edges" and "inverted" or "polarity low" in one sentence make no sense.
> > >
> > > To be on the constructive side, I can *imagine* so badly designed
> > > hardware that uses level and edge at the same time, but before I go to
> > > conclusions, can you share relevant (pieces of) datasheet?
> >
> > The [1] is a real example of how GPIO is being used to detect changing
> > of current level of the signal.
> > Note, ACPI tables for that device have problems [2], but I guess you
> > may get the idea.
>
>
> This is exactly what I need to do. Get an IRQ whenever the value
> changes. But the pin is "inverted"
>
> This is the "schematic" :  https://ibb.co/f8GMBbP . I want to pass to
> userspace a "1" when the switch is closed and "0"  when it is open.
>
And there are also other devices where the swith works the other way
around, so the acpi should be verbose enough to describe both
situations.

With my proposal (use the same active_low field as with GpioIO) we
cover both usecases.

>
>
> >
> >
> > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L138
> > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L45
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
