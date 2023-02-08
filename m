Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7568F208
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjBHP3Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjBHP3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:29:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F0474D0;
        Wed,  8 Feb 2023 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675870134; x=1707406134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CipHrOB+YMxuY6TpmJaPS6wUxtwPrKBPiGWZvgQhGs=;
  b=befQ29k9gLoWyms7MKhjbJb12pbPtwDKnP62dJeQYd1fuUr53ezI1XKd
   SLkJHteAvT4fwMoHLod7c6gm4++sdKDCFs31UnLUkQbUdHR6Pw41Sw4HS
   +ZjUU/A19S/Jm+gGzwIS4v/dY5TIBTxTnSac5j1dRtLE1bTi3pZCQ+0oV
   bNo4gvASzw08hNdPYsVAKaHLGZoTEhCaPIf6KN86xt5BqizFLBbz6cjyp
   zwZ5Utmnn+DAgPdBcT3I4PAAbgLwigShAyMPQnDHJs8bQdAwqEpO2SNIl
   hjFlMNLSAVHiK9roKJrG1Bv7zxegUvAOTWt2HJGQZ3VnyGmDYqF6C4zv7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="310182303"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="310182303"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="617237849"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="617237849"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:28:49 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 1955112243F;
        Wed,  8 Feb 2023 17:28:42 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPmMr-00CrAV-IY; Wed, 08 Feb 2023 17:28:17 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v4 7/8] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Wed,  8 Feb 2023 17:28:06 +0200
Message-Id: <20230208152807.3064242-8-sakari.ailus@linux.intel.com>
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

For all _DSD properties, skip going through the MIPI DisCo for Imaging
property name substitution table if the property doesn't have "mipi-img-"
prefix.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index a0d0d539ab1f0..7d35351553cc7 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -726,6 +726,8 @@ void acpi_init_swnodes(struct acpi_device *device)
 	primary->secondary = software_node_fwnode(ads->nodes);
 }
 
+#define MIPI_IMG_PREFIX "mipi-img-"
+
 static const struct mipi_disco_prop {
 	const char *mipi_prop;
 	const char *dt_prop;
@@ -751,6 +753,9 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
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

