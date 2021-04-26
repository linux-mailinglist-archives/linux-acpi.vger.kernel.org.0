Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD736AAAD
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhDZCkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Apr 2021 22:40:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:49066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhDZCkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 25 Apr 2021 22:40:32 -0400
IronPort-SDR: /6MZYbHvsmZRz8MrDfXgIZzEibD5b+Xs7bsUzgY0fjLXe/BL4u6bFxRl9QcOxHMNN3NPHiqsYV
 vGALs+aSXLHw==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260224233"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260224233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:50 -0700
IronPort-SDR: G9Lszn+JqbJZieY8pIk+Mj1ozV0QhQR36IZWTHNNUaBpmyBQYTmFaEEzjRUa7UcQvvKFKk1Idt
 eUUcQQ2OhUuQ==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="454081397"
Received: from angelata-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.149])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:50 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
Date:   Sun, 25 Apr 2021 19:39:39 -0700
Message-Id: <20210426023941.729334-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea

Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
in parsing MADT Wake table.

Link: https://github.com/acpica/acpica/commit/f1ee0420
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/acpi/actbl2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b2362600b9ff..7dce422f6119 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -733,6 +733,20 @@ struct acpi_madt_multiproc_wakeup {
 	u64 base_address;
 };
 
+#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE	2032
+#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE	2048
+
+struct acpi_madt_multiproc_wakeup_mailbox {
+	u16 command;
+	u16 reserved;		/* reserved - must be zero */
+	u32 apic_id;
+	u64 wakeup_vector;
+	u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];	/* reserved for OS use */
+	u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];	/* reserved for firmware use */
+};
+
+#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.25.1

