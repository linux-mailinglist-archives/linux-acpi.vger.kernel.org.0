Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7F3408B7
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCRPXW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 11:23:22 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43870 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCRPWt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 11:22:49 -0400
Received: by mail-ot1-f48.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so5524093otn.10;
        Thu, 18 Mar 2021 08:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY5+C+cwj/cp1ZOC1jOkEqcVS7X+FmIf75h5mCYb2HE=;
        b=Gi80fnLAHlU5O3XupvvxvRF97528Wzv8QE4J/yq0+PQTwIQ5CqE9/zZYUm8KnPE9Q6
         3NkXpXQossWBHC0OAqDCM6iP7hmwrdEnza0Mt04316qIqXDpyVyWf5/8A/deN1PNLtYq
         fCbkUCkz+dm7ghV8eyZww7Q55b8tGD3MhjghmI0j3n9TjAmkqawQasrYbThexvoTKmrx
         4JlilwfeTWjAJxC1voHoh/rFvAKbYgpZI3KRpysj+OVRlxgo4X7RYscyf+4e6HxKPDLk
         KcmtpNI8+S5IMnifhSIDVGj5qmP7pg/0MBHTkKCjD2VoyavJ6qZDwoVaNZtZGN/NsiAu
         CvyA==
X-Gm-Message-State: AOAM530vpbiopHIKUG5p2zaSZxHrPIoUxAtDiCvmpEsEMSYzvjZUQnJQ
        zLRBGamC7TYbNfzYnRqmeBySVMVlVWYX4UYP4Ek=
X-Google-Smtp-Source: ABdhPJx4Q32BHs/tMtlhyT+bXpmfN1I4SbzZsX3lnWmG6VWKbKxuXudNGvoEyuTQj8wMQ78FzsklmzfAqcCCRkXqelk=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr8107660otr.321.1616080968401;
 Thu, 18 Mar 2021 08:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com> <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com> <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 16:22:37 +0100
Message-ID: <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 11:50 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 18, 2021 at 8:25 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 09:14:37PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
> > > > On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > >
> > > > > On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
> > > > > > > >
> > > > > > > > There is some care that should be taken to make sure we get the order
> > > > > > > > right, but I don't see a fundamental issue here.
> > > > > >
> > > > > > Me neither.
> > > > > >
> > > > > > > > If I understand correctly, Rafael's concern is about changing the parts of
> > > > > > > > ACPICA that should be OS agnostic, so I think we just need another place to
> > > > > > > > call memblock_reserve() rather than acpi_tb_install_table_with_override().
> > > > > >
> > > > > > Something like this.
> > > > > >
> > > > > > There is also the problem that memblock_reserve() needs to be called
> > > > > > for all of the tables early enough, which will require some reordering
> > > > > > of the early init code.
> > > > > >
> > > > > > > > Since the reservation should be done early in x86::setup_arch() (and
> > > > > > > > probably in arm64::setup_arch()) we might just have a function that parses
> > > > > > > > table headers and reserves them, similarly to how we parse the tables
> > > > > > > > during KASLR setup.
> > > > > >
> > > > > > Right.
> > > > >
> > > > > I've looked at it a bit more and we do something like the patch below that
> > > > > nearly duplicates acpi_tb_parse_root_table() which is not very nice.
> > > >
> > > > It looks to me that the code need not be duplicated (see below).
> > > >
> > > > > Besides, reserving ACPI tables early and then calling acpi_table_init()
> > > > > (and acpi_tb_parse_root_table() again would mean doing the dance with
> > > > > early_memremap() twice for no good reason.
> > > >
> > > > That'd be simply inefficient which is kind of acceptable to me to start with.
> > > >
> > > > And I changing the ACPICA code can be avoided at least initially, it
> > > > by itself would be a good enough reason.
> > > >
> > > > > I believe the most effective way to deal with this would be to have a
> > > > > function that does parsing, reservation and installs the tables supplied by
> > > > > the firmware which can be called really early and then another function
> > > > > that overrides tables if needed a some later point.
> > > >
> > > > I agree that this should be the direction to go into.
> > >
> > > So maybe something like the patch below?
> > >
> > > I'm not sure if acpi_boot_table_prepare() gets called early enough, though.
> >
> > To be 100% safe it should be called before e820__memblock_setup().
>
> OK

Well, that said, reserve_bios_regions() doesn't seem to have concerns
like this and I'm not sure why ACPI tables should be reserved before
this runs.  That applies to efi_reserve_boot_services() too.

I can put the new call before e820__memblock_alloc_reserved_mpc_new(),
but I'm not sure why to put it before efi_reserve_boot_services(),
say?
