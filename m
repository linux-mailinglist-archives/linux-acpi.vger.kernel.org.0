Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2E226D9F
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGTRzW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 13:55:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:42499 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgGTRzV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 13:55:21 -0400
IronPort-SDR: IZYxbeF2PhriqJQfyssRtaeLkrQ3W+o2tSV/rLhZhZhs3I6+7Y0PeSnjeAvdJW7VqOvBSGJ7U1
 3eQGyNde52Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="211519707"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="211519707"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:55:20 -0700
IronPort-SDR: kGWHrOwuebMvcPrxTbwZRBVvCuTWMAzyy/Vxw4SxCL541haiUyDJTTDCEW5sMKwJvRMq9XA6qf
 LLwxxbkPH5ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392105373"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2020 10:55:20 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/3] ACPICA: Do not increment operation_region reference counts for field units
Date:   Mon, 20 Jul 2020 10:31:20 -0700
Message-Id: <20200720173121.2580755-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720173121.2580755-1-erik.kaneda@intel.com>
References: <20200720173121.2580755-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit e17b28cfcc31918d0db9547b6b274b09c413eb70

Object reference counts are used as a part of ACPICA's garbage
collection mechanism. This mechanism keeps track of references to
heap-allocated structures such as the ACPI operand objects.

Recent server firmware has revealed that this reference count can
overflow on large servers that declare many field units under the
same operation_region. This occurs because each field unit declaration
will add a reference count to the source operation_region.

This change solves the reference count overflow for operation_regions
objects by preventing fieldunits from incrementing their
operation_region's reference count. Each operation_region's reference
count will not be changed by named objects declared under the Field
operator. During namespace deletion, the operation_region namespace
node will be deleted and each fieldunit will be deleted without
touching the deleted operation_region object.

Link: https://github.com/acpica/acpica/commit/e17b28cf
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exprep.c   | 4 ----
 drivers/acpi/acpica/utdelete.c | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index a4e306690a21..4a0f03157e08 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -473,10 +473,6 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 				    (u8)access_byte_width;
 			}
 		}
-		/* An additional reference for the container */
-
-		acpi_ut_add_reference(obj_desc->field.region_obj);
-
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",
 				  obj_desc->field.start_field_bit_offset,
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index c365faf4e6cd..4c0d4e434196 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -568,11 +568,6 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 			next_object = object->buffer_field.buffer_obj;
 			break;
 
-		case ACPI_TYPE_LOCAL_REGION_FIELD:
-
-			next_object = object->field.region_obj;
-			break;
-
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
 
 			next_object = object->bank_field.bank_obj;
@@ -613,6 +608,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 			}
 			break;
 
+		case ACPI_TYPE_LOCAL_REGION_FIELD:
 		case ACPI_TYPE_REGION:
 		default:
 
-- 
2.25.1

