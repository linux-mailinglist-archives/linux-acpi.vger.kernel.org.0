Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036029F492
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgJ2TK4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 15:10:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:29991 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ2TK4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 15:10:56 -0400
IronPort-SDR: sRMlX4S1UZ+i63auon3FDqT8n4BzLkIy54tPdhWbgJtPXgWIdSq0XAFwi1Csh2b1vCG5bHhpm5
 JTCxvD1j7zmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168622816"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="168622816"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:10:55 -0700
IronPort-SDR: 0bRmMVfvsg88yuWGgqucJT9pKP03MXE1LGVVZkh39p19J6HqAhreD/hGo3E6Fc9WuAupM3W4+O
 rQFRInHxqrxg==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="469243898"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 12:10:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kYDL0-001SSH-02; Thu, 29 Oct 2020 21:11:54 +0200
Date:   Thu, 29 Oct 2020 21:11:53 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ricardo Ribalda <ribalda@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties:
 active_low only for GpioIo()
Message-ID: <20201029191153.GI4077@smile.fi.intel.com>
References: <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com>
 <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
 <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
 <CAHp75Vf-KXSC5x+07rH+wFgv_9xx_+DoMd9ZxTAqr_a5uxc7jA@mail.gmail.com>
 <CAHp75Vd+doPgSZQEOSAW4oRoAqPUdJyoivtNvbO5d1q-e280Eg@mail.gmail.com>
 <CANiDSCtNCn+vj=8kgx8oPUbCJS6mLmOckiWpJtobT_FtUCR3YQ@mail.gmail.com>
 <CANiDSCuJv258cXYgxcWBUVpvQm8tYy0Lrd426e63PHQJAnLYwQ@mail.gmail.com>
 <CAHp75Vc8FLoi=4Z78mNkDJk_qM_V0EA9s3aGb3qXU-i0vg8wxA@mail.gmail.com>
 <CANiDSCvD3JqT8pZy7MtuCtGGSP8bUrkndCf6CK866MeH7Hk3sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCvD3JqT8pZy7MtuCtGGSP8bUrkndCf6CK866MeH7Hk3sA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 07:58:39PM +0100, Ricardo Ribalda wrote:
> On Thu, Oct 29, 2020 at 7:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 29, 2020 at 8:10 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > > On Thu, Oct 29, 2020 at 6:32 PM Ricardo Ribalda <ribalda@google.com> wrote:
> > > > On Thu, Oct 29, 2020 at 6:26 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Oct 29, 2020 at 7:20 PM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Thu, Oct 29, 2020 at 7:17 PM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:

...

> > > > > > > > Let me try to explain myself again:
> > > > > > > >
> > > > > > > > I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
> > > > > > > >
> > > > > > > > The problem is that the value of that pin is inverted: Low means 1 and
> > > > > > > > high means 0.
> > > > > > > >
> > > > > > > > How can I describe that the pin "is inverted" without using the _DSD field?
> > > > > > >
> > > > > > > "Both edges" and "inverted" or "polarity low" in one sentence make no sense.
> > > > > >
> > > > > > To be on the constructive side, I can *imagine* so badly designed
> > > > > > hardware that uses level and edge at the same time, but before I go to
> > > > > > conclusions, can you share relevant (pieces of) datasheet?
> > > > >
> > > > > The [1] is a real example of how GPIO is being used to detect changing
> > > > > of current level of the signal.
> > > > > Note, ACPI tables for that device have problems [2], but I guess you
> > > > > may get the idea.
> > > >
> > > >
> > > > This is exactly what I need to do. Get an IRQ whenever the value
> > > > changes. But the pin is "inverted"
> > > >
> > > > This is the "schematic" :  https://ibb.co/f8GMBbP . I want to pass to
> > > > userspace a "1" when the switch is closed and "0"  when it is open.
> > > >
> > > And there are also other devices where the swith works the other way
> > > around, so the acpi should be verbose enough to describe both
> > > situations.
> > >
> > > With my proposal (use the same active_low field as with GpioIO) we
> > > cover both usecases.
> >
> > Even without your proposal it's feasible.
> > You see, the problem here is that if you describe GPIO as Interrupt,
> > the edge and level together make complete nonsense.
> >
> > Solution: do *not* describe it as Interrupt.
> 
> Now I get my mistake:
> 
> I thought that gpiod_to_irq will not work unless it was a GpioInt()
> but it works fine. So in this case I will just convert it to that.

It's actually that gpio_to_irq() is solely for GPIOs which initially are not IRQs.

> Could we say that doing gpiod_get_value() from a GpioInt() is always
> wrong?

But it's not wrong. Some cases simply make little or no sense, but in principal
why not? Yes, it may be fragile or too much customized.

> Can we modify the code to avoid it?

GpioInt() is orthogonal to GPIO APIs in Linux kernel. It close to be
impossible. Also see above.

> Sorry for the confusion and thanks for your help.

No problem, you're welcome, it's good that you started a discussion!

> > > > > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L138
> > > > > [2]: https://elixir.bootlin.com/linux/latest/source/drivers/extcon/extcon-intel-int3496.c#L45

-- 
With Best Regards,
Andy Shevchenko


