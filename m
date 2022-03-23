Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499C4E55BE
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Mar 2022 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbiCWP5Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Mar 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245281AbiCWP5X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2022 11:57:23 -0400
Received: from hillosipuli.retiisi.eu (retiisi.eu [95.216.213.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE4B7A9AB;
        Wed, 23 Mar 2022 08:55:53 -0700 (PDT)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 5CD82634C93;
        Wed, 23 Mar 2022 17:49:47 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 2/4] ACPI: property: Move acpi_fwnode_device_get_match_data() up
Date:   Wed, 23 Mar 2022 17:47:35 +0200
Message-Id: <20220323154737.169483-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
References: <20220323154737.169483-1-sakari.ailus@linux.intel.com>
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

Move acpi_fwnode_device_get_match_data() up below
acpi_fwnode_device_is_available() so the order matches that in struct
fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1541b318ba46..75dc22c117a5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1253,6 +1253,13 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }
 
+static const void *
+acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
+				  const struct device *dev)
+{
+	return acpi_device_get_match_data(dev);
+}
+
 static bool acpi_fwnode_device_dma_supported(const struct fwnode_handle *fwnode)
 {
 	return acpi_dma_supported(to_acpi_device_node(fwnode));
@@ -1384,13 +1391,6 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static const void *
-acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
-				  const struct device *dev)
-{
-	return acpi_device_get_match_data(dev);
-}
-
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
-- 
2.30.2

