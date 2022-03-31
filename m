Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B114ED9FC
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Mar 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiCaM67 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Mar 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiCaM67 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Mar 2022 08:58:59 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996D213516;
        Thu, 31 Mar 2022 05:57:09 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 02A35634C91;
        Thu, 31 Mar 2022 15:57:04 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 0/4] Shovel firmware specific code to appropriate locations
Date:   Thu, 31 Mar 2022 15:54:46 +0300
Message-Id: <20220331125450.218045-1-sakari.ailus@linux.intel.com>
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

since v2:

- Add pre-processor check for CONFIG_OF_ADDRESS in of_fwnode_iomap() (3rd
  patch).

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
 drivers/of/property.c   | 34 +++++++++++++++++++++++++++++++++
 include/linux/fwnode.h  |  5 +++++
 4 files changed, 77 insertions(+), 40 deletions(-)


base-commit: b2638e56c2ced2ca258d22f939c47327b189e00c
-- 
2.30.2

