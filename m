Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0366DD6E
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 13:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjAQMW0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 07:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjAQMWU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 07:22:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839FC3253F;
        Tue, 17 Jan 2023 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673958139; x=1705494139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0wsDAlznAxVzy0N03kzsPUdve6FSq9whygJ1bNbbiDM=;
  b=YVqzncnJfL6LhwTs9/ksMJmYzM+Zff/G0T1WKJzzteB1wRVaUs4lDxKh
   FJAQrmOOn/5BB4snxMux/DZPTB5ATljGaapZDmpfXO1Oda9Ei0lVzdGHs
   HRgEuB+gafDTOiBKZht+YKykVL/R5M68kmYyVCFtMflCFuP0+SuP7rZLQ
   83mvvMpPbZnJUApP9Dcqsmdq0RttQwzjVS/El+0RhJG4GQghi3LtROegf
   XuPB63aIPyJ4giKB+psrFdsXRDu9LsKz08CBiJbmPF43+ql9mQ7VkPZYA
   Cc2BxF3EcN7RJCyPZNsTKMqNWOZqH9v51uef1MVleJrvsvNZuycnhnXqg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410920116"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410920116"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="727772044"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="727772044"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:22:17 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1D8B120B78;
        Tue, 17 Jan 2023 14:22:12 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pHkzE-00AgVQ-Sz; Tue, 17 Jan 2023 14:22:44 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH 7/8] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Tue, 17 Jan 2023 14:22:43 +0200
Message-Id: <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
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

For all _DSD properties, skip going through the MIPI DisCo for Imaging
property name substitution table if the property doesn't have "mipi-img-"
prefix.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 2174e03a2eafd..840f565b1906f 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -688,16 +688,18 @@ void acpi_init_swnodes(struct acpi_device *device)
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
@@ -713,6 +715,10 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
 {
 	unsigned int i;
 
+	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
+		   sizeof(MIPI_IMG_PREFIX) - 1))
+		return;
+
 	/* Replace MIPI DisCo for Imaging property names with DT equivalents. */
 	for (i = 0; i < ARRAY_SIZE(mipi_disco_props); i++) {
 		if (!strcmp(mipi_disco_props[i].mipi_prop,
-- 
2.30.2

