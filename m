Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF39631F32E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Feb 2021 00:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhBRXuc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Feb 2021 18:50:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:26836 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhBRXua (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:50:30 -0500
IronPort-SDR: VN+xaZBqUv6dXGpZQVZG17LIK1ENouyOVocFntgmUKZVPpBFCH93UD7wQCt+He6+LOsiBsiq5N
 Mts1Z9lFXhVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="163462498"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="163462498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 15:49:50 -0800
IronPort-SDR: nFkoHG3HO5RG8A8XSl4qOqMdpNmI4Vpaev6UL1rdXhIvU9TDgsmfi+uhClQQ1DFka5DLykvkTv
 Jqh+7qN7uoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367723367"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2021 15:49:49 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 2/2] ACPICA: Remove some code duplication from acpi_ev_address_space_dispatch
Date:   Thu, 18 Feb 2021 15:17:08 -0800
Message-Id: <20210218231708.1143640-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210218231708.1143640-1-erik.kaneda@intel.com>
References: <20210218231708.1143640-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

ACPICA commit 383f50ff8cb7424ca16a6c0234f103b41d4a783e

The handling of the space_id == ACPI_ADR_SPACE_GSBUS and
space_id == ACPI_ADR_SPACE_GPIO cases is almost identical,
fold the 2 cases into 1 to remove some code duplication.

Link: https://github.com/acpica/acpica/commit/383f50ff
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/evregion.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 2a3c13e97555..4ef43c8ef5e7 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -244,7 +244,8 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 	 *      the previous Connection)
 	 *   2) bit_width is the actual bit length of the field (number of pins)
 	 */
-	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS) &&
+	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GSBUS ||
+	     region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
 	    context && field_obj) {
 
 		status =
@@ -260,25 +261,11 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 		context->connection = field_obj->field.resource_buffer;
 		context->length = field_obj->field.resource_length;
 		context->access_length = field_obj->field.access_length;
-	}
-	if ((region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) &&
-	    context && field_obj) {
 
-		status =
-		    acpi_os_acquire_mutex(context_mutex, ACPI_WAIT_FOREVER);
-		if (ACPI_FAILURE(status)) {
-			goto re_enter_interpreter;
+		if (region_obj->region.space_id == ACPI_ADR_SPACE_GPIO) {
+			address = field_obj->field.pin_number_index;
+			bit_width = field_obj->field.bit_length;
 		}
-
-		context_locked = TRUE;
-
-		/* Get the Connection (resource_template) buffer */
-
-		context->connection = field_obj->field.resource_buffer;
-		context->length = field_obj->field.resource_length;
-		context->access_length = field_obj->field.access_length;
-		address = field_obj->field.pin_number_index;
-		bit_width = field_obj->field.bit_length;
 	}
 
 	/* Call the handler */
-- 
2.29.2

