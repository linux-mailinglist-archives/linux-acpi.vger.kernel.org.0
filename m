Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A87316A71
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 16:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBJPp2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 10:45:28 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44753 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhBJPp0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 10:45:26 -0500
Received: by mail-oi1-f177.google.com with SMTP id r75so2447756oie.11;
        Wed, 10 Feb 2021 07:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3IPwBT8xxvQKPsxmgcOMrR2P9ZRaO11bj6/TdKvl14=;
        b=ri7vQIgBlBoYJFTpvEilEbgGpEJAJfgX4hZfJjFPeHnVr/wWRkMvT25Z0vp0UrIssz
         JXfpIa3vJIbmd58Hd2aDp7kdAZoHqzJgZQJ1T9ZGfNqL/ieM24WlfKMJyPjjrrdm0/ct
         3+KSoGgmsEiRp3SAHHm/vHEpoulF8DIIuoNrC/KHFyPzbxQTs8wh+nXnWFX1UFwYedNY
         hZATs+mslT3JjpjEsSraWz8+o0+3LHAXpxNhqhU5cN8QEPeLTbMbLKTMc3JTbG4wER5T
         vkKDYmxuzkJJEqv5rA2Wg6d4jcXNA0CWgnFam0AKQSkt8OXa4fgmA4sWuxJL6v1oZuop
         lrdA==
X-Gm-Message-State: AOAM533OtLOjLV0PPobEWtS+9LK9hPOQ6RmGtqlAnn4yf1h1UzhUQR/S
        ySCda5HOaoy9oVn1ML8k/2+nYksAQNTF9/bSeAk=
X-Google-Smtp-Source: ABdhPJyoIp1+jdI6OyfNmVKcJxVr96Cuv2wdPuKahjad0qXgz2dUu0yUXJwbpuCHdQtuBEcy4RNP4KwjziiMh5v1Pn0=
X-Received: by 2002:a54:400b:: with SMTP id x11mr2548700oie.71.1612971885498;
 Wed, 10 Feb 2021 07:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher> <1946478.1QpZic6vku@kreacher>
 <YCPyKjO7XPBFAgbn@smile.fi.intel.com> <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
 <YCP+xOuic5fPx+7i@smile.fi.intel.com>
In-Reply-To: <YCP+xOuic5fPx+7i@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Feb 2021 16:44:34 +0100
Message-ID: <CAJZ5v0iCe=GuauCVzLG83urBHghO0suabHcMg2Kw54XFjBqCbw@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 4:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 10, 2021 at 04:01:16PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 10, 2021 at 3:48 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > > > > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > > > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > > > > -       if (val && nval == 1) {
> > > > > > > +       /* Try to read as a single value first */
> > > > > > > +       if (!val || nval == 1) {
> > > > > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > > > >
> > > > > > This returns -EINVAL if val is NULL.
> > >
> > > Nope. That's why it's a patch 7. Patch 6 solves this.
> >
> > That's my point.  Patch 7 should be the first one in the series.
>
> Ah, okay. Since you want this let me rebase.

Thanks!

> > > > > > >                 if (ret >= 0)
> > > > > > > -                       return ret;
> > > > > > > +                       return val ? ret : 1;
> > > > > >
> > > > > > So val cannot be NULL here.
> > >
> > > Why not? I have changed conditional.
> > >
> > > > > > >         }
> > >
> > > > > > To me, acpi_fwnode_property_read_string_array() needs to special-case
> > > > > > val == NULL and nval == 0.
> > >
> > > nval can be anything in the case of val==NULL. So far neither of your proposals
> > > conform this.
> >
> > That is if !val and nval != 0 is regarded as a valid combination of
> > arguments, but is it?
>
> I believe nobody tested that.
>
> > If that is the case, the check in acpi_data_prop_read() in the last
> > patch that I posted needs to be (!val || nval == 1), but that would be
> > it, no?
>
> I think it also needs the conditional at return as in my patch.

I'm not sure why.

acpi_data_prop_read_single() would return 1 for !val if it finds the
property with a single value and that should be sufficient, shouldn't
it?
