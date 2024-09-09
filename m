Return-Path: <linux-acpi+bounces-8202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B1970B88
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Sep 2024 03:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64641B210A5
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Sep 2024 01:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333911711;
	Mon,  9 Sep 2024 01:55:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56D33EA;
	Mon,  9 Sep 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846921; cv=none; b=tz4m9WNAmkDOLmfw5sbvRLk278YHCFfUozHRpLuMnlNCHerha+o9f3Js9xNy6Sro/Coh2puiZbI6SeewWHu/U4eryW16RH9SMK68enHGln+mdqQSUlla6MvRhsEqSl2Z86/jyg8hMkst+gbTMAkhIQaOKd65xd4PMQHVtvNgqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846921; c=relaxed/simple;
	bh=Zjvnt6HWMsxC2GyC6zf6bm8M8oO8eTAyrccM4we1/d4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TldkDkajLQpRsIo4MV6+rC2sXyAmoioUyyoAbcHlH80WVr8bRZ0k6aUJYPYb1w+dXD/HCUFzIRRLhps4Qf840d6jYHLIvolIK3YPrc0btn4A5jAbaNa/zOihFPItFNwBnz63pVep8y78uxndq4u4WmZB3//DCD7I+ZfvM0ufWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxSOmDVd5mkF8CAA--.4555S3;
	Mon, 09 Sep 2024 09:55:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxHeSDVd5mLgUCAA--.12375S2;
	Mon, 09 Sep 2024 09:55:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] LoongArch: Enable ACPI BGRT handling
Date: Mon,  9 Sep 2024 09:55:14 +0800
Message-Id: <20240909015514.597253-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxHeSDVd5mLgUCAA--.12375S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add ACPI BGRT support on LoongArch so it can display image provied by
acpi table at boot stage and switch to graphical UI smoothly.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/acpi.c | 4 ++++
 drivers/acpi/Kconfig         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 929a497c987e..f1a74b80f22c 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/memblock.h>
@@ -212,6 +213,9 @@ void __init acpi_boot_table_init(void)
 	/* Do not enable ACPI SPCR console by default */
 	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
 
+	if (IS_ENABLED(CONFIG_ACPI_BGRT))
+		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+
 	return;
 
 fdt_earlycon:
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e3a7c2aedd5f..d67f63d93b2a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -451,7 +451,7 @@ config ACPI_HED
 
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
-	depends on EFI && (X86 || ARM64)
+	depends on EFI && (X86 || ARM64 || LOONGARCH)
 	help
 	  This driver adds support for exposing the ACPI Boottime Graphics
 	  Resource Table, which allows the operating system to obtain

base-commit: b31c4492884252a8360f312a0ac2049349ddf603
-- 
2.39.3


