Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25CCE3BE0
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406463AbfJXTNr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:13:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:56947 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392921AbfJXTNr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="188686287"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 12:13:43 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 09/12] ACPICA: debugger: add field unit support for acpi_db_get_next_token
Date:   Thu, 24 Oct 2019 11:55:53 -0700
Message-Id: <20191024185556.4606-10-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit d509afa88e9415f13a3283c38ce9ee034634ae24

Since field unit data output from the debugger are now surrounded by
braces '{', support has been added to acpi_db_get_next_token to recognize
strings beginning with this character as a ACPI_TYPE_FIELD_UNIT.

Link: https://github.com/acpica/acpica/commit/d509afa8
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbinput.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 44d6d7246e6e..26eee2dba0a4 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -511,6 +511,21 @@ char *acpi_db_get_next_token(char *string,
 		}
 		break;
 
+	case ' {':
+
+		/* This is the start of a field unit, scan until closing brace */
+
+		string++;
+		start = string;
+		type = ACPI_TYPE_FIELD_UNIT;
+
+		/* Find end of buffer */
+
+		while (*string && (*string != '}')) {
+			string++;
+		}
+		break;
+
 	case '[':
 
 		/* This is the start of a package, scan until closing bracket */
-- 
2.21.0

