Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA131903A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhBKQm2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 11:42:28 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35583 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhBKQk1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 11:40:27 -0500
Received: by mail-oi1-f178.google.com with SMTP id l3so6778181oii.2;
        Thu, 11 Feb 2021 08:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8q2NiznoWVHuUMkmRhG9I02yDUgNpmTMAt3YoQyfIGk=;
        b=RGLHmA221z8aU7u1IS1sRT8yqYqIJMDyvqois51hPWANv4R8/5f8t0SUtFkqqM6eaz
         n7+sQ9TRINJMFq9C+S7DapFyzL/JbIUWQ3rf8G3jftUw9pwBozz+7vdwePQf2HV09xp9
         xltSjFLp9grG2HobDHKMFU3vUGESdGToCREWE9aFIeoutP72Hc3eAB0J48nEHDQ7i4bJ
         GiwRk6HxzI2A6lyeQ4Xp2vwQ0csDP5mXp1O/MqpvbofZznXOjK4hPpxzsWRE2E2Cw8L1
         gbQ5fcV7pUirTH2Zak2GGui2v2bdXm/FEYSmVmsVEIMWz6U+HMVPOLH4WEfJlud4raqX
         yUKw==
X-Gm-Message-State: AOAM5334z8Lm7aGeMR7nZELnQOUvdIQzliaDjKOoEgY5xxPk6G3lOQe5
        4a0wbt82usxum/k45o0pcO/Xql9s+VisfN51oR8=
X-Google-Smtp-Source: ABdhPJzyQFbX0hSlRZwJpCaG0gnL07XQ4sZ9sbCMqGdf1PZ/ue9UJTn+QzFgmJlhxkJqET2zef5RWey55AhZUUOtyWc=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr3459892oia.157.1613061585919;
 Thu, 11 Feb 2021 08:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher> <1946478.1QpZic6vku@kreacher>
 <YCPyKjO7XPBFAgbn@smile.fi.intel.com> <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
 <YCP+xOuic5fPx+7i@smile.fi.intel.com> <CAJZ5v0iCe=GuauCVzLG83urBHghO0suabHcMg2Kw54XFjBqCbw@mail.gmail.com>
 <YCVQWgg6L5YcAXO1@smile.fi.intel.com>
In-Reply-To: <YCVQWgg6L5YcAXO1@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Feb 2021 17:39:34 +0100
Message-ID: <CAJZ5v0juLyE=vCyw5_qZus3YC65kY=mOhrcb7OoWZQtZNnr_Ag@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 11, 2021 at 4:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 10, 2021 at 04:44:34PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 10, 2021 at 4:42 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Feb 10, 2021 at 04:01:16PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Feb 10, 2021 at 3:48 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > > > > > > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > > > > > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > > > > > > -       if (val && nval == 1) {
> > > > > > > > > +       /* Try to read as a single value first */
> > > > > > > > > +       if (!val || nval == 1) {
> > > > > > > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > > > > > >
> > > > > > > > This returns -EINVAL if val is NULL.
> > > > >
> > > > > Nope. That's why it's a patch 7. Patch 6 solves this.
> > > >
> > > > That's my point.  Patch 7 should be the first one in the series.
> > >
> > > Ah, okay. Since you want this let me rebase.
> >
> > Thanks!
>
> I started rebasing and realised that your approach has swapped the error codes,
> i.e. if it's a single-value and it is, e.g., 16-bit wide, the u8 read will
> return 1, while it has to return -EOVERFLOW.

Well, that's a bug in my patch.

I thought that you would reorder the series to put the fix into the
front of it, but I didn't really mean to rebase it on top of my patch.
Sorry for the confusion.

However, not that you have started to do it apparently, let me post
that patch properly with all of the issues addressed.

> If you prefer, I can move two patches to the beginning, so one will be a good
> prerequisite for this fix. And I'm still unsure about stable (Fixes tag is okay
> to me), because the counting never worked from the day 1.

Well, the code has never worked as intended, so why don't we make
"stable" work as intended too?
