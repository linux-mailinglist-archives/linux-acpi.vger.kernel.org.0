Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E80286D1B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgJHDWA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:29856 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgJHDV7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:21:59 -0400
IronPort-SDR: nkSRqxj0hmty1rTw2XtUs7suX0DGT4egK87Id4mfQG5ofp+Zv/rxjpz2PNl++hA62g3LqksHnQ
 zAPaCk/c0BEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613635"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:21:59 -0700
IronPort-SDR: qs3tDKVuzwR2EolU0b6zYy+2zXIhg1YGVPh0dHwERNbcHbIBTn+A7oSWRNR2BlbMM0Vtfi4y+t
 rBEmb82xW8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229332"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:21:59 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/9] ACPICA: Drop the repeated word "an" in a comment.
Date:   Wed,  7 Oct 2020 19:53:56 -0700
Message-Id: <20201008025403.2401736-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

ACPICA commit 9ed2c006444d1def55bc6f08164ed5d9e809c856

Link: https://github.com/acpica/acpica/commit/9ed2c006
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d50e61384f1f..647cb11d0a0a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -824,7 +824,7 @@ typedef u8 acpi_adr_space_type;
  *
  * Note: A Data Table region is a special type of operation region
  * that has its own AML opcode. However, internally, the AML
- * interpreter simply creates an operation region with an an address
+ * interpreter simply creates an operation region with an address
  * space type of ACPI_ADR_SPACE_DATA_TABLE.
  */
 #define ACPI_ADR_SPACE_DATA_TABLE       (acpi_adr_space_type) 0x7E	/* Internal to ACPICA only */
-- 
2.25.1

