Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0272AFB89
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKKWnt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 17:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgKKWlp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2020 17:41:45 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E11C0401C8
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 14:41:04 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id me8so4942409ejb.10
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2020 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALVcAvrDAuBZ3IPCrkjPwHAX8+DNa5pqM0afUjn5X6s=;
        b=rTT49AnkhNr487K9n5NKwYO9WMUE3MNY/UrxCB1TueO1d+BsQebe1bVAjto6CnRmk/
         RDpD3FTxsnpbumIEQX0xW8WRxu+N8dbL7+UlwJuliNYW4tOrjIHEsijjBDMt5SiFkT7W
         qIC8M6dcNADqftbsDDTwdltE4fVgS48XJPqta990E5jyRjX44U9fYqfo3bpsnhM2g0J7
         eynDKGo1p6EV/6yF+gGpA1ZpwHDZOUAKO9aCvylNPSLobnovjeE+6vOb7pc4GrNqOJdL
         VpWgI5+VW1m4VWGcBZwG83xjGz4jrrCYOWJBRZrRhJgpclGLGZV4RXEKWrc44rurwU4I
         eK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALVcAvrDAuBZ3IPCrkjPwHAX8+DNa5pqM0afUjn5X6s=;
        b=Z7FW+pvecz/0FHLSEh6neNNjbDS2mK6YwhBe5jt0snS+xb3B7npHrKAnXMycOhR+fZ
         Wa1/PhxapwYGG47QtWFOHH4MwBNL65Cf2hiBqz+qnuSiagy4RkwvDCmRqL9Wza91mVMp
         s2QUJ8gJItz+r70+bsrChjxp175JiC8wwiod5bzDxhfdK9rOde6oZvzIoosDtD2iY+xN
         72f/nCoARVzeS9KTYov3vv9EJMjBU6enOzQrw7hqyTJCehSa0eg2GuscwNMrYqFrAuLl
         WhWO2x0Hoq3cPYq/wUlGx+Rmod5cfUgADHpmu7mCZxHrXAqHZbQs3q/bD/UhsxFsY3N1
         HSjA==
X-Gm-Message-State: AOAM533KXLKmA/37L1H8KHz55J2HXz9sVcsIJx2QX5y5fE8jl//GXY7L
        dZ1wbtuceNkNMFLzadPriWbo47L2u7o0IczWhDf7PQ==
X-Google-Smtp-Source: ABdhPJxZkk2CPz2+JgnqesQh/6Q2toSIuomPC2gF0BhYxxkrw/FgNoCUwNXohjnwegJoJqNJZnPv//TQH98s+vGiwVw=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr25980011ejb.264.1605134462866;
 Wed, 11 Nov 2020 14:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com> <4a8b5a64-7ba0-a275-744f-6642f98e2213@infradead.org>
In-Reply-To: <4a8b5a64-7ba0-a275-744f-6642f98e2213@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 14:40:52 -0800
Message-ID: <CAPcyv4gPwNj+aaRs++hxSxJke8H476hhppcn84t3KUBr0Ff2og@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 11, 2020 at 1:42 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/11/20 9:17 AM, Dan Williams wrote:
> > On Tue, Nov 10, 2020 at 11:12 PM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Tue, Nov 10, 2020 at 09:43:50PM -0800, Ben Widawsky wrote:
> >>> +config CXL_MEM
> >>> +        tristate "CXL.mem Device Support"
> >>> +        depends on PCI && CXL_BUS_PROVIDER != n
> >>
> >> depend on PCI && CXL_BUS_PROVIDER
> >>
> >>> +        default m if CXL_BUS_PROVIDER
> >>
> >> Please don't set weird defaults for new code.  Especially not default
> >> to module crap like this.
> >
> > This goes back to what people like Dave C. asked for LIBNVDIMM / DAX,
> > a way to blanket turn on a subsystem without needing to go hunt down
> > individual configs. All of CXL is "default n", but if someone turns on
> > a piece of it they get all of it by default. The user can then opt-out
> > on pieces after that first opt-in. If there's a better way to turn on
> > suggested configs I'm open to switch to that style. As for the
> > "default m" I was worried that it would be "default y" without the
> > specificity, but I did not test that... will check. There have been
> > times when I wished that distros defaulted bleeding edge new enabling
> > to 'm' and putting that default in the Kconfig maybe saves me from
> > needing to file individual config changes to distros after the fact.
>
> What we as developers put into mainline kernel Kconfig files has nothing
> to do with what distros use in their distro config files.
> Or at least it shouldn't.  Maybe your experience has been different.

I agree with that sentiment, but walk it back through the requirement
I mentioned above... *if* we want a top-level CXL option (default n)
that goes and enables many CXL sub-options the default for those
sub-options is something that needs to be listed in the Kconfig. 'm'
is more flexible than 'y', so if a user wants CXL at all, and doesn't
care about how, I'd prefer it's 'm' rather than 'y'.

I have had to go submit distro config fixes when Kconfig defaulted to
'y' when 'm' was available, and the reasoning for why it was 'y' was
"oh, that was the Kconfig default when I flipped this other option".


> >>> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> >>
> >> Please don't use '//' for anything but the SPDX header.
> >
> > Ok, I find // following by /* */ a bit ugly, but I don't care enough to fight.
> >
>
> Hm, it's not in coding-style AFAICT but Linus has OK-ed C99 style comments:
> http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html
>
>
> >>> +MODULE_AUTHOR("Intel Corporation");
> >>
> >> A module author is not a company.
> >
> > At least I don't have a copyright assignment clause, I don't agree
> > with the vanity of listing multiple people here especially when
> > MAINTAINERS has the contact info, and I don't want to maintain a list
> > as people do drive-by contributions and we need to figure out at what
> > level of contribution mandates a new MODULE_AUTHOR line. Now, that
> > said I would be ok to duplicate the MAINTAINERS as MODULE_AUTHOR
> > lines, but I otherwise expect MAINTAINERS is the central source for
> > module contact info.
>
> Sure, MAINTAINERS is fine, but the MODULE_AUTHOR() above provides
> no useful information.
> Even saying (made up) linux-devel@linux.intel.com would be slightly better,
> but some kind of contact info would be great. Otherwise just delete that line.

True, if the goal is to allow random end users to email support
questions about this module I'd rather not put my email there.
Instead, if it's someone that has kernel development questions then
they should be able to use MAINTAINERS for that contact.
