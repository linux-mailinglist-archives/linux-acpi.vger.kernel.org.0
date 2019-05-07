Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5515E38
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEGHbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 03:31:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44019 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGHbh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2019 03:31:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so8243489lji.10;
        Tue, 07 May 2019 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxq5Dy3v0O55Tyn6JrcgrZo7auLXEcgWWOrE9YP6z7o=;
        b=LXDx2wN1wugilOB6On2IwVmV7BqCxCp7mbGaeGuCnJkJPaMfRAv6o2a5hsgBcSKhVX
         /J/Jmvlc2K0EXduG7xPSH8Ixjsd6PPKHQkoA7aq9yHbfxvH7Jn2iXwAiadxjnMaqjHgJ
         8UX2ft5nb50sbtSNmU1ROSaIEv+T5vHkXFtgOLWESlkC2QSuE4OeaunDIfi2cPXzYw+H
         Bf89x9RFxg18nWA2Qqsu2Cn41oil+esunUVReKDKYn66OxOxPUrjevJs1/FmQqGqChQ3
         rj9lotUqLXJG+RyErROMqPrP9KCr09784YnuxlA8ht2SymT7VGPQMZWklKq8CXMjP5Wq
         D8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxq5Dy3v0O55Tyn6JrcgrZo7auLXEcgWWOrE9YP6z7o=;
        b=bKst28tfR0ZWDQnTcEQnfqSVZa6Zv4X50sqvP74DfF9P2mZpGyuZrMMeYFGSZ4eCJ4
         1zzQpy6C9Biw+ughGOeI2wx27nszDz2qkYSY7Gywch5U5Gzj0FYRiVs4Tm2obQ9dCvbn
         GJlRHr+WByV9GAeAU0M5QwD6nyuC5rr88aAG1TWVW5pSF4MgEBfpo6xSIxAWzci8wpgC
         Zrh7RJoHBBMr1wR5Lx2b5ZNO7eYgNoFRvHUnlsxlDxSsOaQ5PgTO/SbLaB6VBxH9oJXn
         /1z3m83XtOj4ssQQXENGhVupn7+hq9UHaSX9TcbmWIlxTRH/fkiSywZ3Fh5bmHSrtnHR
         qvTw==
X-Gm-Message-State: APjAAAWH55j36VcJ1YPPsBitGuetO+E9HoWHVNkNFlebQYINMhM7MmyV
        e/XgDND6vCDWIfwogAdJ3V6ulbFzbAos5PBIRBv4KaLgjg==
X-Google-Smtp-Source: APXvYqxacd7k76Ie2gGE67vgH9r27tzKbjjnTk14CtB4AJyMpnJAoOCgyXXio9Oy3NKPTRPoxgpF1EH1JDc5Muk3B8I=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr2357132lja.157.1557214295314;
 Tue, 07 May 2019 00:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 7 May 2019 09:32:53 +0200
Message-ID: <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Di., 7. Mai 2019 um 09:01 Uhr schrieb Rafael J. Wysocki <rafael@kernel.org>:
>
 Hello Rafael ,  Erik

> +Erik
>
> On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Hello,
> >
> > while testing kernel-5.1 I get on one of my Lenovo Laptops very
> > strange 'ACPI Debug:' messages.
> >
> > After some grepping I realized these are Debug messages from DSDT ,
> > however my kernel does
> > not have ACPI_DEBUG enabled.
> >
> > I found out the module triggering this, on this Laptop is
> > ideapad_laptop , but looking at the code
> > I cannot see what would causes that.
> >
> > Also on the same Laptop with any 5.0.X kernels I cannot see these.
> >
> >
> > ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
> > # CONFIG_ACPI_DEBUGGER is not set
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> >
> > .. dmesg ..
> > ...
> > [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> > [ideapad_laptop] @ 1322
> > [   68.026708] input: Ideapad extra buttons as
> > /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> > [   68.038236] ACPI Debug:  "=====QUERY_64====="
> > [   68.050232] ACPI Debug:  "=====QUERY_65====="
> > [   68.060218] ACPI Debug:  "=====QUERY_64====="
> > [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> > [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> > [ideapad_laptop] returned 0 after 69751 usecssg
> >
> > ...
> >
> > These =====QUERY_XX===== messages are from DSDT:
> >
> > ~/acpi$ grep QUERY dsdt.dsl
> >                Debug = "=====QUERY_11====="
> >                Debug = "=====QUERY_12====="
> >                Debug = "=====QUERY_24====="
> >                Debug = "=====QUERY_25====="
> >                Debug = "=====QUERY_37====="
> >                Debug = "=====QUERY_38====="
> >                Debug = "=====QUERY_64====="
> >                Debug = "=====QUERY_65====="
> >
> > Also this is the code from DSDT for QUERY 64 and 65:
> >
> > ...
> >             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
> >            {
> >                Debug = "=====QUERY_64====="
> >                If ((OSYS == 0x07D9))
> >                {
> >                    If (((WLEX == One) & (WLAT == One)))
> >                    {
> >                        SGOV (0x02040005, One)
> >                    }
> >                    Else
> >                    {
> >                        SGOV (0x02040005, Zero)
> >                    }
> >                }
> >            }
> >
> >            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
> >            {
> >                Debug = "=====QUERY_65====="
> >                If ((OSYS == 0x07D9))
> >                {
> >                    If (((BTEX == One) & (BTAT == One)))
> >                    {
> >                        SGOV (0x0202000B, One)
> >                    }
> >                    Else
> >                    {
> >                        SGOV (0x0202000B, Zero)
> >                    }
> >                }
> >            }
> >
> > ...
> >
> >
> > Any idea what would cause this ?

I think I found what is causing that.

Commit aa9aaa4d61c0048d3faad056893cd7860bbc084c is moving
definition of Linux's  ACPI_DEBUG_DEFAULT to incude/acpi/platform/aclinux.h ,
however include/acpi/acpi.h didn't got updated and  ACPI_DEBUG_DEFAULT now
being always defined as  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT |
ACPI_LV_EVALUATION | ACPI_LV_REPAIR)

BR,

Gabriel C
