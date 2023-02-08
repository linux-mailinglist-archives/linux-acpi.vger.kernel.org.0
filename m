Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030268F9BC
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBHV2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 16:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjBHV17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 16:27:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481B01E9E6;
        Wed,  8 Feb 2023 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675891678; x=1707427678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oneykZrR+STVd3OhHwvigHCRETDt1//PquS0qMtfgRY=;
  b=DwDShrRRpt8DM8S1ddGJtTuXS3gz38V017pJfj4KSsw331XmYy+EB/2S
   i0qU7c+Ya7yrwNY+oXM1ZuTzbWYNptCCpXfL42MPM1T1Kz/8Vg2k1Lzoj
   o+RxXpk2TGHo77J9Fzo/v+grasaKWN5LA3TLYRAT4Vdpk/FmwFp/nlEY0
   8OQspJX1GBfr48rR5pnWFIp7jExmgJkvfXawWuZb3s3JgjaQ2CmRfhejH
   IJuvbjlYdEL7MKWrjtQ4porB87FT6Yr+h8kNJ8gF/ilzhE7XNpXkxjHjO
   eqFlSoV531A4CNMZQojDiuF/GqXepy3RJ2mVJH6kwgWdtJxMpWJO52kHd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327625785"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="327625785"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667394089"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667394089"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:27:54 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id D27CB12288B;
        Wed,  8 Feb 2023 23:27:47 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1pPryM-00DMZS-UC; Wed, 08 Feb 2023 23:27:22 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: [PATCH v5 7/8] ACPI: property: Skip MIPI property table without "mipi-img" prefix
Date:   Wed,  8 Feb 2023 23:27:11 +0200
Message-Id: <20230208212712.3184953-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
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
index 258a2b351dcf3..62e8f3c6006d7 100644
--- a/drivers/acpi/mipi.c
+++ b/drivers/acpi/mipi.c
@@ -730,6 +730,8 @@ void acpi_init_swnodes(struct acpi_device *device)
 	primary->secondary = software_node_fwnode(ads->nodes);
 }
 
+#define MIPI_IMG_PREFIX "mipi-img-"
+
 static const struct mipi_disco_prop {
 	const char *mipi_prop;
 	const char *dt_prop;
@@ -756,6 +758,9 @@ void acpi_properties_prepare_mipi(union acpi_object *elements)
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

