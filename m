Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39F51F0579
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jun 2020 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFFGqz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jun 2020 02:46:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39758 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgFFGqz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jun 2020 02:46:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id d67so10273326oig.6;
        Fri, 05 Jun 2020 23:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwWaD5Q8IVHw1QydWU1MECvDrlkrGMlMpGEjvbM9ZfM=;
        b=skc17AceG0eTRbieph+TCKSJ5sBkDkP+Az3IZe+z4oMkmeP+pv5o6hncBJjwLl8Zv5
         A93GF99rRBpd2zcO3r8T+ZvSTOJfXWVSnG98LXn6pK/T1SDeqIzfjpZxFplxV6eL5Q6G
         w59kpNthIh/YEH/nL5HUBr6BxfRv/jN49awkeNGgpN5hnG2CdJkKwHoI5XE8WjGtdzpG
         Jw5vOyn8NP4nBAuzcjlow+BaQnYL+8bvQUt/f6Kmrulg856noYuL1jOPLClF7lyyhMrq
         3oogE97+Jcgc7vRLUpxW4hStMmBABxy6fsDiyDXZ6bsoBDxXzrUD0WicMYMJlWQbqKI8
         UeWQ==
X-Gm-Message-State: AOAM533+nyFt9rqaWU1UarnuGieaQos1ChNAoQ+xc0cYzaYCd4THvpex
        ONinYMXxt/zycPUkktIC3drOonkEBRA1rEfyJhU=
X-Google-Smtp-Source: ABdhPJy8ArS/aVX9wRHilqeUfr+43DhbEyNX79e34r1Xe4ZcflEBe71GLGg2bZktyqMUHusjoJpLpFXn2OmGWL71c0w=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr4395472oie.103.1591426014336;
 Fri, 05 Jun 2020 23:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <7839183d-1c0b-da02-73a2-bf5e1e8b02b9@suse.cz> <94296941-1073-913c-2adb-bf2e41be9f0f@oracle.com>
 <202006041054.874AA564@keescook> <cb0cdaaa-7825-0b87-0384-db22329305bb@suse.cz>
 <34455dce-6675-1fc2-8d61-45bf56f3f554@suse.cz> <6b2b149e-c2bc-f87a-ea2c-3046c5e39bf9@oracle.com>
 <faea2c18-edbe-f8b4-b171-6be866624856@oracle.com> <CAJZ5v0jqmUmf7mv3wjniVM-YqPqhDSjxunU0E4VYCsUQqvrF_Q@mail.gmail.com>
 <ce333dcb-2b2c-3e1f-2a7e-02a7819b1db4@suse.cz> <894e8cee-33df-1f63-fb12-72dceb024ea7@oracle.com>
 <202006050828.F85A75D13@keescook>
In-Reply-To: <202006050828.F85A75D13@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jun 2020 08:46:42 +0200
Message-ID: <CAJZ5v0jWZUWUco_RuBfrZEVvQ+bo8BMXRn96YtEtfUyZK1khQA@mail.gmail.com>
Subject: Re: slub freelist issue / BUG: unable to handle page fault for
 address: 000000003ffe0018
To:     Kees Cook <keescook@chromium.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 5, 2020 at 5:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 05, 2020 at 04:44:51PM +0200, Vegard Nossum wrote:
> > On 2020-06-05 16:08, Vlastimil Babka wrote:
> > > On 6/5/20 3:12 PM, Rafael J. Wysocki wrote:
> > > > On Fri, Jun 5, 2020 at 2:48 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> > > > >
> > > > > On 2020-06-05 11:36, Vegard Nossum wrote:
> > > > > >
> > > > > > On 2020-06-05 11:11, Vlastimil Babka wrote:
> > > > > > > So, with Kees' patch reverted, booting with slub_debug=F (or even more
> > > > > > > specific slub_debug=F,ftrace_event_field) also hits this bug below. I
> > > > > > > wanted to bisect it, but v5.7 was also bad, and also v5.6. Didn't try
> > > > > > > further in history. So it's not new at all, and likely very specific to
> > > > > > > your config+QEMU? (and related to the ACPI error messages that precede
> > > > > > > it?).
> > > [...]
> > > [    0.140408] ------------[ cut here ]------------
> > > [    0.140837] cache_from_obj: Wrong slab cache. Acpi-Namespace but object is from kmalloc-64
> > > [    0.141406] WARNING: CPU: 0 PID: 1 at mm/slab.h:524 kmem_cache_free+0x1d3/0x250
>
> Ah yes! Good. I had improved this check recently too, and I was worried
> the freelist pointer patch was somehow blocking it, but I see now that
> the failing config didn't have CONFIG_SLAB_FREELIST_HARDENED=y. Once
> SLAB_CONSISTENCY_CHECKS was enabled ("slub_debug=F"), it started
> tripping. Whew.
>
> I wonder if that entire test block should just be removed from
> cache_from_obj():
>
>         if (!memcg_kmem_enabled() &&
>             !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
>             !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
>                 return s;
>
> and make this test unconditional? It's mostly only called during free(),
> and shouldn't be too expensive to be made unconditional. Hmm.
>
> > > And it seems ACPI is allocating an object via kmalloc() and then freeing it
> > > via kmem_cache_free(<"Acpi-Namespace" kmem_cache>) which is wrong.
> > >
> > > > ./scripts/faddr2line vmlinux 'acpi_ns_root_initialize+0xb6'
> > > acpi_ns_root_initialize+0xb6/0x2d1:
> > > kmalloc at include/linux/slab.h:555
> > > (inlined by) kzalloc at include/linux/slab.h:669
> > > (inlined by) acpi_os_allocate_zeroed at include/acpi/platform/aclinuxex.h:57
> > > (inlined by) acpi_ns_root_initialize at drivers/acpi/acpica/nsaccess.c:102
> > >
> >
> > That's it :-) This fixes it for me:
> >
> > diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> > index 2566e2d4c7803..b76bbab917941 100644
> > --- a/drivers/acpi/acpica/nsaccess.c
> > +++ b/drivers/acpi/acpica/nsaccess.c
> > @@ -98,14 +98,12 @@ acpi_status acpi_ns_root_initialize(void)
> >                  * predefined names are at the root level. It is much easier
> > to
> >                  * just create and link the new node(s) here.
> >                  */
> > -               new_node =
> > -                   ACPI_ALLOCATE_ZEROED(sizeof(struct
> > acpi_namespace_node));
> > +               new_node = acpi_ns_create_node(*ACPI_CAST_PTR (u32,
> > init_val->name));
> >                 if (!new_node) {
> >                         status = AE_NO_MEMORY;
> >                         goto unlock_and_exit;
> >                 }
> >
> > -               ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
> >                 new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
> >                 new_node->type = init_val->type;
>
> I'm a bit confused by the internals of acpi_ns_create_note(). It can still
> end up calling ACPI_ALLOCATE_ZEROED() via acpi_os_acquire_object().

No, it can't.

Linux uses the one from include/acpi/platform/aclinuxex.h

> Is this fix correct?

Yes, it is, AFAICS.

Cheers!
