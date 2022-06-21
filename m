Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAF55284B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 01:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiFTX01 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 19:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbiFTX0M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 19:26:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F824123
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 16:25:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so19558431lfa.6
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=23wRLssd9yUqYAVQ0COO9blyB0bEYhanq/ns7VcDlgE=;
        b=a6K24opO14Dj6hgQTimAXkGwICYrRk6VgLGUpR2AqI/ZfwHucLaDZ8qlmbryBseQHn
         6hJZUNfTMN+s8AMKRri0vtlpsaG0HkclhUY6T2yZ8ZIMmIOqvQTe/+L8fGXgcI1XK6tZ
         Xyob8JTfZhQj3N3Nx3CsU7dJ1e6nRz72MOGAuPkRF88WN2ykwFJvIEXtnMdqNQ7m7XcF
         vO1Cw3KKRlicGVsNjvbyUzVcQHjdQBsyhjrpuw16RboevoHzMONMigTaB87oESo7J/tS
         bWRz3toWtYvAHkpSPW6fzSD4Fi+pm4Ce0kmoaSDoInw9IHcfjAiGtN6zrNHf5/wjBGur
         pxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=23wRLssd9yUqYAVQ0COO9blyB0bEYhanq/ns7VcDlgE=;
        b=6BWuVLRmlKPRVt/cfGV6jKzgSZIO04hs2Zj54B64lezNIvuk3vZnso/4+Z1bWD5Clb
         UO5bFUgtNYON53SDSbYw4dmgwXDAz1uWsEU9oCavvMVhzbBQMbFb8+aTE/4edUm8sjb2
         Li4TdyOmaafESYHKQSJpcoN6x+3D0jqshDY3D+F7ItgsbM2NeDwSJhxzrfGA63kpIvvv
         7+Xsbin0PYuE6t/E9dEjAAiZhm3+yM6/evMOmU3fAbf4yQE582P378/PLCaVfQ+K9SbB
         aW8KE+Iz+3q+7u72PVD8MZFhfNJ5vWiOsJ+RxAQuM6p2iEz/odTl6H+XmChupeMmbvHX
         V4yQ==
X-Gm-Message-State: AJIora9JbGcVLJMZ67V/EMQG+hOHH89pvFNCxM/x+rIvswcOwOF14SP7
        oTKa+yBQY8fyVN1RFuZFhO6BhLkZx7R45Wyso2NsYttEmsc=
X-Google-Smtp-Source: AGRyM1tj3E3GMT9NlxXY+pcKooUG/uy9ecdEmK8WlBazVLo1/iJJSNqzIptvCW9xtoDgjbZog94h2BMO/c7qewDSpxo=
X-Received: by 2002:a05:6512:a90:b0:478:f288:f1b5 with SMTP id
 m16-20020a0565120a9000b00478f288f1b5mr14398705lfu.614.1655767552878; Mon, 20
 Jun 2022 16:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-10-mw@semihalf.com>
 <YrDO05TMK8SVgnBP@lunn.ch>
