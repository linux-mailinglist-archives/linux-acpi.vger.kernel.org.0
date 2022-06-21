Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD4552F66
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiFUKDB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 06:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346969AbiFUKDA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 06:03:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2AE29
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 03:02:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s21so10926764lfs.13
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgpvJ+ZYQ9wNJ1RH7x/Iyee2F28bg23N2XRimN8MYRQ=;
        b=ktPF7cOnTQ+f5ss8vA4ne+IqJ1N2aK8YJDV120+3TE5Y/PumvHgTI9YFgKCc/emtfo
         Rpk77hxnFVp2OoD6JZTZahD5WNhRB58jXTzOyhiGI26jAuV0LO2rsYzX++z/fM1OTXPe
         RvxfAcSAdUUJr28uLmAby0mBoPAvpNkCR/jGF056uSrC9GxTDf84J4UvIMjPZ/z/OVKr
         YDXRK3FKeW9eCGLazvBoG9I5pbF0iliNKlnaV6bPxaVInkUTftHN9losZCQKB5WVxwz0
         CEByZvkr8RrFrC80CCL3NKulB9MQXNa9Lh31KJaecljsfW2TK0XIlIiHubuZfpeb4y2v
         U5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgpvJ+ZYQ9wNJ1RH7x/Iyee2F28bg23N2XRimN8MYRQ=;
        b=bYwAoOF2B9j9eARf4yPJkHGVyHHQlpv3IYFXSnn9G6KQk1birUgnd0E0bte8cx/BBP
         wj5+cJfrPGA0gpW/KqwKFKB+ok6u+wycpB9TAqAJSC695vJGz5QmW5UunrBah1XNIu80
         AgfPlMJGo9Ieo+NHFCqR9IUcwQeXoNYPXep/zvHpxD94x0btkuUvHeRjdB3ljdLLMKg+
         jcnryDZOgGRBo+dP740wI9wVz8ZJUUXHAophW+GS88p2cwnGln8g9dNkE0MIu2raclOn
         ZtXZ2HH2yPVq8zjHYm+vjVyaROlI7j1pMPmFVZ8D/7R3rJqVE4tgC6tZAMLjpO2yBC7Q
         xetA==
X-Gm-Message-State: AJIora8N0mUFkI19NcIrVTYVTcmkPvaaMsnEtZhEpKyOLlLb7vSakRw0
        BeauIvwSmS/9o2eEqr0FMna+WlB9p6F2LkhqOu5aaw==
X-Google-Smtp-Source: AGRyM1vJyn4HX+l1jRaEx/IuJ8VvUq21x67APPtICLlcI6h1PNZNhnGzvCIIh/0z7vZgyTr7dsdpoFugsC0f3Mg2usE=
X-Received: by 2002:a05:6512:118f:b0:47f:6a1a:20d4 with SMTP id
 g15-20020a056512118f00b0047f6a1a20d4mr7197196lfr.428.1655805776035; Tue, 21
 Jun 2022 03:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <YrCsgIxOmXQcjy+B@smile.fi.intel.com>
In-Reply-To: <YrCsgIxOmXQcjy+B@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 12:02:46 +0200
Message-ID: <CAPv3WKdJ_zoraG=gpOOSWHJcoMTKkkH8=N21aXX2RrusjWWD9g@mail.gmail.com>
Subject: Re: [net-next: PATCH 00/12] ACPI support for DSA
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 19:21 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:13PM +0200, Marcin Wojtas wrote:
> > Hi!
> >
> > This patchset introduces the support for DSA in ACPI world. A couple of
> > words about the background and motivation behind those changes:
> >
> > The DSA code is strictly dependent on the Device Tree and Open Firmware
> > (of_*) interface, both in the drivers and the common high-level net/dsa=
 API.
> > The only alternative is to pass the information about the topology via
> > platform data - a legacy approach used by older systems that compiled t=
he
> > board description into the kernel.
> >
> > The above constraint is problematic for the embedded devices based e.g.=
 on
> > x86_64 SoCs, which are described by ACPI tables - to use DSA, some tric=
ks
> > and workarounds have to be applied. Addition of switch description to
> > DSDT/SSDT tables would help to solve many similar cases and use unmodif=
ied
> > kernel modules. It also enables this feature for ARM64 ACPI users.
> >
> > The key enablements allowing for adding ACPI support for DSA in Linux w=
ere
> > NIC drivers, MDIO, PHY, and phylink modifications =E2=80=93 the latter =
three merged
> > in 2021. I thought it would be worth to experiment with DSA, which seem=
ed
> > to be a natural follow-up challenge.
> >
> > It turned out that without much hassle it is possible to describe
> > DSA-compliant switches as child devices of the MDIO busses, which are
> > responsible for their enumeration based on the standard _ADR fields and
> > description in _DSD objects under 'device properties' UUID [1].
> > The vast majority of required changes were simple of_* to fwnode_*
> > transition, as the DT and ACPI topolgies are analogous, except for
> > 'ports' and 'mdio' subnodes naming, as they don't conform ACPI
> > namespace constraints [2].
>
> ...
>
> > Note that for now cascade topology remains unsupported in ACPI world
> > (based on "dsa" label and "link" property values). It seems to be feasi=
ble,
> > but would extend this patchset due to necessity of of_phandle_iterator
> > migration to fwnode_. Leave it as a possible future step.
>
> Wondering if this can be done using fwnode graph.
>

Probably yes. It's a general question whether to follow iterating over
phandles pointed by properties, like DT with a minimal code change or
do something completely different.

Best regards,
Marcin
