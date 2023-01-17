Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD166DD6D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjAQMWZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjAQMWU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30A2B297;
        Tue, 17 Jan 2023 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958140; x=1705494140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NKpBwl2Zc7SvCzkgs3bIn5JXfGjCH7WGccSr7o72C24=;
  b=EwAnTEiqwOjrxWaPYqvQRvNPyOgUsqu6kjuYPyBwkYwA3P0cY/r8vs12
   mcCe7LdHATgFIEnc5lW6q+4d/GxMf2Z2lJTesdRxKauH24ZsytoQb0f5T
   MSbGLpFTHmYPLg0onfJp3mQhck5xyKfBwW7rVIv8gEVIrqLrmJQtPJ29/
   DGVUftOXnFy9Zq0eVdJTza6Y2gpw466ffOFLeUDHxC3ZGxhJDN2BAvJqk
   agAqrrVkhy1dW5ZwPVSZkA2IY8BI1cemkITMvh3cw4e4ZboAEG4m0Skdx
   LHHkC5yVgaqRI7J1n+Z4AcCyW3Tpcjtk0s3L1yY9ZXiPzcCr2gWke2/U+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920118"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772045"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772045"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 27E3E20B97;
        Tue, 17 Jan 2023 14:22:12 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgVU-UO; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 8/8] ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support
Date:   Tue, 17 Jan 2023 14:22:44 +0200
Message-Id: <20230117122244.2546597-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
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
index 840f565b1906f..f20851400c041 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -3,6 +3,43 @@
  * MIPI DisCo for Imaging support.
  *
  * Copyright (C) 2022 Intel Corporation
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

