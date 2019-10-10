Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19C4D3091
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 20:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfJJSk6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 14:40:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36867 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfJJSk6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Oct 2019 14:40:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so7800919wmc.2
        for <linux-acpi@vger.kernel.org>; Thu, 10 Oct 2019 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NsqnSY95fdoi2VDvZcdhUdFBDwBGSd8eV8Ri4czn8Y=;
        b=VO7m1YIn2R9UaxF6uga618E7+yQCBUAVgQkcYkf4rfnMXVcQBYAGVv8dz98DoBj4Jm
         f184Ul0TzGHhz36KAQ7Yywcer/gvQu+22svOWhJ+GNCDCnDNm9t+NBKgbmkQlZq2dFbG
         oMZlAyA33VxbAPpS0xTcSuVKRiKFW4nwayOuSsnfSmuW/D3N/Lu2S7zOOlmsUr0FqiuC
         aBU+8ir413SG3KlrJ1B2cyK56pwHeyzRAEpj19YXFCk9yHezV6j2OrO/mhzRSOf5HAyl
         HDp9SP3AmQHnM6rnNDZ0m2fcoFsPNHBSGaegh3SeJRDR2cJuaicfcIdoAE143X04yy0o
         kJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NsqnSY95fdoi2VDvZcdhUdFBDwBGSd8eV8Ri4czn8Y=;
        b=eFYwfd2SR2OmTeb/d3gzi2/XCR0PL9fnRbUqFlFxE8LwVzPh3Lr3jfa0RGC3qhkPnd
         2SIOgfg1fJR00/qL3WzMQJGrzBcUDa0FIOnc9hM/8ekV6TgNOTgl5S9bU26Y0u3/xJZG
         rCKrc32whDQHYbYSHYxdgzNd4OOZ6ZrreFYd+/of1zfghCbx33B5fDgdDtdesfrQFJ9d
         CxuXScCn5BxGnVpn4VGDgIsBRJFv9Vg5FuxkPh8hIa/Vz15ppRqcXlkGaW9zRs1ibrPr
         oNCCMfLI/XFGhDEF3SW1nMYIlRvV2DM+eChSuS5pZRuUdNEIgu9nMaIYsGTAn6Ev5L+6
         uOIA==
X-Gm-Message-State: APjAAAU182S9/HsSFL9qw8YQFcg7ROmaR41sqLBTTwUl7CMX7h0939p2
        nAR+FQmGakl6IlmIinzFtzv4c+ZiDH89eTgrfzakCQ==
X-Google-Smtp-Source: APXvYqw4wievu7Dccjidrshv6ttu1kKAi+nssgofP8O2my9+rW1wYmqnupOkIxWkd14IXVCkfS1rHdtsh9uPI6K9SZI=
X-Received: by 2002:a1c:a9c5:: with SMTP id s188mr7913551wme.61.1570732854939;
 Thu, 10 Oct 2019 11:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <157066227329.1059972.5659620631541203458.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157066230358.1059972.1736585303527133478.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ih2RffZHdwAnHZicL_v8CxV9WnCy+uA1jSSyh58xapA@mail.gmail.com> <CAPcyv4iQ5Np3dDH=-a_7gPnWKBCHXGit2PN-h=Jw_eqj7Lb2BQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iQ5Np3dDH=-a_7gPnWKBCHXGit2PN-h=Jw_eqj7Lb2BQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 10 Oct 2019 20:40:42 +0200
Message-ID: <CAKv+Gu9co_FTVYWNZsXF0H+fV1K76pZX4Yv11ANE6NwDBT3pBQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] x86/efi: EFI soft reservation to E820 enumeration
To:     Dan Williams <dan.j.williams@intel.com>
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

On Thu, 10 Oct 2019 at 20:31, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Oct 9, 2019 at 11:45 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 10 Oct 2019 at 01:19, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > UEFI 2.8 defines an EFI_MEMORY_SP attribute bit to augment the
> > > interpretation of the EFI Memory Types as "reserved for a specific
> > > purpose".
> > >
> > > The proposed Linux behavior for specific purpose memory is that it is
> > > reserved for direct-access (device-dax) by default and not available for
> > > any kernel usage, not even as an OOM fallback.  Later, through udev
> > > scripts or another init mechanism, these device-dax claimed ranges can
> > > be reconfigured and hot-added to the available System-RAM with a unique
> > > node identifier. This device-dax management scheme implements "soft" in
> > > the "soft reserved" designation by allowing some or all of the
> > > reservation to be recovered as typical memory. This policy can be
> > > disabled at compile-time with CONFIG_EFI_SOFT_RESERVE=n, or runtime with
> > > efi=nosoftreserve.
> > >
> > > This patch introduces 2 new concepts at once given the entanglement
> > > between early boot enumeration relative to memory that can optionally be
> > > reserved from the kernel page allocator by default. The new concepts
> > > are:
> > >
> > > - E820_TYPE_SOFT_RESERVED: Upon detecting the EFI_MEMORY_SP
> > >   attribute on EFI_CONVENTIONAL memory, update the E820 map with this
> > >   new type. Only perform this classification if the
> > >   CONFIG_EFI_SOFT_RESERVE=y policy is enabled, otherwise treat it as
> > >   typical ram.
> > >
> > > - IORES_DESC_SOFT_RESERVED: Add a new I/O resource descriptor for
> > >   a device driver to search iomem resources for application specific
> > >   memory. Teach the iomem code to identify such ranges as "Soft Reserved".
> > >
> > > A follow-on change integrates parsing of the ACPI HMAT to identify the
> > > node and sub-range boundaries of EFI_MEMORY_SP designated memory. For
> > > now, just identify and reserve memory of this type.
> > >
> > > Cc: <x86@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Darren Hart <dvhart@infradead.org>
> > > Cc: Andy Shevchenko <andy@infradead.org>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > For the EFI changes
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > although I must admit I don't follow the enum add_efi_mode logic 100%
>
> I'm open to suggestions as I'm not sure it's the best possible
> organization. The do_add_efi_memmap() routine has the logic to
> translate EFI to E820, but unless "add_efi_memmap" is specified on the
> kernel command line the EFI memory map is ignored. For
> soft-reservation support I want to reuse do_add_efi_memmap(), but
> otherwise avoid any other side effects of considering the EFI map.
> What I'm missing is the rationale for why "add_efi_memmap" is required
> before considering the EFI memory map.
>
> If there is a negative side effect to always using the EFI map then
> the new "add_efi_mode" designation constrains it to just the
> soft-reservation case.
>

Could we make the presence of any EFI_MEMORY_SP regions imply
add_efi_memmap? That way, it is guaranteed that we don't regress
existing systems, while establishing clear and unambiguous semantics
for new systems that rely on these changes in order to be able to use
the special purpose memory as intended.
