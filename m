Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16F911FC9C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 02:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfLPBkx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Dec 2019 20:40:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfLPBkx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Dec 2019 20:40:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 371A684517E6E3C7AA24;
        Mon, 16 Dec 2019 09:40:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 09:40:44 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <rafael.j.wysocki@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] ACPICA: debugger: remove unnecessary parentheses
Date:   Mon, 16 Dec 2019 09:37:36 +0800
Message-ID: <20191216013736.170949-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove unnecessary parentheses found by checkpatch

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/acpi/acpica/dbinput.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index e1632b3..8470df94 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -738,7 +738,7 @@ acpi_db_command_dispatch(char *input_buffer,
 	case CMD_NULL:
 
 		if (op) {
-			return (AE_OK);
+			return AE_OK;
 		}
 		break;
 
@@ -818,7 +818,7 @@ acpi_db_command_dispatch(char *input_buffer,
 			acpi_os_printf
 			    ("Invalid adress space ID: must be between 0 and %u inclusive\n",
 			     ACPI_NUM_PREDEFINED_REGIONS - 1);
-			return (AE_OK);
+			return AE_OK;
 		}
 
 		status = acpi_db_display_fields((u32)temp64);
@@ -827,7 +827,7 @@ acpi_db_command_dispatch(char *input_buffer,
 	case CMD_GO:
 
 		acpi_gbl_cm_single_step = FALSE;
-		return (AE_OK);
+		return AE_OK;
 
 	case CMD_HANDLERS:
 
@@ -879,7 +879,7 @@ acpi_db_command_dispatch(char *input_buffer,
 
 		if (op) {
 			acpi_gbl_cm_single_step = TRUE;
-			return (AE_OK);
+			return AE_OK;
 		}
 		break;
 
-- 
2.7.4

