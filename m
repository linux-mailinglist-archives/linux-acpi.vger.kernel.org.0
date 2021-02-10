Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14003169AA
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhBJPCN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 10:02:13 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:44876 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhBJPCJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 10:02:09 -0500
Received: by mail-oo1-f45.google.com with SMTP id n19so542384ooj.11;
        Wed, 10 Feb 2021 07:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4r1dL/62zvPQ5vCFCYHmddBBlQvQ5Mxd0U7I5nMv8U=;
        b=kKzGash8tJjKCoUcKYqqShKbeAwNioV5xrjc73y8GoKqxRvWVhv7iVgBIqbMv70BpY
         tawd+h3lXZTEaGyRMpTPDIyi5p8xAufI3hfsb4v1nJrSWLLeulom4G2SvY+4HxQUDo40
         QltISDisOR3jzi+7/dguruR0fCk+ybjW6ZQ2ObbhAAjFl2sJTGmS/smgKkr+U1+d6HB0
         ADfQ7cgygbHk384xjxPWu0rjQN8qldaURLKEGuMLwOmYREs+HwILa/pc61KxarVtrq2j
         yKkLq3zhLZKJXoqBsgEoJW/THAgEzgG4pOjTAIAcLd9H3xG7pad1pf1nFHUFfO+sSP4b
         D9mw==
X-Gm-Message-State: AOAM5312XeyVdhkj0NJu5O/7yQnnHt/IUhlJMvDyzIbsumhGIU91lB7W
        nu19THNRKRP9nqNDFzm+r6oSDG7jgjiopUf2DyQ=
X-Google-Smtp-Source: ABdhPJwKm4pa3yTqhxxbZTEbrBcRJ7gHf1aXxqRhkCIheRuZV5YbAcxoPstIWOHVylMGxqGSNpeX21ek+qWDIcsNeIk=
X-Received: by 2002:a4a:d50d:: with SMTP id m13mr2348928oos.2.1612969287823;
 Wed, 10 Feb 2021 07:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20210210114320.3478-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hx78JHnP5-5xFTPr0Rh9FvPCzAzTCyBaT6eLZ3Dd-mFA@mail.gmail.com>
 <3881654.NPl3a4M0kB@kreacher> <1946478.1QpZic6vku@kreacher> <YCPyKjO7XPBFAgbn@smile.fi.intel.com>
In-Reply-To: <YCPyKjO7XPBFAgbn@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Feb 2021 16:01:16 +0100
Message-ID: <CAJZ5v0jq1+q3HKDEzgBUWtZY8H0kaiR=bNi1WUsdg3BTAyiPgw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ACPI: property: Allow counting a single value as
 an array of 1 element
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 3:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 10, 2021 at 02:48:09PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 10, 2021 2:31:48 PM CET Rafael J. Wysocki wrote:
> > > On Wednesday, February 10, 2021 1:36:00 PM CET Rafael J. Wysocki wrote:
> > > > On Wed, Feb 10, 2021 at 12:51 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> Rafael, thanks for the review, my answers below.
>
> > > > > We allow to read the single value as a first element in the array.
> > > > > Unfortunately the counting doesn't work in this case and we can't
> > > > > call fwnode_property_count_*() API without getting an error.
> > > >
> > > > It would be good to mention what the symptom of the issue is here.
>
> fwnode_property_match_string() is not working as reported by Calvin.
>
> > > > > Modify acpi_data_prop_read() to always try the single value read
> > > > > and thus allow counting the single value as an array of 1 element.
> > > > >
> > > > > Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > This is a bug fix, so it should go in before the cleanups in this series IMO.
>
> Seems it was never worked, hence neither Fixes tag nor...
>
> > > > Also it looks like stable@vger material.
>
> ...Cc to stable@.
>
> > > > > -       if (val && nval == 1) {
> > > > > +       /* Try to read as a single value first */
> > > > > +       if (!val || nval == 1) {
> > > > >                 ret = acpi_data_prop_read_single(data, propname, proptype, val);
> > > >
> > > > This returns -EINVAL if val is NULL.
>
> Nope. That's why it's a patch 7. Patch 6 solves this.

That's my point.  Patch 7 should be the first one in the series.

> > > > >                 if (ret >= 0)
> > > > > -                       return ret;
> > > > > +                       return val ? ret : 1;
> > > >
> > > > So val cannot be NULL here.
>
> Why not? I have changed conditional.
>
> > > > >         }
>
> > > > To me, acpi_fwnode_property_read_string_array() needs to special-case
> > > > val == NULL and nval == 0.
>
> nval can be anything in the case of val==NULL. So far neither of your proposals
> conform this.

That is if !val and nval != 0 is regarded as a valid combination of
arguments, but is it?

If that is the case, the check in acpi_data_prop_read() in the last
patch that I posted needs to be (!val || nval == 1), but that would be
it, no?
