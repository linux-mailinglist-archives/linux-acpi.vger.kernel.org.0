Return-Path: <linux-acpi+bounces-19651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44654CCAFAA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 09:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE17C31157C2
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA32FE071;
	Thu, 18 Dec 2025 08:37:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA415B971;
	Thu, 18 Dec 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047025; cv=none; b=qvzTgI+r1U31EqquivfA+3yqdy14blxsPh4ZbMdhP80Bnn8BZMSb9T/GpbeOSKPSMHp8KlDuIt+qqS1pyD+em2DI273Wm8v7d+SdiKCpkkj0xymWK+Al0eeJWeTaHdMpYBLA24tr9l2+K1A8jBYugimIZX4kTyGV3p5PNi/BCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047025; c=relaxed/simple;
	bh=TDgtRH+Y0LEyighxlQQbu6qwnxKsPuJ+suU+hKnrFYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJJ1Nqp1TmdpmXbhVeBjbBt5mn+v3byOwSCkgSbhqIqe9xXczZcEPBxGQF9btjXi09cH0t9j+Q1hi33sqh9jQblDOgBQuC/p8euLFg0f7j3LZDPo2ASKIL9+nvQk2OnmD0KgAZtinDV7p722kcWeHzL3oN1jtEZT1s5w4OLwECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-05 (Coremail) with SMTP id zQCowACHHREfvUNpg_MPAQ--.15313S2;
	Thu, 18 Dec 2025 16:36:47 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: perex@perex.cz,
	rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PNP: add a put_device() in isapnp_init()
Date: Thu, 18 Dec 2025 16:36:46 +0800
Message-Id: <20251218083646.553049-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHHREfvUNpg_MPAQ--.15313S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1UXF47Gry3Gr17uF4xXrb_yoW3KrbEq3
	yjva42qrW8uan3Jr1UXF1rZF12vwn0gFs7uF1UtFsxA3y8JFnFyrW5Zas8Aw18Xrn3ZryD
	J3W5GFZ3Cw4xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwkAE2lDlnOgMQAAsD

if pnp_register_protocol() fails, call put_device()
to drop the device reference.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/pnp/isapnp/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 219f96f2aaaf..d6daab7ed59e 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -983,8 +983,10 @@ static int __init isapnp_init(void)
 		return -EBUSY;
 	}
 
-	if (pnp_register_protocol(&isapnp_protocol) < 0)
+	if (pnp_register_protocol(&isapnp_protocol) < 0) {
+		put_device(&isapnp_protocol.dev);
 		return -EBUSY;
+	}
 
 	/*
 	 *      Print a message. The existing ISAPnP code is hanging machines
-- 
2.25.1


