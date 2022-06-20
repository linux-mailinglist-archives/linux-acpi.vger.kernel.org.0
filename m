Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340EE551FFC
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiFTPMU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiFTPMG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 11:12:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF913F2C
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 08:02:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b23so3654710ljh.7
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxQNSbinrTsgQGxNEqtziHy+t5H7kRQgWCro6p1KBMA=;
        b=WPXUf7U5nc8yTs7HL25c+VZwbO5QQ8T1QE+oQNxnT2blOmFQzN3XoFS/PHoxbQ/T31
         fiqhWBaEDnIxujWfPayn2+tJJRfFzsx0aKRSv1es0t9hBbz7BoG56nmQepi5xs/A4dHl
         Xk82m+eF76wCTnIkBRZ5dnb8GLVqsT+ME6Iva/hKtAmD3jK8h7Vt5ATRxDSASk9Ps4/e
         pDLk6tU9UV1a7WtWzYI3tDjPclrLJBkEuo4lA13sX1i1t9X8tHXhGybICgtHao5lJqEV
         IfC5iJ6zmZWDFrNZ4jFr2e4E4Rh7zW5P4prmXo7jXJrStYsEoZ2BaEdIaC5t8rBmXKy6
         aCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxQNSbinrTsgQGxNEqtziHy+t5H7kRQgWCro6p1KBMA=;
        b=c7dHmTr710FiPw0v/ju+MP1Iz7bD5sBrs2RPfe+uN++p99PPmvW4armgtlvlI67f3k
         0pwBexCtuL4spYui1LbbPf37o4eLS0NZ/OH3VJffsgs6QebSxe3UOtXkAqxLb+yXMJXy
         9x85YCCZ+Xe9cHFE10z8cGmN7bpKkH8Wh9BnkPXioa9JMicuin9nJW84bA5j1G2z6k3x
         JwOLlBLH7XrDZvuu9UrFht+3aQSgBEPUZNA02rof2ptGqQOSicfpy9tg3DuEPLIlsOcN
         wj89Zq4yCT+OSALBqatz3AALQi/KoJsEJuWXsimkgAgzJQKTGaoii87CBUxy4KD9RzCA
         47VQ==
X-Gm-Message-State: AJIora84avknOAkcm5LXIZBmPimRhcuRm9Ad5i2JheaiD8I8lvtHH0za
        a1oQpsbwH+V+vACF2dpJcnTKUA==
X-Google-Smtp-Source: AGRyM1tVQkRQxXTDvCUQrJ4dJeOiz18tvgdU6yJBqRC1zlngaVtLknPavVc+pf1G6HMrLNPY1QVPTg==
X-Received: by 2002:a05:651c:12c5:b0:255:9384:b385 with SMTP id 5-20020a05651c12c500b002559384b385mr12087450lje.229.1655737363697;
        Mon, 20 Jun 2022 08:02:43 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e19-20020a05651236d300b0047f79f7758asm17564lfs.22.2022.06.20.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:02:43 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, gjb@semihalf.com,
        mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, upstream@semihalf.com
Subject: [net-next: PATCH 00/12] ACPI support for DSA
Date:   Mon, 20 Jun 2022 17:02:13 +0200
Message-Id: <20220620150225.1307946-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!

This patchset introduces the support for DSA in ACPI world. A couple of
words about the background and motivation behind those changes:

The DSA code is strictly dependent on the Device Tree and Open Firmware
(of_*) interface, both in the drivers and the common high-level net/dsa API.
The only alternative is to pass the information about the topology via
platform data - a legacy approach used by older systems that compiled the
board description into the kernel.

The above constraint is problematic for the embedded devices based e.g. on
x86_64 SoCs, which are described by ACPI tables - to use DSA, some tricks
and workarounds have to be applied. Addition of switch description to
DSDT/SSDT tables would help to solve many similar cases and use unmodified
kernel modules. It also enables this feature for ARM64 ACPI users.

The key enablements allowing for adding ACPI support for DSA in Linux were
NIC drivers, MDIO, PHY, and phylink modifications – the latter three merged
in 2021. I thought it would be worth to experiment with DSA, which seemed
to be a natural follow-up challenge.

