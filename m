Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2254DDBF
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jun 2022 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiFPJBY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jun 2022 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiFPJBV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2022 05:01:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB038192B5
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 02:01:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0A913D5;
        Thu, 16 Jun 2022 02:01:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F95C3F7F5;
        Thu, 16 Jun 2022 02:01:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/3] ACPICA: Add support for FFH Opregion special context data
Date:   Thu, 16 Jun 2022 10:01:04 +0100
Message-Id: <20220616090106.2154906-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616090106.2154906-1-sudeep.holla@arm.com>
References: <20220616090106.2154906-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

FFH(Fixed Function Hardware) Opregion is approved to be added in ACPIC 6.5 via
code first approach[1]. It requires special context data similar to GPIO and
Generic Serial Bus as it needs to know platform specific offset and length.

Add support for the special context data needed by FFH Opregion.

FFH OpRegion enables advanced use of FFH on some architectures. For example,
it could be used to easily proxy AML code to architecture-specific behavior
(to ensure it is OS initiated)

Actual behavior of FFH is ofcourse architecture specific and depends on
the FFH bindings. The offset and length could have arch specific meaning
or usage.

[1] https://bugzilla.tianocore.org/show_bug.cgi?id=3598

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpica/evregion.c | 8 ++++++++
 drivers/acpi/acpica/exfield.c  | 8 ++++++--
 drivers/acpi/acpica/exserial.c | 6 ++++++
 include/acpi/acconfig.h        | 2 ++
 include/acpi/actypes.h         | 7 +++++++
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index b96b3a7e78e5..d5aed3249630 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -172,6 +172,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			ctx->subspace_id = (u8)region_obj->region.address;
 		}
 
+		if (region_obj->region.space_id ==
+			ACPI_ADR_SPACE_FIXED_HARDWARE) {
+			struct acpi_ffh_info *ctx =
+			    handler_desc->address_space.context;
+
+			ctx->offset = region_obj->region.address;
+			ctx->length = region_obj->region.length;
+		}
 		/*
 		 * We must exit the interpreter because the region setup will
 		 * potentially execute control methods (for example, the _REG method
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 2b89a496de65..657f4002f9dc 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -141,7 +141,9 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_PLATFORM_RT)) {
+		    ACPI_ADR_SPACE_PLATFORM_RT
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_FIXED_HARDWARE)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
@@ -305,7 +307,9 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		    || obj_desc->field.region_obj->region.space_id ==
 		    ACPI_ADR_SPACE_IPMI
 		    || obj_desc->field.region_obj->region.space_id ==
-		    ACPI_ADR_SPACE_PLATFORM_RT)) {
+		    ACPI_ADR_SPACE_PLATFORM_RT
+		    || obj_desc->field.region_obj->region.space_id ==
+		    ACPI_ADR_SPACE_FIXED_HARDWARE)) {
 
 		/* SMBus, GSBus, IPMI serial */
 
diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
index 4da20d7845df..fd63f2042514 100644
--- a/drivers/acpi/acpica/exserial.c
+++ b/drivers/acpi/acpica/exserial.c
@@ -323,6 +323,12 @@ acpi_ex_write_serial_bus(union acpi_operand_object *source_desc,
 		function = ACPI_WRITE;
 		break;
 
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+
+		buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
+		function = ACPI_WRITE;
+		break;
+
 	default:
 		return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
 	}
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index c3ae3ea88e17..02e57191c1fd 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -190,6 +190,8 @@
 
 #define ACPI_PRM_INPUT_BUFFER_SIZE      26
 
+#define ACPI_FFH_INPUT_BUFFER_SIZE      144
+
 /* _sx_d and _sx_w control methods */
 
 #define ACPI_NUM_sx_d_METHODS           4
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 3491e454b2ab..1b4f81f1ac5d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1115,6 +1115,13 @@ struct acpi_pcc_info {
 	u8 *internal_buffer;
 };
 
+/* Special Context data for FFH Opregion (ACPI 6.5) */
+
+struct acpi_ffh_info {
+	u64 offset;
+	u64 length;
+};
+
 typedef
 acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
 				     u32 function,
-- 
2.36.1

