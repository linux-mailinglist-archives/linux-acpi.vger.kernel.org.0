Return-Path: <linux-acpi+bounces-10172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2E9F453B
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3851888CE0
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2718DF62;
	Tue, 17 Dec 2024 07:37:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F816EB7C
	for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421061; cv=none; b=SXMLd51D5u4idv+NyvK91d8PQTWwUt4RacxF+8SZWylJl/kxVpZZbiQfIFP8omKuL5MFZ1mW/XLpTElpY+4iETenuJRyRC9JaO3Mjl67pG/gzsdXSlDS6g/J8IGRm68lEaMfkdb0DBx21ayOHM2RZ0FeUU7/AMuSgU2yJHYh6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421061; c=relaxed/simple;
	bh=qk1pLnOgCMuXpFYHx8AiSmUj83Tvxx9m3apNTq2l47Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EE5yU1nKHXGGqGvtTolxwSPwZ2lrfkhLm2CNvNOfRKVWzso7shnQrLxTSHYWaGi5JLzDotGWPnXyzHODcrui8RmtGDYp5CUndJbcRdoY/Zm3ZoVVqVM6tuMOK4WNJG5PlbE+JY+FPfmwv36mgHWN3sYKYYlpmPSyrS/s203mraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.7])
	by gateway (Coremail) with SMTP id _____8Dx2uE8KmFnoLFXAA--.43062S3;
	Tue, 17 Dec 2024 15:37:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.7])
	by front1 (Coremail) with SMTP id qMiowMBxnsc2KmFnZgUAAA--.25S2;
	Tue, 17 Dec 2024 15:37:31 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xiaotian Wu <wuxiaotian@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] ACPI: EC: Enable EC support on LoongArch by default
Date: Tue, 17 Dec 2024 15:37:04 +0800
Message-ID: <20241217073704.3339587-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxnsc2KmFnZgUAAA--.25S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWrKw4fZFyDtFW8Cr18tFc_yoW8AF4Up3
	9rZFy7Cr4UJF45Ar1DC3y8uFW5X3ZxGrW7uay7Cw1DuF9rur98Aw1jqF93JFyUAwsxAa40
	vF95Wayj9an8WwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxU2MKZDUUUU

Commit a6021aa24f6417416d933 ("ACPI: EC: make EC support compile-time
conditional") only enable ACPI_EC on X86 by default, but the embedded
controller is also widely used on LoongArch laptops so we also enable
ACPI_EC for LoongArch.

The laptop driver cannot work without EC, so also update the dependency
of LOONGSON_LAPTOP to let it depend on APCI_EC.

Reported-by: Xiaotian Wu <wuxiaotian@loongson.cn>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/Kconfig               | 4 ++--
 drivers/platform/loongarch/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d65cd08ba8e1..d81b55f5068c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -135,10 +135,10 @@ config ACPI_REV_OVERRIDE_POSSIBLE
 config ACPI_EC
 	bool "Embedded Controller"
 	depends on HAS_IOPORT
-	default X86
+	default X86 || LOONGARCH
 	help
 	  This driver handles communication with the microcontroller
-	  on many x86 laptops and other machines.
+	  on many x86/LoongArch laptops and other machines.
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongarch/Kconfig
index 5633e4d73991..447528797d07 100644
--- a/drivers/platform/loongarch/Kconfig
+++ b/drivers/platform/loongarch/Kconfig
@@ -18,7 +18,7 @@ if LOONGARCH_PLATFORM_DEVICES
 
 config LOONGSON_LAPTOP
 	tristate "Generic Loongson-3 Laptop Driver"
-	depends on ACPI
+	depends on ACPI_EC
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	depends on MACH_LOONGSON64
-- 
2.43.5


