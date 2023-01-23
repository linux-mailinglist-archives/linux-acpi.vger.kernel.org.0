Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AE677CF9
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAWNsY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 08:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjAWNsS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 08:48:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046E6195;
        Mon, 23 Jan 2023 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674481669; x=1706017669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w0UfttjcJxSi2il/R2rCa7OUQMUniQXCcAEUvtujrp0=;
  b=ljNsQVJI86ofGxa1jq1bHRh5FIn1UnpMMN+CXcTx40zWneNoW/LnSS/e
   AYRBFvHSoa2nL5NvATr8r9SL/j4KPDmIhZC/Aix7gQFiXt2+2eik6rW12
   qFTXAuFxxul6CplJsF5jHsx6Aq9BNmGnpiT/vvQ8ks9bfdhCi+p8tqbAz
   SGNicU+emBLUCEanuzq1nwR9J6wzftzI+JSh+KCHiRV+qYmE5Loi1ypNw
   T5wVlbPCAf8CnvFT8xPBgZ1LHZkrw2Q0f5qh1Ea6oHwB9Yh2fdboEdjPJ
   CEFZG9CRjtZbtMekTAwNny1v/CRulqITw3MvRzRoRE5KUKmtRR3A+yEUs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390542179"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390542179"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785601931"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="785601931"
Received: from turnipsi.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 05:46:40 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id CC86B20D7E;
        Mon, 23 Jan 2023 15:46:33 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pJx9Y-00173b-4o; Mon, 23 Jan 2023 15:46:28 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v2 7/8] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Mon, 23 Jan 2023 15:46:16 +0200
Message-Id: <20230123134617.265382-8-sakari.ailus@linux.intel.com>
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

For all _DSD properties, skip going through the MIPI DisCo for Imaging
property name substitution table if the property doesn't have "mipi-img-"
prefix.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 9177170952104..3cb698b094ac1 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -681,16 +681,18 @@ void acpi_init_swnodes(struct acpi_device *device)
 	device->fwnode.secondary = software_node_fwnode(ads->nodes);
 }
 
+#define MIPI_IMG_PREFIX "mipi-img-"
+
 static const struct mipi_disco_prop {
 	const char *mipi_prop;
 	const char *dt_prop;
 } mipi_disco_props[] = {
-	{ "mipi-img-lens-focus", "lens-focus" },
-	{ "mipi-img-flash-leds", "flash-leds" },
-	{ "mipi-img-clock-frequency", "clock-frequency" },
-	{ "mipi-img-led-max-current", "led-max-microamp" },
-	{ "mipi-img-flash-max-current", "flash-max-microamp" },
-	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
+	{ MIPI_IMG_PREFIX "lens-focus", "lens-focus" },
+	{ MIPI_IMG_PREFIX "flash-leds", "flash-leds" },
+	{ MIPI_IMG_PREFIX "clock-frequency", "clock-frequency" },
+	{ MIPI_IMG_PREFIX "led-max-current", "led-max-microamp" },
+	{ MIPI_IMG_PREFIX "flash-max-current", "flash-max-microamp" },
+	{ MIPI_IMG_PREFIX "flash-max-timeout", "flash-max-timeout-us" },
 };
 
 /**
@@ -706,6 +708,9 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
 {
 	unsigned int i;
 
+	if (!str_has_prefix(elements[0].string.pointer, MIPI_IMG_PREFIX))
+		return;
+
 	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
 	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
 		if (!strcmp(mipi_disco_props[i].mipi_prop,
-- 
2.30.2

