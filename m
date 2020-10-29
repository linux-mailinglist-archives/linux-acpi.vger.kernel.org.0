Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BD529F31F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgJ2R0H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 13:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgJ2R0F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 13:26:05 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D0C0613CF;
        Thu, 29 Oct 2020 10:26:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so2927863pgg.1;
        Thu, 29 Oct 2020 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ztGYY/eyx/yp7ALYZLwGRqLddpCGI+AHHziIjGBV1M=;
        b=FWL+cKVT0VDWznjXqhV+cIxsfltQ9roMo2r2thpj401yo3LUs19ERsrtoB8lf8mn4U
         QoHoP3SYlAZiS4rza8d3MpGfvno4f+JGRTVA6fKuv2Ms2PXSQdEbNu67REs++qp3d3yv
         hWTP8MNmlzZZDMqHUAj0U483eR1eWxUN8qrFrCtb7lxAqQfX7Q9YWYXx1YNUNFZNytG+
         9V+X0qKDlHgZFRwBAhp0SO3dem299j8Jk/WiMaIc/agaz9F6xUuVDGapOByMtmxoAsJ7
         zbSyhVaiG1MnImMq2bz0QWekcBafmsQSQKiCU0bUo7Zb4vqaTLxoZFchBE+UWZOika3B
         RwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ztGYY/eyx/yp7ALYZLwGRqLddpCGI+AHHziIjGBV1M=;
        b=R0b6ddBn6EzKFLorvbZikSzuwsauyQfKXxRnSAgU8PKOH1/m51EkIXThQddoCteNCY
         0HZqBrI99qGGUPoiIG7lC0QfugZOJm4aGFnT6CDez1+mbDFcmcMrIR+Z08S9H2mLIZWC
         x0rHhG4lazIse8k4dmodTCBTpLpsXVFpyixSDjFlK/s5OEGLKthZcygOhTs9543OHawD
         xceBtePDQtaX7CeJ4s22EkyNwuGY/YY+7itUnPi0P73wNko68l1wdg6nR3cIr4EnVpUd
         wbTrb5z6rmeU3JnzkFBBlivePMN+SbtRo+6aZkfXUYakPfV3Vl4TRJu9Q+SWHGxza/nk
         +TgQ==
X-Gm-Message-State: AOAM532M/yegaXF2iyrPu0Fy9RJKKP5/YQ+fcJDsbaIXQtKo51sKX7dt
        MqwD5dcbAstc8ELZS6UT49+K3AQljkIJ5SUUXUxuw5gJLINy2w==
X-Google-Smtp-Source: ABdhPJwGniRCTOAqXA7FRpEfoDNBbuG6hq2Pf+i11Cv8wRhq7HJW7mK2BPFYFTHOYzWdqOr0AbI/s3dn1NTD6/hQx1M=
X-Received: by 2002:a65:47c2:: with SMTP id f2mr4946276pgs.4.1603992364948;
 Thu, 29 Oct 2020 10:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com> <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
In-Reply-To: <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:25:48 +0200
Message-ID: <CAHp75Vd+doPgSZQEOSAW4oRoAqPUdJyoivtNvbO5d1q-e280Eg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
To:     Ricardo Ribalda <ribalda@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 7:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 29, 2020 at 7:17 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 29, 2020 at 4:55 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > > On Thu, Oct 29, 2020 at 3:45 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:
> >
> > ...
> >
> > > > ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
> > > > Resource Descriptor Macro).
> > > >
> > > > > Without using the active_low, how can we describe  a pin that is
> > > > > active low and has to trigger an irq on both edges?
> > > >
> > > > This is nonsense.
> > > > What does it mean?
> > >
> > > Let me try to explain myself again:
> > >
> > > I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
> > >
> > > The problem is that the value of that pin is inverted: Low means 1 and
> > > high means 0.
> > >
> > > How can I describe that the pin "is inverted" without using the _DSD field?
> >
> > "Both edges" and "inverted" or "polarity low" in one sentence make no sense.
>
> To be on the constructive side, I can *imagine* so badly designed
> hardware that uses level and edge at the same time, but before I go to
> conclusions, can you share relevant (pieces of) datasheet?

The [1] is a real example of how GPIO is being used to detect changing
of current level of the signal.
Note, ACPI tables for that device have problems [2], but I guess you
may get the idea.


[1]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L138
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L45

-- 
With Best Regards,
Andy Shevchenko
