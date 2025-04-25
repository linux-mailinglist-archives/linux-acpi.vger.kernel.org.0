Return-Path: <linux-acpi+bounces-13292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503AA9D1BF
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0751BC1616
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C44225390;
	Fri, 25 Apr 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="QdRYVSCj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8C22258B;
	Fri, 25 Apr 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609668; cv=none; b=lOTTsnd8Nawk1UT49B91+2tW+2fWWuB+BVxD8KJZo3NUH4hfNRDFH6JrPm+S1mxkfMVgykpJiiv39XK1oXt/hbyc+Y06g3OD7xM1bqd5QUUEcEiT22OXWnoDl5f5J0zf1eY/l/gOra+E1VyjMeT6LyzK5NUcOjI7ogqcRvBt6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609668; c=relaxed/simple;
	bh=sEWkmldI0bniPYlwO1Sq9VF2lFwbfP8QFMiXtpfDN/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G14xVbl7poIT6QLqEWFeevhxYc8JUFYCiy5gtiSZRK3g5DmF9sRGGjKEXedv3dLov5RmB8K8BUEok1S8GcRvnl2U8jC/jaPTUZZBImuG1Rg7oX+ILouRkEixvcPYCYYY5CywGSv+XoqyYiPfleK+Iwpt/4nWNfOZHETEnaHQ7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=QdRYVSCj; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9ADAA6632EA;
	Fri, 25 Apr 2025 21:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609663;
	bh=sEWkmldI0bniPYlwO1Sq9VF2lFwbfP8QFMiXtpfDN/w=;
	h=From:Subject:Date;
	b=QdRYVSCjhZ01wBzEhQFqfz7QpphJA8FMOpGxavE9wPlGGIr+MAuI4xHW74XFTparH
	 FmqN1mBJSo6aJGQKa2GVvbew6Ca5ek8mSINs2hBGZzrDXgrXc4xgVdpMxWF11yxjkI
	 tHkNX8I1jVWucxEgf4VY8nolF+62XhVibb6h1JqeEFKrS6V+H+CPYss0UPsaThUz+r
	 g2Juc9ZcHaGZIWtJN3TYLQhqnoT84juvonwN+RnIyO4a9m+NDz1qJybuDjcGjfISai
	 tqF2Gcf468DJjv9nPYbJ9jl0ZzymzaIIqQK2Zn5qTAzr1TPkBmnlFaMTT5Sd2B7nw9
	 OYb9Cf82MVl8A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 06/19] ACPICA: actbl2.h: MRRM: Add typedef and other  definitions
Date: Fri, 25 Apr 2025 21:24:02 +0200
Message-ID: <3372188.44csPzL39Z@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptefhgffgueeileffleffieeuvefgtdetheeiheelveehtdfhveeggedtkeelgeehnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Tony Luck <tony.luck@intel.com>

ACPICA commit 04fd53b2647b9f6f98cfca551383689cb3b59362

The MRRM table describes association between physical address ranges
and "region numbers".

Structure defined in the Intel Resource Director Technology (RDT)
Architecture specification downloadable from www.intel.com/sdm

Link: https://github.com/acpica/acpica/commit/04fd53b2
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a3008bae6f48..4fd5e8b2e199 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -37,6 +37,7 @@
 #define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
 #define ACPI_SIG_MPAM           "MPAM"	/* Memory System Resource Partitioning and Monitoring Table */
 #define ACPI_SIG_MPST           "MPST"	/* Memory Power State Table */
+#define ACPI_SIG_MRRM           "MRRM"	/* Memory Range and Region Mapping table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_NFIT           "NFIT"	/* NVDIMM Firmware Interface Table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non HD Audio Link Table */
@@ -1736,6 +1737,45 @@ struct acpi_msct_proximity {
 	u64 memory_capacity;	/* In bytes */
 };
 
+/*******************************************************************************
+ *
+ * MRRM - Memory Range and Region Mapping (MRRM) table
+ *
+ ******************************************************************************/
+
+struct acpi_table_mrrm {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 max_mem_region;	/* Max Memory Regions supported */
+	u8 flags;		/* Region assignment type */
+	u8 reserved[26];
+	u8 memory_range_entry[];
+};
+
+/* Flags */
+#define ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS    (1<<0)
+
+/*******************************************************************************
+ *
+ * Memory Range entry - Memory Range entry in MRRM table
+ *
+ ******************************************************************************/
+
+struct acpi_table_mrrm_mem_range_entry {
+	ACPI_SUBTABLE_HEADER_16 header;
+	u32 reserved0;		/* Reserved */
+	u64 addr_base;		/* Base addr of the mem range */
+	u64 addr_len;		/* Length of the mem range */
+	u16 region_id_flags;	/* Valid local or remote Region-ID */
+	u8 local_region_id;	/* Platform-assigned static local Region-ID */
+	u8 remote_region_id;	/* Platform-assigned static remote Region-ID */
+	u32 reserved1;		/* Reserved */
+	/* Region-ID Programming Registers[] */
+};
+
+/* Values for region_id_flags above */
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL   (1<<0)
+#define ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE  (1<<1)
+
 /*******************************************************************************
  *
  * MSDM - Microsoft Data Management table
-- 
2.43.0





