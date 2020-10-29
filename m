Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D129F2D6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ2RUW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 13:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgJ2RUV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 13:20:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47998C0613CF;
        Thu, 29 Oct 2020 10:20:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b3so2915669pfo.2;
        Thu, 29 Oct 2020 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6Uz54WuxnDJ+k4Eco5IKqgdA9hb/8pbhmxkv/FMSmM=;
        b=j/q/nLAGZfY9GIST0ARhhpYeBgZyoLu1xoaxwc6RZP45InpbchoeqONc3771SdTm0z
         qTfgR1rKryboQSJjmQwxfPUPCXqEqmczYK5EKdVOzIHbcdsxXNvgaT8lcCAjYXD7IoBf
         jqf9RIFyEUsrm43x6t1ar4ggrwCiBQExJqeiEjTfr1GkqL7Q2awzwbK7Bgw3mj92MNeI
         7pE7c4OQkE5NKV0NPTePaHEAEzcO419VRAUrr3twD1pyfVH7RaagLq2aSFhVGzdcFa17
         7bILTiycCNOii1b70W0mpgU5qRb5X6LM2C4lIZcG1DVdVOlv61uOGaDtqi/XJmbgWI2e
         L1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6Uz54WuxnDJ+k4Eco5IKqgdA9hb/8pbhmxkv/FMSmM=;
        b=aq/qbyG0KfbXmKb9M6RKEdI0v1kT/Dr1c5795jWAELwH5or2q9bcp7D8S+bYeDesyS
         x2OmyoGJrtHSCB3bL8fvo/hz41sDiZSSUddlXx7YZ1EfRyhUlR5j3Ra6gLiTAXC9uQK4
         FRsE0AVrbV8ZIjJfh+PmXFsRLru3pXon7Zj7yIEKspbouDgYsxe3uqdIuxnz2MWIGnb7
         MFXfThJWXap6b3JEWeuPUCMRnmYjUbjqa5PjKrCrt6sQc65iUkUSHHWUgqay3Ea3CSbT
         P/KOcEL2UkESFNwdSCL9M00SCgyCT6BqCGEtd30aIPMvUxyo7knFmd075sqHGSSh8dSZ
         u8Qw==
X-Gm-Message-State: AOAM532ZA9IIGPPYejPXSb2UF5qPr29I1DXme3butG8sztvhQWLSK51m
        kjKn/if3WH+RTe0UvG1aUdkW4B7sAStBpW/pFGuvmZrsvBc=
X-Google-Smtp-Source: ABdhPJwFJT3T243YU8PhF0+GmN89Ub+5YNo/oaEw7I7FmY1FPHJhilZqPozPhipGzu6JGF2APB9sR3T6yN6Jq+GfayE=
X-Received: by 2002:a63:1e02:: with SMTP id e2mr4778017pge.74.1603992019848;
 Thu, 29 Oct 2020 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
In-Reply-To: <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:20:03 +0200
Message-ID: <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 7:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Oct 29, 2020 at 4:55 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > On Thu, Oct 29, 2020 at 3:45 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:
>
> ...
>
> > > ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
> > > Resource Descriptor Macro).
> > >
> > > > Without using the active_low, how can we describe  a pin that is
> > > > active low and has to trigger an irq on both edges?
> > >
> > > This is nonsense.
> > > What does it mean?
> >
> > Let me try to explain myself again:
> >
> > I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
> >
> > The problem is that the value of that pin is inverted: Low means 1 and
> > high means 0.
> >
> > How can I describe that the pin "is inverted" without using the _DSD field?
>
> "Both edges" and "inverted" or "polarity low" in one sentence make no sense.

To be on the constructive side, I can *imagine* so badly designed
hardware that uses level and edge at the same time, but before I go to
conclusions, can you share relevant (pieces of) datasheet?


-- 
With Best Regards,
Andy Shevchenko
