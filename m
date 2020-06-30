Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1720F358
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jun 2020 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgF3LEy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jun 2020 07:04:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35377 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgF3LEe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2020 07:04:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so17089222oik.2;
        Tue, 30 Jun 2020 04:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXIRIHHncqo0zBLK3dtMRuMsQ9p5Az0FH+7MVXNOGgk=;
        b=K5bwXcOtIDbWYFJlyEiw59h4My36mdbLWRkhv3MFfX+NYheBF5pZfd2BGi3ClR3hEu
         hLDVBqU/tSrTKlkdPywoXRo/+PwakNZ//my+yhx7JCwud5WYcSzkrvBKfShFuIz9l8iN
         3EopntkNX19JvqoroTbhpOWzW82mUXdSs7XaVZJbZomdo/AMJgRp5Np7OhJr0bfI2Cv1
         lp2ea7eJtltKrrPDn1SxJ4CC614Ggge4UvltBeydnZcTbanvP1pPPQD2LuCAlF+DmKun
         Q2yDo4GSMlbeO+jI1cdKcoaWB73dePvWRKpAo6SAblx103jV0hr1YWGmGA6np7nEZyft
         gysw==
X-Gm-Message-State: AOAM532h4iok/G8EI4d3+U0rUKmuPbUPvZWlzEU+ovbY9F8cqXTjZJJC
        CKgz5edLrPGRtJbJ7yhqfhiJxUfk7RvSSbmIOgI=
X-Google-Smtp-Source: ABdhPJyrXV+odnKMMsJSNg1252EbQtYugp1MCGhfn0n9yvdE0dCa6B3S5wf96DbBHiDa3tUn2DkDotITWi/UNHXvnXk=
X-Received: by 2002:a54:4585:: with SMTP id z5mr16015967oib.110.1593515073282;
 Tue, 30 Jun 2020 04:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
 <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
 <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com> <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 13:04:21 +0200
Message-ID: <CAJZ5v0g8=tXU8HHkoXSOwSmRhTgwb5rW8N8QQga6AU91kp1dVw@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 29, 2020 at 10:46 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Jun 28, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > > > Hi All,
> > > > >
> > > > > This series is to address the problem with RCU synchronization occurring,
> > > > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > > > when the namespace and interpreter mutexes are held.
> > > > >
> > > > > Like I said before, I had decided to change the approach used in the previous
> > > > > iteration of this series and to allow the unmap operations carried out by
> > > > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > > > which is done in patches [1-2/4].
> > > >
> > > > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > > > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > > > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > > > variant of unmapping.
> > > >
> > > > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > > > always defer the final unmapping and the only ACPICA change needed to support
> > > > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > > > of the unused mappings when leaving the interpreter (module the extra call in
> > > > the debug code for consistency).
> > > >
> > > > So patches [1-2/4] have been changed accordingly.
> > > >
> > > > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > > > range and so it is introduced by patches [3-4/4].
> > > >
> > > > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > > > after rebasing on top of the new [1-2/4].
> > > >
> > > > The below information is still valid, but it applies to the v3, of course.
> > > >
> > > > > For details, please refer to the patch changelogs.
> > > > >
> > > > > The series is available from the git branch at
> > > > >
> > > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > > >  acpica-osl
> > > > >
> > > > > for easier testing.
> > > >
> > > > Also the series have been tested locally.
> > >
> > > Ok, I'm still trying to get the original reporter to confirm this
> > > reduces the execution time for ASL routines with a lot of OpRegion
> > > touches. Shall I rebuild that test kernel with these changes, or are
> > > the results from the original RFT still interesting?
> >
> > I'm mostly interested in the results with the v3 applied.
> >
>
> Ok, I just got feedback on v2 and it still showed the 30 minute
> execution time where 7 minutes was achieved previously.

This probably means that "transient" memory opregions, which appear
and go away during the AML execution, are involved and so moving the
RCU synchronization outside of the interpreter and namespace locks is
not enough to cover this case.

It should be covered by the v4
(https://lore.kernel.org/linux-acpi/1666722.UopIai5n7p@kreacher/T/#u),
though, because the unmapping is completely asynchronous in there and
it doesn't add any significant latency to the interpreter exit path.
So I would expect to see much better results with the v4, so I'd
recommend testing this one next.

> > Also it would be good to check the impact of the first two patches
> > alone relative to all four.
>
> I'll start with the full set and see if they can also support the
> "first 2" experiment.

In the v4 there are just two patches, so it should be straightforward
enough to test with and without the top-most one. :-)
