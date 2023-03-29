Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F286CD769
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjC2KKj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjC2KKL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 06:10:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0E1BFE;
        Wed, 29 Mar 2023 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680084607; x=1711620607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IfGacDFJLLqr9f6JjzSb6VFnxUdNv5+L5s27tHa+Ivg=;
  b=dKVyXU7aNRHhyklrRWeIQ13EgP4B7jB30AQqYMk5QDrDRX3rjVhpONSl
   90RhbuVQG2vW4d5Iw+7qbut7eXMaVYZ0r4K6njADkoo2dw25j+XpMZx3J
   GnGG5YNHn5Dmg2hHVTvGwCz8fMtS2dBc/BfuTTVyKPzi6AuEqVCmoCHHB
   ynQYTDscpcEBii6SLYNurRoub6jCA6TmekQFhPGxod56C34NQ0JDcmruz
   Y9t3h9tX+WpbrVcVhToMOdmZe6S0i1Yj4vP6cUU0sYyJzwTJKlJrhV8Te
   3vxBbVHkOLj7JQxpJicmwq5WLUoLQfWbm9h20mqU27G0KXXMQo4INu3Jm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="343256269"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343256269"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="773517755"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="773517755"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 03:10:05 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 2E0A8122809;
        Wed, 29 Mar 2023 13:10:02 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v8 10/10] ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support
Date:   Wed, 29 Mar 2023 13:09:51 +0300
Message-Id: <20230329100951.1522322-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Document how ACPI _CRS CSI-2 and DisCo for Imaging works. It's non-trivial
so such documentation can be useful.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 90ad4b43f008..926d39948268 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -9,6 +9,43 @@
  * Also see <URL:https://www.mipi.org/specifications/mipi-disco-imaging>.
  *
  * Copyright (C) 2023 Intel Corporation
+ *
+ * _CRS CSI-2 descriptors, as defined starting from ACPI 6.4 [1], contain
+ * information on cross-device CSI-2 bus configuration. The descriptors are
+ * located under transmitter devices, and the receiver devices have no direct
+ * way to access them even if the information in these descriptors is equally
+ * important for receivers. This information is amended with MIPI DisCo for
+ * Imaging [2] specification that defines _DSD data nodes and properties.
+ *
+ * The support for these is based on two-fold approach, firstly renaming
+ * properties where semantics matches and secondly gathering information to
+ * generate properties using information gathered from various sources. The
+ * former is trivial (see acpi_properties_prepare_mipi() at the end of the
+ * file) whereas the latter requires a more elaborate explanation.
+ *
+ * acpi_bus_scan_crs_csi2() scans an ACPI bus for devices with _CRS CSI-2
+ * descriptors and stores them to a linked list. This is done as traversing just
+ * this list is much smaller task than the entire DSDT. This list is then used
+ * to figure out how much memory is needed for swnodes related to a given ACPI
+ * device (handle). Further on, the same function sets the property values for
+ * the properties the values of which are obtained from the _CRS CSI-2
+ * descriptor. The information is stored into another list where the information
+ * can be looked up based on device's acpi_handle as the struct acpi_device
+ * isn't available yet at this point (and could not, as cross-device references
+ * need to be set up before the devices are available for drivers to probe).
+ *
+ * For each struct acpi_device, acpi_init_swnodes() further obtains information
+ * required to find out the values for the rest of the properties needed by
+ * drivers. This includes all port and endpoint properties as the node
+ * structures used by DT graphs and DisCo for Imaging are different. Finally the
+ * function registers software nodes for the device and sets the secondary
+ * pointer for the ACPI device's fwnode.
+ *
+ * Access to data the structures is serialised using acpi_scan_lock in scan.c.
+ *
+ * [1] https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
+ *
+ * [2] https://www.mipi.org/specifications/mipi-disco-imaging
  */
 
 #include <linux/acpi.h>
-- 
2.30.2

