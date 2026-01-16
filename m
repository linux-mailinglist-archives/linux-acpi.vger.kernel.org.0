Return-Path: <linux-acpi+bounces-20398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E6D2D394
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F28F3065A95
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5334BA24;
	Fri, 16 Jan 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yjSjfYLZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7D34B190;
	Fri, 16 Jan 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548600; cv=none; b=Jj+ZymyRyj/UZ8mjhCTBFPe3JBhtnuUmxgV81mgCnHQw2wZVox5UVLlnTRCtH5hF3U+1AH2pJdvjMU69sz0UhQaFMMQuY2Nl3bA4YhfTjbT3wH25Y8aG2la7/FnVLOph1TEqqNHSQDJMQ8o9C8XNDXZxOiFkM0haMy/4fUbR5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548600; c=relaxed/simple;
	bh=Q7sFifz7jlueIviHX+V/sg2+xAwEUpxIZxq+G0loZuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tb8wUXsJclk0XGeCKu2+mHlU1UanEZNsPe7Sx+8Me3HyBBtv5tfvCp+F7HmFUu75OCK3Rpoh7ozwCYmdy+gvF4ulfv+EFQq3QsfCnXMCT3nZj2q5EJARTpNStU/gqrKKwMECqGq4+rjgQrHAa0Giz+huKnhw8x3fEdIvChNm/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yjSjfYLZ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768548585; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/u3f4ulv0uUWloKmKaHVHhRaLcOwhEfgiFHqNcfXBmw=;
	b=yjSjfYLZ4sPvjs0Tl6ISc3qTT4kmWozSdnDXtL58EvuhhscQB11rklQftnZF2/c47Efz/3zZC6axU3mKxLDwUMbe1mZVG7nluQSTaMTDYze5q/8gDpVD+gloKUmKWmdpa/daEtNyYmAisik+96msUNCpJb7tw17OFAgeNG4i5LI=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wx9NsxE_1768548584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 16 Jan 2026 15:29:44 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>
Cc: Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v3] ACPI/PPTT: Check total CPU numbers when a CPU can't be found in PPTT table
Date: Fri, 16 Jan 2026 15:29:43 +0800
Message-Id: <20260116072943.26322-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug that kernel printed error message:
" ACPI PPTT: PPTT table found, but unable to locate core 1 (1)"
and later on the kernel met issues when building up scheduler domain.

Debug showed the kernel actually brought up all 8 CPUs successfully
(MADT and other table worked fine), while the PPTT table was broken
as it only had 4 CPUs in total.

Add check for number of CPU of PPTT table against system CPU number,
and warn if they are not equal, to help debugging similar issues.

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

  v3
  * Only check the number of CPUs in PPTT table againt system
    CPU count when error happens, instead of dump all the CPU/cache
	entries (Sudeep/Rafael)

  v2
  * rebase againt 6.19 and refine the commit log

 drivers/acpi/pptt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..9958c3961001 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -529,6 +529,43 @@ static void acpi_pptt_warn_missing(void)
 	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
 }
 
+static void pptt_verify_cpu_count(struct acpi_table_header *table_hdr)
+{
+	struct acpi_subtable_header *entry;
+	unsigned long end;
+	struct acpi_pptt_processor *cpu;
+	u8 len;
+	int nr_pptt_cpus = 0;
+	static bool checked;
+
+	if (checked)
+		return;
+
+	end = (unsigned long)table_hdr + table_hdr->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+				sizeof(struct acpi_table_pptt));
+
+	while ((unsigned long)entry + sizeof(struct acpi_pptt_processor) <= end) {
+		len = entry->length;
+		if (!len) {
+			pr_warn("Invalid zero length subtable\n");
+			return;
+		}
+
+		cpu = (struct acpi_pptt_processor *)entry;
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
+		if (cpu->header.type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    (cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE))
+			nr_pptt_cpus++;
+	}
+
+	if (nr_pptt_cpus != num_possible_cpus())
+		pr_warn("The number of CPUs (%d) in PPTT table doesn't match system's CPU count (%d)!\n",
+			nr_pptt_cpus, num_possible_cpus());
+
+	checked = true;
+}
+
 /**
  * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
  * @table: Pointer to the head of the PPTT table
@@ -565,6 +602,9 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	}
 	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
 		    cpu, acpi_cpu_id);
+
+	/* Check whether PPTT table's CPU count match with system count */
+	pptt_verify_cpu_count(table);
 	return -ENOENT;
 }
 
-- 
2.39.5 (Apple Git-154)


