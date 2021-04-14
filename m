Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99B35F1A6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 12:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhDNKtc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 06:49:32 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:40816 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhDNKtZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Apr 2021 06:49:25 -0400
Received: by mail-oo1-f49.google.com with SMTP id v21-20020a4ae0550000b02901e6970ea355so410950oos.7;
        Wed, 14 Apr 2021 03:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6d/FuuxybGA+l39RRGwCNBN7zcndhrQwzJhiqm3MB4U=;
        b=h3VBrqCppbzBjATV9RqXps3D1LGKBiHB6zQEDCjvskd6EY2JOB0xpfm7rvnNpD297N
         4B5IsKxmNpxsMOiDjhl21wz0TkXDB6kdPivKJ1V5XlVmdXOZJ5nDsNYvLFPZq1ECEE19
         oakxqnoZbKjvqhw3qypLJCUIQX45fO9OD8iGXC7eFn0tTxaoK/KlAtwnxTq+f2/oU64F
         Tposu8/FooGYj+J7wbIEMnjRb++rBBkzmnQmnl6i7ZModHpx7bnzWa0IcoQsUuyMrxsc
         Scisu6VmH2d+HcpojUy3ZmWRDdrmgIu6g/jn9axUde+eIjsi062znyZ6nZgDNghgqhT1
         oDhg==
X-Gm-Message-State: AOAM532n6zXNphjrgnrMkR/rsR1n0P37Zb5pb+GVJ60qqnfNJyKAju0V
        PZSbzD7v4kQCnjHxVN2Pa66S3EBJq5N8dvdZVos=
X-Google-Smtp-Source: ABdhPJxb/dLFyFlGBNQl3SFJx7iysvA9qVLVRL4WebeB7CIWQYzda7D0v6eHM0QPM5WV/aBVkTGZa+7zrlKOedhgjv8=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr30553600oos.2.1618397335486;
 Wed, 14 Apr 2021 03:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <11752259.O9o76ZdvQC@kreacher> <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
 <CAJZ5v0hHJYT6kSxoH-v7QQ7oOh=OgQXDpNB7BW7rPwrc0L3SOQ@mail.gmail.com>
 <5cfba81b-fe73-b604-2442-011deee9bcb3@redhat.com> <YHakFzNYBS6YLpPi@linux.ibm.com>
In-Reply-To: <YHakFzNYBS6YLpPi@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Apr 2021 12:48:43 +0200
Message-ID: <CAJZ5v0g7Lm+eA=6C04f7xCdhKrE8cQxU6rSP9zxf0POpJDuDGg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2021 at 10:13 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Apr 14, 2021 at 09:42:01AM +0200, David Hildenbrand wrote:
> > On 13.04.21 19:53, Rafael J. Wysocki wrote:
> > > On Tue, Apr 13, 2021 at 7:43 PM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > On 13.04.21 16:01, Rafael J. Wysocki wrote:
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
> > > > > ACPI tables") attempted to address an issue with reserving the memory
> > > > > occupied by ACPI tables, but it broke the initrd-based table override
> > > > > mechanism relied on by multiple users.
> > > > >
> > > > > To restore the initrd-based ACPI table override functionality, move
> > > > > the acpi_boot_table_init() invocation in setup_arch() on x86 after
> > > > > the acpi_table_upgrade() one.
> > > > >
> > > > > Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> > > > > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >
> > > > > George, can you please check if this reintroduces the issue addressed by
> > > > > the above commit for you?
> > > > >
> > > > > ---
> > > > >    arch/x86/kernel/setup.c |    5 ++---
> > > > >    1 file changed, 2 insertions(+), 3 deletions(-)
> > > > >
> > > > > Index: linux-pm/arch/x86/kernel/setup.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/arch/x86/kernel/setup.c
> > > > > +++ linux-pm/arch/x86/kernel/setup.c
> > > > > @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
> > > > >
> > > > >        cleanup_highmap();
> > > > >
> > > > > -     /* Look for ACPI tables and reserve memory occupied by them. */
> > > > > -     acpi_boot_table_init();
> > > > > -
> > > > >        memblock_set_current_limit(ISA_END_ADDRESS);
> > > > >        e820__memblock_setup();
> > > > >
> > > > > @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
> > > > >        reserve_initrd();
> > > > >
> > > > >        acpi_table_upgrade();
> > > > > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > > > > +     acpi_boot_table_init();
> > > > >
> > > > >        vsmp_init();
> > > >
> > > > This is fairly late; especially, it's after actual allocations -- see
> > > > e820__memblock_alloc_reserved_mpc_new().
> > > >
> > > > Can't the table upgrade mechanism fix up when adjusting something?
> > >
> > > Not at this point of the cycle I'm afraid.
> > >
> > > > Some details on what actually breaks would be helpful.
> > >
> > > Generally speaking, the table overrides that come from the initrd are
> > > not taken into account if acpi_boot_table_init() runs before
> > > acpi_table_upgrade() and the latter cannot run before
> > > reserve_initrd().
> >
> > I see. (looking at Documentation/acpi/initrd_table_override.txt I understand
> > what acpi table overrides are for :) )
> >
> > >
> > > Honestly, I'm not sure how much effort it would take to untangle this ATM.
> >
> > Also true; ideally, we wouldn't have any allocations (find+reserve) before
> > ordinary reservations are done.
> >
> > However, I have no idea if we can move
> > e820__memblock_alloc_reserved_mpc_new() and reserve_real_mode() around
> > easily. Also, reserve_initrd()->relocate_initrd() does allocations.
>
> Even if we can move e820__memblock_alloc_reserved_mpc_new() and
> reserve_real_mode(), the allocation in reserve_initrd() has to be before
> the tables override, we would only reduce the probability of allocating an
> ACPI page.
>
> I think what we can do is to override the ACPI tables separately from their
> initial parsing. Rafael, what do you say?

Well, possibly.  With one caveat that parsing a table that's going to
be overridden subsequently may not be a good idea.

Anyway, things like that can only be done in the next cycle or later.
