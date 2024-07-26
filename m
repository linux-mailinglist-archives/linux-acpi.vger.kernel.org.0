Return-Path: <linux-acpi+bounces-7058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C6993D5BF
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C1C1C22EBF
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F5176FDF;
	Fri, 26 Jul 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw/TiznC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51F144D0A
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006787; cv=none; b=j9KS17wfu75psGW9brukEIg4hRlQwtOGj3X/O34rFidS40P9YteqcwR8YL2Cm4DAhY+ENXOtr3YlxQr0z/NEl4UahT0wgg/XkQET6QcxeOyW7ALkgfelkxORgmQjVI0yEV7IK1G2FZyVChXWcLb1pfexGLC2+kAjiAlMzfeudZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006787; c=relaxed/simple;
	bh=DJ86BtVE2JCzrx59f0Fa+KK1Cd6I5tsMr5jZeIX0zJg=;
	h=From:To:Cc:Date:Subject:Message-Id:MIME-Version:Content-Type; b=h0kHaFNs9U14OK992WlpVfOouWDzgmgZjhlUDvhJg53BQm2MWQRDQiAvq1A5QTM53RcaDhhKUpR59GJmShqOkYEdu2ym5d4yfki3x9XMRDCShSHYKG6MYpZM1bizakMRXriXfIiGZQLcGXycJrlJstnTZpRMy5fxDfjtjB1+WtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw/TiznC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0777CC32782;
	Fri, 26 Jul 2024 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722006787;
	bh=DJ86BtVE2JCzrx59f0Fa+KK1Cd6I5tsMr5jZeIX0zJg=;
	h=From:To:Cc:Date:Subject:Reply-To:From;
	b=Qw/TiznCswf+uZm/inCEB7Sr7wnLIYbk7ZnG3cRSD2Zshf4Ii8qngzLK1PTC4niRQ
	 jqdpW1pr6SKRyyW3rN14mUIszGkb+iLmBNGlJ+FKul5J0T7ljYniVTb+NG23hIFH62
	 Qw9DVX5OWREPME1I2odIjh32BdtG8mj/djFCjljt1uErt7IyNYNgHNI9BHO1V7e/hN
	 XvsqxNTUF0WEMTgG5wK2Wx+r9yoaVu+ZCxgXALdcg35JeDA2dZAY2vwPTmMj5x9ZUO
	 fo4roqv6BshdE8dtBNdgxOMmFnTb4Gj4sxlmwA9YOwXaoIjREn9Ey/LrtBc+2A/lti
	 Md8lOM2mWTjTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E51C3DA4A;
	Fri, 26 Jul 2024 15:13:06 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>
Date: Fri, 26 Jul 2024 23:03:01 +0800
Subject: [PATCH] ACPI: rename acpi_arm_init to acpi_arch_init
Message-Id: 446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=CSwR7TCrsvxBPNO4Jtd8j8bvR9ZKzVr6G7jVKrKc2YE=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmo70BNKf+wvGOF+OSz4/dfrlMNQTR+yfGwNLRI
 6Ww8gkp0iqJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZqO9AQAKCRCwMePKe/7Z
 bqZZD/wLFGqmtueW+3Cie4OcSd8aAT6XB3iIl/wxoQSMWN87RcC0Nr578CQ2IGmbCP3BORRm/7B
 mflmMfxLruh0Yqp3tjXRMwXf3BRrD/u8LIC4ccLivlG5OJZZb3jvdnjB11WIj6cjqdpZBPe2XCi
 besJCMEwqLIkqd1N1LKa/rGKDLY8qmn6PQpNOhupGXNpBp/7DwNI7pcT1RolcFledN3ZZALCymY
 g3VUWWykFEh/u0djm8RHfsQ7V8KrIz22OYG5v+DTGfeasb0Bx9yqIxHMUbOkaZe+zd3lMI+QPJ4
 iak5imJ9yavYnMbs9I5GRouEK/QpyxzPsbZzmihSfkzSOe45UXDTcefLc9HqMWpj7Q5I5R714tT
 dDtO0vrnqAhYNJaZs2LMYVvTzoqrbl+PqIWYzayMzJc+rGESdBnx8oT/AJJfny43zGR5IS33xDi
 MWdJlwDpld+g/n+KMFoFw3oug2RGtB5sKUdztxUrwQLlBfGsS60mZbUHVya1QlHTYnCX8KijBfW
 aul8tJCCLdwOn3wOSSKH645tC/MijdHgi1WlcMXPeBvmP7ajS2Cnb4synIDS7Qe3xUv4Pe6b2IZ
 wik9FKwGZr3mimSOXyMUvZ4eIezqc7CLYE0djzCz326kl+5UrxX4/Ztn9kLLkiKlIAzp1BK+s4c
 CccvAn3xrX6qpcg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Miao Wang <shankerwangmiao@gmail.com>

So that we avoid arch-specific code in general ACPI initialization flow.
Other architectures can also have chance to define their own
arch-specific acpi initialization process if necessary.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 arch/arm64/include/asm/acpi.h | 2 ++
 drivers/acpi/arm64/init.c     | 2 +-
 drivers/acpi/bus.c            | 2 +-
 include/linux/acpi.h          | 6 +++---
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index a407f9cd549e..0d24e920e143 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -188,4 +188,6 @@ static inline void acpi_map_cpus_to_nodes(void) { }
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
 
+#define ACPI_HAVE_ARCH_INIT
+
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
index d0c8aed90fd1..7a47d8095a7d 100644
--- a/drivers/acpi/arm64/init.c
+++ b/drivers/acpi/arm64/init.c
@@ -2,7 +2,7 @@
 #include <linux/acpi.h>
 #include "init.h"
 
-void __init acpi_arm_init(void)
+void __init acpi_arch_init(void)
 {
 	if (IS_ENABLED(CONFIG_ACPI_AGDI))
 		acpi_agdi_init();
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 284bc2e03580..662f69e379ef 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1458,7 +1458,7 @@ static int __init acpi_init(void)
 	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
-	acpi_arm_init();
+	acpi_arch_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f0b95c76c707..3c3a83499c2d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1517,10 +1517,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_ARM64
-void acpi_arm_init(void);
+#ifdef ACPI_HAVE_ARCH_INIT
+void acpi_arch_init(void);
 #else
-static inline void acpi_arm_init(void) { }
+static inline void acpi_arch_init(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_PCC
-- 
2.39.2



