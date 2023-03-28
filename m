Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187276CBC46
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC1KOY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjC1KOG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 06:14:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF1729D;
        Tue, 28 Mar 2023 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998439; x=1711534439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hkNgIaP0g/C3BTjHNqyHJHmBw3OxqK9Z0QZNFnAGY0=;
  b=JUT8q/pl8fFXK5+vG4FKFtautPbwpS+wK7R0vGGMNW8WTxufdO6EZYp1
   pCToDYSn0lfT4hfKCoyY8Vo/13qhj7Ad1Qvtm/hMy6H0tEgAezExoTpOH
   OFLKnwEhKJFuLI1GntKtgpMOmZeopsrTA7/6RgevSfZWHC5Ig7k548m6K
   djFRCgth0KIHV/tJjtBf4smUJD0T6UtNRn0Qvl3sPw7Svc6LCxhZ76kkU
   W3VNWvF4asfAFhQtf6UrPL8+fLFZiBIQK2U3RfpvMNAUcXR933+SgQDFC
   mxj8DWjZaBTTKfm7ONpVvJyHu9ZN+3g3orfo0rlNGFmsgsk3wLxFzjXI0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328985358"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="328985358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827432725"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827432725"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:13:16 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 9429812243C;
        Tue, 28 Mar 2023 13:13:13 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v7 09/10] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Tue, 28 Mar 2023 13:13:02 +0300
Message-Id: <20230328101303.1458570-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For all _DSD properties, skip going through the MIPI DisCo for Imaging
property name substitution table if the property doesn't have "mipi-img-"
prefix.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index fcbef3677558..ae6bdc487363 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -717,6 +717,8 @@ void acpi_init_swnodes(struct acpi_device *device)
 	primary->secondary = software_node_fwnode(ads->nodes);
 }
 
+#define MIPI_IMG_PREFIX "mipi-img-"
+
 static const struct mipi_disco_prop {
 	const char *mipi_prop;
 	const char *dt_prop;
@@ -743,6 +745,9 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
 	char *e0 = elements[0].string.pointer;
 	unsigned int i;
 
+	if (!str_has_prefix(elements[0].string.pointer, MIPI_IMG_PREFIX))
+		return;
+
 	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
 	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
 		if (!strcmp(mipi_disco_props[i].mipi_prop, e0)) {
-- 
2.30.2

