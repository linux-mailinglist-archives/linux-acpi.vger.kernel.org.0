Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F867C013
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjAYWla (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 17:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjAYWl0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 17:41:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34891611D1;
        Wed, 25 Jan 2023 14:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686485; x=1706222485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcpkaA8znAcXmZvR7D9QW4a1tNOl0+iRgapkzQEW7aw=;
  b=iKa33ICnCpRjcIlFS4HWMr89IN2Cwwlq1xQ2ClSHlp9wr4kFuW/Fw3MQ
   UbOo5sh8R6mvW14enQC8DRlRSPCOL0bcgw3IN9ywrswt3JFzFyv0CrMiC
   3GkzZO4O4jOePGYQb/UwIwRg07i3pyJVsd7ADzc/JBalDdPtPAwRhAavp
   bHuJXwrVLaGRKqs0a/2LvgWeoCGlbUQMHjF7ne+DmW39o0p8rdtkaIn6D
   uLMD7Ho3l1ImwM9N+D4r5evonKp4DtIOnyIopJMAf1rS6dbp2aulfEHoL
   QlpJVZsk1DfqQ94WkVKJx2kOCQyL1oVYmPbWqsvx0batjC+seNFeFYSRE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326727214"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326727214"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="662646448"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="662646448"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:21 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 653FD122758;
        Thu, 26 Jan 2023 00:41:14 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pKoS7-001gPd-D8; Thu, 26 Jan 2023 00:41:11 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v3 8/8] ACPI: property: Document _CRS CSI-2 and DisCo for Imaging support
Date:   Thu, 26 Jan 2023 00:41:01 +0200
Message-Id: <20230125224101.401285-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
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
index 17fcc0417e27d..e87cfb584e39a 100644
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

