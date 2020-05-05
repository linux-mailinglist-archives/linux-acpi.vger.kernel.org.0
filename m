Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0761C4B43
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEEBIh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:50715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgEEBIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:37 -0400
IronPort-SDR: RPawIuUOtUd5DCO/I6FuhcwwgUih4mxwrEvBELC3zrtMJdM9d9TRCf7PkMqk6tiwFWjiSxoOJ0
 U/5uwYvqwxnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:36 -0700
IronPort-SDR: NqFfZlHdvrOoFZepdc2x8Dkw3+QlRBAAgP5faAbGs0xXDb0RYaVnpGZ8AQ3rAJSvooDmqX8CeF
 rj9OG6yDLA3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865798"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Kurt Kennett <kurt_kennett@hotmail.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/6] ACPICA: Dispatcher: add status checks
Date:   Mon,  4 May 2020 17:46:52 -0700
Message-Id: <20200505004654.2870591-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The status chekcs are used to to avoid NULL pointer dereference on
field objects

ACPICA commit 3244c1eeba9f9fb9ccedb875f7923a3d85e0c6aa

Link: https://github.com/acpica/acpica/commit/3244c1ee
Reported-by: Kurt Kennett <kurt_kennett@hotmail.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 0189b5d4e3a3..fa768b3a989e 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -517,13 +517,20 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	info.region_node = region_node;
 
 	status = acpi_ds_get_field_names(&info, walk_state, arg->common.next);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	if (info.region_node->object->region.space_id ==
-	    ACPI_ADR_SPACE_PLATFORM_COMM
-	    && !(region_node->object->field.internal_pcc_buffer =
-		 ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
-				      length))) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
+	    ACPI_ADR_SPACE_PLATFORM_COMM) {
+		region_node->object->field.internal_pcc_buffer =
+		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
+					 length);
+		if (!region_node->object->field.internal_pcc_buffer) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
 	}
+
 	return_ACPI_STATUS(status);
 }
 
-- 
2.25.1