It turned out that without much hassle it is possible to describe
DSA-compliant switches as child devices of the MDIO busses, which are
responsible for their enumeration based on the standard _ADR fields and
description in _DSD objects under 'device properties' UUID [1].
The vast majority of required changes were simple of_* to fwnode_*
transition, as the DT and ACPI topolgies are analogous, except for
'ports' and 'mdio' subnodes naming, as they don't conform ACPI
namespace constraints [2].

The patchset can be logically split to subsets of commits:
* Move a couple of missing routines to fwnode_ equivalents
* Rework net/dsa to use fwnode_*/device_* API
* Introduce fwnode_mdiobus_register_device() and allow MDIO device probing
  in ACPI world.
* Add necessary ACPI-related modifications to net/dsa and add Documentation
  entry.
* Shift example mv88e6xxx driver to fwnode_*/device_* and add ACPI hooks.
The changes details can be found in the commit messages.

Note that for now cascade topology remains unsupported in ACPI world
(based on "dsa" label and "link" property values). It seems to be feasible,
but would extend this patchset due to necessity of of_phandle_iterator
migration to fwnode_. Leave it as a possible future step.

Testing:
* EACH commit was tested against regression with device tree on EspressoBIN
  and SolidRun CN913x CEx7 Evaluation board. It works as expected throughout
  entire patchset.
* The latter board was used as example ACPI user of the feature - it's 1:1
  to what's available when booting with DT. Please check [3] and [4] to
  compare the DT/ACPI description.

For convenience, this patchset is also available on a public branch [5].

I am looking forward to any comments or remarks, your review will be
appreciated.

Best regards,
Marcin

[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
[2] https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#acpi-namespace
[3] https://github.com/semihalf-wojtas-marcin/edk2-platforms/commit/6368ee09a232c1348e19729f21c05e9c5410cdb9
[4] https://github.com/tianocore/edk2-non-osi/blob/master/Silicon/Marvell/OcteonTx/DeviceTree/T91/cn9130-cex7.dts#L252
[5] https://github.com/semihalf-wojtas-marcin/Linux-Kernel/commits/dsa-acpi-v1

Marcin Wojtas (12):
  net: phy: fixed_phy: switch to fwnode_ API
  net: mdio: switch fixed-link PHYs API to fwnode_
  net: dsa: switch to device_/fwnode_ APIs
  net: mvpp2: initialize port fwnode pointer
  net: core: switch to fwnode_find_net_device_by_node()
  net: mdio: introduce fwnode_mdiobus_register_device()
  net: mdio: allow registering non-PHY devices in ACPI world
  ACPI: scan: prevent double enumeration of MDIO bus children
  Documentation: ACPI: DSD: introduce DSA description
  net: dsa: add ACPI support
  net: dsa: mv88e6xxx: switch to device_/fwnode_ APIs
  net: dsa: mv88e6xxx: add ACPI support

 include/linux/etherdevice.h                     |   1 +
 include/linux/fwnode_mdio.h                     |  22 ++
 include/linux/of_net.h                          |   6 -
 include/linux/phy_fixed.h                       |   4 +-
 include/net/dsa.h                               |   1 +
 drivers/acpi/scan.c                             |  15 +
 drivers/net/dsa/mv88e6xxx/chip.c                |  76 +++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   1 +
 drivers/net/mdio/acpi_mdio.c                    |  40 ++-
 drivers/net/mdio/fwnode_mdio.c                  | 129 +++++++
 drivers/net/mdio/of_mdio.c                      | 105 +-----
 drivers/net/phy/fixed_phy.c                     |  37 +-
 drivers/net/phy/mdio_bus.c                      |   4 +
 net/core/net-sysfs.c                            |  18 +-
 net/dsa/dsa2.c                                  | 104 ++++--
 net/dsa/port.c                                  |  54 ++-
 net/dsa/slave.c                                 |   6 +-
 Documentation/firmware-guide/acpi/dsd/dsa.rst   | 359 ++++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst     |   1 +
 19 files changed, 748 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/dsa.rst

-- 
2.29.0

