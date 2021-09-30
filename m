Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68441E2BB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348172AbhI3Ui7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 16:38:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhI3Ui6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Sep 2021 16:38:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD41761A56;
        Thu, 30 Sep 2021 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633034235;
        bh=ZN/Nq4IgDxA5EErobLPJ0c5Be2iycRE3S97JflvWD9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPq32jzrlVuSLzPIdtejsKSzsAH69I5mBXX6U4MgMyQOLfcspvQV45lqUpUrsWCEP
         ayiHVc8S8I85gJOUfnTpxVRaOuMnPHiuwzZaLjgSX5uVOOcHev30cMAckqhb3WMJtE
         XO+nPmZzryQW9u/Ygz4l9jCDCxh7MlS/5Dx2Z1z8sIASb42Sc4fuwbtIxMBR7UcUV3
         eYdDPf0skysbXbzxf+BvPSOJGiaccSsyiErFWYr6LJr5Q8jIK64Xnd5qkUAX0nm7/J
         ohdo96/J1aZzlxeIChDpd4fJBgkVkyWWoWDy8HcU/F22d1enAByOlaPg8haOwuHkjk
         mM22RjtiJYdkg==
Received: by mail-wr1-f50.google.com with SMTP id s21so12070079wra.7;
        Thu, 30 Sep 2021 13:37:15 -0700 (PDT)
X-Gm-Message-State: AOAM532yRAVy8IfF+aUoa0MksgNmAUjhzgAVIKR4FUDZaCKKoTallhxH
        GryYhx94SdL/sDDjz/KF3g9U2w7biUGnK0bGku8=
X-Google-Smtp-Source: ABdhPJxnvUmd3Sbm2atNTl5zn2nKYHQQUHYsV989BMn4qOekZwOKzz7lOcoZ2V0mgqE23bRnU5Gh6fYz6YWSBCH+J7o=
X-Received: by 2002:a5d:564f:: with SMTP id j15mr8376557wrw.336.1633034234173;
 Thu, 30 Sep 2021 13:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121338.938994-1-arnd@kernel.org> <CAJZ5v0jJRYQPSfVV_hCD6uxch+vU6kvWV9-KAfqHckHgkFOeaA@mail.gmail.com>
 <CAJZ5v0jDKK6ecsubVDv_=EUF3goiiDW28tvbKF9cesMphgKaug@mail.gmail.com>
In-Reply-To: <CAJZ5v0jDKK6ecsubVDv_=EUF3goiiDW28tvbKF9cesMphgKaug@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 30 Sep 2021 22:36:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Xmj0O8zORM9O+GLS9maqKV-awuSNQdC_zxN1z7mnjnA@mail.gmail.com>
Message-ID: <CAK8P3a1Xmj0O8zORM9O+GLS9maqKV-awuSNQdC_zxN1z7mnjnA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, Sep 30, 2021 at 8:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 8:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Sep 27, 2021 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > >  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> > > -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> > > -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> > > +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> > > +#define ACPI_OFFSET(d, f)               offsetof(d, f)
> > >  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
> > >  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
> > >
> > > --
> >
> > Queued up as 5.16 material, converted into an upstream ACPICA pull
> > request and submitted, thanks!
>
> And reverted from there, because it introduced build issues.
>
> Can we use alternative definitions that don't depend on uintptr_t and
> offsetof()?

It's a bit tricky, as both were introduced to avoid portability issues.

For uintptr_t, we could use 'unsigned long', which works on everything
that Linux can run on, but wouldn't work if this code can be compiled
for 64-bit Windows. 'size_t' probably works, but likely has the same problem
as 'uintptr_t' because they require and additional #include. I see
that some code uses acpi_uintptr_t, which looks like it is meant to
replace uintptr_t, this is defined as 'void *' in include/acpi/actypes.h,
so that probably wouldn't avoid the warning.

For offsetof(), we could use __builtin_offsetof(), which would work with
any gcc-compatible compiler, if the goal is to avoid including <stddef.h>.
If it has to work on other compilers, there is no portable way that doesn't
rely on standard headers. The best idea I'd have would be to use
"#ifdef offsetof" to choose between the trivial implementation I had
and the old one that works for non-standard C but may invoke
undefined behavior.

       Arnd
