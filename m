Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDC245848
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Aug 2020 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHPPMP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Aug 2020 11:12:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:4504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgHPPMN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Aug 2020 11:12:13 -0400
IronPort-SDR: tg36YUYzgBH+xqhuZDER4EoP1t21UA8E7bxrP+vZ652nJKYRDVsxWXfS5SvTo8dvfbSNQptFMr
 sqhgWcPrvxeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="154567680"
X-IronPort-AV: E=Sophos;i="5.76,320,1592895600"; 
   d="scan'208";a="154567680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 08:12:12 -0700
IronPort-SDR: Qyf5OJZh0AtfKvWuMk/nfhWJPKdM+cAv6sM///0y9mNYCl4z31e26uF3xnWfhYhj40TC2jCLyt
 08+oNtPPZreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,320,1592895600"; 
   d="scan'208";a="296235914"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2020 08:12:10 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] ACPI: processor: Print more information when acpi_processor_evaluate_cst() failed
Date:   Sun, 16 Aug 2020 23:12:30 +0800
Message-Id: <20200816151230.14524-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some platforms have bogus _CST which might cause expectd behavior
in the cpu idle driver. Some bogus _CST might be unable to be
disassembled by acpica-tools due to broken format.
Print extra log if the _CST extraction/verification failed.
This can be used to help the user narrow down why the cpu
idle driver fails to behave as expected.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/acpi_processor.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b51ddf3bb616..c1d34c448edb 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -798,22 +798,34 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 		memset(&cx, 0, sizeof(cx));
 
 		element = &cst->package.elements[i];
-		if (element->type != ACPI_TYPE_PACKAGE)
+		if (element->type != ACPI_TYPE_PACKAGE) {
+			acpi_handle_warn(handle, "_CST C%d type(%x) is not package, skip...\n",
+					 i, element->type);
 			continue;
+		}
 
-		if (element->package.count != 4)
+		if (element->package.count != 4) {
+			acpi_handle_warn(handle, "_CST C%d package count(%d) is not 4, skip...\n",
+					 i, element->package.count);
 			continue;
+		}
 
 		obj = &element->package.elements[0];
 
-		if (obj->type != ACPI_TYPE_BUFFER)
+		if (obj->type != ACPI_TYPE_BUFFER) {
+			acpi_handle_warn(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
+					 i, obj->type);
 			continue;
+		}
 
 		reg = (struct acpi_power_register *)obj->buffer.pointer;
 
 		obj = &element->package.elements[1];
-		if (obj->type != ACPI_TYPE_INTEGER)
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_warn(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
+					 i, obj->type);
 			continue;
+		}
 
 		cx.type = obj->integer.value;
 		/*
@@ -850,6 +862,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 				cx.entry_method = ACPI_CSTATE_HALT;
 				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
 			} else {
+				acpi_handle_warn(handle, "_CST C%d declares FIXED_HARDWARE C-state but not supported in hardware, skip...\n",
+						 i);
 				continue;
 			}
 		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -857,6 +871,8 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
 				 cx.address);
 		} else {
+			acpi_handle_warn(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
+					 i, reg->space_id);
 			continue;
 		}
 
@@ -864,14 +880,20 @@ int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 			cx.valid = 1;
 
 		obj = &element->package.elements[2];
-		if (obj->type != ACPI_TYPE_INTEGER)
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_warn(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
+					 i, obj->type);
 			continue;
+		}
 
 		cx.latency = obj->integer.value;
 
 		obj = &element->package.elements[3];
-		if (obj->type != ACPI_TYPE_INTEGER)
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_warn(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
+					 i, obj->type);
 			continue;
+		}
 
 		memcpy(&info->states[++last_index], &cx, sizeof(cx));
 	}
-- 
2.17.1

