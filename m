Return-Path: <linux-acpi+bounces-18023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A9BF580F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C45664FE9DB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1132AAD1;
	Tue, 21 Oct 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="mtcgjYK/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D130269AEE;
	Tue, 21 Oct 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038933; cv=none; b=Tvv5vpWYssTlpfeWhgtcvypWEfw7rNc2JvSMhEHHYO+g0s1LEiEviPpD0kW9uHIl/maWs4JQywanZ1u2yJbuUhhbryMRCSZgrRq4Lj2NJmyuOOuv0YZ9WPF3qvmypAA/9S11GLgt71AmIjV+Y1Iio21ru/V+PI4oT+7Kuk1z5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038933; c=relaxed/simple;
	bh=nY1r0rxq3zaIyV9igiRD6jd9u+zKeLm99ZgpBR96GdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZPZx6hdMbuxpjrz6btcfD0Ks+PlPwTChy5OT2Rj8fHBIgqtSF2su9WqjYQF/uvrUCdetB+Als2M6GTmm4+N5ieEzqsyyKFV4Eu5eZ/amS74uqcVmPSvmZYVr64PiWAy0qSKH9nApiNCC8MDL2fPkF01PwzV3Z8wiJ4LgLAtdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=mtcgjYK/; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1761038924;
	bh=6oB5odA3UzXNEi7uAc9r3126xC/gOgrjKsCdeXENfnU=;
	h=From:To:Cc:Subject:Date:From;
	b=mtcgjYK/H7i5havNt1Z+iywQROBMi1C/19KSLs03eDNPrlLLNaxgHt+j5HQmHuNY3
	 u2fs2y2N1MZJx0LHe+TPIyLDmOkuMkGmxB86HCS9nK+zLf9JeWflmO5FNsXsh8Vh/r
	 OO1NsZF987gHXUz12J6tPALakJd/Sd5k+6CQQO8s=
Received: from stargazer (unknown [IPv6:2409:8a4c:e29:d50::b3c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 14EC566D01;
	Tue, 21 Oct 2025 05:28:40 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Guenter Roeck <linux@roeck-us.net>,
	Xi Ruoyao <xry111@xry111.site>,
	stable@vger.kernel.org,
	Saket Dumbre <saket.dumbre@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-acpi@vger.kernel.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
	acpica-devel@lists.linux.dev (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] acpica: Work around bogus -Wstringop-overread warning since GCC 11
Date: Tue, 21 Oct 2025 17:28:25 +0800
Message-ID: <20251021092825.822007-1-xry111@xry111.site>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ACPI_MISALIGNMENT_NOT_SUPPORTED, GCC can produce a bogus
-Wstringop-overread warning, see https://gcc.gnu.org/PR122073.

To me it's very clear that we have a compiler bug here, thus just
disable the warning.

Cc: stable@vger.kernel.org
Fixes: a9d13433fe17 ("LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled")
Link: https://lore.kernel.org/all/899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net/
Link: https://github.com/acpica/acpica/commit/abf5b573
Co-developed-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/acpi/acpica/tbprint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 049f6c2f1e32..e5631027f7f1 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 11
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
+
 	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
@@ -143,4 +148,5 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   local_header.asl_compiler_id,
 			   local_header.asl_compiler_revision));
 	}
+#pragma GCC diagnostic pop
 }
-- 
2.51.1


