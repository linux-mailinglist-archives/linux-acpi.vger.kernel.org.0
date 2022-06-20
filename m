Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734AC552846
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 01:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347359AbiFTXZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 19:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347355AbiFTXY6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 19:24:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D96275C4
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 16:21:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o23so6396039ljg.13
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ur/MUBYcS1Q/QKNpXUCglSf5F59d0HWGTRVKBIepEDE=;
        b=GNRt7tT9S9xvcwHyHM40dX+0JaFJIUhwyEwwLSabMcUU7w33ohJRv8TmTIzPcUpjdk
         FE7h/zE4Ge2KA3ZRWr9ghHl1SOIXB1mokPhl5UTIMIkubDtlr98Kg1tUlTecVnUR0ZjO
         NUbBvpqXCB5d2GXmh/Mm0j4YS7ZK7N0TCM/KL2G0IHEySgCZ4rpRLf/szNbIZhpWr1fh
         AoLJm2yGFojXcMtqpDKAYjjgVdt7xMxd0bPXvTg+mykdsnEQm4/XqG1kJAdPj7OaJqpK
         HuRDmP5r++IBnSOCeGCcDWqPABjceE1MEaHgMgZUVoWIbmExZRBmmMOGmzQAxVOd6J7/
         uJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ur/MUBYcS1Q/QKNpXUCglSf5F59d0HWGTRVKBIepEDE=;
        b=Q06dQuNbV5ki9YtFFanDpGuMqyUcPYA8obS8K2kr/7kPnRy8PRyPzskQkCaTlYj/ou
         QVEvAFEeFSpOnYLts+7oCFCa+i3NggmWcRHljbJi8ZRgixKucKV7Hs5xa6nxpfPJMN2R
         Jh8vLJG2XSU4LHbK4D/2oBuP/BQWnJqRQpzfae4Q9/HtHWDPpIoSTeUBD/FrwXdo4NUm
         uFGh+mHuE9LPY+J1zAKoOlzXqczeI+zza1szxvvBrYaBwgj9YGypmuuSmd7sCaaQvAdz
         ggorYb8eWnx4zJkl7bK1ZhMMPUf6eqkeCA01Dq+PeFRiexj0SkzFwWYN1z+JxgbsihH6
         hSmQ==
X-Gm-Message-State: AJIora/sPYR8dXersHDtOB1YSx/Hi8qz5OTQhbBzhAbpaVFh7sVRFcSU
        cXkgNzAJtKoXrWbZV8V1Iq7UKTrd8fD1IEVOeuUMtg==
X-Google-Smtp-Source: AGRyM1umHmCHjUaSlc4jQIWCikcJqPjhTSaSbtvEsQB+8Sb4DNMpDbRmU2BtcR+xboE2+9+orXsggpCBfshz6a3nCzc=
X-Received: by 2002:a2e:a58d:0:b0:25a:6348:9595 with SMTP id
 m13-20020a2ea58d000000b0025a63489595mr6664777ljp.72.1655767312454; Mon, 20
 Jun 2022 16:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-10-mw@semihalf.com>
 <YrC6Ihd4I13ctL18@lunn.ch>
In-Reply-To: <YrC6Ihd4I13ctL18@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 01:21:42 +0200
Message-ID: <CAPv3WKeLYDR3PuspOGU-oVf8tak5aNRDNP0nEN-jDJmoWa-USg@mail.gmail.com>
Subject: Re: [net-next: PATCH 09/12] Documentation: ACPI: DSD: introduce DSA description
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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

pon., 20 cze 2022 o 20:19 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:22PM +0200, Marcin Wojtas wrote:
> > Describe the Distributed Switch Architecture (DSA) - compliant
> > MDIO devices. In ACPI world they are represented as children
> > of the MDIO busses, which are responsible for their enumeration
> > based on the standard _ADR fields and description in _DSD objects
> > under device properties UUID [1].
>
> I would say this is too limiting. In the DT world, they are not
> limited to MDIO children. They can be I2C children, SPI children
> etc. There are plenty of I2C switches and SPI switches. This is
> actually something we got wrong with the first DT binding. We simply
> translated the platform data in DT, and at that time, there was only
> MDIO switches supported. That was a real blocker to I2C, SPI and MMIO
> devices until we discarded the DT binding and had a second go.
>
> DSA switches are just devices on a bus, any sort of bus.
>
> Look at Documentation/devicetree/binding/net/dsa/dsa.yaml. There is no
> reference to MDIO.
>
> I would expect the same with ACPI. Somehow the bus enumerates and
> instantiates a device on the bus. The device then registers itself
> with the DSA core. The DSA core does not care what sort of bus it is
> on, that is the drivers problem.
>

Thanks for mentioning the other options. It makes things easier and
the MDIO as current strict dependency will be dropped.

Best regards,
Marcin
