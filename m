Return-Path: <linux-acpi+bounces-6071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541B8D2D4F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 08:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919891C2267F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2024 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8552482FF;
	Wed, 29 May 2024 06:32:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1838DE8;
	Wed, 29 May 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964335; cv=none; b=Cq0dbbFIKYg748ccG0owm0E+u4lVrjrwQw4cC7WJntHYEvAgSwlfs2AET0uIuRMwIKQttRaCXffU4fGp9mnr2ktsJMkQ/GZdna0iwLqptSSYeYXsgLydQCs3gKjKsJKDkLjf8DK6LbpQz+FKibPW5SZRaI4Ujy8Mvx4Zuo6pX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964335; c=relaxed/simple;
	bh=Xs98dxPvN8E+SI+7xNtVW3wrO5Cb9Zr5Ix8c8yFymWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBvp5DR7iwBXktcJcHs6/OjxwnQxHE6gZJsFYvyYOjejk/wWjl20BhJYQiCIt0dUx/wZ87Z8b5BsvkNRFgaDGq7dX8d8BTQGtJDILvOasrLXPbRyujK6oHYrXsfFzh1Ilt4Rgsr+B4m7s+mU1cj6vBJ7c6phfLnxuLVM6jYpokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx7erpy1ZmfgMBAA--.4358S3;
	Wed, 29 May 2024 14:32:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxNMXoy1ZmY6YMAA--.22585S2;
	Wed, 29 May 2024 14:32:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	rafael@kernel.org
Cc: loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()
Date: Wed, 29 May 2024 14:32:06 +0800
Message-ID: <20240529063206.30421-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxNMXoy1ZmY6YMAA--.22585S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW7uw1xXFy8GFW3AF1rKrX_yoW8XFyxpr
	1Fyr4kKr45u3s7GFyUA3s5ur98trnFk34xXFWjkryrC3Z8Wr18XF4qgF9rZF1Fqw48Kw4I
	v3WftF1agFW0kwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW7UUUUU==

acpi_table_upgrade() and acpi_boot_table_init() are defined as
empty function under !CONFIG_ACPI_TABLE_UPGRADE and !CONFIG_ACPI
in include/linux/acpi.h, there are no implicit declaration errors
with various configs.

As Huacai suggested, CONFIG_ACPI_TABLE_UPGRADE is ugly and not
necessary here, just remove it. At the same time, just keep
CONFIG_ACPI to prevent build error and give a signal to tell
us the code is ACPI-specific, and also put acpi_table_upgrade()
under CONFIG_ACPI.

  #ifdef CONFIG_ACPI_TABLE_UPGRADE
  void acpi_table_upgrade(void);
  #else
  static inline void acpi_table_upgrade(void) { }
  #endif

  #ifdef	CONFIG_ACPI
  ...
  void acpi_boot_table_init (void);
  ...
  #else	/* !CONFIG_ACPI */
  ...
  static inline void acpi_boot_table_init(void)
  {
  }
  ...
  #endif	/* !CONFIG_ACPI */

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index ea6d5db6c878..08a077e4efd7 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -353,10 +353,8 @@ void __init platform_init(void)
 	arch_reserve_vmcore();
 	arch_reserve_crashkernel();
 
-#ifdef CONFIG_ACPI_TABLE_UPGRADE
-	acpi_table_upgrade();
-#endif
 #ifdef CONFIG_ACPI
+	acpi_table_upgrade();
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
-- 
2.42.0


