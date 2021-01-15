Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343D42F8547
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbhAOTWH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 14:22:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:59259 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbhAOTWG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 14:22:06 -0500
IronPort-SDR: 4ZVsW3YpVmKnmFokc8d2McMROUD3oAzc8ooUSjhJUkgijEvttCp6dl0srlGd9sjbmhgE3DtABP
 UPjjusYBg1Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="240139533"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="240139533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:20:55 -0800
IronPort-SDR: GPst1zLC2QS82hM8nCuBUU/4c0wCGNTUFzl9aBDhSDQJ127Vtf0dwA951xFxBApwP/Un4zYre0
 1XdnfxMDt8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="425417884"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 11:20:55 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 2/9] ACPICA: Clean up exception code class checks
Date:   Fri, 15 Jan 2021 10:48:19 -0800
Message-Id: <20210115184826.2250-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115184826.2250-1-erik.kaneda@intel.com>
References: <20210115184826.2250-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Maximilian Luz <luzmaximilian@gmail.com>

ACPICA commit 5a8390fbd4c5c60da0b6d4ba53b5ee34fda9a0cb

With the exception code class check macros fixed in the previous commit,
let us now use those to simplify exception class checks across acpica.

Link: https://github.com/acpica/acpica/commit/5a8390fb
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dbobject.c | 2 +-
 drivers/acpi/acpica/dsdebug.c  | 2 +-
 drivers/acpi/acpica/psloop.c   | 3 +--
 drivers/acpi/acpica/psparse.c  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index 4b4c530a0654..95ab91b35f29 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -47,7 +47,7 @@ acpi_db_dump_method_info(acpi_status status, struct acpi_walk_state *walk_state)
 
 	/* Ignore control codes, they are not errors */
 
-	if ((status & AE_CODE_MASK) == AE_CODE_CONTROL) {
+	if (ACPI_CNTL_EXCEPTION(status)) {
 		return;
 	}
 
diff --git a/drivers/acpi/acpica/dsdebug.c b/drivers/acpi/acpica/dsdebug.c
index 63bc5f19fb82..2c22e3eff535 100644
--- a/drivers/acpi/acpica/dsdebug.c
+++ b/drivers/acpi/acpica/dsdebug.c
@@ -100,7 +100,7 @@ acpi_ds_dump_method_stack(acpi_status status,
 
 	/* Ignore control codes, they are not errors */
 
-	if ((status & AE_CODE_MASK) == AE_CODE_CONTROL) {
+	if (ACPI_CNTL_EXCEPTION(status)) {
 		return_VOID;
 	}
 
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 3cf0687b9915..1ba17cf16c41 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -264,8 +264,7 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 								ACPI_TO_POINTER
 								(TRUE));
 				if (ACPI_FAILURE(status)
-				    && ((status & AE_CODE_MASK) !=
-					AE_CODE_CONTROL)) {
+				    && !ACPI_CNTL_EXCEPTION(status)) {
 					if (status == AE_AML_NO_RETURN_VALUE) {
 						ACPI_EXCEPTION((AE_INFO, status,
 								"Invoked method did not return a value"));
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index bd3caf735be3..06490a137982 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -383,7 +383,7 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 	default:
 
 		status = callback_status;
-		if ((callback_status & AE_CODE_MASK) == AE_CODE_CONTROL) {
+		if (ACPI_CNTL_EXCEPTION(callback_status)) {
 			status = AE_OK;
 		}
 		break;
-- 
2.29.2

