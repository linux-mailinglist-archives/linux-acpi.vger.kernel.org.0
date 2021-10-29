Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25244017A
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJ2RyS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 13:54:18 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35669 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJ2RyS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Oct 2021 13:54:18 -0400
Received: by mail-oi1-f182.google.com with SMTP id x8so10162670oix.2;
        Fri, 29 Oct 2021 10:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTzpgEOUBS8sMoWyNwkruiW9zm9JkTMzDcOqujNJPkk=;
        b=PsFBsNfhONKckqYjnuziH9R0hvqs+2UpSA1HNTpr3t5S5EHCiTLNLxA6n9zMStRhfg
         VdwRs9R3MkL5DQHN+Y/e+Ru3p0Lj4NWygSGJ6rpA2Mub8Cts++THL60+pl0cUdSApvZ4
         yzaTrakPW9m7CS2iOrgZylkoWmX6NwDE1vxjO+19cZq2POSV4xowAVs2Z8s2l/ic5wbB
         t1hPFPcB6VDpdBkJZ4cQviBnqVgSWCZDpBfLWqXwNhQfnAfydhknEZvntQwghW0B3L+X
         26vwyhiDieIzXdjfCwNdAXX/xjj+SwHlFzFnoUxQrzOzcGyuqvFeDr+7e1/iCNxzVgDs
         I8zQ==
X-Gm-Message-State: AOAM5325YJzT0LccPwzg2KO1tS/02Yadf2P+LYDpPpcbT1XRPZ5Nkff+
        O/slx1gYnoikxRny+QoH7tjX/rfj1cmG69DCD4ag6fMKnjs=
X-Google-Smtp-Source: ABdhPJy+JH/a/FNH755t1Dh1xCmQQTD//BsHJ/VldL46iyeLGRohdsF/7PO1GEzJz/hqmt35dg8+/ipdm/D4imtPqdA=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr8990625oil.166.1635529909246;
 Fri, 29 Oct 2021 10:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
 <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
In-Reply-To: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Oct 2021 19:51:38 +0200
Message-ID: <CAJZ5v0jiDR+54S8tuWf1E8Fxaw+JNmK6ERbW5wh9DNV7SbhRJQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.15-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 9:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 22, 2021 at 9:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >  - Fix an ACPI tools build issue introduced recently when the minimal
> >    stdarg.h was added (Miguel Bernal Marin).
>
> Hmm. ACPI already has that odd ACPI_USE_BUILTIN_STDARG case in
> acgcc.h, which ends up using _exactly_ the same macros as the
> <linux/stdarg.h> implementation does, and is basically exactly the
> same "minimal stdarg".
>
> Ok, so the macro argument names are different, and there are
> whitespace differences, but semantically identical.
>
> So maybe the ACPI code could drop one or the other in favor of the
> identical macros?

The ACPI_USE_BUILTIN_STDARG check comes from the upstream code
assuming that whoever doesn't use the "common" stdarg.h will set
ACPI_USE_BUILTIN_STDARG, but we don't set it and we provide our own
stdarg.h, so we can make the following change (on top of the -rc7):

---
 include/acpi/platform/acgcc.h |   13 -------------
 1 file changed, 13 deletions(-)

Index: linux-pm/include/acpi/platform/acgcc.h
===================================================================
--- linux-pm.orig/include/acpi/platform/acgcc.h
+++ linux-pm/include/acpi/platform/acgcc.h
@@ -10,25 +10,12 @@
 #ifndef __ACGCC_H__
 #define __ACGCC_H__

-/*
- * Use compiler specific <stdarg.h> is a good practice for even when
- * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
- */
 #ifndef va_arg
-#ifdef ACPI_USE_BUILTIN_STDARG
-typedef __builtin_va_list va_list;
-#define va_start(v, l)          __builtin_va_start(v, l)
-#define va_end(v)               __builtin_va_end(v)
-#define va_arg(v, l)            __builtin_va_arg(v, l)
-#define va_copy(d, s)           __builtin_va_copy(d, s)
-#else
 #ifdef __KERNEL__
 #include <linux/stdarg.h>
 #else
-/* Used to build acpi tools */
 #include <stdarg.h>
 #endif /* __KERNEL__ */
-#endif /* ACPI_USE_BUILTIN_STDARG */
 #endif /* ! va_arg */

 #define ACPI_INLINE             __inline__
