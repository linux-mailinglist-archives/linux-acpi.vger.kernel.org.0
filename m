Return-Path: <linux-acpi+bounces-12079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B4A5BF7B
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05193B4318
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D262C253F3B;
	Tue, 11 Mar 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6Anww8A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6473223704
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693417; cv=none; b=Cc/4+wb96OCOWTpSUBjai3ghdvhdecS3aNG1wEsY/i0zH6H1JtIdTOWCsNL9yA7OaO7tPo/xPWmrdCRhcu9TfTKZYXaJjOf5a3yi4mITOaVUV9S7sxkEGm1BxHRybfeFgh61t0gy835IIogVpKIOpt7S5zSIdXwmyW28P03s0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693417; c=relaxed/simple;
	bh=R5aw7MD7fszMmISFJnS6fPp1O1iXt+LvTz4PCfyGpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADWAadvR4ADPLkiEWpT0Rzoz7UaZS0CMDhlgWmu38EljdmtTptmSnhb23e2q35B/vt8o2oLQVvqUrjc9UGxXpt9QvNpCXV4K4GKESbs9qre8/pb7o2DK6YncDXcoK4lIy5DgzN1LeP88awllV2EMPsWskFkl7Uz7RE/DCQLPFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6Anww8A; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741693403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RERT5E1MM2pFoldvbcZ0gDwZRyPWCHafbQQW5IfliwY=;
	b=n6Anww8ANxWByh3stUtbsfnYyUgR3oG+ELt/cBpGh+c0EoUh6I/0TRmgN96kKcableXnJg
	6nmIsrpzZLoHWbM5YSm8nbzDJn6pYV86GUlJNVKe6pGhc26VjGMfH3+zS7xqEAX76miQml
	Xs2M7JOBXdoJ393tjm/8gXhrcTqTV3I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Robert Richter <rrichter@amd.com>,
	Bruno Faccini <bfaccini@nvidia.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ACPI: NUMA: Use str_enabled_disabled() helper function
Date: Tue, 11 Mar 2025 12:42:57 +0100
Message-ID: <20250311114300.497657-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Acked-by: Bruno Faccini <bfaccini@nvidia.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/acpi/numa/srat.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..ac7045f3b85b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -18,6 +18,7 @@
 #include <linux/nodemask.h>
 #include <linux/topology.h>
 #include <linux/numa_memblks.h>
+#include <linux/string_choices.h>
 
 static nodemask_t nodes_found_map = NODE_MASK_NONE;
 
@@ -187,8 +188,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 			pr_debug("SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
 				 p->apic_id, p->local_sapic_eid,
 				 p->proximity_domain_lo,
-				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
-				 "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_SRAT_CPU_ENABLED));
 		}
 		break;
 
@@ -200,8 +200,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 				 (unsigned long long)p->base_address,
 				 (unsigned long long)p->length,
 				 p->proximity_domain,
-				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
-				 "enabled" : "disabled",
+				 str_enabled_disabled(p->flags & ACPI_SRAT_MEM_ENABLED),
 				 (p->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) ?
 				 " hot-pluggable" : "",
 				 (p->flags & ACPI_SRAT_MEM_NON_VOLATILE) ?
@@ -216,8 +215,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 			pr_debug("SRAT Processor (x2apicid[0x%08x]) in proximity domain %d %s\n",
 				 p->apic_id,
 				 p->proximity_domain,
-				 (p->flags & ACPI_SRAT_CPU_ENABLED) ?
-				 "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_SRAT_CPU_ENABLED));
 		}
 		break;
 
@@ -228,8 +226,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
 				 p->acpi_processor_uid,
 				 p->proximity_domain,
-				 (p->flags & ACPI_SRAT_GICC_ENABLED) ?
-				 "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_SRAT_GICC_ENABLED));
 		}
 		break;
 
@@ -247,8 +244,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 				 *(u16 *)(&p->device_handle[0]),
 				 *(u16 *)(&p->device_handle[2]),
 				 p->proximity_domain,
-				 (p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
-				"enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED));
 		} else {
 			/*
 			 * In this case we can rely on the device having a
@@ -258,8 +254,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 				(char *)(&p->device_handle[0]),
 				(char *)(&p->device_handle[8]),
 				p->proximity_domain,
-				(p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
-				"enabled" : "disabled");
+				str_enabled_disabled(p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED));
 		}
 	}
 	break;
@@ -271,8 +266,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
 				 p->acpi_processor_uid,
 				 p->proximity_domain,
-				 (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
-				 "enabled" : "disabled");
+				 str_enabled_disabled(p->flags & ACPI_SRAT_RINTC_ENABLED));
 		}
 		break;
 
-- 
2.48.1


