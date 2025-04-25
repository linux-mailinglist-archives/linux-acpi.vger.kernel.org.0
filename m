Return-Path: <linux-acpi+bounces-13282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9BAA9D1A7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B2D1BC0CFB
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159321E082;
	Fri, 25 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gWkXJ3qL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916321ABAA;
	Fri, 25 Apr 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609663; cv=none; b=ZIP3Q4y6smHlEhh1soRW2mpP4NQPtve+DlsFZolY4hU7VkrK7kvbctXYKuYBH8J4LdahLEFTaXVzb/Dk/ouzviUt+fFJF2npO6IOivWea1xXir/1iRHRcxGtpGe+hUohtjPNCzYpdnd8akMM+MFaRUmpzAyXoV7EhjkbaZu4nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609663; c=relaxed/simple;
	bh=cI7GeKomdGvPYsn9OEfB9I5dh+S17dzPFLPqnuezrHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwzaH2vePlFpTcU1VWzkLG9oKfUmTj2TV4Ev99YyGk2bUccaKYd5plHSSnHohLRh4DbAnuIhaYQQnZpjrmfIylmPbEtdsKI7w9sANMgtOWLcK/2AyvgbDfXzgaCoYu3sn0uWcDCyuQ7P9VKYFBWlg70w4CeTQURQu+Xwx1xvuAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gWkXJ3qL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3D4E8663631;
	Fri, 25 Apr 2025 21:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609651;
	bh=cI7GeKomdGvPYsn9OEfB9I5dh+S17dzPFLPqnuezrHI=;
	h=From:Subject:Date;
	b=gWkXJ3qLpBt6MFDNCF8MJsdNpy8v4re96Oz1Myj9/iGGCJSbVfNfsMB5BZjpEklgO
	 dVFeStGW8NrYckXTagpfp0dkrpKvOVoPFIf6C977D4Ie5NnddGk5G4y8yJasC3FULs
	 aArtrNv6ZQGlmlXIO2yV4ZQkTQo1DXukSocHkMH0iXVIZrgDBRn75uqkyVcujnxvE5
	 kY9osl/o0YeT9TsaBk3vFBLtVl7sCEjm7nCT7w15jhprNxAs3gzyuvxGCxuC31QqyQ
	 qxfWXIlAdvAEciSYoQyEDRZsEvEto5+P1gkY1OpPd0yteZzNxpyM31n2/XhABlEKO3
	 tmLLoM6Lj6Bzg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 18/19] ACPICA: Replace strncpy() with memcpy()
Date: Fri, 25 Apr 2025 21:32:12 +0200
Message-ID: <1910878.atdPhlSkOF@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Ahmed Salem <x0rw3ll@gmail.com>

ACPICA commit 83019b471e1902151e67c588014ba2d09fa099a3

strncpy() is deprecated for NUL-terminated destination buffers[1].

Use memcpy() for length-bounded destinations.

Link: https://github.com/KSPP/linux/issues/90 [1]
Link: https://github.com/acpica/acpica/commit/83019b47
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exconvrt.c  | 4 ++--
 drivers/acpi/acpica/tbfind.c    | 4 ++--
 drivers/acpi/acpica/utnonansi.c | 2 +-
 include/acpi/actypes.h          | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index bb1be42daee1..399c005aa57b 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -226,8 +226,8 @@ acpi_ex_convert_to_buffer(union acpi_operand_object *obj_desc,
 		/* Copy the string to the buffer */
 
 		new_buf = return_desc->buffer.pointer;
-		strncpy((char *)new_buf, (char *)obj_desc->string.pointer,
-			obj_desc->string.length);
+		memcpy((char *)new_buf, (char *)obj_desc->string.pointer,
+		       obj_desc->string.length);
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..35f72dffc250 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	memcpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	memcpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..803e3e893825 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -168,7 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
 
-	strncpy(dest, source, dest_size);
+	memcpy(dest, source, dest_size);
 	dest[dest_size - 1] = 0;
 }
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 5b9f9a612548..e90ca342d7de 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -522,7 +522,7 @@ typedef u64 acpi_integer;
 #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
 #else
 #define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
-#define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
+#define ACPI_COPY_NAMESEG(dest,src)     (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
 #endif
 
 /* Support for the special RSDP signature (8 characters) */
-- 
2.43.0





