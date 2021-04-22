Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6667368724
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhDVTZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 15:25:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:21022 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236896AbhDVTZV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 15:25:21 -0400
IronPort-SDR: ftT6oKJbSF7LNhiAiWb5B3/KRrmYx9RkdeWC7xSQlM4suUDVZa0M6qLji6d7Hf6oKW1cjIVxZa
 68K4dOod+uYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192770835"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="192770835"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:24:46 -0700
IronPort-SDR: hMyTLInCgAsgjgmQav97cgnnIy/kyPX5XWK0gnuyqkx93/RaOfWM3uwPMC3+L6FdM1eWROmYTo
 aJd5FVm7RLsw==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="464063693"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 12:24:45 -0700
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
Subject: [PATCH 1/3] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
Date:   Thu, 22 Apr 2021 12:24:39 -0700
Message-Id: <20210422192442.706906-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210422192442.706906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
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

