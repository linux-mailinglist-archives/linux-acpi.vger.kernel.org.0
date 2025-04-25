Return-Path: <linux-acpi+bounces-13294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B024EA9D1C5
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045FA1B8498D
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B6227E8B;
	Fri, 25 Apr 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="a4zqpdYP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A5224895;
	Fri, 25 Apr 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609669; cv=none; b=LgiT5saH5VJrZyatMeXeVFq7wt8rTDowZMb0M+T5ZuqjQQ203tiHDZJgqnJLKZOCCKHUXysEXcKfDkwQ+zJmG6eG2WgiKzo39MaLF9jvKLwYoBP4sodMgmuaGp/HPeglqUPNa1a7zxO3LoUS46t+dGgyrT/FrN56rxy6apuxJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609669; c=relaxed/simple;
	bh=jyYyqlBOdqzfAZqZWN3kugHVmB5zIKTbSCk+YAcB/r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKKZ5FovJCQGEY8ToFIiXNEa+4JVAlreSM4783t8UnT+WLIPKjW/e+1GSPfwzBvkaYM+M+sC2UL6MXTsBETjt5FBFQczB6Df1zdCTo6u7qU3ieRwUkJHQSMkmfhXpldaKmcIj8Z7pWfYovFudoUxwSYBOPKlW+6z88WDzwUMnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=a4zqpdYP; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 561E8663631;
	Fri, 25 Apr 2025 21:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609664;
	bh=jyYyqlBOdqzfAZqZWN3kugHVmB5zIKTbSCk+YAcB/r4=;
	h=From:Subject:Date;
	b=a4zqpdYP0CaWK+eFMUGcdF+L76xkrbgVuwzet5VSeP+/WrHum8a+e7DVVxJkHACD5
	 fSS3OGoTe4Ovik3vSGTWmkDYBnx3CAoTpxUNzkdkIITbYe+iYGicTKYTnT/o/IKKJZ
	 cqSLVWIS8kragxJbHv5aiULjTGl/cbVB//nJ1I1LhsSDwpoFD7MSJvR4wT007X491b
	 I+6atwsRvABi7MlYSau0C/nhXJgqHHAyIiJ1/wldmKjW011fZmUJSUTnEa/yZutYP4
	 delLHOSdRD/cPhp/9kB5j41f3e6f8k/tBPIsqSLzebz0X1x5yjHWf8/2jf7pl2aKE0
	 eKYP6lcAnfVew==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 04/19] ACPICA: Interpret SIDP structures in DMAR
Date: Fri, 25 Apr 2025 21:22:35 +0200
Message-ID: <2239745.irdbgypaU6@rjwysocki.net>
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

From: Alexey Neyman <aneyman@google.com>

ACPICA commit af51f730e0bccf789686cea68e116d5f0b27aacb

Added in revision 3.4 of the VT-d spec. To support SIDP, part of the
previously reserved field in the device scope structure was used to
create a 1-byte "Flags" field.

Link: https://github.com/acpica/acpica/commit/af51f730
Signed-off-by: Alexey Neyman <aneyman@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 329454c303b9..e0cbda95fec8 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -819,7 +819,8 @@ enum acpi_dmar_type {
 	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
 	ACPI_DMAR_TYPE_NAMESPACE = 4,
 	ACPI_DMAR_TYPE_SATC = 5,
-	ACPI_DMAR_TYPE_RESERVED = 6	/* 6 and greater are reserved */
+	ACPI_DMAR_TYPE_SIDP = 6,
+	ACPI_DMAR_TYPE_RESERVED = 7	/* 7 and greater are reserved */
 };
 
 /* DMAR Device Scope structure */
@@ -827,7 +828,8 @@ enum acpi_dmar_type {
 struct acpi_dmar_device_scope {
 	u8 entry_type;
 	u8 length;
-	u16 reserved;
+	u8 flags;
+	u8 reserved;
 	u8 enumeration_id;
 	u8 bus;
 };
@@ -923,6 +925,15 @@ struct acpi_dmar_satc {
 	u8 reserved;
 	u16 segment;
 };
+
+/* 6: so_c Integrated Device Property Reporting Structure */
+
+struct acpi_dmar_sidp {
+	struct acpi_dmar_header header;
+	u16 reserved;
+	u16 segment;
+};
+
 /*******************************************************************************
  *
  * DRTM - Dynamic Root of Trust for Measurement table
-- 
2.43.0





