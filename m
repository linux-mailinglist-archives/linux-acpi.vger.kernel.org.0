Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C904AAE91
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Feb 2022 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiBFJ0Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Feb 2022 04:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiBFJ0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Feb 2022 04:26:15 -0500
Received: from hillosipuli.retiisi.eu (retiisi.eu [95.216.213.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F4C06109E;
        Sun,  6 Feb 2022 01:26:14 -0800 (PST)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::e1:3])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id E140E634C90;
        Sun,  6 Feb 2022 11:18:19 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 0/4] Shovel firmware specific code to appropriate locations
Date:   Sun,  6 Feb 2022 11:16:39 +0200
Message-Id: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi folks,

This set moves the implementation of recently added device property API
functions to OF and ACPI frameworks, where the rest of such functionality
resides.

Compile tested.

Note that after some initial confusion, this set actually does depend on
Andy's patch "device property: Don't split fwnode_get_irq*() APIs in the
code" to appear in the linux-acpi tree.

Sakari Ailus (4):
  device property: Convert device_{dma_supported,get_dma_attr} to fwnode
  ACPI: property: Move acpi_fwnode_device_get_match_data() up
  device property: Add iomap to fwnode operations
  device property: Add irq_get to fwnode operation

 drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
 drivers/base/property.c | 42 ++++++-----------------------------------
 drivers/of/property.c   | 31 ++++++++++++++++++++++++++++++
 include/linux/fwnode.h  |  5 +++++
 4 files changed, 74 insertions(+), 40 deletions(-)

-- 
2.30.2


