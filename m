Return-Path: <linux-acpi+bounces-13280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA336A9D1A2
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD584A2380
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3921C178;
	Fri, 25 Apr 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="L1c/9PE/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A3218EB4;
	Fri, 25 Apr 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609661; cv=none; b=rwRAPWOu6kiXj/gDdY4N/H31Ve4sFG2q86Jbz3SuRNyinNCbFBGuDCa3r3v3LmoLMJiAE/dzFp79w1DQ50liaaG+MEEetwy54egpsnQUw2tWv+r+V2s9S/FIQR81TLIO3utxTo20SJFqsLVYp/Iouiv2qzoWKpSFq3qLpQU6faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609661; c=relaxed/simple;
	bh=OTVyk9B8wqVer1n6P3g47htIrI8L+Uj4KwHWWWvh/Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnRiCSitUvOtuHk7zwWa8EtiEVf7GeVZr+RMT2/l0QOhd2ORVGKWJ2T/22O/CUkn45wyfKLIU3ES70uB+ohAwOJNzlLe90iL7mIiqcF80kzWm6CWLCwIjQKWNH72yBuM7gN1PlJhEqg/LEL9loZ5ufsWnzndUL2NZJwt8CUVQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=L1c/9PE/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 10140663C4C;
	Fri, 25 Apr 2025 21:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609652;
	bh=OTVyk9B8wqVer1n6P3g47htIrI8L+Uj4KwHWWWvh/Lk=;
	h=From:Subject:Date;
	b=L1c/9PE/Dw62yP80XL0YkwxBpmU+faFntUlc1OlnkqmqXttTs67o0owNGKgdHwguD
	 rphrY/R8aNU51Qn5QrhkBJCx5CRlSUw7dNpLdIo1lCs6zzqfnqAO7z2yRPfDFkh9Ir
	 l6dIrEpJZtdB5ay5jvCvDqT8JpHRWpXXhfd+aRMNLdaUlrtOObZ2um+/s7BO+WvlLF
	 OKqWoX++dWkkNcdkwTk0VkUDtb0Btyh7ENmHSbuvVPPycnpfMTtEMyhLCnYj5/ZDcN
	 i7TQp5JAjvKKR0FWYS7xYYtPuA5t04r2CoMkuozu/H+PcQT6mls2D2YxWgiuvWtife
	 nY5aV2ayXH3jw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 17/19] ACPICA: Apply ACPI_NONSTRING in more places
Date: Fri, 25 Apr 2025 21:31:05 +0200
Message-ID: <3833065.MHq7AAxBmi@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Ahmed Salem <x0rw3ll@gmail.com>

ACPICA commit 1035a3d453f7dd49a235a59ee84ebda9d2d2f41b

Add ACPI_NONSTRING for destination char arrays without a terminating NUL
character. This is a follow-up to commit 35ad99236f3a ("ACPICA: Apply
ACPI_NONSTRING") where not all instances received the same treatment, in
preparation for replacing strncpy() calls with memcpy()

Link: https://github.com/acpica/acpica/commit/1035a3d4
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acdebug.h                            | 2 +-
 include/acpi/actbl.h                                     | 6 +++---
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 911875c5a5f1..58842130ca47 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,7 +37,7 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
-	char name_seg[ACPI_NAMESEG_SIZE + 1];
+	char name_seg[ACPI_NAMESEG_SIZE + 1] ACPI_NONSTRING;
 };
 
 #define PARAM_LIST(pl)                  pl
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 2fc89704be17..74cc61e3ab09 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,12 +66,12 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE] __nonstring;	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	char oem_id[ACPI_OEM_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
 	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 9d70d8c945af..987a5d32f3b6 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
 typedef struct osl_table_info {
 	struct osl_table_info *next;
 	u32 instance;
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 
 } osl_table_info;
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 13817f9112c0..9fc927fcc22a 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAMESEG_SIZE + 16];
+	char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;
-- 
2.43.0





