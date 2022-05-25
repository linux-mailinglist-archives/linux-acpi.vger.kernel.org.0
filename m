Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8C533D19
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiEYNBG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiEYNBD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 09:01:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D40A5AA0
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483661; x=1685019661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+u3D5272MmR3cXbcceeLW6iNFLPmVc+zRjoajCHDgI=;
  b=Z/02fRTNyQhWasjpaYSKBoRiJ4/qKk/nRgkjCtKMUcfYltGbW1MbxeZo
   zloUPu0dA0XxPH46AecNIv0BDiHQlvZVunxG0CuWeC/SqHOTdjA+VgmNB
   pQf46pZlH1HVkb9QwV9a7OJWX4VGXdk77Z+9CBiTvEL6RACn474RVIMZ2
   UC+AwvCAf3D6WiVk2K+jaa7mM27PHcnnpzZY6X0MjlPd7MqjEGtWu2a1t
   vZ6O+xGnCFfcgNjL8El34EZmPoerAK/FLvsOamn8tWdShhaBWaz3jakwE
   vzeHcScFZ1VIIJLZQ9CrMwAWvXSZ3GWei6Rm/+90Bag5WqpastKa4ZG4Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255868667"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255868667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:01:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601894138"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:00:59 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 860172073E;
        Wed, 25 May 2022 16:00:57 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1ntqdf-003Dea-Db; Wed, 25 May 2022 16:01:23 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
Date:   Wed, 25 May 2022 16:01:17 +0300
Message-Id: <20220525130123.767410-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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
index bc9a645f8bb77..f8c83ee6c8d59 100644
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
+static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
+{
+	struct acpi_data_node *dn;
+
+	list_for_each_entry(dn, &data->subnodes, sibling) {
+		acpi_status status;
+		int ret;
+
+		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_err(dn->handle, "Can't tag data node\n");
+			return 0;
+		}
+
+		ret = acpi_tie_nondev_subnodes(&dn->data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
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
+	    acpi_tie_nondev_subnodes(&adev->data) < 0) {
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

