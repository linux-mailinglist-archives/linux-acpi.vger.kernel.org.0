Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0316AD9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEGTFA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 15:05:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38250 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGTFA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 May 2019 15:05:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id y19so5084509lfy.5;
        Tue, 07 May 2019 12:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zWJfwz+fwYJ1p02uShHdeYN/Qq2lWdk2D2AnZwo/RE=;
        b=C9kqiPtjJhOr+PT9TOzf9EdTE4aAycrdlfcomlxZDi9eWymu8VL66yBjYifDrVmLQ1
         h5if7Y23u0n1K74IJ36bYKIs2jxph+5G+MbiplhElUg6ajOJMpEMHipTnZVCs0KZ3W72
         0ccNxikXjj+mliOLNyDDrMxnvP6cyOtLFPdygIpiNvUCS2UBS21mW0LKb424MqBzkwJx
         iz41xMUu+eh5d1wbmyVpSNUlL4Zg9bFzuFB0SvNVpNpBOa6LZm3KRS5PYdvtA2dzE9vc
         dcBglkX6yZTasuobzX3tUUJUPouS9ipPyidbVZUIuN6a1YOTsQ7/FeFJmk0LW4Ih+c3R
         gbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zWJfwz+fwYJ1p02uShHdeYN/Qq2lWdk2D2AnZwo/RE=;
        b=Jxud9hNZHIC89A48jQSPpEdgISxtXChyl1XLCRr0we0OI8X/vyC7sxr/zPz/41AnxX
         e37btIN/qFt/UxNPhmxX/XzIYscbpdDrdcybv1qvNM8r1aTTm3PRKS8VRBDdaQUjCUJE
         v/u/eoUqVqEwcbZTbQMY3WpetT9nKQLuqd7UDOpi9pqi+ClH4LYVm6Tb51ZYN89KL/WH
         nU6yP+ODamzZqbm71MeSi/wB7ZLQtSz/Mzdq3KMb2SDnAVjRe/W6kAA1HEx1trNuRsqt
         3lGANmKqXgx+vAVGyv7BAy5W+k8ASxpYKxRx0vXJXGvysa5yP1J79gIH9LyLkwhYNlTb
         6wWg==
X-Gm-Message-State: APjAAAUTlCCm4UAqqs621Z1JWdtZ99NJnDwUxal7fOdNqIcwtLsO7s5s
        bEFQTqbnlFJRvlwpfffpvGHX2Qt0D1bhD09I0AR20g0=
X-Google-Smtp-Source: APXvYqxRFT8eFl96LKSEpeW6IfTfSWn3NoQOypBRaYlTSzug24KxN+OlnkY+P2KCuHLU2Qpwm7Sf2m3xTWj/dI4fPc8=
X-Received: by 2002:a19:7d04:: with SMTP id y4mr17763594lfc.153.1557255897702;
 Tue, 07 May 2019 12:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
 <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
 <CAJZ5v0ghNMPMdc03T-is-=-k11rZ8K5O9Av+TnbBY_2mNr-eug@mail.gmail.com>
 <CAEJqkgiB7woieNZ-vVm7x-GzVrqGpJWLXOM9JpSUgPgE7eA6gA@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED53C5A9EBD@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C5A9EBD@ORSMSX122.amr.corp.intel.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 7 May 2019 21:06:16 +0200
