Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF54E55BD
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbiCWP5Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245278AbiCWP5W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 11:57:22 -0400
Received: from hillosipuli.retiisi.eu (retiisi.eu [95.216.213.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E47A9AD;
        Wed, 23 Mar 2022 08:55:53 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 2D2C4634C90;
        Wed, 23 Mar 2022 17:49:47 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 0/4] Shovel firmware specific code to appropriate locations
Date:   Wed, 23 Mar 2022 17:47:33 +0200
Message-Id: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
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

The dependencies can be found in Rafael's devprop branch now.

changes since v1:

- Drop wrongly placed Depends-on: tag from the first patch.

- Drop IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode) check (3rd
  patch).

Sakari Ailus (4):
  device property: Convert device_{dma_supported,get_dma_attr} to fwnode
  ACPI: property: Move acpi_fwnode_device_get_match_data() up
  device property: Add iomap to fwnode operations
  device property: Add irq_get to fwnode operation

 drivers/acpi/property.c | 36 +++++++++++++++++++++++++++++++----
 drivers/base/property.c | 42 ++++++-----------------------------------
 drivers/of/property.c   | 30 +++++++++++++++++++++++++++++
 include/linux/fwnode.h  |  5 +++++
 4 files changed, 73 insertions(+), 40 deletions(-)

-- 
2.30.2

