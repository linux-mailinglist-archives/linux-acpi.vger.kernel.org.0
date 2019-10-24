Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52156E3BDD
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392932AbfJXTNr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:13:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:56947 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392923AbfJXTNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="188686284"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 12:13:43 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 08/12] ACPICA: debugger: surround field unit output with braces '{'
Date:   Thu, 24 Oct 2019 11:55:52 -0700
Message-Id: <20191024185556.4606-9-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 76ca57291d007d33087982a4b28cd1ee9bcd37a6

This helps differentiate the type of named objects between field
units and buffers. In other words, without this symbol, it would be
difficult to tell whether a particular named object is a buffer or a
field unit.

Link: https://github.com/acpica/acpica/commit/76ca5729
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbnames.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 06fe87c6647d..29a172869a6e 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -551,6 +551,11 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
 
+	/*
+	 * Since this is a field unit, surround the output in braces
+	 */
+	acpi_os_printf("{");
+
 	ret_value = (union acpi_object *)buffer.pointer;
 	switch (ret_value->type) {
 	case ACPI_TYPE_INTEGER:
@@ -571,7 +576,7 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 		break;
 	}
 
-	acpi_os_printf("\n");
+	acpi_os_printf("}\n");
 
 	ACPI_FREE(buffer.pointer);
 	return (AE_OK);
-- 
2.21.0