Message-ID: <CAEJqkggvtYobXNjFbvqjajMcbZ_+3PrQJC-9kK+nn5cgXgOyWg@mail.gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am Di., 7. Mai 2019 um 20:46 Uhr schrieb Schmauss, Erik
<erik.schmauss@intel.com>:
>
>
>
> > -----Original Message-----
> > From: Gabriel C [mailto:nix.or.die@gmail.com]
> > Sent: Tuesday, May 7, 2019 2:33 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; LKML <linux-
> > kernel@vger.kernel.org>; Schmauss, Erik <erik.schmauss@intel.com>
> > Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without
> > CONFIG_ACPI_DEBUG being set
> >
> > Am Di., 7. Mai 2019 um 10:35 Uhr schrieb Rafael J. Wysocki
> > <rafael@kernel.org>:
> > >
> > > On Tue, May 7, 2019 at 9:31 AM Gabriel C <nix.or.die@gmail.com> wrote:
> > > >
> > > > Am Di., 7. Mai 2019 um 09:01 Uhr schrieb Rafael J. Wysocki
> > <rafael@kernel.org>:
> > > > >
> > > >  Hello Rafael ,  Erik
> > > >
> > > > > +Erik
> > > > >
> > > > > On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com>
> > wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > while testing kernel-5.1 I get on one of my Lenovo Laptops very
> > > > > > strange 'ACPI Debug:' messages.
> > > > > >
> > > > > > After some grepping I realized these are Debug messages from
> > > > > > DSDT , however my kernel does not have ACPI_DEBUG enabled.
> > > > > >
> > > > > > I found out the module triggering this, on this Laptop is
> > > > > > ideapad_laptop , but looking at the code I cannot see what would
> > > > > > causes that.
> > > > > >
> > > > > > Also on the same Laptop with any 5.0.X kernels I cannot see these.
> > > > > >
> > > > > >
> > > > > > ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1 #
> > > > > > CONFIG_ACPI_DEBUGGER is not set # CONFIG_ACPI_DEBUG is not
> > set #
> > > > > > CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set #
> > > > > > CONFIG_THINKPAD_ACPI_DEBUG is not set
> > > > > >
> > > > > > .. dmesg ..
> > > > > > ...
> > > > > > [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> > > > > > [ideapad_laptop] @ 1322
> > > > > > [   68.026708] input: Ideapad extra buttons as
> > > > > >
> > /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> > > > > > [   68.038236] ACPI Debug:  "=====QUERY_64====="
> > > > > > [   68.050232] ACPI Debug:  "=====QUERY_65====="
> > > > > > [   68.060218] ACPI Debug:  "=====QUERY_64====="
> > > > > > [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> > > > > > [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> > > > > > [ideapad_laptop] returned 0 after 69751 usecssg
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > These =====QUERY_XX===== messages are from DSDT:
> > > > > >
> > > > > > ~/acpi$ grep QUERY dsdt.dsl
> > > > > >                Debug = "=====QUERY_11====="
> > > > > >                Debug = "=====QUERY_12====="
> > > > > >                Debug = "=====QUERY_24====="
> > > > > >                Debug = "=====QUERY_25====="
> > > > > >                Debug = "=====QUERY_37====="
> > > > > >                Debug = "=====QUERY_38====="
> > > > > >                Debug = "=====QUERY_64====="
> > > > > >                Debug = "=====QUERY_65====="
> > > > > >
> > > > > > Also this is the code from DSDT for QUERY 64 and 65:
> > > > > >
> > > > > > ...
> > > > > >             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
> > > > > >            {
> > > > > >                Debug = "=====QUERY_64====="
> > > > > >                If ((OSYS == 0x07D9))
> > > > > >                {
> > > > > >                    If (((WLEX == One) & (WLAT == One)))
> > > > > >                    {
> > > > > >                        SGOV (0x02040005, One)
> > > > > >                    }
> > > > > >                    Else
> > > > > >                    {
> > > > > >                        SGOV (0x02040005, Zero)
> > > > > >                    }
> > > > > >                }
> > > > > >            }
> > > > > >
> > > > > >            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
> > > > > >            {
> > > > > >                Debug = "=====QUERY_65====="
> > > > > >                If ((OSYS == 0x07D9))
> > > > > >                {
> > > > > >                    If (((BTEX == One) & (BTAT == One)))
> > > > > >                    {
> > > > > >                        SGOV (0x0202000B, One)
> > > > > >                    }
> > > > > >                    Else
> > > > > >                    {
> > > > > >                        SGOV (0x0202000B, Zero)
> > > > > >                    }
> > > > > >                }
> > > > > >            }
> > > > > >
> > > > > > ...
> > > > > >
> > > > > >
> > > > > > Any idea what would cause this ?
> > > >
> > > > I think I found what is causing that.
> > > >
> > > > Commit aa9aaa4d61c0048d3faad056893cd7860bbc084c is moving
> > definition
> > > > of Linux's  ACPI_DEBUG_DEFAULT to incude/acpi/platform/aclinux.h ,
> > > > however include/acpi/acpi.h didn't got updated and
> > > > ACPI_DEBUG_DEFAULT now being always defined as  (ACPI_LV_INIT |
> > > > ACPI_LV_DEBUG_OBJECT | ACPI_LV_EVALUATION | ACPI_LV_REPAIR)
> > >
> > > I'm not sure what you mean by this.
> > >
> > > include/acpi/acpi.h should get the right definitions through
> > > include/acpi/platform/acenv.h and include/acpi/acoutput.h that are
> > > included by it.
> > >
> >
> > Hmm yes should , I missed that include. However it does not work.
> >
> > I've just put back old code back into drivers/acpi/bus.c to test and all working
> > now fine without any other changes.
> >
> > > It looks like incude/acpi/platform/aclinux.h has not been included by
> > > include/acpi/platform/acenv.h for some reason when building this
> > > module.
> >
> > If this one getting it wrong all will do so , they all just include <linux/acpi.h>.
> >
> > Probably not so much users will notice that , I just did because my BIOS
> > vendor forgot DEBUG around.
>
> Do you still get this issue after doing make clean and rebuilding your kernel?

A clean build from tarball has this issue for me. I don't think is a
building problem ,
any <5.1 kernel is fine , kernel 5.1 with your commit reverted is fine too ,
kernel 5.1 with your commit in but the removed hunk in bus.c re-added
is fine also.
