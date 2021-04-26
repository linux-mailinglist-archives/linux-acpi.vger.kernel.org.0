Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851A436AAAE
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 04:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhDZCkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Apr 2021 22:40:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:49066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhDZCkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 25 Apr 2021 22:40:32 -0400
IronPort-SDR: +M/ClXIvrwS1Hwe/YWNH3z+vH87MfBXYqHIs2boR5frfOKnsRzBx8Pu+8IXpYvQ5uF5BBqeJTZ
 Y6fkYx3HmrRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260224234"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260224234"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:51 -0700
IronPort-SDR: j5RPKbBeWX/ha9cj5BvI5f3wCiaMIhf+bTo2brYEaTlzKwRWQt11hz3sTn2Bms+NNk7g23/QA1
 luG5Em/7eHTw==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="454081400"
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
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/3] ACPI/table: Print MADT Wake table information
Date:   Sun, 25 Apr 2021 19:39:40 -0700
Message-Id: <20210426023941.729334-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When MADT is parsed, print MADT Wake table information as
debug message. It will be useful to debug CPU boot issues
related to MADT wake table.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/tables.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9d581045acff..206df4ad8b2b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -207,6 +207,17 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p;
+
+			p = (struct acpi_madt_multiproc_wakeup *) header;
+
+			pr_debug("MP Wake (Mailbox version[%d] base_address[%llx])\n",
+				 p->mailbox_version, p->base_address);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
-- 
2.25.1

