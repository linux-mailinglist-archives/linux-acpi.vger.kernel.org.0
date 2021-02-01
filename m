Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973730AFC2
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBASun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 13:50:43 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40351 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBASun (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 13:50:43 -0500
Received: by mail-oi1-f179.google.com with SMTP id k142so5480568oib.7;
        Mon, 01 Feb 2021 10:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOyiAkm4EZ4H70a+GP6ZyqUn1vvRaBH/f0gl3qIFpYY=;
        b=ImEKVCvFakcrrs9qQ85KlGAGGSiepv1BJ7VlB/wyCu03KWeRtNPyucFPg3nK6zCP8P
         4YvrQXWsf0yGcbtAgeoDU8PzPsz241ZdJKKEngtaBXcWwhU/HDz144aDL1uwY1aTeUPv
         nOEaITKUrcGB31VB8+s5+sug77Dl6bsDSupS3sZ/9bvW+uAkb573V0hy8eRNlV/ibOga
         H5b5O4gfkvZlT9YBWu6k0It3Ld/Rj8FDTV09G/+HvnyWrQd5yneABWDXdsKRaAyjXgLU
         K5c9gfFLPeAj+nR2jk42kjX0E10iMO0rYlvCJkTjKFF4FznasZqMd9N1yhAMZLpgrerb
         Eahg==
X-Gm-Message-State: AOAM530zC0fCr2QYqfOMfI2LcrXYwQ/DZHeBa+hh5hdeT1gaYar4VEt8
        +8Kv3xf6OyrvG8C14o2KbERaqH3lPLCdq0J+lUw=
X-Google-Smtp-Source: ABdhPJzLA3DzsrAUF09uDXBNIgSYisgX3jApC6Ba9Ye4EuEP84kjmP4Akv5YDF8Omh0VMlWbwgL0iKioz8R+yHcuA14=
X-Received: by 2002:aca:d14:: with SMTP id 20mr171918oin.157.1612205401622;
 Mon, 01 Feb 2021 10:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell> <YA/xfxcwCabETug6@smile.fi.intel.com> <YBhLuNZ7xmHdhurU@smile.fi.intel.com>
In-Reply-To: <YBhLuNZ7xmHdhurU@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 19:49:50 +0100
Message-ID: <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 7:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 26, 2021 at 12:39:59PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 26, 2021 at 08:21:01AM +0000, Lee Jones wrote:
> > > On Mon, 25 Jan 2021, Andy Shevchenko wrote:
> > >
> > > > This is a second part of the Intel MID outdated platforms removal.
> > > > First part is available as immutable branch [1]. The series has functional
> > > > and build dependencies, so the mentioned branch should be used as a base
> > > > for these changes.
> > > >
> > > > Note, that some of the drivers, that arch/x86 covers, seems never appeared
> > > > in the upstream (like msic_ocd).
> > >
> > > What platforms stop working after this removal?
> >
> > Intel Moorstown, Medfield, Clovertrail.
> >
> > > Are you sure no-one is using them?
> >
> > Definitely.
> >
> > > I wouldn't be keen on breaking Janet's PC that she's been using daily
> > > and keeping up-to-date since the 90's.
> >
> > They never were in PCs.
> >
> > All of them were supported by Android and Janet won't update her phone or even
> > Android tablet for sure they never ever run any kind of Linux than Android.
>
> So, I hope you are satisfied and we may proceed with removal.

Speaking of which, the patches here are requisite for SFI support
removal, so I'd like to route them through the ACPI tree if that's
fine by all of the interested parties.

Thanks!
