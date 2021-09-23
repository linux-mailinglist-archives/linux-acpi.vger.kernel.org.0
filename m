Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE1415EE3
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Sep 2021 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhIWM4h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Sep 2021 08:56:37 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33325 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhIWM4e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2021 08:56:34 -0400
Received: by mail-ot1-f45.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso8464420otu.0;
        Thu, 23 Sep 2021 05:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cnE91Z/Nvkblt8KBxlBOz53Y6ULkVoI6AYMgns74AQ=;
        b=yqKS/r8R2nGhZknhJArHXXEPv40WzYB6FXPozTajea7bPtIA+bQ6z5wyphkCLuBZ5i
         O0Z1mlF4NQI5zqn5G6lnKeI8OeTpQjg7O3r4aQsapkfh+xH8VL3eHmvjXquJo7GSAX9a
         CMHZa6KJ9fqrgSYt/sD25KzSBY5w/EhdfjkpmjoRKIaoLOrww2KjaU5HqjrT7M/nrvWu
         eMbK0j9VbRCfVE/IjEIfeAlNiC5es2yymzWf5j6/oOsmYh98mu2yddL+8Q6e+FHrmbEa
         Q7m99wyuKx+TobKVIDu0QeurvzQEEEz5tcRKU86QEi7vYiJ2fmzCUULv7OG3Tjjpj35s
         gFAw==
X-Gm-Message-State: AOAM533uwXCyAOfxV0MraB3X/Vb5Hbz156yxErPdxU7nehAglEn5rNdP
        fPtu5r6uoc/HswD49JhFSW/O9zN8zRXwwXvT4/k=
X-Google-Smtp-Source: ABdhPJy+DM/7fT9mdBRiBQ1UqkGSyZLL8dWzJQl/kV0NQnaajz48gdaoaHkrbTe8M5Xt/wAgkOMXK6u6ADeQd59vYFI=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr4285920otr.301.1632401703209;
 Thu, 23 Sep 2021 05:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210910122820.26886-1-justin.he@arm.com> <20210910143223.6705-1-justin.he@arm.com>
 <20210922163336.GA24633@lpieralisi> <56147a0b8b9fba46@bloch.sibelius.xs4all.nl>
 <20210923094031.GA6454@lpieralisi> <CAJZ5v0g+OVbhuUUDrLUCfX_mVqY_e8ubgLTU98=jfjTeb4t+Pw@mail.gmail.com>
 <56147c6e73afe9f6@bloch.sibelius.xs4all.nl>
In-Reply-To: <56147c6e73afe9f6@bloch.sibelius.xs4all.nl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Sep 2021 14:54:52 +0200
Message-ID: <CAJZ5v0j7=EGbtGw+FOMwyNWoyRoaeT1cvu6si7nPVVFh307J0g@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "ACPI: Add memory semantics to acpi_os_map_memory()"
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jia He <justin.he@arm.com>,
        Harb Abdulhamid <harb@amperecomputing.com>,
        Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2021 at 2:26 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: "Rafael J. Wysocki" <rafael@kernel.org>
