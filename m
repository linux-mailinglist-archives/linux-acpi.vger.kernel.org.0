Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42C344AC2
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCVQMY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCVQLy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 12:11:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92DC061574;
        Mon, 22 Mar 2021 09:11:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so11317993pjb.1;
        Mon, 22 Mar 2021 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAU3XotYk58Jx3jm/EY+lIpeD0VVnlHINJxwS0to0ow=;
        b=MjrWk4Nf2w599QoKZVGXVoIdEkJXAmYHD1r5rpULNqXSqsth3SMc05mwf/y2mdPhyP
         WeBKBRWdjJG9j1LYPogCCY8OOeCYVDyoF6qpW7MbLZYcjRhfO6DWKqAZ0htJJ8LsBqxS
         P8YDqeV+Vm8ZzmCrFP9B8UMO2EmE26f0+6vtDPn5y69mH3GILHGqbQ/MaFjMlraSza/r
         dX9HX9czW5dx9DIViv0yqVcUfZEDRkFQI0Q0eiamPu90DF16UKvw29ruj9MMNu0tXz86
         gYVmqSXTIGJp6hZJeG3DgRj+pZB9wUwgovVAW5/doJFGs6huRaYx9krzHt9hankd/LCM
         UQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAU3XotYk58Jx3jm/EY+lIpeD0VVnlHINJxwS0to0ow=;
        b=XZJ8R4peQrfcNyhJ2fDvOOpnGahVh+ccvsT6YbT4cf7slMrHoTRp/ViU7+nYAtenzu
         51TFctQtJj+9VykdekWhII2sa+BvP03FKDR/JT0pWJAZpGlMeOjPwaX29OZGo1ypyYeC
         CdvwWhkkY2gdtMDso15DT8zxQo93L6hMQG0yrKXeKoW0yhFKus/HJkaoF/fHImFOH506
         9516tO6Bdwen3YMvebz6dly3GoZWsJ5kQ+78d2UhEF93fa2EzpDTj+5E63Ci/zMvsiw0
         bYeE60leou09VScvL3MEI7yQH4C6eW2R1vflLpSHwDMm8kJwoCfFMSdfTy04HCM9Q+xh
         4b5w==
X-Gm-Message-State: AOAM530iIVBrQB/N0oVa4vl9bQkP3kal8w40Wz8k57wX+EglRxxAL2LC
        vjbdS2zB0wVwFphn3PNrVNVBz7wenx2T1ceeuDo=
X-Google-Smtp-Source: ABdhPJxZCChRf15y2Mrhxu/vyAfrOe8t8ssIghi60IQuYY2W2vCY68wBeuMslVoVb3bQJZ8ZnMWl5qAvbncDaOOpFA4=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr99609pjb.129.1616429513936;
 Mon, 22 Mar 2021 09:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com>
 <CAHp75VeVhHhkzPVdGRa9inLJtW0QF=dDp3jB-U1xvKWRY_pbyw@mail.gmail.com> <CAJZ5v0gxjCiP-XbvLkHZiewjMhpR6KdJFapjV_-F05Uc_G7tqQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gxjCiP-XbvLkHZiewjMhpR6KdJFapjV_-F05Uc_G7tqQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 18:11:37 +0200
Message-ID: <CAHp75VeC2MUEQTQnZMb96sz+P7gQVUPtds9CfxFf9t7rOVeXRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPI: scan: Use unique number for instance_no
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 5:42 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Mar 22, 2021 at 4:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 22, 2021 at 4:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The decrementation of acpi_device_bus_id->instance_no
> > > > in acpi_device_del() is incorrect, because it may cause
> > > > a duplicate instance number to be allocated next time
> > > > a device with the same acpi_device_bus_id is added.
> > > >
> > > > Replace above mentioned approach by using IDA framework.
> >
> > ...
> >
> > > > +       result = ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 255, GFP_KERNEL);
> > >
> > > This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
> > > should be 256 above, instead of 255.
> >
> > Ah, good catch!
> >
> >
> > > While at it, though, there can be more than 256 CPU devices easily on
> > > contemporary systems, so I would use a greater number here.  Maybe
> > > 4096 and define a symbol for it?
> >
> > I was thinking about it, but there is a problem with the device name,
> > since it will break a lot of code,
>
> What problem is there?

If we have only 2 digits, but you are right, we have _at least_ two digits.

> > And taking into account that currently we don't change the behaviour
> > it is good enough per se as a fix.
> >
> > That said, we may extend by an additional patch with a logic like this:
> >
> > res = ida_get(4096)
> > if (res < 0)
> >   return res;
> > if (res >= 256)
> >  use %04x
> > else
> >  use %02x
> >
> > Would it make sense to you?
>
> I'm not sure why not to always use %02x ?  It doesn't truncate numbers
> longer than 2 digits AFAICS.

Yeah, should work. Thanks for review, I'll send a new version soon.

-- 
With Best Regards,
Andy Shevchenko
