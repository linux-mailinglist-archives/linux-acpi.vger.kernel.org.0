Return-Path: <linux-acpi+bounces-19650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CCCCAE57
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 09:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2085303D9D0
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C73314A0;
	Thu, 18 Dec 2025 08:29:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8D2F4A1E;
	Thu, 18 Dec 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046555; cv=none; b=mdk7EP4yY/bDUHMfN3Hqtwmdd7lgGHPr1phWNMZB08RfTtAogvpiwjqD7gsmR23sWb3STwwmLJ+DkwUxeFoGKj+I+trLs9bXQmQLWTui4fkSSO3KUEDqlmqlOu5jj86KkUyyi3xaIrpBa2eboolCsDsJ8JfFo15kHVYDbDq3naI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046555; c=relaxed/simple;
	bh=yan87aoK1lKEqlTcLKlz/R7dPwf7+CWveoL0gDer/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFqLIlaEqt7NmIQBFuGDIbj8kpMNYtlZ4YZYvUrmamWArEFFor9MUZLW0o7/HTtLVQDW73RkFH+AVfBG461iP8Ue7XVrvjwprdcghPiFU1fNZZYY5upTOqg1kPF45i6ZfrQKs48nODy1g3HECpCR6l17coeOsmylzv8Rx9qjK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowABn+g1Qu0Npfc4PAQ--.38831S2;
	Thu, 18 Dec 2025 16:29:05 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PNP: add a error handling in pnpacpi_init()
Date: Thu, 18 Dec 2025 16:29:03 +0800
Message-Id: <20251218082903.551296-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn+g1Qu0Npfc4PAQ--.38831S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw17Zw43Zr4kGr4fKF45Jrb_yoWDXFXE9F
	W0qa42qryfuws2kr1UXF18ZFyUtFn2gF48WanYqF1fA395XrWkZr98Cr98JanrWF18CFy7
	Kw45Kr48ArZ3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwwAE2lDlnOZaAAAsm

Add a error handling for pnp_register_protocol(), and if
it fails, call put_device() to drop the device reference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/pnp/pnpacpi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index a0927081a003..0b63e1748b7c 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -304,7 +304,10 @@ static int __init pnpacpi_init(void)
 		return 0;
 	}
 	printk(KERN_INFO "pnp: PnP ACPI init\n");
-	pnp_register_protocol(&pnpacpi_protocol);
+	if (pnp_register_protocol(&pnpacpi_protocol)) {
+		put_device(&pnpacpi_protocol.dev);
+		return 0;
+	}
 	acpi_get_devices(NULL, pnpacpi_add_device_handler, NULL, NULL);
 	printk(KERN_INFO "pnp: PnP ACPI: found %d devices\n", num);
 	pnp_platform_devices = 1;
-- 
2.25.1


