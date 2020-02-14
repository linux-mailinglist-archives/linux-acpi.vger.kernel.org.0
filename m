Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475A215F668
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbgBNTI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:26795 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbgBNTI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702902"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sven Barth <sb@miray.de>, Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 07/10] ACPICA: cast length arguement to acpi_ns_build_normalized_path() as u32
Date:   Fri, 14 Feb 2020 10:48:01 -0800
Message-Id: <20200214184804.15114-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Sven Barth <sb@miray.de>

ACPICA commit d216e4c8d886d7fb82697948c4fee8a5777a1a5a

Link: https://github.com/acpica/acpica/commit/d216e4c8
Signed-off-by: Sven Barth <sb@miray.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/nsnames.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index 370bbc867745..832b79c4b008 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -164,7 +164,7 @@ acpi_ns_handle_to_pathname(acpi_handle target_handle,
 	/* Build the path in the caller buffer */
 
 	(void)acpi_ns_build_normalized_path(node, buffer->pointer,
-					    required_size, no_trailing);
+					    (u32)required_size, no_trailing);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%s [%X]\n",
 			  (char *)buffer->pointer, (u32) required_size));
@@ -315,7 +315,7 @@ char *acpi_ns_get_normalized_pathname(struct acpi_namespace_node *node,
 
 	/* Build the path in the allocated buffer */
 
-	(void)acpi_ns_build_normalized_path(node, name_buffer, size,
+	(void)acpi_ns_build_normalized_path(node, name_buffer, (u32)size,
 					    no_trailing);
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES, "%s: Path \"%s\"\n",
-- 
2.21.0

