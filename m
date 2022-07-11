Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95E5700C4
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jul 2022 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiGKLhR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jul 2022 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGKLgy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jul 2022 07:36:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469418CC88
        for <linux-acpi@vger.kernel.org>; Mon, 11 Jul 2022 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657538654; x=1689074654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dgHYjxjaZ22vidNEa9JBIfWnldQrAuv7O6HrKbbOWWs=;
  b=UDWc8U6pJ7JaqKLj0Wy7Qa6lVvpboeYkqtpNbAhVRBs0owr5z4py8CzZ
   CA63jwEafDILQh5SI2cZ/gw0bbRn9GXyktwC4aGqIm4LRgT43bbpcSyRm
   RhxrUWNOzrzDiuEFME+pw4aMH/WB5VbzP6hEL++bhRXRngH9QXvK9/B0F
   j4ZgMKr+MpXNenDiXfjpyEsNcQk4uBTGcd92z0yMuWUf+0ax6PZWelqez
   c9TA7kku2pYVWH71UcoY1Suz3K+W5HXeviDS0+dn4iRgOLYYRCgO+mxW+
   szCgS/921Ubhw+k+bJVOeodJw5djJFF5z+dbVZpBLhODxYexEjGcpY0XB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310239433"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310239433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="592221522"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 04:23:59 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id E445E20861;
        Mon, 11 Jul 2022 14:23:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oArYE-00CnYU-9z; Mon, 11 Jul 2022 14:26:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v4 2/8] ACPI: property: Tie data nodes to acpi handles
Date:   Mon, 11 Jul 2022 14:26:00 +0300
Message-Id: <20220711112606.3050368-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA allows associating additional information (i.e. pointers with
specific tag) to acpi_handles. The acpi_device's are associated to
acpi_handle's in acpi_tie_acpi_dev() in scan.c, do the same here for the
_DSD data nodes.

This allows direct data node references in properties, implemented later on
in the series.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 42 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 6d698f3f83a0a..08b5292d2f89b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -340,6 +340,43 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 	return props;
 }
 
+static void acpi_nondev_subnode_tag(acpi_handle handle, void *context)
+{
+}
+
+static void acpi_untie_nondev_subnodes(struct acpi_device_data *data)
+{
+	struct acpi_data_node *dn;
+
+	list_for_each_entry(dn, &data->subnodes, sibling) {
+		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
+
+		acpi_untie_nondev_subnodes(&dn->data);
+	}
+}
+
+static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
+{
+	struct acpi_data_node *dn;
+
+	list_for_each_entry(dn, &data->subnodes, sibling) {
+		acpi_status status;
+		bool ret;
+
+		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_err(dn->handle, "Can't tag data node\n");
+			return false;
+		}
+
+		ret = acpi_tie_nondev_subnodes(&dn->data);
+		if (!ret)
+			return ret;
+	}
+
+	return true;
+}
+
 static bool acpi_extract_properties(const union acpi_object *desc,
 				    struct acpi_device_data *data)
 {
@@ -419,7 +456,9 @@ void acpi_init_properties(struct acpi_device *adev)
 					&adev->data, acpi_fwnode_handle(adev)))
 		adev->data.pointer = buf.pointer;
 
-	if (!adev->data.pointer) {
+	if (!adev->data.pointer ||
+	    !acpi_tie_nondev_subnodes(&adev->data)) {
+		acpi_untie_nondev_subnodes(&adev->data);
 		acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
 		ACPI_FREE(buf.pointer);
 	}
@@ -462,6 +501,7 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
 
 void acpi_free_properties(struct acpi_device *adev)
 {
+	acpi_untie_nondev_subnodes(&adev->data);
 	acpi_destroy_nondev_subnodes(&adev->data.subnodes);
 	ACPI_FREE((void *)adev->data.pointer);
 	adev->data.of_compatible = NULL;
-- 
2.30.2

