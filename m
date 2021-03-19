Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351D34250E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSSoz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:44:55 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33282 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCSSoW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 14:44:22 -0400
Received: by mail-ot1-f41.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so9470718ota.0;
        Fri, 19 Mar 2021 11:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR8NIAoP3ynBOhOjQZ15G+E4WBburaxkSRvRk4396go=;
        b=lSvbIuy56uHTzIe8tNhZo4u+IM5CDcezfnhWGVzNQ+Ce4f51cFHloOvdA8uBJvfi8F
         4ZiXmEcWPt0BgnwBfe94B5wVXg1kWnkXQGipA99db/d8iZDBcYgppOtuZgd1EIUl49gs
         RqZH/SaTHDUetq0wT3hkj1nAyRN358AYO1w7TbRsmWhEwmavMfx6/grPk4979oTj+6ri
         Zo6ltuAwLKTUrmopmxL6ESL4g3/RwykATJrFo0hvwKd8l5I+YZ3MzUU0FGoLHLq0GlYZ
         C0YXEjvjpKny1uOGlQHSk4SubGJKwYO5kS+JM9QO+elQXb5uuxlp3q49CsEAL9mx9/rQ
         M6JQ==
X-Gm-Message-State: AOAM5309ab7dcYl0qFRRPa0Zi7lMZRZ/dEPH1+G+9MnVAXRt2GE85QNm
        GIV18CBmTNAdoGN4NlQsnP3F2rG3FfZIr7R2ZiMwSW1Zkv4=
X-Google-Smtp-Source: ABdhPJznCwEMXGPf6ROMg55dBLUqElK+MJzvCyuPcu7vKmB0CsjaD99GxOEwHiYr6iPEzzmbhruXFZg8bemiuby/92w=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr2156324otq.260.1616179462192;
 Fri, 19 Mar 2021 11:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210312160137.19463-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jHXQC+P1_FTq6TkMKAb=FsBH=cw3mUkp9rJUC7R1B-5A@mail.gmail.com> <YFToGiFbGkJDDaMF@smile.fi.intel.com>
In-Reply-To: <YFToGiFbGkJDDaMF@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 19:44:11 +0100
Message-ID: <CAJZ5v0hFsfX7A0t4Snr7qsivzmCecSkNxMm6OFaB30PjXspAmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: scan: Use unique number for instance_no
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 7:06 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 19, 2021 at 06:00:38PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 12, 2021 at 5:02 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Current mechanism of incrementing and decrementing plain integer
> > > to get a next free instance_no when creating an ACPI device is fragile.
> > >
> > > In case of hot plug event or namespace removal of the device instances
> > > with the low numbers the plain integer counter can't cover the gaps
> > > and become desynchronized with real state of affairs. If during next
> > > hot plug event or namespace injection the new instances of
> > > the devices need to be instantiated, the counter may mistakenly point
> > > to the existing instance_no and kernel will complain:
> > > "sysfs: cannot create duplicate filename '/bus/acpi/devices/XXXX1234:02'"
> >
> > This is a slightly convoluted way of stating that there is a bug in
> > acpi_device_del().
>
> Any suggestion how to massage the above?

Why don't you simply say something like "The decrementation of
acpi_device_bus_id->instance_no in acpi_device_del() is incorrect,
because it may cause a duplicate instance number to be allocated next
time a device with the same acpi_device_bus_id is added."
