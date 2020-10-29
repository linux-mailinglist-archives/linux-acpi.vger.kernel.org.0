Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0C29F3D8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ2SLu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJ2SKy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 14:10:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CBFC0613CF;
        Thu, 29 Oct 2020 11:10:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so2992502pfp.13;
        Thu, 29 Oct 2020 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mYoC9fzlZILsK+v50uE5+YhxokVe2DzlkWulezZ7CI=;
        b=kXtAoYycNFk6+FrKWo8f4xSLyBDeMpMWM6sgDbBeglsOFQWBWXrY5L4HhHVJYmhWvE
         ONXSSMgPYXlink5oYPNbxLO/upi165EJlNfMLzLNgKNJgmkrd6eh2Pkj6gIPTGGrFeWa
         sIbHzRzMY86DMN6S27eWQSm518p8ELEPX4KT3JpGvOipfvYDVPbGdnXAeGHN9cWkikkx
         iiViBNKjhr01vRpXp20obCQur8doE3fZpKXq/4fKfxdLfnNbOKaujl/mM2/Ng8QFzENm
         JOXk38f8rr4x+4esofPenX9hyEqRtDZ14g1uxkkITKOueQQi3vAEIRRSt08QucwhccTc
         elSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mYoC9fzlZILsK+v50uE5+YhxokVe2DzlkWulezZ7CI=;
        b=KJb7G+BPkTRAgtJVkK3AElAUAvLgsqGZW4uHyqbtQofT4mOrSv7zAkDRjqrBp27med
         S3+F52nAnEnvsrYDjyM0IaN0vM1epJAgEz9YhCOU3llvIXmtkXimMYaj/19GUOQiV0Ix
         cX8aS1wqW5OcqQfm8WeP5nSsK+hCCaw5zQFkn1BpBekk+u4MuXSw4qPc6hVzg+x6HW5k
         d51fCZMXqKY64a+N69wdjc1EwJpLzPakZwWWruDMk7yKIWje3w7lBLy3k+v4I5NjkD+w
         8ltXMuvlS3Bq0Xj4E9bf8RUP/8dcaW0Q+1MRu8PIKY6iXNzVoKBVCCrLGpWJXXHUjStN
         uWOg==
X-Gm-Message-State: AOAM532FEfxyTVSUqRsr1LXwzC/poFDGybmTuuZucpWKI2NUaZLpeJC4
        VG6Szwl5dmRgnBovYdMw7mI7nGamkP0bnSeaYKZszyL1L6M=
X-Google-Smtp-Source: ABdhPJxfEMjDFrWielFFXMh8vbPfRPlkCX6EKzU1tlvI3OeeaVaRtM2mWw+ipcc1u/pMntP1J6qdXCzufODpFgdsLp8=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr327451pjs.181.1603995054113;
 Thu, 29 Oct 2020 11:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
 <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
 <CAHp75Vd+doPgSZQEOSAW4oRoAqPUdJyoivtNvbO5d1q-e280Eg@mail.gmail.com> <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com>
In-Reply-To: <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 20:10:37 +0200
Message-ID: <CAHp75VdZiOnQdUirEM1BG27kV=htNX95Ar6eJ8LAK91MsOyYSg@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 7:32 PM Ricardo Ribalda <ribalda@google.com> wrote:
> On Thu, Oct 29, 2020 at 6:26 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 29, 2020 at 7:20 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
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

Yes. It's fine. The above is using GpioIo() resource where polarity is
part of the _DSD (okay, the actual ACPI table doesn't have it, but you
can do it).

> This is the "schematic" :  https://ibb.co/f8GMBbP . I want to pass to
> userspace a "1" when the switch is closed and "0"  when it is open.

> > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L138
> > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L45

-- 
With Best Regards,
Andy Shevchenko
