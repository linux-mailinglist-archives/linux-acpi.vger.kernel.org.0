Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDD362769
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhDPSFP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbhDPSFP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Apr 2021 14:05:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30956C061574
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2021 11:04:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so43419707ejr.5
        for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2021 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc9tpLdABKe3k+bL9U1Q0ClltNGtCJ/DmDcgCrhYdYg=;
        b=K3Y4k6P9B2fQV4CiR+khvfZXow2zdY2hX27fW9sgnIblaRE2hi2taF7p9Q4+AVcl4s
         PfD8Ve5pKKASpKAll7IWIR3sutavY35ZyGnoSeGS8TSFfO7pt0sY4jZ2NOXX3aa+uGEt
         hS8GPNmg0Kma0AUOiHZGH3XRkgHpY3q9QceqDF/VvGGr6hxG6R/PlKMfXoOLDzdf8+FE
         JWH+eP92Afm41WhA/O1edLt5VLQcWd/s3RUB7P/6f157Rp/NIu9TD3WCQCkg/FgRiFYR
         csxIBYc1ZQnzWAR8kN1svzNl5N3wrbg/gOMMMDKcCXCLEOdXR8MKYtIJJrmNX1ZgDtAA
         gCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc9tpLdABKe3k+bL9U1Q0ClltNGtCJ/DmDcgCrhYdYg=;
        b=bxibyWnApoc2+R+mlgpBVF5j4thSsGMviYpVJWnVeRnGJz8hmYw8e4O5b1C4yHToM8
         U6JiS1wMN26qV1+1CWVozyKZHmonTx5HviBYMxygrxR4MphF/+SbENJ3gha8FKF+W39e
         1JfSxA7GBvnPEEVNi3W+PiBrSdSveWwEkE3ukmW5cbDf7e2rxD09cJTYjz+PnZuZahLc
         5WUt8J7WcmjQfkciU+2vdly7dKzP1aUU0FinTb0MBDSNpt75+DNGYeaNfkPOC19usTbt
         8wSEitzXSZ8wOHD6AvBP5ZmswVX3b+HkTp9A65HTPToUDpdbeLqHSHKIRWHIQwxSfUz7
         R8nw==
X-Gm-Message-State: AOAM532poy0zXoY0OzLeHW6z6NsooFSwcYyBefVtpMZMgnLuowycm+di
        VjPIRpQzPy/g+xl/C3lo1g3ek0Kscq8RiiZ38z0o1Q==
X-Google-Smtp-Source: ABdhPJzkDt6LekTblXCPYAUVMDzlqIo96JgBbNZCYuPdE91LgUOXmqNtScSYjIQX27TBLJw8r7il/9ZzZaWobeHGEDM=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr9559800ejw.341.1618596287889;
 Fri, 16 Apr 2021 11:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
 <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
 <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com> <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
In-Reply-To: <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 11:04:36 -0700
Message-ID: <CAPcyv4j+66FaPHPLkF+ZPQq=uncYJ1Mx8JMzZnhp86qS=JewjQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 16, 2021 at 10:34 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 16, 2021 at 09:15:34AM -0700, Dan Williams wrote:
> > On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > > is not correct. Import GUID to variable of guid_t type and then
> > > > > compare.
> > > >
> > > > Hmm, what about something like the following instead, because it adds
> > > > safety. Any concerns about evaluating x twice in a macro should be
> > > > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > > > not an array.
> > >
> > > ARRAY_SIZE doesn't check type.
> >
> > See __must_be_array.
> >
> > > I don't like hiding ugly casts like this.
> >
> > See PTR_ERR, ERR_PTR, ERR_CAST.
>
> It's special, i.e. error pointer case. We don't handle such here.
>
> > There's nothing broken about the way the code currently stands, so I'd
> > rather try to find something to move the implementation forward than
> > sideways.
>
> Submit a patch then. I rest my case b/c I consider that ugly castings worse
> than additional API call, although it's not ideal.

It sounds like you'll NAK that patch, and I'm not too enthusiastic
about these proposed changes either because I disagree that the code
is incorrect. Is there another compromise?
