Return-Path: <linux-acpi+bounces-19649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E993BCCAD7B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 09:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C881302CF7B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C065338F20;
	Thu, 18 Dec 2025 08:20:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2033373E;
	Thu, 18 Dec 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046011; cv=none; b=dLonQH+qPxujJoEMotHQa/083pPQM7hexWr6JgYyZpl8EL+dNSZigp/84wibmHgu5P/5AwfaomvdR+RwwtsC+1RbFovYjR7FyRh4y8Da2NZRmJLrrlkvlht3WOmXue/FiU33xOebrHc9Di3VgyYhdUTfTMDNCgXzsub5Y7KnVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046011; c=relaxed/simple;
	bh=rPLXOZC3Wt6koNftBuHRaL3/E30W8zFZBc7CjteOnXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtbCT73y8QU9EBisZekqihIZodWqOdvQreLvSUmlLbRELBrBmG//GSGixpRZ1nOTpsXtc6X8uCamtUxRRf9MkeWzmV+wtouopeq+jdiWjeCeG5Wc5NplxLknzxwk27fYs5xJ8LMxxSeYy71sXhmAgNWXaUY6ZHsFFCOAx8Ucn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowAA3zRAsuUNpBp0PAQ--.5448S2;
	Thu, 18 Dec 2025 16:19:56 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: rafael@kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PNP: add put_device() in pnpbios_init()
Date: Thu, 18 Dec 2025 16:19:55 +0800
Message-Id: <20251218081955.548521-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3zRAsuUNpBp0PAQ--.5448S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1UXF47Gry3Gr17uF4xXrb_yoW3CrgEgF
	y0gFy2qrWrC397Gr1UJr1xZFWUK3ZruFs29r4ktF4Yy34Iqr1qg3s8Zr98A34Uua1xAryD
	AFW5trWxArs7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCRETE2lCxptgmQABsW

If pnp_register_protocol() fails, call put_device()
to drop the device reference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/pnp/pnpbios/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f7e86ae9f72f..997e0153d6e3 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -538,6 +538,7 @@ static int __init pnpbios_init(void)
 	/* register with the pnp layer */
 	ret = pnp_register_protocol(&pnpbios_protocol);
 	if (ret) {
+		put_device(&pnpbios_protocol.dev)
 		printk(KERN_ERR
 		       "PnPBIOS: Unable to register driver.  Aborting.\n");
 		return ret;
-- 
2.25.1


