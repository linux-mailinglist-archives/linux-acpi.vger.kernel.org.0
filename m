Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B288524E287
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Aug 2020 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHUVRj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Aug 2020 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgHUVRc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Aug 2020 17:17:32 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68676C061575
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2020 14:17:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so4087026ejb.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2020 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Czkv47Mapytq1xHY+oPYH574MMmQySGYRJkgBW3lM+E=;
        b=GXn5QvE0B4fW4XfVmy6nF7VEmR25ramQstv7uYApzkRaODFrVdOXnM1zTZ6Wsmibwy
         dPfmTNTs899e7OIe+phFR2chos0Ft2tgG9zqM01uVVZPmE29arGNgsIzosvPzhSWUnGe
         J3wNyPfrnyhgIVWAU45//p0AhY4mBc6FUmzeNpTdQDSCbuWVi6ai4sl/4TKN7Bd6ypw8
         5lZeOIWb5H2+OaFKo947ypFBddehhnskfMBHe4gMQN+LdPUupi+433hVBX7NeDX/oBC5
         TgSqJ5flLj3v0348Ps+2DpHLbXs1TxDkDp2CaVgcTvVCd7lwN8q+51xsM4whGP0VMhL1
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Czkv47Mapytq1xHY+oPYH574MMmQySGYRJkgBW3lM+E=;
        b=FGdKYuZjsUFGuO7Jlv5+69cD9p7OmV19bM7CeOj5Kv9cCALojHAS+QiqjMfFvjUUKP
         gj8fIQYbksH1YqMnHeD3/Pm/cofqANoqy4XUS3NzOSU2mnGipE0MBFzUc083+Viw0vmH
         or8wwcqMJveH8gVi42quhWFLHMoy5twZVM0R9N4fIE18Ed6Bb8uUKrW7akb0i9OKJ8BR
         vvQU/WZ94j7jcVhN58s53INzRAPdlsmClnvXaR1xEHsL1F5LIhujbmn/2x/2ow41Nlwm
         pRzc79Ug5gbtChQUs0f4dKkJUs3p0ywLIhddTmqEjcV8W3j0dkifrMIVBCppBw9WWMHJ
         2hBw==
X-Gm-Message-State: AOAM532PdH7q6PYF3xTftnSdzb2Rvesh8LtLebdGD905Bo/AtBsghZtc
        bXjMfkc2Gi+W7JQtCO93CTypUhebLF5kaGhXX27CJw==
X-Google-Smtp-Source: ABdhPJw7R+XywZgNxGuYeGtmKWkV2KF0ClltQZXGVP6GBaNPhi5e1DOir94iWrkYJw3POQerQKgrC5Sthl/6YvvLxa0=
X-Received: by 2002:a17:907:10d9:: with SMTP id rv25mr4570332ejb.264.1598044649266;
 Fri, 21 Aug 2020 14:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <6af3de0d-ffdc-8942-3922-ebaeef20dd63@redhat.com> <CAPcyv4h=oBnzmP2PHAFX6H2jsNq8zSUzQLYySj0Ke7FAqZwb0A@mail.gmail.com>
 <3dfde5e3-e1e2-2097-afa1-303042de5e07@redhat.com>
In-Reply-To: <3dfde5e3-e1e2-2097-afa1-303042de5e07@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Aug 2020 14:17:18 -0700
Message-ID: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeff Moyer <jmoyer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 21, 2020 at 11:30 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.08.20 20:27, Dan Williams wrote:
> > On Fri, Aug 21, 2020 at 3:15 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >>>>
> >>>> 1. On x86-64, e820 indicates "soft-reserved" memory. This memory is not
> >>>> automatically used in the buddy during boot, but remains untouched
> >>>> (similar to pmem). But as it involves ACPI as well, it could also be
> >>>> used on arm64 (-e820), correct?
> >>>
> >>> Correct, arm64 also gets the EFI support for enumerating memory this
> >>> way. However, I would clarify that whether soft-reserved is given to
> >>> the buddy allocator by default or not is the kernel's policy choice,
> >>> "buddy-by-default" is ok and is what will happen anyways with older
> >>> kernels on platforms that enumerate a memory range this way.
> >>
> >> Is "soft-reserved" then the right terminology for that? It sounds very
> >> x86-64/e820 specific. Maybe a compressed for of "performance
> >> differentiated memory" might be a better fit to expose to user space, no?
> >
> > No. The EFI "Specific Purpose" bit is an attribute independent of
> > e820, it's x86-Linux that entangles those together. There is no
> > requirement for platform firmware to use that designation even for
> > drastic performance differentiation between ranges, and conversely
> > there is no requirement that memory *with* that designation has any
> > performance difference compared to the default memory pool. So it
> > really is a reservation policy about a memory range to keep out of the
> > buddy allocator by default.
>
> Okay, still "soft-reserved" is x86-64 specific, no?

There's nothing preventing other EFI archs, or a similar designation
in another firmware spec, picking up this policy.

>   (AFAIK,
> "soft-reserved" will be visible in /proc/iomem, or am I confusing
> stuff?)

No, you're correct.

> IOW, it "performance differentiated" is not universally
> applicable, maybe  "specific purpose memory" is ?

Those bikeshed colors don't seem an improvement to me.

"Soft-reserved" actually tells you something about the kernel policy
for the memory. The criticism of "specific purpose" that led to
calling it "soft-reserved" in Linux is the fact that "specific" is
undefined as far as the firmware knows, and "specific" may have
different applications based on the platform user. "Soft-reserved"
like "Reserved" tells you that a driver policy might be in play for
that memory.

Also note that the current color of the bikeshed has already shipped since v5.5:

   262b45ae3ab4 x86/efi: EFI soft reservation to E820 enumeration
