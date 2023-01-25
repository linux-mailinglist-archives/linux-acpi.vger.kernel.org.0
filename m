Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15367C00B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 23:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAYWl0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 17:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjAYWlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 17:41:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66001611CD;
        Wed, 25 Jan 2023 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686483; x=1706222483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGvJ4YHtweo6deHWDxmYVbRg6bnjeZLfNRz/TFDhCwc=;
  b=jKvD2g8UcEasMkbgm0Y7Wmt9PvHNJTUvD1Ar5+k/BLWDNIGb9Tpt0OuV
   IdwkBAuzam8vWuOFamrORuEAbFLb+KsHMrqsSjA6GPdm2DTYFqEI+aQwU
   xtRB1KFPkZB4l5LCE0X2N9mNanMd/HzrezaRjzn1QXxwDuGoEFzkQb+RA
   0DJ2i9RE2C5LnpW00XaeAVG42Xkgj4sIq9C13hXdFTgD/IETZuz7EADq4
   ubG593en90uoEpdUYzD4IyYeQZqhe4P/yzj9iYp//92BRB0DNpHc+NzBv
   egl/6DulGysqL5NTrTEFXLsHYd5V4zHbl+R+xTpWLxUOpCdR+mq5mUOa1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326727207"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326727207"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="662646445"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="662646445"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:41:21 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 61639122749;
        Thu, 26 Jan 2023 00:41:14 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pKoS7-001gPa-CU; Thu, 26 Jan 2023 00:41:11 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v3 7/8] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Thu, 26 Jan 2023 00:41:00 +0200
Message-Id: <20230125224101.401285-8-sakari.ailus@linux.intel.com>
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

For all _DSD properties, skip going through the MIPI DisCo for Imaging
property name substitution table if the property doesn't have "mipi-img-"
prefix.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/mipi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
index 4211b53b41682..17fcc0417e27d 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -688,6 +688,8 @@ void acpi_init_swnodes(struct acpi_device *device)
 	primary->secondary = software_node_fwnode(ads->nodes);
 }
 
+#define MIPI_IMG_PREFIX "mipi-img-"
+
 static const struct mipi_disco_prop {
 	const char *mipi_prop;
 	const char *dt_prop;
@@ -713,6 +715,9 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
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

