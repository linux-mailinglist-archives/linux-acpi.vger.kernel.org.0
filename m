Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840951D85C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392141AbiEFNCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356442AbiEFNCP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:02:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CF6338E
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841912; x=1683377912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+u3D5272MmR3cXbcceeLW6iNFLPmVc+zRjoajCHDgI=;
  b=mivn6oJZ7ZEWDybbi3e1gTqVruUW/mkaRpzYkyXwdAHeMVNDVdfctGl7
   vNomLQ19r1g3WnuqNwn5ieJ079khyV6+bK5Gegm6fh35VcfwepTJe83n0
   H14YOH6ON8aPW9rf9E0iPYnr6sXOF3X8+ct1JLy+VcJ7U/99O1MA9i1ze
   o4tRI9dM+anls4Og0EAOaxOfjWlmlDCTfyVTWI92EQGnkqqIEliQeq3L8
   dSG7KrqrPFwDP4xtonkFtlqKs1V9PQL+Awh+0HlM/tcOI5uHIJ4ku3Bur
   8zZnMSW90JRnIkGn1DvEL9m8qp13hxS1nGFNi1lfUQ4Kg0lQTBh1QJfh0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266051605"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266051605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695169231"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:58:30 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id B008020BC8;
        Fri,  6 May 2022 15:58:28 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1nmxZJ-00480U-AE; Fri, 06 May 2022 16:00:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH 03/11] ACPI: property: Tie data nodes to acpi handles
Date:   Fri,  6 May 2022 16:00:17 +0300
Message-Id: <20220506130025.984026-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

