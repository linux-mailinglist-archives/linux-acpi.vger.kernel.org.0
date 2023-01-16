Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAB66CDF9
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jan 2023 18:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjAPRw7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Jan 2023 12:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjAPRwW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jan 2023 12:52:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582430B15
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2023 09:34:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o20so11713049lfk.5
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jan 2023 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmraRpuO5ELeElFfAOw0Nh37ZSQFfwxPPIwwqMsmgL4=;
        b=V+h/CQdJOWBxk+dGuEIFekryknJOcNnk7U+yyq0TPPCGK8xYOAo7uJSEbwsoa5kmwZ
         rLDJwlQpGHrKqWG+5jfXbkpdahfno/3bqM5m+SdU/7F/z2SHcoxHCIkgQ5PpxC5sxcc4
         PaQQPRi3eJciPzEOPQQGcHx9s9Io5r7y0Bqzdt6TsUkl5F/rdkY+ILog/WnN4eGE4IF0
         RR7seekRYx/9W3H6hRdmPTUL8tkQQb3rzsL1L//Q/b0VU7U06Fckm6STuBl6tzuvKxfL
         fyp4vVMR1yWVnVq5wSj7O/JH53eWH+2GRGrLeRUGnWaH+u5Iv3yIzDXBMOYhPWx+62/y
         f8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmraRpuO5ELeElFfAOw0Nh37ZSQFfwxPPIwwqMsmgL4=;
        b=zMQk2jIBWLNiUW1AgUp4VqI8ylvDOVqHtXvh/vMgGcbHC0F3xQ/aFrJGNx02eG8Zeu
         iDmSxEc/WithaZKLblJj04lTQ8lkDlS2bL3QHWSG4JjSQqYpsKGeVxRueAWTLFlhsee1
         WmZroURnY9SIomzmY11TovgKhxVRWWOKDv1QmeZ/ABv1e5iQ99bzizMJh3QoxTDe0xrF
         Ya+SyA+p8ARC2IkACoQBycglolNl2Xx8vRn/eN4SfZfF4KZDjCr7qTPqTfwtz72mHHnT
         RU4EnP1uQ609ZxPAstjRMXTfWNu09lUs34cM152+I2bUN2pzGqt1j5Oqpa99CBxuMSDB
         2pkQ==
X-Gm-Message-State: AFqh2krcDX8G7fNQ4jOBjo46wIKSvzkRxzI2sCsXJ15vYAok9JguUTsj
        NTOMqf5AVcjgJOCBpAAB16X3DQ==
X-Google-Smtp-Source: AMrXdXuGyZsMSygYIaoRf9XpgzdIX4imHYpJs+W1uAV3qfHH1KN67g1oN78E5JS6WCPlxYhV0udbng==
X-Received: by 2002:ac2:599d:0:b0:4b5:b8a9:b42c with SMTP id w29-20020ac2599d000000b004b5b8a9b42cmr24001064lfn.17.1673890497084;
        Mon, 16 Jan 2023 09:34:57 -0800 (PST)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b0028b7f51414fsm707333lji.80.2023.01.16.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:34:56 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        sean.wang@mediatek.com, Landen.Chao@mediatek.com,
        linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, mw@semihalf.com,
        jaz@semihalf.com, tn@semihalf.com, Samer.El-Haj-Mahmoud@arm.com
Subject: [net-next: PATCH v4 0/8] DSA: switch to fwnode_/device_
Date:   Mon, 16 Jan 2023 18:34:12 +0100
Message-Id: <20230116173420.1278704-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

After a longer while this is a re-spin of the DSA migration
to fwnode_/device_ API.
It addresses all comments from the previous iteration - the
details are summarized in the changelog section below.
For reference, here is the discussion under v3.
https://lore.kernel.org/netdev/20220727064321.2953971-1-mw@semihalf.com/t/

The ultimate goal of these changes is to prepare the DSA to use ACPI in
future, which works locally on my branches [1][2], however, this part
needs to be handled separately on the lists, as discussed in v1.

The patchset is based and tested on top of
pure net-next/main branch. Each commit was checked on:
* On EspressoBIN
* On SolidRun CN913x CEx7 Eval Board 

