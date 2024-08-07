Return-Path: <linux-acpi+bounces-7397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D25949FDD
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 08:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C257284372
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EA1B5821;
	Wed,  7 Aug 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMN/L43Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC521B5817
	for <linux-acpi@vger.kernel.org>; Wed,  7 Aug 2024 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012725; cv=none; b=t0E05WoSGjof0ZaRelk2G2EV/3vtjf4pVoHbFIME3VceAiSft1ynCeTxvmwcsLD5b5nXqGMYjJYczfVdR9QoG9Gz8KMbAA4Q+Mb404dJEBAnCf8R67z9Ng5cm+3dP9/YT5uMh8nS/RFPDSn2c+lIcwMh1SKPCFDHJ5iXgpkM4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012725; c=relaxed/simple;
	bh=uLYUHtEGQLjfak6R41AoA3cjPMFVdYNbZd5bOiIAwUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iZ3W+R99A1ADkH01ccCR+s6aG13d5s+Tb43Ar+8xhHE8KTm+EuI049mvspHZXyxdYFnj6R0JykR2chfgRMskx3q9vmLLZcdY+97Rdruh9ZwjgBJFSaVFdOtzaxVXuieYlJj6cRv/wIFeVfHWiUwLbxAU0/ocHluCstg+G0HWMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMN/L43Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1E82C32782;
	Wed,  7 Aug 2024 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723012724;
	bh=uLYUHtEGQLjfak6R41AoA3cjPMFVdYNbZd5bOiIAwUc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rMN/L43ZJYxvLgE1Nkpd706DKghFRUjY/fuzLiW+JGoys4rvD/+yWETzjEipTdFYO
	 +ECicUW0zHTTJl+9ZWSvL/a3xDFLanSou+tohbww771JLlUiKky4xV0i+orWZyoP7y
	 Q+pNbq9ZGb7baJHouLtqiYc98eetV4jtnKurjgSmIYKUR8wtYyAvBFErGWCHNG5KFg
	 enAJLTaT7T/YsH+Qmj1VnOglfAUulUr1oSx2ICka09JogeP8LVKX6JMsoXLaiWpbLq
	 qRgxxFSJiMfQW7jcQvLAl2BF9U6tIkgSXRATOABzE/dJRpeeSxMq4Ecc3I1c1T0QYF
	 /yjiL8FKi4NKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE0C52D6F;
	Wed,  7 Aug 2024 06:38:44 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 07 Aug 2024 14:36:12 +0800
Subject: [PATCH v2] ACPI: introduce acpi_arch_init
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com>
X-B4-Tracking: v=1; b=H4sIANsVs2YC/x3MQQqAIBBA0avIrBsQi8quEi3ExpqNySgRhHdPW
 r7F/y9kEqYMi3pB6ObMV2wwnQJ/ungQ8t4MRptBz3pCjkUudD4xOvFnMxcM3tpAfU+j2aGlSSj
 w82/XrdYPmQDXLGYAAAA=
To: Hanjun Guo <guohanjun@huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=PwRtjL6KwaJet/RgRLb11kIQcxlFiQsK9B6kUpBB98I=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmsxZzDbVLjrRb5y9D3vj5+ZJtq/uQt1buMk2J0
 yY/VdwFnQ2JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZrMWcwAKCRCwMePKe/7Z
 bmhTD/0awF1iZkM4M3/RJ8uH0JLx9//MZ+4UbNQ/bk3rkzyx7eeYjW3yzIipcptQl2czV5bH4TK
 UHthyGbyJXXHnTSt9C7yv3lXmhVOxaLaJ0WvEWr6lxaW5HOL/5YPyQK5FlepvuHt917CcWxnN9P
 02fpZJbMVs4j2injz1uak/OMxzVP0+3dXFsw5wSRUMBjLvOAu3hw8WujVsKtJ3nQZH6eVqwxV9u
 Fpylxrqy5kvtMbrJ53/WUdNO0v9GUM2tmYX5TgBgnVHLXN15BNyHfMGSvjllG3GVRwFyhc+Fq23
 Q0gt7UqiY3lAb8+9vJ98IAbORIV53J3IjCZghu6kp/NLxP6s+pZyCg7Gnqk9G+S13kB69Y12jKf
 eEXbEhAAk/XVmBIvZcy/0r6Hh9Z7WlXcCN1H0seCikEmNEkkb9XJWGFPR3moPIjZYzdnIPXRIuW
 rpZMkkCHBTA1TM94iaSAfLCnWZ/vvvU9yQUPBR1nke6358Kq3zlbFqhJ975oI3dnBBKbG6e88aq
 iu2CDJV9P0aJtaJC0IQ4YjkdsNcvbdS45NBU+c3kC5Ib2QGBd1azGc3lg6kbrdpnd+u81HPxVit
 PXlDa0IR+autUP1X/f7hjdKTB3KlXEcJh2R9NDrZravfs5aSA3uCvfK54HS17DahgMAz+pdjYLj
 67jgYqyHg1TNIDw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Miao Wang <shankerwangmiao@gmail.com>

To avoid arch-specific code in general ACPI initialization flow,
we introduce a weak symbol acpi_arch_init. Currently, arm64 can
utillize this to insert its specific flow. In the future,
other architectures can also have chance to define their own
arch-specific acpi initialization process if necessary.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Changes from v1
- Change acpi_arch_init from a static inline stub to a weak function
  according to Haijun Guo's advice
---
 drivers/acpi/arm64/init.c | 2 +-
 drivers/acpi/bus.c        | 4 +++-
 include/linux/acpi.h      | 6 +-----
 3 files changed, 5 insertions(+), 7 deletions(-)

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
index 284bc2e03580..b47541e45a5a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1431,6 +1431,8 @@ static int __init acpi_bus_init(void)
 struct kobject *acpi_kobj;
 EXPORT_SYMBOL_GPL(acpi_kobj);
 
+void __weak acpi_arch_init(void) { }
+
 static int __init acpi_init(void)
 {
 	int result;
@@ -1458,7 +1460,7 @@ static int __init acpi_init(void)
 	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
-	acpi_arm_init();
+	acpi_arch_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..52862c377747 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1523,11 +1523,7 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_ARM64
-void acpi_arm_init(void);
-#else
-static inline void acpi_arm_init(void) { }
-#endif
+void acpi_arch_init(void);
 
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);

---
base-commit: d4560686726f7a357922f300fc81f5964be8df04
change-id: 20240807-intro-acpi-arch-init-fc99fe33e62d

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



