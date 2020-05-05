Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC821C4B40
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgEEBIh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:50715 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEEBIg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:36 -0400
IronPort-SDR: 3Ynwrp4uB90lMhLCgqAY5o/FROAF5rmOv505vXtHCNXK8DxTONmqGgeSMdJfWy1YssmeRyjs6h
 W6b/eneLQ62Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:36 -0700
IronPort-SDR: 4oPofk11adubO1yX84JBHh2bZfp2XaKPNqfXoOBMHb/AECT1CYVua08xuQcNtOIw3x2u3sXvn9
 QCiYHVsI1wug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865795"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/6] ACPICA: Disassembler: ignore AE_ALREADY_EXISTS status when parsing create operators
Date:   Mon,  4 May 2020 17:46:51 -0700
Message-Id: <20200505004654.2870591-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit cd66d0a50fdc9cc4dcd998e08e7aa3c4154bea2d

Disassembler is intended to emit existing ASL code as-is. Therefore,
error messages emitted during disassembly should be ignored or
handled in a way such that the disassembler can continue to parse the
AML. This change ignores AE_ALREADY_EXISTS errors during the deferred
Op parsing for create operators in order to complete parsing ASL
termlists.

Link: https://github.com/acpica/acpica/commit/cd66d0a5
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index c901f5aec739..0189b5d4e3a3 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -177,7 +177,10 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 					arg->common.value.string, ACPI_TYPE_ANY,
 					ACPI_IMODE_LOAD_PASS1, flags,
 					walk_state, &node);
-		if (ACPI_FAILURE(status)) {
+		if ((walk_state->parse_flags & ACPI_PARSE_DISASSEMBLE)
+		    && status == AE_ALREADY_EXISTS) {
+			status = AE_OK;
+		} else if (ACPI_FAILURE(status)) {
 			ACPI_ERROR_NAMESPACE(walk_state->scope_info,
 					     arg->common.value.string, status);
 			return_ACPI_STATUS(status);
-- 
2.25.1

