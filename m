Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF468F20A
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjBHP3R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjBHP25 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:28:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE24A1DC;
        Wed,  8 Feb 2023 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870135; x=1707406135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmAzV5Ey0dOlMAkoo1U7iYsjcuexXaLxDHD8ptgue0s=;
  b=aNDzZ0A9sKJmK1BtnzJBa0glKdsWjGENiBUnhMPM/9jGE/sWSJG/z+lu
   0XGTZqqXw3HhHgP2lTGtDG8a6p0jA438x2Vi0rciUrIsRAi9OYEpIsHMc
   nL98u45YxvsZL08UxY+tdE85R/c+lkrEeiTHSsNwXjFN0W41U6xSXyTde
   nDYtLHcq22j4mmoXkvGznj86PRLlRyfSePxjYVWD79HIY/me9dWEw0UQX
   vsQTmGEF7gq7uyeftjhP33e25woBU26s9J9jgqi+NbyKDdnNeNcgNq1C6
   81K0RSUY9aubx06ZpWMJ7/qRQJqw1djhbvhYi3yzkVKlapT8E1jNr2OPx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182305"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237850"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237850"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:49 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 1A50E122463;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAY-Iu; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 8/8] ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support
Date:   Wed,  8 Feb 2023 17:28:07 +0200
Message-Id: <20230208152807.3064242-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 7d35351553cc7..b944ae7646a8f 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -3,6 +3,43 @@
  * MIPI DisCo for Imaging support.
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

