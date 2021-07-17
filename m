Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52293CC0D9
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jul 2021 05:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhGQDVe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 23:21:34 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52938 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230504AbhGQDVe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 23:21:34 -0400
Received: from localhost.localdomain (unknown [114.217.243.208])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxgOIATPJgEO8gAA--.19368S2;
        Sat, 17 Jul 2021 11:18:29 +0800 (CST)
From:   Rui Wang <wangrui@loongson.cn>
To:     linux-acpi@vger.kernel.org
Cc:     Rui Wang <wangrui@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: Kconfig: Fix table override from built-in initrd
Date:   Sat, 17 Jul 2021 11:18:06 +0800
Message-Id: <20210717031806.29866-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxgOIATPJgEO8gAA--.19368S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kXF43ur17Ww15KrWfZrb_yoWkZFXEg3
        WDJF1xJryUArW0yry0qa1fZw1qyw1fWFyfZw4DK34Svr97J393u3s8AFyDJ347Ca4xKw1U
        Zwn5Xrn7Ary2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU84SoDUUUU
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 65e00e04e5aea ("initramfs: refactor the initramfs build rules")
had dropped the CONFIG_INITRAMFS_COMPRESSION.

This patch updates INITRAMFS_COMPRESSION="" to INITRAMFS_COMPRESSION_NONE.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Len Brown <lenb@kernel.org>
CC: Shunyong Yang <shunyong.yang@hxt-semitech.com>
CC: linux-acpi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Rui Wang <wangrui@loongson.cn>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9d872ea477a6..8f9940f40baa 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -370,7 +370,7 @@ config ACPI_TABLE_UPGRADE
 config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
 	bool "Override ACPI tables from built-in initrd"
 	depends on ACPI_TABLE_UPGRADE
-	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
+	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION_NONE
 	help
 	  This option provides functionality to override arbitrary ACPI tables
 	  from built-in uncompressed initrd.
-- 
2.32.0

