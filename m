Return-Path: <linux-acpi+bounces-13031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D7FA8885B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB09162DF5
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6B27FD46;
	Mon, 14 Apr 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nemufrau"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78E274679;
	Mon, 14 Apr 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647425; cv=none; b=KZCxVFfJA43XRrMAkzj0GTrYK9+TgRSlUGjCRI3MWdnRDc76Uuif9PcJZpwU7jnBzb778y2QDGropEaiktdJ7OUYH0c+tKZTfKEzkTdJOumkRkDEccr/ryzHCzXv30eUTw7bNpFusfI4fyfx3JUOBEssyEc0fhpVuRSteSOtAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647425; c=relaxed/simple;
	bh=5mIrpgYYyOWnWfHA4froNo0fLcAsTlaVkF6dDIafk/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Czn+q6SIVTwHaVfFXyNh2kvbLWm+JpdGAhcRumx8zy13rI62mQz8u/u506albY0uVWXBqaIqKBqSEvLpfyOByWGQD8NOseyGbtkIdeFVlU+bTt0ZKb3xU+SzxVzDcLkrlkoy9gWvvk+1zr3nBDV6QM9ESSqsbt/Q2R1n946Zouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nemufrau; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso23102495e9.3;
        Mon, 14 Apr 2025 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647422; x=1745252222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkjFVNMudnik//LPfbYGJBFZCdlS+2tZiHLOdVcdf7c=;
        b=nemufrauGiZlhIh0s8c40fltRNQCIgSGtB7WVuDhbKRiVntPMKwdBuD3bdn7boVQSO
         3QZ6Cj5q51CylfIEXC1xW/6fo3foPWOdM3F0RHGmfFNoJJxHXvL+Pv6JsHc6gnULEQAj
         IXN8bRTn3WOHEdtjZKIUgeZ/rj66fYohQpvJf5C9IS39/9aAeQ07fPYEfp41T5yhdZ8U
         1JjhDRJNJsEhX1Y86a85plg50c457l9IVvl5iW1KChmwy4HfboSAoMF0XyjMVVrn2bYE
         x6MzczY8miNODyrujZLisx33V42eblb19dm+mt2Bna/JSkTFgsSqL2HkuIknZPPkBu7A
         e0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647422; x=1745252222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkjFVNMudnik//LPfbYGJBFZCdlS+2tZiHLOdVcdf7c=;
        b=lPYJlIdsPFwPZ2sZBkLyiwsoXvvTt/9JTFoFaEC3Yi6750SPUOi6tcVa49VwsnZkO5
         07Gv4rc4C6DzELgljHxg3mM44225XAvIi3NIIrhjlm/TSH7YqLIjbWaxGTH6rqeJ0f7v
         R99zIdjMpTh7/wV07al0Wlt4ywIBwKmUnxSGKlP7PtO4bY1XWzGq77qLbo4IoQy1T0fe
         kxnXwul3WqxFbd5kmGzZcYbgSt7lUU2i5h8RAQOsDKryMbCefi8v5TXveC4Xb3mvTee/
         dr4O6Jih1s/hZ8orLE3Yqvve/jr0ra2RGoPJpMmMswH9JKchAa0DA3vaocRd0SvJNn4K
         kKYg==
X-Forwarded-Encrypted: i=1; AJvYcCVnnoIptiIG3zeQ6iVJ4/5TiDNycvrA4cRZvGR7quyCPMejxD+IOVKz89pS1KHUBSMjoAN5VJ5czPEK@vger.kernel.org, AJvYcCW6DgQrnJDcr79kviBZmLTHhusyjvK2IpPuVKbz61Fbdnlpp07KBki24oxPgO3zN4vpRqtbruw91qy+YF2i@vger.kernel.org
X-Gm-Message-State: AOJu0YxCU2KLPlYxoYisWw4MajCsfpen73rUf0H3xtG+KzU9KjsVOlYT
	zv41LwDsgNi9VP+hOTGnuIvX0OLByRgJ7IOhI2bpYrqYQj8IvU4L
