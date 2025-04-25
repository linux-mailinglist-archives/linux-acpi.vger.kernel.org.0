Return-Path: <linux-acpi+bounces-13285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC9A9D1AF
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0953B4E4262
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB5221DBA;
	Fri, 25 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iT8hvHFQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694021E0A2;
	Fri, 25 Apr 2025 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609665; cv=none; b=P1Hnp9vfQXZ/oP+Gl/PddVONC4pD2JcR5VEgLi5fnYdH0rEzPaqugwV9aO+DmLnMYi6Ml9iy+FKrlsmMXjPiqoybPw3HF+atVk1HaoCJz0oOTDuaIOCB7MCR60Iga/wBjXP/STAYl0cX0ZzZ4cXkR/cg7Zc+J//7Ra+Eil02vQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609665; c=relaxed/simple;
	bh=pPckTPByF/XXFoU3BY7lObJpUQmjZFNX7uQDNWTtnBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYOvdLzfaPjQnztJdo0h36yvIZZTSeg3UQllAv1q3CAuyrFVTa43C1YdnXQTpeQc+GNKkkAvuyt47X/ZIKRIgjhiLUIPZcjEf5M6P8dTGajjXk0N6+zpNWcssSBoFdXTq9ZF0YHhworIZWddDFaAyzel1dxaJc7gBBsfV+1WBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iT8hvHFQ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D6A0D664659;
	Fri, 25 Apr 2025 21:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609657;
	bh=pPckTPByF/XXFoU3BY7lObJpUQmjZFNX7uQDNWTtnBM=;
	h=From:Subject:Date;
	b=iT8hvHFQhDTxlwmMgO1vBkcKd3Ii2XPqpIaZVL2tOnP0y+7SDDjB/ELX3tP/xMITI
	 EgN/Cln3iYhxtawX7qs4m9mLOZhm+la+UXrMjrrxXndZtgzEyJ1Tfx4/ebIpgVTod8
	 QT+OF//+Gsaj8UPPrOAmFJyCu5g2eX1OKQ+AbGPR2KXARflQRF414iEHKmMHnb2n4H
	 JXz9ySlaH0aGrU07g4pjxDqoLMba9JxUdok6uc1BIm2ADuKLciLozzm+d58O7d2CC2
	 /YcIgM1xuDbF2or4QIzx/Yo8OxSGzZnvNsE68t8K26hSFVwjvQNe79QXx5yRfAJeo6
	 bo6sb4pURnlDA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 12/19] ACPICA: Introduce ACPI_NONSTRING
Date: Fri, 25 Apr 2025 21:27:58 +0200
Message-ID: <1841930.VLH7GnMWUR@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Kees Cook <kees@kernel.org>

ACPICA commit 878823ca20f1987cba0c9d4c1056be0d117ea4fe

In order to distinguish character arrays from C Strings (i.e. strings with
a terminating NUL character), add support for the "nonstring" attribute
provided by GCC. (A better name might be "ACPI_NONCSTRING", but that's
the attribute name, so stick to the existing naming convention.)

GCC 15's -Wunterminated-string-initialization will warn about truncation
of the NUL byte for string initializers unless the destination is marked
with "nonstring". Prepare for applying this attribute to the project.

Link: https://github.com/acpica/acpica/commit/878823ca
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actypes.h        | 4 ++++
 include/acpi/platform/acgcc.h | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf3ad..f7b3c4a4b7e7 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1327,4 +1327,8 @@ typedef enum {
 #define ACPI_FLEX_ARRAY(TYPE, NAME)     TYPE NAME[0]
 #endif
 
+#ifndef ACPI_NONSTRING
+#define ACPI_NONSTRING		/* No terminating NUL character */
+#endif
+
 #endif				/* __ACTYPES_H__ */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 04b4bf620517..68e9379623e6 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -72,4 +72,12 @@
                 TYPE NAME[];                    \
         }
 
+/*
+ * Explicitly mark strings that lack a terminating NUL character so
+ * that ACPICA can be built with -Wunterminated-string-initialization.
+ */
+#if __has_attribute(__nonstring__)
+#define ACPI_NONSTRING __attribute__((__nonstring__))
+#endif
+
 #endif				/* __ACGCC_H__ */
-- 
2.43.0





