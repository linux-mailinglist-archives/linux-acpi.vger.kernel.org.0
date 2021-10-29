Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF94440392
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhJ2TyH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:54:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:30771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhJ2TyG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:54:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="229466474"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="229466474"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="466634162"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:37 -0700
Subject: [PATCH 2/6] ACPI: Teach ACPI table parsing about the CEDT header
 format
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:37 -0700
Message-ID: <163553709742.2509508.5177761945441327574.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The CEDT adds yet one more unique subtable header type where the length
is a 16-bit value. Extend the subtable helpers to detect this scenario.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/tables.c |    9 +++++++++
 include/linux/acpi.h  |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 29d44fe19ef0..b1514fde11bc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -40,6 +40,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
+	ACPI_SUBTABLE_CEDT,
 };
 
 struct acpi_subtable_entry {
@@ -225,6 +226,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return entry->hdr->hmat.type;
 	case ACPI_SUBTABLE_PRMT:
 		return 0;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.type;
 	}
 	return 0;
 }
@@ -239,6 +242,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->hmat.length;
 	case ACPI_SUBTABLE_PRMT:
 		return entry->hdr->prmt.length;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.length;
 	}
 	return 0;
 }
@@ -253,6 +258,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->hmat);
 	case ACPI_SUBTABLE_PRMT:
 		return sizeof(entry->hdr->prmt);
+	case ACPI_SUBTABLE_CEDT:
+		return sizeof(entry->hdr->cedt);
 	}
 	return 0;
 }
@@ -264,6 +271,8 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_HMAT;
 	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
 		return ACPI_SUBTABLE_PRMT;
+	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
+		return ACPI_SUBTABLE_CEDT;
 	return ACPI_SUBTABLE_COMMON;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 509b72676e2e..cbee050f4b1d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -133,6 +133,7 @@ union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
 	struct acpi_prmt_module_header prmt;
+	struct acpi_cedt_header cedt;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);

