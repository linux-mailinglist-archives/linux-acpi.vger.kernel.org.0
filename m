Return-Path: <linux-acpi+bounces-18769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B31C4C2D9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 08:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3DA634F1E1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 07:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47206271462;
	Tue, 11 Nov 2025 07:50:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C882D0292;
	Tue, 11 Nov 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847441; cv=none; b=bMpw2TRy9qrX0HY3q4nFL5y5Ah5iFrIiw/NoOvvN6Arfc0Ptlnc4GfDAjUftS1uc8bYNzjFND9lDKuWRVQpZ4ywW4Gygfxdvs/2w7SEL/6/tDchvaVH7aTk4jKMoX833KNI2EL8gOEoqLWoO2DT3HpacJE+Np5TDD9O3lMQmTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847441; c=relaxed/simple;
	bh=474upDe9XIRvjtyq93x2kr0Fjro4gxTBuXtuuyfX04w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDAej3XqsrM1C74RhYvxQwkmAhYyIGy+kQfYuL3psx7+SpQErtInUoZU4WfTSoy6DgVyJgA9iJAVxXV/I4tGfAPJgg4vWS5c+FplvyeCP5Epk0NB0wkM7rR/3JM/LM6RaXPkpyGsxmyG65ESPF8Q+hMuIK6JIxX4crDiEvcsJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAnvMvH6hJpTJVRAA--.3706S2;
	Tue, 11 Nov 2025 15:50:33 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
Date: Tue, 11 Nov 2025 15:50:00 +0800
Message-ID: <20251111075000.1828-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnvMvH6hJpTJVRAA--.3706S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw15ArW7tryDtw1xurW3KFg_yoWDZFgEgF
	yqgrZ3Gr1kXrWIgrs7Cr9aga9Fyrn3WF98Ar4xKFWfA3WkAFW7JFy7ZFnxJryxuF43tF90
	gw1vvw1rAw1IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjb18PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRADA2kSwWCiAAAAsh

acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtain the
parent fwnode but returns without calling fwnode_handle_put() on it. This
leads to a fwnode refcount leak and prevents the parent node from being
released properly.

Call fwnode_handle_put() on the parent fwnode before returning to
fix the leak.

Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmware specific locations")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/acpi/property.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1b997a5497e7..7f8790e8dc4e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1714,6 +1714,7 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
 		fwnode_property_read_u32(fwnode, "endpoint", &endpoint->id);
 
+	fwnode_handle_put(port_fwnode);
 	return 0;
 }
 
-- 
2.25.1


