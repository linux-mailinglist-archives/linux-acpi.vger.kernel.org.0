Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0063688B7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhDVVrx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 17:47:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:1514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237137AbhDVVrw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:47:52 -0400
IronPort-SDR: Fk6mWJM7OcFS0Vo0tii/TMbEw6brVoMYzdxpWFfVDhMn9Tl/bJ/STs4gTd1hDeEr+RGX83ECAY
 9qI581YU/DiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281306572"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281306572"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:17 -0700
IronPort-SDR: wpzOF3mo6S0W85ikIvNf6P0uLjq8lupg3sQ4S3CK+l/Uga82EevrlnP8Tl97NiJDxB+y4IWjSQ
 Qs6KWTm2Ukrw==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455965124"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:16 -0700
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
Subject: [PATCH v2 2/3] ACPI/table: Print MADT Wake table information
Date:   Thu, 22 Apr 2021 14:47:07 -0700
Message-Id: <20210422214708.716164-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When MADT is parsed, print MADT Wake table information as
debug message. It will be useful to debug CPU boot issues
related to MADT wake table.

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