> > Date: Thu, 23 Sep 2021 13:05:05 +0200
> >
> > On Thu, Sep 23, 2021 at 11:40 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Thu, Sep 23, 2021 at 01:09:58AM +0200, Mark Kettenis wrote:
> > > > > Date: Wed, 22 Sep 2021 17:33:36 +0100
> > > > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > >
> > > > > On Fri, Sep 10, 2021 at 10:32:23PM +0800, Jia He wrote:
> > > > > > This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> > > > > >
> > > > > > After this commit, a boot panic is alway hit on an Ampere EMAG server
> > > > > > with call trace as follows:
> > > > > >  Internal error: synchronous external abort: 96000410 [#1] SMP
> > > > > >  Modules linked in:
> > > > > >  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
> > > > > >  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
> > > > > >  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > [...snip...]
> > > > > >  Call trace:
> > > > > >   acpi_ex_system_memory_space_handler+0x26c/0x2c8
> > > > > >   acpi_ev_address_space_dispatch+0x228/0x2c4
> > > > > >   acpi_ex_access_region+0x114/0x268
> > > > > >   acpi_ex_field_datum_io+0x128/0x1b8
> > > > > >   acpi_ex_extract_from_field+0x14c/0x2ac
> > > > > >   acpi_ex_read_data_from_field+0x190/0x1b8
> > > > > >   acpi_ex_resolve_node_to_value+0x1ec/0x288
> > > > > >   acpi_ex_resolve_to_value+0x250/0x274
> > > > > >   acpi_ds_evaluate_name_path+0xac/0x124
> > > > > >   acpi_ds_exec_end_op+0x90/0x410
> > > > > >   acpi_ps_parse_loop+0x4ac/0x5d8
> > > > > >   acpi_ps_parse_aml+0xe0/0x2c8
> > > > > >   acpi_ps_execute_method+0x19c/0x1ac
> > > > > >   acpi_ns_evaluate+0x1f8/0x26c
> > > > > >   acpi_ns_init_one_device+0x104/0x140
> > > > > >   acpi_ns_walk_namespace+0x158/0x1d0
> > > > > >   acpi_ns_initialize_devices+0x194/0x218
> > > > > >   acpi_initialize_objects+0x48/0x50
> > > > > >   acpi_init+0xe0/0x498
> > > > > >
> > > > > > As mentioned by Lorenzo:
> > > > > >   "We are forcing memory semantics mappings to PROT_NORMAL_NC, which
> > > > > >   eMAG does not like at all and I'd need to understand why. It looks
> > > > > >   like the issue happen in SystemMemory Opregion handler."
> > > > > >
> > > > > > Hence just revert it before everything is clear.
> > > > > >
> > > > > > Fixes: 437b38c51162 ("ACPI: Add memory semantics to acpi_os_map_memory()")
> > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > Cc: Harb Abdulhamid <harb@amperecomputing.com>
> > > > > >
> > > > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > >
> > > > > Rewrote the commit log, please take the patch below and repost
> > > > > it as a v3.
> > > > >
> > > > > It would still be great if Ampere can help us understand why
> > > > > the NormalNC attributes trigger a sync abort on the opregion
> > > > > before merging it.
> > > >
> > > > To be honest, I don't think you really need an explanation from Ampere
> > > > here.  Mapping a part of the address space that doesn't provide memory
> > > > semantics with NormalNC attributes is wrong and triggering a sync
> > > > abort in that case is way better than silently ignoring the access.
> > >
> > > That's understood and that's what I explained in the revert commit
> > > log, no question about it.
> > >
> > > I was just asking to confirm if that's what's actually happening.
> > >
> > > > Putting my OpenBSD hat on (where we have our own ACPI OSPM
> > > > implementation) I must say that we always interpreted SystemMemory as
> > > > memory mapped IO and I think that is a logical choice as SystemIO is
> > > > used for (non-memory mapped) IO.  And I'd say that the ACPI OSPM code
> > > > should make sure that it uses properly aligned access to any Field
> > > > object that doesn't use AnyAcc as its access type.  Even on x86!  And
> > > > I'd say that AML that uses AnyAcc fields for SystemMemory OpRegions on
> > > > arm64 is buggy.
> > > >
> > > > But maybe relaxing this when the EFI memory map indicates that the
> > > > address space in question does provide memory semantics does make
> > > > sense.  That should defenitely be documented in the ACPI standard
> > > > though.
> > >
> > > Mapping SystemMemory Opregions as "memory" does not make sense
> > > at all to me. Still, that's what Linux ACPICA code does (*if*
> > > that's what acpi_os_map_memory() is supposed to mean).
> > >
> > > https://lore.kernel.org/linux-acpi/20210916160827.GA4525@lpieralisi
> >
> > It doesn't need to do that, though, if there are good enough arguments
> > to change the current behavior (and the argument here is that it may
> > be an MMIO region, so mapping it as memory doesn't really work, but it
> > also may be a region in memory - there is no rule in the spec by which
> > SystemMemory Opregions cannot be "memory" AFAICS) and if that change
> > doesn't introduce regressions in the installed base.
> >
> > > Where do we go from here, to be defined, we still have a bug
> > > to fix after the revert is applied.
> > >
> > > drivers/acpi/sysfs.c
> > >
> > > maps BERT error regions with acpi_os_map_memory().
> >
> > That mechanism is basically used for exporting ACPI tables to user
> > space and they are known to reside in memory.  Whether or not BERT
> > regions should be mapped in the same way is a good question.
>
> It is not inconceivable that BERT regions actually live in memory of
> the BMC that is exposed over a bus that doesn't implement memory
> semantics is it?

No, it isn't, which is why I think that mapping them as RAM may not be
a good idea in general.

At the same time, mapping the ACPI tables like the DSDT etc. as RAM is
always valid.
