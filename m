Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001BD2D8A03
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Dec 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405289AbgLLUrQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Dec 2020 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLLUrQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Dec 2020 15:47:16 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59942C0613CF
        for <linux-acpi@vger.kernel.org>; Sat, 12 Dec 2020 12:46:36 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o144so11068247ybc.0
        for <linux-acpi@vger.kernel.org>; Sat, 12 Dec 2020 12:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ijt+NjD3TZPeXbC6i9nWnLN67OJPRDUiGF9H3UmXq2k=;
        b=kr0FpmR3SbD0idhUyctf3dZ8T8xNboxEpAN8CcBOgmu3uJ0KrveJNqzsSoIwK/K7tq
         XWIuZ66VOFxU0CFVjSZxoWPziLVT8Gr0QUyfivvUsLq6/iL2Mvtli3m1H9cULkPPMcgV
         WobEunVyK0zts6FuPSDlgdpvD7SqZI6YbozEEcyvRn5ApLM96v7xdzaTvZInBRS+h8IL
         GIc0soajEnaTT29Pc3+d6D3+8RH0TUJ3VV2iksHiGmwyRLDkHQqFZw4KDweNrCWdRdzE
         j/6irrj1OldeCwh7lF0718FFFiCQjnmpJAmGSggtWnBonWmwwreMgrVW+wLXmVff3zfX
         oZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ijt+NjD3TZPeXbC6i9nWnLN67OJPRDUiGF9H3UmXq2k=;
        b=hvHvwwjywkPI3nfmZuro1BlNWpscX6/L8AhodU1CoGtUd4CFpEpRk+P0n4cTXIZEtW
         tAx8U6YZ5bZGzlU2h60kGEQZwSUDxhRQiQVKq16N9BzEY8WsF1oaRASOdrIE09kxmfiK
         ItvVcjVwf1/2FT+tfeqNmV8lL5uN4IjHXbfNAAHD3FyRc1kFIUHbrNH2kgrgAFDUJvw/
         /4KLaC78vg+oByzzLKGyjmF2cJ97VAg2KVUhBa/dzbEM9iRK39DcwE7oauQm4q2+FPeO
         6M2WReDlXEKMInMCrmJ8RzidWAK3Kw8Ii5WFp1Y4JMZbbPpuxvp/7Ix0urxosn4jo9oS
         92AQ==
X-Gm-Message-State: AOAM531HCVO9eygtDpakth16JOt8UAyzpFb+qi9f0kZf/kowvSzG7ANj
        usSwtvifSf+nxiAt+m3F9Fa8VdtueUn+xKyPuSMr4g==
X-Google-Smtp-Source: ABdhPJzX/62NBi5SxpI99IO3HFbbb1DCVEYLhUQDot3PsD2IncutxliNtdFRGLQBYffbDm1y+Wdg8pulfm93KiHN+ac=
X-Received: by 2002:a25:8401:: with SMTP id u1mr28064525ybk.96.1607805995165;
 Sat, 12 Dec 2020 12:46:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGETcx8BmwWKAcH3vtLh=zrTEwJX_Y2nS1uB4Hq0priMQOnohQ@mail.gmail.com>
 <CAJZ5v0gyCmt66FKJU-ui8-ab6bedvpGU+cV7dKf25a_BOOKH4w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gyCmt66FKJU-ui8-ab6bedvpGU+cV7dKf25a_BOOKH4w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 12 Dec 2020 12:45:59 -0800
Message-ID: <CAGETcx98vivT1oTPqCVO1vovvwVPeNfW3aFFzVHEUmRS8ya75g@mail.gmail.com>
Subject: Re: fw_devlink for ACPI - need some pointers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 12, 2020 at 12:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Dec 12, 2020 at 3:13 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Hi ACPI devs,
> >
> > I want to take a stab at adding fw_devlink support for ACPI.
> >
> > fw_devlink adds device links between consumer and supplier devices. It
> > finds the supplier-consumer dependencies by looking at the firmware
> > nodes of devices as they are added to driver core.
> >
> > Main benefits of fw_devlink (because it creates device links):
> > * Removes a lot of deferred probes or probe failures (due to poor
> > error handling).
> > * Makes module load order less important for things to probe successfully.
> > * Makes suspend/resume a bit more robust.
> >
> > For DT (devicetree), I know how to interpret the common properties
> > (Eg: clocks, -gpios, etc) to figure out what devices supply resources
> > for a given device. In general, I'm familiar with DT and there's also
> > Documentation/devicetree/bindings/ that I can grep for if I need to
> > know what a property means. So, I've been able to implement fw_devlink
> > for DT.
> >
> > Now, I want to add support for ACPI to get the ball rolling. However,
> > I'm fairly clueless with it comes to ACPI. So, if I can get some
> > pointers, that'd be great!
> >
> > Things I need help with:
> > 1) I don't even know how to view the ACPI data on my PC. For example,
> > in DT, /sys/firmware/devicetree/ has the entire DT represented as a
> > tree of folders and files. How do I read ACPI info that lists all the
> > devices, their properties, etc?
>
> You can look at the directory structure under
> /sys/devices/LNXSYSTM\:00/ which roughly corresponds to DT contents.

Are these struct acpi_device (the fwnode) or are they actual devices
that'll get probed?

>
> > 2) Is there documentation to look up what each of those device properties mean?
>
> Of course there is.  The docs in Documentation/firmware-guide/acpi/ to
> start with, the ACPI spec and a number of assorted additional pieces.
>
> > 3) How are some of the common device dependencies listed in ACPI? For
> > example, if a device depends on power, clock, GPIO, interrupt, etc how
> > does ACPI list the supplier devices for each of those resources?
>
> That depends.
>
> _DEP is one way to specify dependencies between devices in ACPI, but
> there are others.

What is _DEP? Is it a property? Can I find it as a property in an ACPI fwnode?

What are the other ways of specific dependencies?

> > 4) Assuming there are a few common properties that list the device
> > dependencies, how do I look up a firmware node that a property points
> > to? If this is not how it works, how does it work?
>
> The concept of "properties" as you know them from DT doesn't apply to
> ACPI in general.

Ok. What else could I look at from an ACPI fwnode that might give me
dependency info?

> While it is possible to define "properties" of a device in a way that
> is kind of analogous to DT, it really isn't used in practice.

Mmm... this is what I was wondering/suspecting. With what little I
know about ACPI, it looks like a lot of the HW details is hidden from
the OS. Are all of those details just handled by running
instructions/code that's part of ACPI info that is provisioned?

> Generally speaking, the spec defines the ways to represent various
> types of information etc.

In general, how much of it is actually used by Linux? And how much of
it is Linux just executing code that ACPI provides?

> > In general, any pointers to docs that'll answer the above questions
> > would also be appreciated.
>
> Well, you may find it less compelling than expected, but feel free to
> ask if you have any more specific questions.

So the real question is, is there enough info in ACPI to make
meaningful device links before drivers for devices are loaded? If so,
what part of the ACPI data do I need to look at?

In general, I get the sense most (90%) ACPI devices appear standalone
(no dependencies on other devices) to Linux because they hide all the
clock, power control, IOMMU, and other dependencies in the firmware
somehow. Is my intuition right? I guess TL;DR is, is fw_devlink likely
to be useful for ACPI based machines? I wonder if ACPI provides more
info in the ARM+ACPI world.

-Saravana
