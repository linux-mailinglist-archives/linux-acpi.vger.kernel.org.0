Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9784B196167
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgC0WnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgC0WnN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:13 -0400
IronPort-SDR: 1h2N689uUMtGu3Ffh+f9g9XWevUBlB+YCMQil9ZhoBoxZ+StMUu+DWpSbnGLVveidkuFm6EyVO
 BooEIFZ7aFFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:12 -0700
IronPort-SDR: u2Avz1zK7HxBhgWvdPByravw+DWua6gbqSh+R5VyxgAUWIZ/t1uzkK42VqBsFQrAIM2ldtoUsg
 +2Rw6ke1kFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051976"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:11 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        David Seifert <soap@gentoo.org>,
        Benjamin Berg <bberg@redhat.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 05/10] ACPICA: acpiexec: remove redeclaration of acpi_gbl_db_opt_no_region_support
Date:   Fri, 27 Mar 2020 15:21:05 -0700
Message-Id: <20200327222110.1204634-6-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 825c53661cacc7e3dab4844588201846143bd1b7

This variable was re-defined in a file specific to acpiexec. Remove
the redundant declaration and move the initialize to the debugger.

Patch based on suggestions by David Seifert and Benjamin Berg.

Link: https://github.com/acpica/acpica/commit/825c5366
Reported-by: David Seifert <soap@gentoo.org>
Reported-by: Benjamin Berg <bberg@redhat.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbxface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 3eb45ea93e5e..9dfd693cda3e 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -409,6 +409,7 @@ acpi_status acpi_initialize_debugger(void)
 	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
 
 	acpi_gbl_db_opt_no_ini_methods = FALSE;
+	acpi_gbl_db_opt_no_region_support = FALSE;
 
 	acpi_gbl_db_buffer = acpi_os_allocate(ACPI_DEBUG_BUFFER_SIZE);
 	if (!acpi_gbl_db_buffer) {
-- 
2.25.1

