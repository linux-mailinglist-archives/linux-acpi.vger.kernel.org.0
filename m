Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A173B8794
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhF3RVr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 13:21:47 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40838 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhF3RVr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 13:21:47 -0400
Received: by mail-oi1-f174.google.com with SMTP id l26so1266492oic.7;
        Wed, 30 Jun 2021 10:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whtWAytPA5br2VV4bJUkRa0hO694zx905NLhlKUp6LU=;
        b=aUD2KogdniYhCFtx3q0EkA+BYPKrXuXebRT1OyYfACrqrQDAuuStijVQsgiCarb973
         QfAKLZGkbeHCWgcsmHY5xLt6KEovSIq90SY0u5kmDAdvtRicsX0uao85tkfHHD43cl7G
         D6SJ6rKg/ScNmf6NS9RUgiBAb8fLKKPDZ2VcJzb7HpziLMFf8rqh/adqnbenQgZ8oR6r
         8SvRFxeJlR4Wn84OysZK3vnrwMXBjp1PmlpJOJeN3KWLxUeBdq46fq9Ssw3lt41BwQh+
         5ErVEe0lPZj0xVUO8tCKB3cvYUkX+w8cTjX7dFGhpLiIgYNMccT4eAMslWUiH0CbR9Ru
         XRvg==
X-Gm-Message-State: AOAM530OiDEOXB9SkHYIbEG/U9tCjgFxkFpycYqEMI4cjJfvAZtirraw
        hF/ChrumQVTI7D8lv5yHFDi/+XT1us9wy2Q3XgHzZuTy9Lc=
X-Google-Smtp-Source: ABdhPJygstd0PRgk2pxEcXN0jArtIMaBZc9XO/XHoaayrFM6WqvQTdGWNTD46q43af/peMAHQCUHNxybVhOfWC9ocRY=
X-Received: by 2002:aca:417:: with SMTP id 23mr11542778oie.71.1625073556563;
 Wed, 30 Jun 2021 10:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
 <YNxLvhBBE7Ff6Q5u@zn.tnic>
In-Reply-To: <YNxLvhBBE7Ff6Q5u@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 19:19:05 +0200
Message-ID: <CAJZ5v0g_+xDVYRiVR4aDFKsNqLg9DeGAMKU1+CPCorpf=Ceb7A@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v5.14-rc1
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2021 at 12:47 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 29, 2021 at 09:01:10PM +0200, Rafael J. Wysocki wrote:
> > Erik Kaneda (6):
> >       ACPICA: Fix memory leak caused by _CID repair function
> >       ACPICA: iASL: add disassembler support for PRMT
> >       ACPICA: Add support for PlatformRtMechanism OperationRegion handler
> >       ACPICA: Add PRMT module header to facilitate parsing
> >       ACPI: PRM: implement OperationRegion handler for the
> > PlatformRtMechanism subtype
>
> $ git checkout master
> $ git pull
> $ make oldconfig
>
> Platform Runtime Mechanism Support (ACPI_PRMT) [Y/n/?] (NEW) ?
>
> There is no help available for this option.
> Symbol: ACPI_PRMT [=y]
> Type  : bool
> Defined at drivers/acpi/Kconfig:547
>   Prompt: Platform Runtime Mechanism Support
>   Depends on: EFI [=y] && X86_64 [=y]
>   Location:
>     -> Power management and ACPI options
>
>
>
> Platform Runtime Mechanism Support (ACPI_PRMT) [Y/n/?] (NEW)
>
> I don't know what that means, there's no help, no nothing. And it is
> default y for no apparent reason.
>
> /me looks at the commit message:
>
>     Platform Runtime Mechanism (PRM) is a firmware interface that exposes
>     a set of binary executables that can either be called from the AML
>     interpreter or device drivers by bypassing the AML interpreter.
>     This change implements the AML interpreter path.
>
> I'm still unclear whether I need it or not.

That's a fair point.

> Guys, you need to think about your users and to write help text which is
> *actually* usable for people who do not deal with ACPI firmware gunk.

We will.

What about the following help text (white space damage by gmail)?

---
 drivers/acpi/Kconfig |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -548,3 +548,13 @@ config ACPI_PRMT
     bool "Platform Runtime Mechanism Support"
     depends on EFI && X86_64
     default y
+    help
+      Platform Runtime Mechanism (PRM) is a firmware interface exposing a
+      set of binary executables that can be called from the AML interpreter
+      or directly from device drivers.
+
+      Say Y to enable the AML interpreter to execute the PRM code.
+
+      While this feature is optional in principle, leaving it out may
+      substantially increase computational overhead related to the
+      initialization of some server systems.
