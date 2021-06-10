Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5333A3282
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJRyy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 13:54:54 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44632 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJRyy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 13:54:54 -0400
Received: by mail-ed1-f43.google.com with SMTP id u24so34036946edy.11
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5N9tssE2i0AgVK7/2trUERhx4u2w/EofSnQ2711Vg0=;
        b=NwyASavLYyq5W9Tb2GGDH2wkOtzzWTAyyvhi06tuRc3Ne1GMb9L1kbyJ13EscFk3nO
         BFnHWcY9XiM6T+TsIcgSCGFGXmAt7sZ99gmzYCKEJnfghHERCC8XWQgzxn+CovjpBM83
         BtWyOwSUC3iO/EzsLahGQhj7+v8LpXrDRQfYHPdmiTfOJu8U4zcx24XdPFpEuEjfp/Q+
         kTQqBQVlGd6FklnVW0c3pxM/u8bVdL+BvKwWURshHDQrNdBPS0FtUOcufze255FZ8Mje
         kMGNfSQKyz3bHaeFACGsWJuV1cBXZRjGmV5lawxXT0aL/P5M5VETkrqhQjbz6tnTcixz
         YZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5N9tssE2i0AgVK7/2trUERhx4u2w/EofSnQ2711Vg0=;
        b=t135aaW6ddPH384GGpt1yqeZCxn/hzHbPJd/KRg1+zFCUGhbgYFkFIEYqk7LCEr+E/
         yoKO7ThpQbGYbnBawTg5G716rc5C5KSitz/5MCt+iAN1kw86v5SjA4RTq4sN5poJ8jJo
         hV659brjlJsjtwLctwS6tkjfuG8pxELGgOhWMM9emHvdNc23ehJmctXR5urv64sSD5a9
         mBNBcpA1fKs0SMSm4JjZBCLeG7Zgemv1Irv4ygT9HyQLF5y1TdWQzJIMFJup5XvR4J4S
         H02TV3jQnpvJv9y+P0k6bQutJF5ixLcRgCnMdfc+Ld8eXi2SxgFHQqvwnF4liaUsfdN8
         SR5w==
X-Gm-Message-State: AOAM5301GNDciUcHmruu9Z+TLR6RRlGvtfVJDltxm4MwbU03xRcf60tC
        F44RCO8pQ1yEqO29haM726cCyyY21QfaEalCPaxnusnDpd8=
X-Google-Smtp-Source: ABdhPJzCoetYoBQDDWOYa33AgKwAl3+emGrXImDnBKCyVLiFrGTBa7kK2HiwwjAhOB5hDtHoyt6aO6lmFkRa/p6cU/k=
X-Received: by 2002:aa7:c753:: with SMTP id c19mr675196eds.33.1623347503093;
 Thu, 10 Jun 2021 10:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210610163917.4138412-1-ciorneiioana@gmail.com> <YMJEMXEDAE/m9MhA@lunn.ch>
In-Reply-To: <YMJEMXEDAE/m9MhA@lunn.ch>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Thu, 10 Jun 2021 19:51:03 +0200
Message-ID: <CABdtJHv-Xu5bC2-T7a0UgbYpkNP1SLfWwdLWLLKj5MBvA2Ajyw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 00/15] ACPI support for dpaa2 driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ioana Ciornei <ciorneiioana@gmail.com>,
        Grant Likely <grant.likely@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Pieter Jansen Van Vuuren <pieter.jansenvv@bamboosystems.io>,
        Saravana Kannan <saravanak@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Calvin Johnson <calvin.johnson@nxp.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux.cj" <linux.cj@gmail.com>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 6:56 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jun 10, 2021 at 07:39:02PM +0300, Ioana Ciornei wrote:
> > From: Ioana Ciornei <ioana.ciornei@nxp.com>
> >
> > This patch set provides ACPI support to DPAA2 network drivers.
>
> Just to be clear and avoid confusion, there is a standing NACK against
> this patchset. Please see the discussion here:
>
> https://patchwork.kernel.org/project/linux-acpi/patch/20200715090400.4733-2-calvin.johnson@oss.nxp.com/#23518385
>
> So far, i've not seen any indication the issues raised there have been
> resolved. I don't see any Acked-by from an ACPI maintainer. So this
> code remains NACKed.

Andrew,

The ACPI maintainers did bless the use of the ACPI standards followed
in this patchset, and their only abstinence from ACK'ing the patchset
was whether the code was used in production systems.  Well currently,
not only have we, SolidRun, been using this patchset and the associated
ACPI tables in our SystemsReady certified firmware for the HoneyComb,
but we also have customers using this same patchset and firmware on
their systems rolled out to customers.

Additionally we have an entire new product line based on Marvell's
Armada CN913x series, which also needs this patchset to be fully
functional.

I am quite certain this is more than enough production systems using
this ACPI description method for networking to progress this patchset
forward.

-Jon
