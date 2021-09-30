Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FB941E1C8
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhI3Syy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 14:54:54 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:34506 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhI3Syx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2021 14:54:53 -0400
Received: by mail-oo1-f52.google.com with SMTP id k11-20020a4abd8b000000b002b5c622a4ddso2158707oop.1;
        Thu, 30 Sep 2021 11:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWz5foWcr+bWR6CSFDKJoUEhYPxpGczQBoONhahdcus=;
        b=6zI9O/BfzTHbkcmFk6j3uN5Yaq53uE0Z9r2yZMNJvSSqQIan/jE8vZOG+xg13DreMs
         hv6O0UiVv6459N+21foxCzQbUg83Q5NJygstIZMZvSbWmFtp6M4U8xomc3mg4MBrHzQC
         x4o9xdr8Xmv6r3UMcCFT6+igaqmsc1uNkuT5pU31l/gKG1SFoL/ynefVCuftE5np9ihw
         dQmEN9OJBEHnGiSbr3ycnlsJRRWRhVEeDIUNuIouN93Eu9ZUyegHiLv6KbikUhS44yMu
         J0Oz1XDaI1oV0jNYOoKwQtmpTDLZR5XV5ZJo2Y0uUkD4sijIRolfPIIzCeYCp3z6ZUNC
         8/MQ==
X-Gm-Message-State: AOAM532e9r7QhmXW42AmXja79zo9+trtQV4OY49HQvFF2UrKzCf2UWwW
        9RKo614sURhPGRNr+Pwbsf0em5cypRRWdKA8FWry/6jgKkI=
X-Google-Smtp-Source: ABdhPJw8+m2xqrDVqABBbHFhPc+Vi/u0KcQlXUvSeYYp71RAa69bRuSXSureyv6cjZyWA10UqXHMSc2jbi7XhFK/J08=
X-Received: by 2002:a05:6820:17a:: with SMTP id k26mr6219832ood.37.1633027990202;
 Thu, 30 Sep 2021 11:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121338.938994-1-arnd@kernel.org> <CAJZ5v0jJRYQPSfVV_hCD6uxch+vU6kvWV9-KAfqHckHgkFOeaA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJRYQPSfVV_hCD6uxch+vU6kvWV9-KAfqHckHgkFOeaA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Sep 2021 20:52:59 +0200
Message-ID: <CAJZ5v0jDKK6ecsubVDv_=EUF3goiiDW28tvbKF9cesMphgKaug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 29, 2021 at 8:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Sep 27, 2021 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are some very old macros for doing an open-coded offsetof() and
> > cast between pointer and integer in ACPI headers. clang-14 now complains
> > about these:
> >
> > drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
> >          ACPI_FADT_OFFSET(pm_timer_block),
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
> >  #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
> >                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
> >  #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
> >  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
> >                                                                               ^ ~~~~~~~~~~~~~~~~~~~~~~~
> > Convert them to the modern equivalents.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/acpi/actypes.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> > index 92c71dfce0d5..285bc7b73de3 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
> >  /* Pointer/Integer type conversions */
> >
> >  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> > -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> > -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> > +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> > +#define ACPI_OFFSET(d, f)               offsetof(d, f)
> >  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> >  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
> >
> > --
>
> Queued up as 5.16 material, converted into an upstream ACPICA pull
> request and submitted, thanks!

And reverted from there, because it introduced build issues.

Can we use alternative definitions that don't depend on uintptr_t and
offsetof()?