In-Reply-To: <YrDO05TMK8SVgnBP@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 01:25:42 +0200
Message-ID: <CAPv3WKeSoErRWZYV3X6+kDd9VZAqQmjA7KvC14_Zs8RbbLXjDg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 21:47 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > +In DSDT/SSDT the scope of switch device is extended by the front-panel
> > +and one or more so called 'CPU' switch ports. Additionally
> > +subsequent MDIO busses with attached PHYs can be described.
>
> Humm, dsa.yaml says nothing about MDIO busses with attached PHYs.
> That is up to each individual DSA drivers binding.
>
> Please spilt this into a generic DSA binding, similar to dsa.yaml, and
> a Marvell specific binding, similar to marvell.txt. It might be you
> also need a generic MDIO binding, since the marvell device is just an
> MDIO device, and inherits some of its properties from MDIO.
>
> > +
> > +This document presents the switch description with the required subnod=
es
> > +and _DSD properties.
> > +
> > +These properties are defined in accordance with the "Device
> > +Properties UUID For _DSD" [dsd-guide] document and the
> > +daffd814-6eba-4d8c-8a91-bc9bbf4aa301 UUID must be used in the Device
> > +Data Descriptors containing them.
> > +
> > +Switch device
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The switch device is represented as a child node of the MDIO bus.
> > +It must comprise the _HID (and optionally _CID) field, so to allow mat=
ching
> > +with appropriate driver via ACPI ID. The other obligatory field is
> > +_ADR with the device address on the MDIO bus [adr]. Below example
> > +shows 'SWI0' switch device at address 0x4 on the 'SMI0' bus.
> >
> > +.. code-block:: none
> > +
> > +    Scope (\_SB.SMI0)
> > +    {
> > +        Name (_HID, "MRVL0100")
> > +        Name (_UID, 0x00)
> > +        Method (_STA)
> > +        {
> > +            Return (0xF)
> > +        }
> > +        Name (_CRS, ResourceTemplate ()
> > +        {
> > +            Memory32Fixed (ReadWrite,
> > +                0xf212a200,
> > +                0x00000010,
>
> What do these magic numbers mean?
>
> > +                )
> > +        })
> > +        Device (SWI0)
> > +        {
> > +            Name (_HID, "MRVL0120")
> > +            Name (_UID, 0x00)
> > +            Name (_ADR, 0x4)
> > +            <...>
> > +        }
>
> I guess it is not normal for ACPI, but could you add some comments
> which explain this. In DT we have
>
>     properties:
>       reg:
>         minimum: 0
>         maximum: 31
>         description:
>           The ID number for the device.
>
> which i guess what this _ADR property is, but it would be nice if it
> actually described what it is supposed to mean. You have a lot of
> undocumented properties here.
>
>
> > +label
> > +-----
> > +A property with a string value describing port's name in the OS. In ca=
se the
> > +port is connected to the MAC ('CPU' port), its value should be set to =
"cpu".
>
> Each port is a MAC, so "is connected to the MAC" is a bit
> meaningless. "CPU Port" is well defined in DSA, and is a DSA concept,
> not a DT concept, so you might as well just use it here.
>
> > +
> > +phy-handle
> > +----------
> > +For each MAC node, a device property "phy-handle" is used to reference
> > +the PHY that is registered on an MDIO bus. This is mandatory for
> > +network interfaces that have PHYs connected to MAC via MDIO bus.
>
> It is not mandatory. The DSA core will assume that port 0 has a PHY
> using address 0, port 1 has a PHY using address 1, etc. You only need
> a phy-handle when this assumption does not work.
>
> > +See [phy] for more details.
> > +
> > +ethernet
> > +--------
> > +A property valid for the so called 'CPU' port and should comprise a re=
ference
> > +to the MAC object declared in the DSDT/SSDT.
>
> Is "MAC" an ACPI term? Because this does not seem very descriptive to
> me. DT says:
>
>       Should be a phandle to a valid Ethernet device node.  This host
>       device is what the switch port is connected to
>
> > +
> > +fixed-link
> > +----------
> > +The 'fixed-link' is described by a data-only subnode of the
> > +port, which is linked in the _DSD package via
> > +hierarchical data extension (UUID dbb8e3e6-5886-4ba6-8795-1319f52a966b
> > +in accordance with [dsd-guide] "_DSD Implementation Guide" document).
> > +The subnode should comprise a required property ("speed") and
> > +possibly the optional ones - complete list of parameters and
> > +their values are specified in [ethernet-controller].
>
> You appear to be cut/pasting
> Documentation/firmware-guide/acpi/dsd/phy.txt. Please just reference
> it.
>
> > +Below example comprises MDIO bus ('SMI0') with a PHY at address 0x0 ('=
PHY0')
> > +and a switch ('SWI0') at 0x4. The so called 'CPU' port ('PRT5') is con=
nected to
> > +the SoC's MAC (\_SB.PP20.ETH2). 'PRT2' port is configured as 1G fixed-=
link.
>
> This is ACPI, so it is less likely to be a SoC. The hosts CPU port
> could well be an external PCIe device for example. Yes, there are AMD
> devices with built in MACs, but in the ACPI world, they don't happen
> so often.
>
> I assume you have 3 different 'compatible' strings for the nv88e6xxx
> driver? You should document them somewhere and say how they map to
> different marvell switches,
>

Thank you for the remarks, I'll address all after the consensus about
the binding is established.

Best regards,
Marcin
