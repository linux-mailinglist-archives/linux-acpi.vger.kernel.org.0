Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF129F2D1
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgJ2RSK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgJ2RSK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 13:18:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692EC0613CF;
        Thu, 29 Oct 2020 10:18:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p17so1589087pli.13;
        Thu, 29 Oct 2020 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kPIwFKawRaFZ1InawsQhSnShN6iQh2cGimv6mqGdfg=;
        b=kTfFcVXj3xclyEx1+i5CVDK2Y5qdsEE0QWqlUrj8ZEUTEBKKiZGKBbcQ3S+zt4Xx4K
         t3ebLhKsjvX8L4rehESxEePkATPok51WAojGxIZi0N0ysQhaKwyv1TDF83tHFx67vyRA
         OHFXFtsW4prUNs30CcECK2qWR/4nhCpRr24sovFwfm4WxIGxSejBlB5V/yMBJgi0JF5k
         liwWOSYywtsTnns7criYhBpOpoKZZCe93gVLlejkL4p4tcrHqTOtUGTslHDj8S5VpgTV
         M97hVcbiLR6zGcY0vOTR9JodXcOYKZGAKx02/kLG/fNVALZXJQwWaTVps7gowMPoTPZ7
         LBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kPIwFKawRaFZ1InawsQhSnShN6iQh2cGimv6mqGdfg=;
        b=ryUXrnIDbrE/duR3Pp/YTZnyQeuv86fmkkGhdZfBc0C7yxMekJ3XJHThg1GIihmm9e
         axIzJYg6sKktGlx2DbIROWt8T6IC3lDNtZpmpZyl1epopqHP0Ml4f1695/sdvkiLZ7vZ
         v1PBvITjQ+B8GVOgmz1TwwJzOdvRipwHgVVgxtR1KT9o/pKnKidBkDugjcAVGo0KoeOE
         oLCmhLO7G+2bcvR15jII3FCF4cLL2x9tpy07+EGBc7QafOaoO8izE71IKrvxN1RtBYJ2
         KuxTGRguX3vxSVpTBbjrjlm5j3eRWDAkI6S5nxAhcjV8E/ERRcridyLg2IKItKZG7nV5
         OSeQ==
X-Gm-Message-State: AOAM530r6UYgIX8poMzRf+JMyPGSJwjywbO9qKxdrXIXtPRyLl+OHRyp
        1UN1x9r44hv7+EAdCCyBLX8N6FckP/obG1DTWOtBVnT7uKtANw==
X-Google-Smtp-Source: ABdhPJx89o2B/1PifUAC0aLwKQ5Kk5nfLT04pV/pxzgaG+51Dl75y8uOmPXvigSzisusgd0P9KGqKFeEymHpJOEWegc=
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id
 d10-20020a170902aa8ab02900d3c9dd77d1mr5040299plr.0.1603991889820; Thu, 29 Oct
 2020 10:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
 <CANiDSCtRDwfFo9HE84iujjFe6h9aS6b3B8wkz5Rt0aO8=XMsNg@mail.gmail.com>
 <20201029144656.GD4077@smile.fi.intel.com> <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
In-Reply-To: <CANiDSCuNVT=jr8rLyfWhGKNSOy5OnH7YBZaWSguBDVg219OGvQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:17:53 +0200
Message-ID: <CAHp75VfuZPpBZsyUEyD_R+ZEjPms6Z9L1tDdBKYfusWnbhtyww@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 4:55 PM Ricardo Ribalda <ribalda@google.com> wrote:
> On Thu, Oct 29, 2020 at 3:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 28, 2020 at 10:10:42PM +0100, Ricardo Ribalda wrote:

...

> > ActiveLevel field is described in 19.6.55 GpioInt (GPIO Interrupt Connection
> > Resource Descriptor Macro).
> >
> > > Without using the active_low, how can we describe  a pin that is
> > > active low and has to trigger an irq on both edges?
> >
> > This is nonsense.
> > What does it mean?
>
> Let me try to explain myself again:
>
> I have a gpio pin that produces IRQs on both edges. so ActiveLevel is Both
>
> The problem is that the value of that pin is inverted: Low means 1 and
> high means 0.
>
> How can I describe that the pin "is inverted" without using the _DSD field?

"Both edges" and "inverted" or "polarity low" in one sentence make no sense.

-- 
With Best Regards,
Andy Shevchenko
