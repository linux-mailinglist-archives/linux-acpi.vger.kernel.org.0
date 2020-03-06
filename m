Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4917C782
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFVFm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 16:05:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44328 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFVFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 16:05:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id v22so3805061otq.11
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2020 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=zHeO+NASipBgaWDXKZxHQ9T6Qk7JyQTufn1LqoKL9eCvWxA6ERYUyq5brfvaGK2Q2T
         O/1XtzLEJ1OB063KrHNDlljqirAy6dSyKF1iCoBOl1Vku6umli7wybNDN4liHG6HiEkL
         iJQBdSeZVh2iwysFc31yvgGzAfDguHevXnkROYvBITGUqkec3Q6DiV6vn3qAjCSwkC6V
         7yLNzobtVea45nRJ6F+O3pxCAX7i2s3r6qp0ctkisp7YTbLrPNxHKjQpvGQULi0khAfv
         gHd+Vg6XcX50oieboKdVEQSwY9XXXxKOGwnkGWC6OtC68at4+VqDSlJ0yEpTWQIPL97W
         CziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=s3+kOdNEfMOS5hG3oUxyNhMHoqvbEI8B2RJ4ciulAo+U7yRctc7Z2mTAaxyBSfVugB
         uZ5xYxdoChdR2QUdSvbjyu6bS24g1MrotLUF8ajMDYVb77CNUuA7VRQci69WXNEGEjUw
         K+gdtHRmj41x25gGpR2VSU+Op2nKDpWTcZ5Var31SzzMMZxomSLbs8zWcqY/eafYvDKT
         FeTNFxJCg9t6ljzCXCu0RqBP5uHC8kQxlPmyMn+HHhDIvvvJIKOjVv193bmpsxY8QfuT
         qFuzlHTqWe6hXHLXzw7dgmtLquxh6In6vCiVF3UZf2wFxvVZEjMC5M/HcBlxYPj0IAya
         yoDg==
X-Gm-Message-State: ANhLgQ0Z4D1ZD0aFXs1f1X9HlUo+Cw9KCy3He/6OpYVvYmyk40rJ4Tpt
        KD/yuHy3wdNsSbOsBxBxCYuLKvqr706snsKertzV+Q==
X-Google-Smtp-Source: ADFU+vu3caJkxN5foYyF0GPM62BSitG6fiBBhbRTadus2AVityefuk0oEkE1SzZK3vy+IUU4Bmf/G7dorCK3e8I7x8s=
X-Received: by 2002:a05:6830:1313:: with SMTP id p19mr763057otq.126.1583528741694;
 Fri, 06 Mar 2020 13:05:41 -0800 (PST)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Mar 2020 13:05:30 -0800
Message-ID: <CAPcyv4jCWtPf0XEHfw6GGGE80k0_wKpoaruopRFJwKcsHk18gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Manual definition of Soft Reserved memory devices
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 6, 2020 at 12:07 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Given the current dearth of systems that supply an ACPI HMAT table, and
> > the utility of being able to manually define device-dax "hmem" instances
> > via the efi_fake_mem= option, relax the requirements for creating these
> > devices. Specifically, add an option (numa=nohmat) to optionally disable
> > consideration of the HMAT and update efi_fake_mem= to behave like
> > memmap=nn!ss in terms of delimiting device boundaries.
>
> So, am I correct in deducing that your primary motivation is testing
> without hardware/firmware support?

My primary motivation is making the dax_kmem facility useful to
shipping platforms that have performance differentiated memory, but
may not have EFI-defined soft-reservations / HMAT (or
non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
platforms where the platform firmware policy for what is
soft-reserved, or not, is not the policy the system owner would pick.
I'd also highlight Joao's work [1] (see the TODO section) as an
indication of the demand for custom carving memory resources and
applying the device-dax memory management interface.

> This looks like a bit of a hack to
> me, and I think maybe it would be better to just emulate the HMAT using
> qemu.  I don't have a strong objection, though.

Yeah, qemu emulation does not help when you, the system owner, have a
different use case than what the bare-metal platform-firmware
envisioned for "specific-purpose memory".

[1]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
