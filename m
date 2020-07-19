Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC652253A2
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jul 2020 21:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgGSTOg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 19 Jul 2020 15:14:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36158 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSTOg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Jul 2020 15:14:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id 72so10595020otc.3;
        Sun, 19 Jul 2020 12:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vgePeYsDGdOfYJ+zrhF6ulRCJSEh7r7GG7PhUNcyLQ=;
        b=cBPB3z4dag6pgFqrJXBC/hcQZaACsU6016ZinRNn55vEqaKeS/em8tpvzsSULv7/S+
         CLY71dJJh6+QId5HH7ZwDXc1tbjGam+uWlwpKAoucwCsYNjQ46YPoP29GfDqvC8oXzfR
         D7lnRDc4+KsPlITqkUj7Y0hHX+w1f3KExKmI9Svxh7oDyNvYN54WdCyrfI3+KT3YH1FI
         t1uhep0MNmypgel+MhPzTvvs0xfZH31hkmQ9/7ywE8oed1c/zY470nZPvnapub+i1Nhg
         bbl5SuW7P21DNGMjF9Qwasf7Rqe0rG8OYANKAhwXN2KV/k52QFO4Oeg36S2JgETH6hiw
         njww==
X-Gm-Message-State: AOAM531cA74inAKeXmOdD/T45aHHj235ZODMpyjGB4PQW1oRFvv8p+Uh
        x/5N7SJsf2qjgHDZUS2qv6Cp/+EJY0YRJrgQkVw=
X-Google-Smtp-Source: ABdhPJwNclm9vK0RlcGozdCrMYwS4qEdXErvuUT3XWaBD09UNJEHHHmrT266kjioUmRdyYj0HIAkNxsHHJ4QFXCh6OE=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr17201578oth.262.1595186075072;
 Sun, 19 Jul 2020 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher> <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
In-Reply-To: <1738949fd49e9804722bf82d790e3022fc714677.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Jul 2020 21:14:23 +0200
Message-ID: <CAJZ5v0ga+j4iK7oTbkFPDmN=UpUMHfbmQMyBnP-LvG-xSj50kQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 16, 2020 at 9:22 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-06-29 at 18:33 +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The ACPICA's strategy with respect to the handling of memory mappings
> > associated with memory operation regions is to avoid mapping the
> > entire region at once which may be problematic at least in principle
> > (for example, it may lead to conflicts with overlapping mappings
> > having different attributes created by drivers).  It may also be
> > wasteful, because memory opregions on some systems take up vast
> > chunks of address space while the fields in those regions actually
> > accessed by AML are sparsely distributed.
> >
> > For this reason, a one-page "window" is mapped for a given opregion
> > on the first memory access through it and if that "window" does not
> > cover an address range accessed through that opregion subsequently,
> > it is unmapped and a new "window" is mapped to replace it.  Next,
> > if the new "window" is not sufficient to acess memory through the
> > opregion in question in the future, it will be replaced with yet
> > another "window" and so on.  That may lead to a suboptimal sequence
> > of memory mapping and unmapping operations, for example if two fields
> > in one opregion separated from each other by a sufficiently wide
> > chunk of unused address space are accessed in an alternating pattern.
> >
> > The situation may still be suboptimal if the deferred unmapping
> > introduced previously is supported by the OS layer.  For instance,
> > the alternating memory access pattern mentioned above may produce
> > a relatively long list of mappings to release with substantial
> > duplication among the entries in it, which could be avoided if
> > acpi_ex_system_memory_space_handler() did not release the mapping
> > used by it previously as soon as the current access was not covered
> > by it.
> >
> > In order to improve that, modify acpi_ex_system_memory_space_handler()
> > to preserve all of the memory mappings created by it until the memory
> > regions associated with them go away.
> >
> > Accordingly, update acpi_ev_system_memory_region_setup() to unmap all
> > memory associated with memory opregions that go away.
> >
> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/evrgnini.c | 14 ++++----
> >  drivers/acpi/acpica/exregion.c | 65 ++++++++++++++++++++++++----------
> >  include/acpi/actypes.h         | 12 +++++--
> >  3 files changed, 64 insertions(+), 27 deletions(-)
> >
>
> Hi Rafael,
>
> Picking up from Dan while he's out - I had these patches tested by the
> original reporter, and they work fine. I see you had them staged in the
> acpica-osl branch. Is that slated to go in during the 5.9 merge window?

Yes, it is.

> You can add:
> Tested-by: Xiang Li <xiang.z.li@intel.com>

Thank you!
