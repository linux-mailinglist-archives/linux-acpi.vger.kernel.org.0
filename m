Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E16344973
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCVPnK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 11:43:10 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34481 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCVPmv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 11:42:51 -0400
Received: by mail-ot1-f42.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so16388983otn.1;
        Mon, 22 Mar 2021 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GP3lCJZc4gYGIls7XWVDwUQAFlT0Yz/pnrig4GIvJM=;
        b=qb7YY5fPcWJAGVLRaov0a8B7b6+hMeek8UG40a3OfJGfrIeiC2cTM38XdnYXcEyN5e
         c8CvKhqytuh27Tq+2kV9lJPmGcZjYG98deH7Jw0PpciRKlJpUVS/xHsk5Ep6W7xwZb/y
         gL4Vnh0SVYhB6N3QzHJJs8OnRB6+ZCvw8+C5FDz5EtNz7kENXoSwOodrcIfsFASWKwN4
         NL+K/DkmBMCirpSbQlTNbcD87/FcBI67pENAXrlWI+GOgglTFfze04pfPCJQaqekh8RA
         /Ts19dcXpxgI/Abgm5cAhYYkai0JB4YoDsBYVJgP4ZrPnAg+QtJcPy7NHwDLccQFbGVJ
         qWKw==
X-Gm-Message-State: AOAM533AeGgQuF6DoMelhx4ttd7coLeFCcYZQe8dXJuzcmKPIchMT2eD
        ur1QY80BjUk8NG+4CY8mUKvDgD5u15O8ayMuEAs=
X-Google-Smtp-Source: ABdhPJzV3qz+83jdENbJnKRS5X9R2Xx3meuFt+kw4JkvZXceQED7OUkKom4tKE5IzgVwB0ykTAQZ5+/T6SW+te4d1lk=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr458297otq.260.1616427770673;
 Mon, 22 Mar 2021 08:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com> <CAHp75VeVhHhkzPVdGRa9inLJtW0QF=dDp3jB-U1xvKWRY_pbyw@mail.gmail.com>
In-Reply-To: <CAHp75VeVhHhkzPVdGRa9inLJtW0QF=dDp3jB-U1xvKWRY_pbyw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 16:42:39 +0100
Message-ID: <CAJZ5v0gxjCiP-XbvLkHZiewjMhpR6KdJFapjV_-F05Uc_G7tqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPI: scan: Use unique number for instance_no
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Mon, Mar 22, 2021 at 4:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 4:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The decrementation of acpi_device_bus_id->instance_no
> > > in acpi_device_del() is incorrect, because it may cause
> > > a duplicate instance number to be allocated next time
> > > a device with the same acpi_device_bus_id is added.
> > >
> > > Replace above mentioned approach by using IDA framework.
>
> ...
>
> > > +       result = ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 255, GFP_KERNEL);
> >
> > This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
> > should be 256 above, instead of 255.
>
> Ah, good catch!
>
>
> > While at it, though, there can be more than 256 CPU devices easily on
> > contemporary systems, so I would use a greater number here.  Maybe
> > 4096 and define a symbol for it?
>
> I was thinking about it, but there is a problem with the device name,
> since it will break a lot of code,

What problem is there?

> And taking into account that currently we don't change the behaviour
> it is good enough per se as a fix.
>
> That said, we may extend by an additional patch with a logic like this:
>
> res = ida_get(4096)
> if (res < 0)
>   return res;
> if (res >= 256)
>  use %04x
> else
>  use %02x
>
> Would it make sense to you?

I'm not sure why not to always use %02x ?  It doesn't truncate numbers
longer than 2 digits AFAICS.
