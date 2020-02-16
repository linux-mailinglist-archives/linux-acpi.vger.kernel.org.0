Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87157160664
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Feb 2020 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgBPUtO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Feb 2020 15:49:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42653 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPUtN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Feb 2020 15:49:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so14145538otd.9
        for <linux-acpi@vger.kernel.org>; Sun, 16 Feb 2020 12:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWK2l3ezdzvA3GVxiSq1O+tgY8mTUG3Oa2phHQeXZLc=;
        b=MpRtQY0w0ZuidO5BCMmSO9Cd6i+gCgoR4EPA9qvIvh8taAm+HQnDU94m+H9SCWSnFP
         eBycW+G6ppWw/JdAC1eT90NT9YXzGRnTC6C6J/Ylb7/lKkLHT7kFbHGJjMahUQ+DCyAY
         rP0ZK/4Gln3/ZrqyJBrs5vhoW5OrLilEQ4I33tA+++Wfa3aCBveLaQCrMWLMCMI2gjch
         h6jXtOFp8RYDsrBAA1jr2QoME95VYx21TCNOzyxIVRgUTrdgmNLU8p3UeIemUh6lGso7
         wOrbexH9g64XM3YJNRBzmCblJZmyJFoAis7IhF8Tu/p4QCsHhqJ4wbXZBOu2evOYftWM
         E6AA==
X-Gm-Message-State: APjAAAXIe4tKlR0dhq3WziVhVlbBp8uYFZuTzgZCDOukvClIbS6vqUpy
        +IdMwdrbAXiwYDkVB1QpI/NChzc9b4fHosF5l1ZjDSKI
X-Google-Smtp-Source: APXvYqzmxePp89Rb6c7VuIlJ1OKOgJPJ5JR3smykIEcUWe/LECWRvBxlXw/GSQ403qRfaTbSYIIwDvtAm4BWApSOjiI=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr10223683otd.266.1581886153005;
 Sun, 16 Feb 2020 12:49:13 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
 <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com> <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.2002161038370.4312@n3.vanv.qr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 16 Feb 2020 21:49:02 +0100
Message-ID: <CAJZ5v0jOOi0SjZ+SUv8L8f6z2uxu40Q7AP_q9XKVEOePxwBHfg@mail.gmail.com>
Subject: Re: Linux hangs at ACPI init on Medion P15648 MD63490
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Feb 16, 2020 at 3:16 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
>
> On Sunday 2020-02-16 01:32, Rafael J. Wysocki wrote:
> >On Fri, Feb 14, 2020 at 8:28 PM Jan Engelhardt <jengelh@inai.de> wrote:
> >>
> >> I have a problem with a certain x86 laptop, and judging from the
> >> kernel's output, this looks very much like a broken ACPI table.
> >> Versions tried are 5.3.8 (Fedora31 liveimage), 5.5.2 (openSUSE
> >> Tumbleweed installer) and 5.6.0-rc1+
> >> (b19e8c68470385dd2c5440876591fddb02c8c402; self compile), all
> >> exhibiting the same hang.
> >>         ACPI: \: Used as first EC
> >>         ACPI: \: GPE=0x10, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> >
> >Would it be possible to try 5.0 or earlier on the problematic machine?
> >You may be hitting a regression here.
>
> Seems not to be the case. The same hang shows, with slightly different messages.
>
>         5.0
>         unable to progress to the problem point...
>         the NMI watchdog causes a panic due to the slow scrolling of
>         earlyprintk=efi
>
>         4.12.14 (openSUSE)
>         ACPI: : EC: EC started
>         ACPI: : EC: interrupt blocked
>         ACPI: \: Used as first EC
>         ACPI: \: GPE=0x10, EC_CMD/EC_SC=0x66, EC_DATA=0x62
>                 (no mention of IRQ=-1)
>         ACPI: \: Used as boot ECDT EC to handle transactions
>         <hang>
>
>         4.4.76 (openSUSE)
>         ACPI : EC: EC description table is found, configuring boot EC
>         ACPI : EC: EC started
>         <hang>
>
> I thus went back to 5.6-rc and enabled full ACPI tracing
> (layer=0xffffffff/level=0xffffffff) starting from
>
> nsinit.c:213    /* Walk namespace to execute all _INIs on present devices */
>
> onwards. That log output is at http://inai.de/files/m923.mp4 [53MB].

If that is the case, then AFAICS the issue may not be directly related
to the EC at all.  This output only means that the system has an ECDT,
but that should not be a problem by itself.

The system appears to hang somewhere in acpi_ns_initialize_devices()
and it is hard to say where exactly.

I would suggest creating a BZ entry at bugzilla.kernel.org for this
issue and attaching the output of acpidump from the affected system in
there.