Any comments or remarks will be appreciated.

Best regards,
Marcin

[1] https://github.com/semihalf-wojtas-marcin/Linux-Kernel/commits/dsa-acpi-dev
[2] https://github.com/semihalf-wojtas-marcin/edk2-platforms/commits/dsa-acpi-v2

Changelog v3 -> v4:
1/8:
  * Improve commit message.

2/8:
  * Improve handling the old 'fixed-link' binding in
    fwnode_phy_is_fixed_link()
  * Stop shadowing the real error codes in fwnode_phy_register_fixed_link()

3/8 
  * Make "label" property optional again
  * Fix mt7530 compile error reported by kernel test robot <lkp@intel.com>
  * Simplify code update in mv88e6xxx

4/8
  * Improve commit message

5/8
  * Improve commit message

7/8
  * Update dev_dbg message

8/8
  * Move fwnode declaration
  * Simplify obtaining match_data 

Changelog v2 -> v3:
1/8:
  * Replace forward declaration s/device_node/fwnode_handle/ in
    include/linux/phy_fixed.h
  * Add Florian's RB

* 3/8:
  * Extend lines width in the commit message.
  * While dropping dp->dn fields in the drivers, switch to
    fwnode_ API in the updated places.

* 5/8:
  * Update routine name to fwnode_find_parent_dev_match()
  * Improve comment section
  * Move the definition adjacent to a group of fwnode
    APIs operating on parents

Changelog v1 -> v2:
1/8
  * Drop unnecessary check in fixed_phy_get_gpiod()
  * Improve line breaking
  * Use device_set_node & dev_fwnode

2/8
  * Switch to fwnode_property_count_u32 and fix comparison
    in if statement.

3/8
  * Drop dn usage entirely and use dp->fwnode only. Update
    all dependent drivers to use to_of_node.
  * Use device_set_node, dev_fwnode & device_get_named_child_node
  * Replace '_of' routines suffix with '_fw'

4/8
  * Use device_set_node

5/8
  * New patch

6/8 
  * Use device_match_fwnode
  * Restore EXPORT_SYMBOL()

7/8
  * Get rid of of_mdiobus_register_device 

8/8
  * Use dev_fwnode in mv88e6xxx_probe 
  * Simplify condition checks in mv88e6xxx_probe as suggested by Andy

Marcin Wojtas (8):
  net: phy: fixed_phy: switch to fwnode_ API
  net: mdio: switch fixed-link PHYs API to fwnode_
  net: dsa: switch to device_/fwnode_ APIs
  net: mvpp2: initialize port fwnode pointer
  device property: introduce fwnode_find_parent_dev_match
  net: core: switch to fwnode_find_net_device_by_node()
  net: mdio: introduce fwnode_mdiobus_register_device()
  net: dsa: mv88e6xxx: switch to device_/fwnode_ APIs

 include/linux/etherdevice.h                     |   1 +
 include/linux/fwnode_mdio.h                     |  22 ++++
 include/linux/of_net.h                          |   6 -
 include/linux/phy_fixed.h                       |   6 +-
 include/linux/property.h                        |   1 +
 include/net/dsa.h                               |   2 +-
 net/dsa/port.h                                  |   4 +-
 drivers/base/property.c                         |  23 ++++
 drivers/net/dsa/mt7530.c                        |   6 +-
 drivers/net/dsa/mv88e6xxx/chip.c                |  57 ++++-----
 drivers/net/dsa/qca/qca8k-8xxx.c                |   2 +-
 drivers/net/dsa/realtek/rtl8365mb.c             |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   2 +-
 drivers/net/mdio/fwnode_mdio.c                  | 125 ++++++++++++++++++++
 drivers/net/mdio/of_mdio.c                      | 112 +-----------------
 drivers/net/phy/fixed_phy.c                     |  39 +++---
 net/core/net-sysfs.c                            |  25 ++--
 net/dsa/dsa.c                                   | 118 +++++++++---------
 net/dsa/port.c                                  |  85 +++++++------
 net/dsa/slave.c                                 |   7 +-
 20 files changed, 341 insertions(+), 304 deletions(-)

-- 
2.29.0

