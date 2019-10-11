Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B67D4320
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfJKOmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 10:42:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37151 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKOmW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 10:42:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id k32so8164281otc.4
        for <linux-acpi@vger.kernel.org>; Fri, 11 Oct 2019 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTilIw9kuA9/ZhCVKjq7t0Q6xQINI3VdWiZdaAX92yU=;
        b=KjTfLZ9sbaX0HivZiN4cHJnsOpK3hFTGS5Y8ZzYKXwLkTQReEEf7cMwCEFQC5QY2xs
         0x/rLue2CD9ODblikQU95h7c2+Oz+4QpD2iYBR0F87gvmOctZK4TghAsjbxxEALSeJAw
         QSRqYZT2bsJzFz666Wdsp+28CNHvmfteiNpMgNTHM2Q3uf+/DVBzn9BZIMLz+iU3VAWA
         6bkCF5b+Y7OUMjrLQOIK6Xq8AG6zY6g6pIzy7fHojmIymTQFECpIk0yReHvLhzHih0F6
         zB5E+R6W1FaMSvJ1bGepGXiDzg/FuLWHUQeFgBrjnBf0E1vX1S8ejyo7sDbilV+w0zcZ
         VI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTilIw9kuA9/ZhCVKjq7t0Q6xQINI3VdWiZdaAX92yU=;
        b=YF6viksB99l6oxLiMM7CI7uM8Lg9HqOyLhYCNbmDCNCVha+KfjfqAImCeiurEZV4Wl
         OBElqjCQ11Ly4T1UzX/khWuokvLx11jxc6Dhm/nem1a2WPDbykcxtY7rOSzeaLb0r4Bk
         dHPFMi9bMr7fyhNmEy44p4A9D8r41eu0rYdrIw+ZLtPEK44nnx8kz0OhrdWevCNZCaVG
         Uo9xhYlSTjyCioJFtLLR/W9os3+/xRTLriJiwJ1kG9a5SlQK6QukqLFR7+xa5BoiOheU
         GbHijDquuIYZ3t+o5ycuuI41YjaHUBmnihDsjTrl00wgPTd4bSrQwtiq4wQbKbvr3HCy
         DBkQ==
X-Gm-Message-State: APjAAAUBYV93WwE2LWQHESuEWbwwrFKjrkLIdwh7sntWyG1N5dalkmxO
        2b1ptNU18LVxWsfJ1dMz7XtJhkB9AUnRL7/8Ujbl3Q==
X-Google-Smtp-Source: APXvYqwbudi4rN4fTGWZokyloO/sdPo8umpYpvPsXhd6DJ//G8XqDY9mywrjwmYrdj4F50rvy8xzyKsE7vc8ZY7tDOQ=
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr12615074otf.126.1570804528988;
 Fri, 11 Oct 2019 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com>
 <CAPcyv4iQ5Np3dDH=-a_7gPnWKBCHXGit2PN-h=Jw_eqj7Lb2BQ@mail.gmail.com>
 <CAKv+Gu9co_FTVYWNZsXF0H+fV1K76pZX4Yv11ANE6NwDBT3pBQ@mail.gmail.com>
 <CAPcyv4iCpA_a7272HXVwBY3NqR1RbyuoXbQOPWG2xFHgqN8-iA@mail.gmail.com> <CAKv+Gu-EOaEmiT_ZA8RBatWAWNVXnNgv-wLJSp5b-zhvof3D6g@mail.gmail.com>
In-Reply-To: <CAKv+Gu-EOaEmiT_ZA8RBatWAWNVXnNgv-wLJSp5b-zhvof3D6g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Oct 2019 07:35:18 -0700
Message-ID: <CAPcyv4jHTrrfNnBNw_H_4wGWGsg1QF1582BcN-078K5KCBhNBA@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] x86/efi: EFI soft reservation to E820 enumeration
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 10, 2019 at 10:52 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 11 Oct 2019 at 04:39, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 11:41 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Thu, 10 Oct 2019 at 20:31, Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > On Wed, Oct 9, 2019 at 11:45 PM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > >
> > > > > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > > > > interpretation of the EFI Memory Types as "reserved for a specific
> > > > > > purpose".
> > > > > >
> > > > > > The proposed Linux behavior for specific purpose memory is that it is
> > > > > > reserved for direct-access (device-dax) by default and not available for
> > > > > > any kernel usage, not even as an OOM fallback.  Later, through udev
> > > > > > scripts or another init mechanism, these device-dax claimed ranges can
> > > > > > be reconfigured and hot-added to the available System-RAM with a unique
> > > > > > node identifier. This device-dax management scheme implements "soft" in
> > > > > > the "soft reserved" designation by allowing some or all of the
> > > > > > reservation to be recovered as typical memory. This policy can be
> > > > > > disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> > > > > > efi=nosoftreserve.
> > > > > >
> > > > > > This patch introduces 2 new concepts at once given the entanglement
> > > > > > between early boot enumeration relative to memory that can optionally be
> > > > > > reserved from the kernel page allocator by default. The new concepts
> > > > > > are:
> > > > > >
> > > > > > - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
> > > > > >   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
> > > > > >   new type. Only perform this classification if the
> > > > > >   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
> > > > > >   typical ram.
> > > > > >
> > > > > > - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
> > > > > >   a device driver to search iomem resources for application specific
> > > > > >   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
> > > > > >
> > > > > > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > > > > > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > > > > > now, just identify and reserve memory of this type.
> > > > > >
> > > > > > Cc: <x86@kernel.org>
> > > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > > Cc: Darren Hart <dvhart@infradead.org>
> > > > > > Cc: Andy Shevchenko <andy@infradead.org>
> > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > >
> > > > > For the EFI changes
> > > > >
> > > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > >
> > > > > although I must admit I don't follow the enum add_efi_mode logic 100%
> > > >
> > > > I'm open to suggestions as I'm not sure it's the best possible
> > > > organization. The do_add_efi_memmap() routine has the logic to
> > > > translate EFI to E820, but unless "add_efi_memmap" is specified on the
> > > > kernel command line the EFI memory map is ignored. For
> > > > soft-reservation support I want to reuse do_add_efi_memmap(), but
> > > > otherwise avoid any other side effects of considering the EFI map.
> > > > What I'm missing is the rationale for why "add_efi_memmap" is required
> > > > before considering the EFI memory map.
> > > >
> > > > If there is a negative side effect to always using the EFI map then
> > > > the new "add_efi_mode" designation constrains it to just the
> > > > soft-reservation case.
> > > >
> > >
> > > Could we make the presence of any EFI_MEMORY_SP regions imply
> > > add_efi_memmap? That way, it is guaranteed that we don't regress
> > > existing systems, while establishing clear and unambiguous semantics
> > > for new systems that rely on these changes in order to be able to use
> > > the special purpose memory as intended.
> >
> > In fact that's how it works. EFI_MEMORY_SP is unconditionally added.
> > Other EFI memory types are optionally added with the add_efi_memmap
> > option.
>
> That is not what I meant.
>
> Why not behave as if 'add_efi_memmap' was passed if any EFI_MEMORY_SP
> regions exist?

Hmm, ok, on the assumption that any platform that is modern enough to
specify EFI_MEMORY_SP likely does not need the opt-in? I can get on
board with that. It's also simple enough to undo if it causes problems
in practice.
