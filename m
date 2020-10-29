Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7622629F3E1
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2SN2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgJ2SN1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 14:13:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF5C0613CF;
        Thu, 29 Oct 2020 11:13:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b3so3037550pfo.2;
        Thu, 29 Oct 2020 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGYJcAticCHQyU9+6ZTvCFYI8+5dsk62PD6GdjXKSRg=;
        b=s/buyCYhyu+RXC+cdtIm/HtnYigIZpBxmEvveCLpiQmKAAL2L0fGL9q6IlccgKFWXQ
         /K2kOlvHcLT463YjD6UVarAw7VAVddNFE8hMWUmYgwbRd45LsfvDafL6oFSN46og2gOy
         IOkjQqXtGcp40ant5vJlMZe9Ju02aZuCCjCokPWEbXPAH7gr3kbcXa7agNimLf92y1dp
         G7NueTbmCwrT9WFDTsIpjw7iRwWHE1IBQUUJzxHOWxZ/FSfYdXe1azZd1qEKjcD4lJHX
         oj1SFPQF0a4Q3MHWWdne+1mAH28sdhZh9RI2DdMirtbfW36qsTXB9aZNWjDIVGnNbdcZ
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGYJcAticCHQyU9+6ZTvCFYI8+5dsk62PD6GdjXKSRg=;
        b=W+52fxYpE+aG97IKGz2SzNiK2y2PueKGe9GLrmW6ObX3gdpDIAEWsvtnX+NSeJGKU9
         2LsJEPRnduBM29KwtpGbWZaPq6FIH9IeOIwV0NODL2bhX4yEPyAplqP1uXP301t9cXmp
         rUhaqk1pISKFLoKlXK+ZExdDytOoDTtBW0OpAOjznpcIbcZH9xUdXzm9Dkog5b4+51sd
         //cpAHiMIN+HhvBAK1ny3F9zsjnvWWwSdE8ZVC2+8+CCEZdyPKxZ5d7Mpi4Mgm82MYCK
         grRwvbhrLW4gDVvFJg41D3FVOQoF0OsJ6eXOnAF4bIm6tZwsqrQBMUt+iD/N/EMUqDkT
         H2cA==
X-Gm-Message-State: AOAM530rU2lCCQkkEjwMk3Yhrf8Xbe6aAWa/Rkv2Zjp0GeVj1+yx1DiK
        hSbSfyFEFQOn+S9ZaR81XdHv46uNMYtJlUV5xwGSx2rwdtE=
X-Google-Smtp-Source: ABdhPJxf5acRx0XYFa8yL46jzEyN25AIYY0LpDR/f7dKNlES89it/SJ+exMdVc5RgZpZo+KECbziMwtjDmDFWok836Q=
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr361451pjb.129.1603995207337;
 Thu, 29 Oct 2020 11:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
 <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
 <CAHp75Vd+doPgSZQEOSAW4oRoAqPUdJyoivtNvbO5d1q-e280Eg@mail.gmail.com>
 <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com> <CANiDSCuJv258cXYgxcWBUVpvQm8tYy0Lrd426e63PHQJAnLYwQ@mail.gmail.com>
In-Reply-To: <CANiDSCuJv258cXYgxcWBUVpvQm8tYy0Lrd426e63PHQJAnLYwQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 20:13:11 +0200
Message-ID: <CAHp75Vc8FLoi=4Z78mNkDJk_qM_V0EA9s3aGb3qXU-i0vg8wxA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
To:     Ricardo Ribalda <ribalda@google.com>
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

On Thu, Oct 29, 2020 at 8:10 PM Ricardo Ribalda <ribalda@google.com> wrote:
> On Thu, Oct 29, 2020 at 6:32 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > On Thu, Oct 29, 2020 at 6:26 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Oct 29, 2020 at 7:20 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Oct 29, 2020 at 7:17 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Oct 29, 2020 at 4:55 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > > > > > On Thu, Oct 29, 2020 at 3:45 PM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
> > > > > > > Resource Descriptor Macro).
> > > > > > >
> > > > > > > > Without using the active_low, how can we describe  a pin that is
> > > > > > > > active low and has to trigger an irq on both edges?
> > > > > > >
> > > > > > > This is nonsense.
> > > > > > > What does it mean?
> > > > > >
> > > > > > Let me try to explain myself again:
> > > > > >
> > > > > > I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
> > > > > >
> > > > > > The problem is that the value of that pin is inverted: Low means 1 and
> > > > > > high means 0.
> > > > > >
> > > > > > How can I describe that the pin "is inverted" without using the _DSD field?
> > > > >
> > > > > "Both edges" and "inverted" or "polarity low" in one sentence make no sense.
> > > >
> > > > To be on the constructive side, I can *imagine* so badly designed
> > > > hardware that uses level and edge at the same time, but before I go to
> > > > conclusions, can you share relevant (pieces of) datasheet?
> > >
> > > The [1] is a real example of how GPIO is being used to detect changing
> > > of current level of the signal.
> > > Note, ACPI tables for that device have problems [2], but I guess you
> > > may get the idea.
> >
> >
> > This is exactly what I need to do. Get an IRQ whenever the value
> > changes. But the pin is "inverted"
> >
> > This is the "schematic" :  https://ibb.co/f8GMBbP . I want to pass to
> > userspace a "1" when the switch is closed and "0"  when it is open.
> >
> And there are also other devices where the swith works the other way
> around, so the acpi should be verbose enough to describe both
> situations.
>
> With my proposal (use the same active_low field as with GpioIO) we
> cover both usecases.

Even without your proposal it's feasible.
You see, the problem here is that if you describe GPIO as Interrupt,
the edge and level together make complete nonsense.

Solution: do *not* describe it as Interrupt.

> > > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L138
> > > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L45


-- 
With Best Regards,
Andy Shevchenko
