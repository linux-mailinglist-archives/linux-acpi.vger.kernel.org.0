Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198D20F3BB
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jun 2020 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgF3LpG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jun 2020 07:45:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44102 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgF3LpF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2020 07:45:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id k6so13283772oij.11;
        Tue, 30 Jun 2020 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsb4MIquaSTYBlodVHOtWcad2ied9oc2sDMq3Pcztr8=;
        b=RgSem/6hKZyL5bnr0I6wtLTuCIU5eROtT/fbswHXXSku/UQ2FfVFZVCMp9r9nr9WQB
         aec61BhzkmYKzfgrzP/DgGQnP6lMtJ2RzTCuUjCsN/m3xcPqTweGY5HNprJ94XpnDNb5
         NgpWcDcMcf5c7UdTeqbyIRuun0aiNR2LyPxYzbxB3NFhqqciSD/THcuqUeRMuK/dyD05
         R10iqJK12/QJp6atG70VOckH6wasXnGiKf53Rn632euLG8nJVHNubwJ5jaNVC6A4Qu/C
         Z8rE0b5OmY4VfWXnqCPyg5MLrGew7UlpzjInvJOf7dkGLohNgsjNS923/KOb4jxdPmJ3
         1nHA==
X-Gm-Message-State: AOAM532WGeazL+Lr7cNC8mtMi8z16lbjGa3pZ+i49gOkzewesTYPr6kz
        lr0pzGQySBaixg6WdH+xapZ+SeRmJ3+rxsXIyh8=
X-Google-Smtp-Source: ABdhPJwFw2GAEuZCNbPr0iNOFM+E2OWBK7BzCaHpl9FhHHuLN3NQg/TnqaWOD86/EaQux1Nj8hPKxgTGiCH4OqeDwRQ=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr9785173oih.68.1593517504450;
 Tue, 30 Jun 2020 04:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2788992.3K7huLjdjL@kreacher> <1666722.UopIai5n7p@kreacher>
 <1794490.F2OrUDcHQn@kreacher> <20200629205708.GK1237914@redhat.com>
In-Reply-To: <20200629205708.GK1237914@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 13:44:52 +0200
Message-ID: <CAJZ5v0hiAVfgWTLcP2N5PWLsqL7mpHbuL1_de79svYYhd3R57A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ACPICA: Preserve memory opregion mappings
To:     Al Stone <ahs3@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 29, 2020 at 10:57 PM Al Stone <ahs3@redhat.com> wrote:
>
> On 29 Jun 2020 18:33, Rafael J. Wysocki wrote:
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
> > diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
> > index aefc0145e583..89be3ccdad53 100644
> > --- a/drivers/acpi/acpica/evrgnini.c
> > +++ b/drivers/acpi/acpica/evrgnini.c
> > @@ -38,6 +38,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> >       union acpi_operand_object *region_desc =
> >           (union acpi_operand_object *)handle;
> >       struct acpi_mem_space_context *local_region_context;
> > +     struct acpi_mem_mapping *mm;
> >
> >       ACPI_FUNCTION_TRACE(ev_system_memory_region_setup);
> >
> > @@ -46,13 +47,14 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
> >                       local_region_context =
> >                           (struct acpi_mem_space_context *)*region_context;
> >
> > -                     /* Delete a cached mapping if present */
> > +                     /* Delete memory mappings if present */
> >
> > -                     if (local_region_context->mapped_length) {
> > -                             acpi_os_unmap_memory(local_region_context->
> > -                                                  mapped_logical_address,
> > -                                                  local_region_context->
> > -                                                  mapped_length);
> > +                     while (local_region_context->first_mm) {
> > +                             mm = local_region_context->first_mm;
> > +                             local_region_context->first_mm = mm->next_mm;
> > +                             acpi_os_unmap_memory(mm->logical_address,
> > +                                                  mm->length);
> > +                             ACPI_FREE(mm);
> >                       }
> >                       ACPI_FREE(local_region_context);
> >                       *region_context = NULL;
> > diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
> > index d15a66de26c0..fd68f2134804 100644
> > --- a/drivers/acpi/acpica/exregion.c
> > +++ b/drivers/acpi/acpica/exregion.c
> > @@ -41,6 +41,7 @@ acpi_ex_system_memory_space_handler(u32 function,
> >       acpi_status status = AE_OK;
> >       void *logical_addr_ptr = NULL;
> >       struct acpi_mem_space_context *mem_info = region_context;
> > +     struct acpi_mem_mapping *mm = mem_info->cur_mm;
> >       u32 length;
> >       acpi_size map_length;
>
> I think this needs to be:
>
>         acpi_size map_length = mem_info->length;
>
> since it now gets used in the ACPI_ERROR() call below.

No, it's better to print the length value in the message.

>  I'm getting a "maybe used unitialized" error on compilation.

Thanks for reporting!

I've updated the commit in the acpica-osl branch with the fix.
