Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF40558B89
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 01:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiFWXIG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jun 2022 19:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiFWXIF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 19:08:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F21BCB0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 16:08:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so1474290lfg.7
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8W/oRQBAHexnfGyJ1VqjpiqHa9H+SQBCtE7ZQrUbWF0=;
        b=n3yuIVtow+fK5FJOgLkxsupR+xKY4GMpqUpzFcRHGUYTiV2x9/maWvxtE7TktkaP3G
         a/AtaLW5385h6qMstwIAv2Qoe5ijPpfGRxpJHR09wVPaUXaOzkGqCwJOxbtvyucGLPv2
         KYYjc+KYyFfD/VhDqLHAbwbtLpBZ3ad+5RKIMCBGQugoFTvnS/wh1CP1xdN5yczq0FKI
         c7aTFG8lrAslYH0TJhTbtgo1cz3EkSxHmHvd0b30Vm7R727jBAU5YpJcR3m4js7LM2Mu
         URJ0cVlUP/QopMEP6Pg1vMRDD0we4SlF9cS0nCW3tEhdshcBXBjDFBdp0TNMITbHDBT3
         fvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8W/oRQBAHexnfGyJ1VqjpiqHa9H+SQBCtE7ZQrUbWF0=;
        b=B6FM5Diq1s2BA2F0ypwj0rtanrjGUNjvVyfMToejrqok6RM05ImUz7V4zypEcgXWfc
         KTpn4CbNaL9DLbrqfe7YmxsJVKcdWN8w/jibMB1BbH/YiW+MKex+AS4zDknVgZPW7T2s
         MImb872wa/VE34dj8fKOZqKOzg/UW0RyFBD4qdK/JO4V9JUDolUelb4wU4ZYuIDDPake
         e+gynA5hMuLQ8pUZ78hePdIMPR2b6MpHx0V17FoNDuZQxw9eV4Vt1bgwsPmIPXTS2+si
         bAicHsydrKQKmYuNZBm+6P6QXAilJ5SrNqQKOF0pIY/H3pwxSkecHJunsl8h3uwRiUcs
         kfSQ==
X-Gm-Message-State: AJIora/r/OtKdWMHHETEZ6Gg4NkMTciFFKJ2kfkOKJvNJCcyfwGp3UhJ
        jEdZM3wxnROHo/jBh+Nqwo/t3K8/ThMsYKoFpBuuDw==
X-Google-Smtp-Source: AGRyM1sGIvrP3CG9Kp2cvOPx0vUnT4oQEGxCAzgYgCA+DSul0RFshuZr9+rk6XZqIcJOLI+94LREMotxY1kayQVDp+w=
X-Received: by 2002:a05:6512:1308:b0:47d:b9cc:ee88 with SMTP id
 x8-20020a056512130800b0047db9ccee88mr6860281lfu.680.1656025681159; Thu, 23
 Jun 2022 16:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-9-mw@semihalf.com>
 <YrDFmw4rziGQJCAu@lunn.ch> <CAJZ5v0g4q8N5wMgk7pRYpYoCLPQoH==Z+nrM0JLyFXSgF9y0+Q@mail.gmail.com>
 <54618c2a-e1f3-bbd0-8fb2-1669366a3b59@gmail.com> <CAJZ5v0j3A-VYFgcnziSqejp-qJVbrbyFP40S-m9eYTv=H9J0ow@mail.gmail.com>
 <YrQZOX4n0ZuTSANP@lunn.ch>
In-Reply-To: <YrQZOX4n0ZuTSANP@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 24 Jun 2022 01:07:52 +0200
Message-ID: <CAPv3WKc9niXpgppT27weeW0A87zNEGvd2xLCyoXeXKuqqxWs6g@mail.gmail.com>
Subject: Re: [net-next: PATCH 08/12] ACPI: scan: prevent double enumeration of
 MDIO bus children
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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

czw., 23 cze 2022 o 09:42 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > And when the ACPI subsystem finds those device objects present in the
> > ACPI tables, the mdio_device things have not been created yet and it
> > doesn't know which ACPI device object will correspond to mdio_device
> > eventually unless it is told about that somehow.  One way of doing
> > that is to use a list of device IDs in the kernel.  The other is to
> > have the firmware tell it about that which is what we are discussing.
>
> Device IDs is a complex subject with MDIO devices. It has somewhat
> evolved over time, and it could also be that ACPI decides to do
> something different, or simpler, to what DT does.
>
> If the device is an Ethernet PHY, and it follows C22, it has two
> registers in a well defined location, which when combined give you a
> vendor model and version. So we scan the bus, look at each address on
> the bus, try to read these registers and if we don't get 0xffff back,
> we assume it is a PHY, create an mdio_device, sub type it to
> phy_device, and then load and probe the driver based on the ID
> registers.
>
> If the device is using C45, we currently will not be able to enumerate
> it this way. We have a number of MDIO bus drivers which don't
> implement C45, but also don't return -EOPNOTSUPP. They will perform a
> malformed C22 transaction, or go wrong in some other horrible way. So
> in DT, we have a compatible string to indicate there is a C45 devices
> at the address. We then do look around in the C45 address space at the
> different locations where the ID registers can be, and if we get a
> valid looking ID, probe the driver using that.
>
> We also have some chicken/egg problems. Some PHYs won't respond when
> you read there ID registers until you have turned on clocks, disabled
> reset lines, enable regulators etc. For these devices, we place the ID
> as you would read from the ID registers in DT as the compatible
> string. The mdio_device is created, sub-types as a PHY and the probe
> happens using the ID register found in DT. The driver can then do what
> it needs to do to get the device to respond on the bus.
>

Currently the PHY detection (based on compatible string property in
_DSD) and handling of both ACPI and DT paths are shared by calling the
same routine fwnode_mdiobus_register_phy() and all the following
generic code. No ID's involved.

With MDIOSerialBus property we can probably pass additional
information about PHY's via one of the fields in _CRS, however, this
will implicate deviating from the common code with DT. Let's discuss
it under ECR.

> Then we have devices on the bus which are not PHYs, but generic
> mdio_devices. These are mostly Ethernet switches, but Broadcom have
> some other MDIO devices which are not switches. For these, we have
> compatible strings which identifies the device as a normal string,
> which then probes the correct driver in the normal way for a
> compatible string.

_HID/_CID fields will be used for that, as in any other driver. In
case Broadcom decides to support ACPI, they will have to define their
own ACPI ID and update the relevant driver (extend struct mdio_driver
with  .acpi_match_table field) - see patch 12/12 as an example.

>
> So giving the kernel a list of device IDs is not simple. I expect
> dealing with this will be a big part of defining how MDIOSerialBus
> works.
>

Actually the _HID/_CID fields values will still be required for the
devices on the bus and the relevant drivers will use it for matching,
which is analogous for the compatible string handling. The
MDIOSerialBus _CRS macro will not be used for this purpose, same as
already existing examples of I2CSerialBus or SPISerialBus (although
the child devices use them, they also have _HID/_CID for
identification).

What we agreed for is to get rid of is a static list of MDIO
controllers ID's, which I proposed in this patch, whose intention was
to prevent its enumeration by the default ACPI scan routines, in case
the device's parent is a listed MDIO bus. Instead, just the presence
of MDIOSerialBus macro in the _CRS method of the child device will
suffice to get it skipped at that point. Any other data in this macro
will be in fact something extra that we can use for any purpose.

Best regards,
Marcin
