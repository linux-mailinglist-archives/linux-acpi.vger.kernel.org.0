Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3276D677CF5
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 14:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjAWNsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 08:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjAWNrx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 08:47:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1ED26863;
        Mon, 23 Jan 2023 05:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674481650; x=1706017650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxz6Qmb9JJgDkMLpiIA7nHvUeKSoY4Ii0gk0EloM5/g=;
  b=MtUcIhTc8QSM9ukEq4xxsBv9afp/obxB3T/U2d4Ra3RakwMtzQy/s/rE
   R5L/GMT01nmTT3j7YN84tjgNnQu7XsYsiadwN1HexjsEMKVlU4zPWAOeE
   IJ0ZuJtSgRg3ZZvW6U5ZaQkznGiaH+CAT6HnPNiDkX9UlPb5OHQLGmaQT
   NvUtR2SWqzDH2gIf/fQZTZHX0OsQFwoRiH0UX0f6l+6XX6wB3gh8Mwap/
   4TWVFeDaxq0xE/rRdv4a9khc5xKZ9/CNCztfN9VCtWxBsuzTEe7ce8PkW
   /8Or/ICAQTAwH9TjKCzV8djVBOaOW36uR76U42RavM9j/TuYG/rnNw2Gv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390542177"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390542177"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785601929"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="785601929"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:40 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id CF2F120DD5;
        Mon, 23 Jan 2023 15:46:33 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pJx9Y-00173e-5g; Mon, 23 Jan 2023 15:46:28 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v2 8/8] ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support
Date:   Mon, 23 Jan 2023 15:46:17 +0200
Message-Id: <20230123134617.265382-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
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
index 3cb698b094ac1..24cef9d501ebc 100644
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

