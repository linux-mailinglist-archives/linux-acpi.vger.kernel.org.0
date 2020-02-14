Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72FE15F667
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbgBNTI1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:26791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388080AbgBNTI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702899"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Sven Barth <sb@miray.de>, Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 06/10] ACPICA: cast the result of the pointer difference to u32
Date:   Fri, 14 Feb 2020 10:48:00 -0800
Message-Id: <20200214184804.15114-7-erik.kaneda@intel.com>
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

Altnatively we could declare aml_length as acpi_size, but then one
would need to cast at the assignment for method_obj->method.aml_length

ACPICA commit 72805936603fcf84e98f1b89bf99b5101af27fb8

Link: https://github.com/acpica/acpica/commit/72805936
Signed-off-by: Sven Barth <sb@miray.de>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/nsxfname.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 984129dcaa0c..0e6aba81605b 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -516,7 +516,7 @@ acpi_status acpi_install_method(u8 *buffer)
 
 	method_flags = *parser_state.aml++;
 	aml_start = parser_state.aml;
-	aml_length = ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
+	aml_length = (u32)ACPI_PTR_DIFF(parser_state.pkg_end, aml_start);
 
 	/*
 	 * Allocate resources up-front. We don't want to have to delete a new
-- 
2.21.0