X-Gm-Gg: ASbGncvkJBmzjPWjSicFl5rycgdZ97xehKbdxMvSBapFd4thD5X83CmWi98pa2cRohn
	4WiSDfQ5FRlc4hDQhoMSFna0aTDORuKavSSYaDVa5J9/qZ/VMoRF+9cT2czuUO9RXmxAlibGEKY
	Z9mfBe84uarUaRFxsNBQPJUmqOuHtqK9EzaYiAKgq0EdyNz/mCBBsjrVbbvCPKmFw3jmeCqTDmt
	J3X359vT62+cYrI3fJrJJek4XRh0Nq7xb9eJflYIHDWc02xkxNiAU1qPUNjk/4MGQN3zmpQXL/t
	2Pm/YVvctl8g6ED73chyJ4YQlSCKGO3y4NcG009HnGrYWUo=
X-Google-Smtp-Source: AGHT+IHPIbTS1R/1F7V1Djo8inVDRUiqSFcAusGYcbzQSAXcB8tgjd3bWvhTCAjZTBdrpgu/BpVLDg==
X-Received: by 2002:a05:600c:3b15:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-43f3a9266e0mr91073805e9.5.1744647421175;
        Mon, 14 Apr 2025 09:17:01 -0700 (PDT)
Received: from noctura.suse.cz ([103.210.134.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f206264a1sm186983455e9.9.2025.04.14.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:17:00 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
X-Google-Original-From: Brahmajit Das <listout@listout.xyz>
To: 
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ACPI: Fix building with GCC 15
Date: Mon, 14 Apr 2025 21:46:42 +0530
Message-ID: <20250414161644.30400-1-listout@listout.xyz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the Linux kernel initializes many non-C-string char arrays with
literals. While it would be possible to convert initializers from:
   { "BOOP", ... }
to something like:
   { { 'B', 'O', 'O', 'P' }, ... }
that is annoying.
Making -Wunterminated-string-initialization stay silent about char
arrays marked with nonstring would be much better.

Without the __attribute__((nonstring)) we would get the following build
error:

...
drivers/acpi/acpica/acpredef.h:903:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
  903 |         {{"_S3D", METHOD_0ARGS,
      |           ^~~~~~
drivers/acpi/acpica/acpredef.h:906:11: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
  906 |         {{"_S4D", METHOD_0ARGS,
      |           ^~~~~~

and,

...
drivers/acpi/acpica/nsrepair2.c:115:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
  115 |         {"_ALR", acpi_ns_repair_ALR},
      |          ^~~~~~
drivers/acpi/acpica/nsrepair2.c:116:10: error: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (5 chars into 4 available) [-Werror=unterminated-string-initialization]
  116 |         {"_CID", acpi_ns_repair_CID},
...

Upstream GCC has added this commit
622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
about truncating NUL char when initializing nonstring arrays.

[0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
[1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455

Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/acpi/acpica/aclocal.h   |  4 ++--
 drivers/acpi/acpica/nsrepair2.c |  2 +-
 drivers/acpi/tables.c           | 28 +++++++++++++++-------------
 include/acpi/actbl.h            |  3 ++-
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6f4fe47c955b..d2cda1b35e59 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
  * expected_return_btypes - Allowed type(s) for the return value
  */
 struct acpi_name_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
 	u16 argument_list;
 	u8 expected_btypes;
 };
@@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
 					      converted_object);
 
 struct acpi_simple_repair_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
 	u32 unexpected_btypes;
 	u32 package_index;
 	acpi_object_converter object_converter;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 1bb7b71f07f1..a28b1fa2b1ea 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
 				     return_object_ptr);
 
 typedef struct acpi_repair_info {
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] __attribute__((nonstring));
 	acpi_repair_function repair_function;
 
 } acpi_repair_info;
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 2295abbecd14..27104cbb48b5 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -396,19 +396,21 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 }
 
 /* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
-static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
-	ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
-	ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
-	ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
-	ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
-	ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
-	ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
-	ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
-	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
-	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
-	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT };
+static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst
+	__attribute__((nonstring)) = {
+		ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
+		ACPI_SIG_EINJ, ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT,
+		ACPI_SIG_MSCT, ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT,
+		ACPI_SIG_ASF,  ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR,
+		ACPI_SIG_HPET, ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG,
+		ACPI_SIG_MCHI, ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI,
+		ACPI_SIG_TCPA, ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT,
+		ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
+		ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
+		ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
+		ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
+		ACPI_SIG_NBFT
+	};
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 451f6276da49..88ba1b978053 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,7 +66,8 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE];	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE]
+		__attribute__((nonstring)); /* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-- 
2.49.0


