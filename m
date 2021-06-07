Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546D539DAE1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGLPo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 07:15:44 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40770 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGLPo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 07:15:44 -0400
Received: by mail-oi1-f175.google.com with SMTP id r17so7394824oic.7
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 04:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/h3jcy7/S2vPHlgTPwq3uNVWT03uXn9873uamgg6qjU=;
        b=G53bsbG/F7p/NJTxnqwd8/XdtJ0WovIkCW4cLVu9vwfPWt23gYoSlxf/PbGa3wqJ73
         6Di+tA82dtD86OCfU5fRIa0jmcaUMt4JIyBRhxhepK8pneMdnufGI6JWsrDIkBuMsWMF
         QIEL/65CQRbqWMTRyzyo+QgnFHBb/HFzBWbSC8JbFWjFae5fxjXLBNoJGaJXkRZ+coee
         fg/XPkAD/FiAY46GDyBiJn2x6SL2eJ/sjUBe7QgUNhen/XLq3M4z8zZUFlfCZ7IT+QhE
         I5/XQu0cIN5XHNYs/tfnninHCq0FrmwQJxshyp2VU/VyZTmrehNNtKTpunrnCwBawabu
         WZmQ==
X-Gm-Message-State: AOAM5305AIfQkWwlb6g7TTxzTfOqfn5k7hVu9ICouMuPaNKzWQ6WK2JS
        sXdkmlal6WcCnBpEVVYA4cDOLUHO1CxqR2hNK+M=
X-Google-Smtp-Source: ABdhPJxFJ//iJCc5QZYwDyPW8auwr7QjUk+lM8UgtZo6czFHvknFGzSFqp1WNiAEirJ4Viuz5VslbJ9ouwWbvb4qbvQ=
X-Received: by 2002:aca:650d:: with SMTP id m13mr2801761oim.157.1623064419739;
 Mon, 07 Jun 2021 04:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com> <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
In-Reply-To: <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 13:13:21 +0200
Message-ID: <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@outlook.com>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 7, 2021 at 12:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> HI,
>
> On 6/7/21 11:43 AM, Hans de Goede wrote:
> > Hi,
> >
> > On 6/3/21 7:26 PM, Hans de Goede wrote:
> >> Hi Rafael,
> >>
> >> I've been helping some users with trying to get to the bottom of some
> >> new ACPI errors with kernel 5.12, see:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> >>
> >> After looking at dmesg output; and after editing the dmesg output
> >> a bit so that I could do diff -u on it, the following stands out:
> >>
> >> --- dmesg_5.10.38-1-lts      2021-06-03 16:29:41.372922210 +0200
> >> +++ dmesg_linux-5.12.5-arch1-1       2021-06-03 16:30:01.013031634 +0200
> >> @@ -92,7 +92,7 @@
> >>  ACPI: IRQ9 used by override.
> >>  Using ACPI (MADT) for SMP configuration information
> >>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
> >> -ACPI: Core revision 20200925
> >> +ACPI: Core revision 20210105
> >>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096 bytes)
> >>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff] (7274496 bytes)
> >>  ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> >> @@ -113,10 +113,6 @@
> >>  ACPI: Dynamic OEM Table Load:
> >>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> >>  ACPI: Dynamic OEM Table Load:
> >> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> >> -ACPI: Dynamic OEM Table Load:
> >> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> >> -ACPI: Dynamic OEM Table Load:
> >>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
> >>  ACPI: Dynamic OEM Table Load:
> >>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> >>
> >> Note how for some reason the kernel is no longer loading the Cpu0Hwp and
> >> HwpLvt SSDT-s ?
> >>
> >> Do you have any ideas what might be causing this ?
> >
> > Good news, a very similar bug is being tracked here:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1963717
> >
> > And one of the reporters there has done a git bisect and has found the commit which is causing the problem for them:
> >
> > """
> > git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
> > "ACPI: Execute platform _OSC also with query bit clear".
> >
> > Tested 5.12.9 kernel with the commit reverted, and confirmed that the error
> > messages are gone. (I had to revert
> > 5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)
> >
> > It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc which is absent
> > in the stable 5.12.x
> >
> > Hope this helps
> > """
>
> I've taken a quick look at commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear") and I think I may have found the problem.
>
> I've attached a patch which I think may fix this (and I've asked the reporters of the bugs to test this).

Thank you, the patch looks reasonable to me.

It looks like commit 719e1f561afb went a bit too far.
