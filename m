Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B7443588
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhKBS2v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 14:28:51 -0400
Received: from foss.arm.com ([217.140.110.172]:41712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235070AbhKBS2s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Nov 2021 14:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA73B11D4;
        Tue,  2 Nov 2021 11:26:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 112C83F7B4;
        Tue,  2 Nov 2021 11:26:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robert Moore <robert.moore@intel.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH 2/3] ACPICA: Add support for PCC Opregion special context data
Date:   Tue,  2 Nov 2021 18:25:41 +0000
Message-Id: <20211102182542.3460787-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102182542.3460787-1-sudeep.holla@arm.com>
References: <20211102182542.3460787-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PCC Opregion added in ACPIC 6.3 requires special context data similar
to GPIO and Generic Serial Bus as it needs to know the internal PCC
buffer and its length as well as the PCC channel index when the opregion
handler is being executed by the OSPM.

Lets add support for the special context data needed by PCC Opregion.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpica/evregion.c | 11 +++++++++++
 include/acpi/actypes.h         |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 4ef43c8ef5e7..963cdf83372a 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -162,6 +162,17 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
+		if (region_obj->region.space_id ==
+						ACPI_ADR_SPACE_PLATFORM_COMM) {
+			struct acpi_pcc_info *ctx =
+					handler_desc->address_space.context;
+
+			ctx->internal_buffer =
+					field_obj->field.internal_pcc_buffer;
+			ctx->length = region_obj->region.length;
+			ctx->subspace_id = region_obj->region.address;
+		}
+
 		/*
 		 * We must exit the interpreter because the region setup will
 		 * potentially execute control methods (for example, the _REG method
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 92c71dfce0d5..ac2eb334f61b 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1098,6 +1098,14 @@ struct acpi_connection_info {
 	u8 access_length;
 };
 
+/* Special Context data for PCC Opregion (ACPI 6.3) */
+
+struct acpi_pcc_info {
+	u8 subspace_id;
+	u16 length;
+	u8 *internal_buffer;
+};
+
 typedef
 acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
 				     u32 function,
-- 
2.25.1

