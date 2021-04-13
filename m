Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25FD35E5AC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 19:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhDMRyR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 13:54:17 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35638 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhDMRyR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Apr 2021 13:54:17 -0400
Received: by mail-ot1-f44.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16910202oto.2;
        Tue, 13 Apr 2021 10:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZAoDkrR42DaMFPAXYSwp4F1d1CFF/3apQEZeTX5xO4=;
        b=g+Ntzh3UyzcEe5T/BQF2HQxxCHV3LYelAICaRWuBWqBW5/b7bpFf4Ad+zmS6c7hIw6
         K7uMQ5KsxQhVaPEYzhm/ZPRC37K7QoRAiUUUKe3CuqL5w5tlbm1iSD8m/ADjFRnV7yWu
         jWsvR10jcHYk6bNlE/SecomXi7ZkuBNqiS/1OJtE6FfWEkS6aEvRR8tOHWLBCjLWciHZ
         65WgOi3KO5+onS+0hSJLVMhYIJKPi+1VZ1TZP+iEC35rK7git0z+AQGsm4KwpAmvTpAP
         01fUmx6dD8N1+iyTJR2p1FYUcXAzlJrLHrajtm4N9gdZy6h6vcYf6uCZmUAs8uy8gqm9
         3D9A==
X-Gm-Message-State: AOAM530vfijMVrcQcc7EI/ulRS7ZflIBbSmN3Pn7W9KPrzFd9aPDo6Q7
        yBx9oyU5qjsNlpeaHSs4uEPxg+DHqp8mEq1QGng=
X-Google-Smtp-Source: ABdhPJwWioBmb0kiRyTRIBrrGZrxVitvcdnynaqpvKueWlIFsIK2+hVxNJbd3BqNEE3WEQ0QYlmmb5GKr+9a04IMB1A=
X-Received: by 2002:a9d:6951:: with SMTP id p17mr16507793oto.206.1618336437080;
 Tue, 13 Apr 2021 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <11752259.O9o76ZdvQC@kreacher> <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
In-Reply-To: <dea11d82-4fe5-ac23-585c-a1f74e076ca7@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Apr 2021 19:53:46 +0200
Message-ID: <CAJZ5v0hHJYT6kSxoH-v7QQ7oOh=OgQXDpNB7BW7rPwrc0L3SOQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()
To:     David Hildenbrand <david@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 13, 2021 at 7:43 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.04.21 16:01, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by
> > ACPI tables") attempted to address an issue with reserving the memory
> > occupied by ACPI tables, but it broke the initrd-based table override
> > mechanism relied on by multiple users.
> >
> > To restore the initrd-based ACPI table override functionality, move
> > the acpi_boot_table_init() invocation in setup_arch() on x86 after
> > the acpi_table_upgrade() one.
> >
> > Fixes: 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > George, can you please check if this reintroduces the issue addressed by
> > the above commit for you?
> >
> > ---
> >   arch/x86/kernel/setup.c |    5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/arch/x86/kernel/setup.c
> > ===================================================================
> > --- linux-pm.orig/arch/x86/kernel/setup.c
> > +++ linux-pm/arch/x86/kernel/setup.c
> > @@ -1045,9 +1045,6 @@ void __init setup_arch(char **cmdline_p)
> >
> >       cleanup_highmap();
> >
> > -     /* Look for ACPI tables and reserve memory occupied by them. */
> > -     acpi_boot_table_init();
> > -
> >       memblock_set_current_limit(ISA_END_ADDRESS);
> >       e820__memblock_setup();
> >
> > @@ -1132,6 +1129,8 @@ void __init setup_arch(char **cmdline_p)
> >       reserve_initrd();
> >
> >       acpi_table_upgrade();
> > +     /* Look for ACPI tables and reserve memory occupied by them. */
> > +     acpi_boot_table_init();
> >
> >       vsmp_init();
>
> This is fairly late; especially, it's after actual allocations -- see
> e820__memblock_alloc_reserved_mpc_new().
>
> Can't the table upgrade mechanism fix up when adjusting something?

Not at this point of the cycle I'm afraid.

> Some details on what actually breaks would be helpful.

Generally speaking, the table overrides that come from the initrd are
not taken into account if acpi_boot_table_init() runs before
acpi_table_upgrade() and the latter cannot run before
reserve_initrd().

Honestly, I'm not sure how much effort it would take to untangle this ATM.
