Return-Path: <linux-acpi+bounces-12366-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E0A6A2BF
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCED58A4CF8
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Mar 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725B222577;
	Thu, 20 Mar 2025 09:33:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F42222CA;
	Thu, 20 Mar 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463185; cv=none; b=Tvy8LcGcBYY3rBQzBiGsWnxzuT07HqdPHfpA+t95/iP3rGumty7ITbkDNwyLePMdED/vWk8s3wUwZKF7EVGpb6q+NehoiTLGfBBlerT/Cx2ytQsr33Ki//frzh8tArHWhb9QvCxjWyXKw21gIDCu0481XtTVdmj1y6oGzA9kUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463185; c=relaxed/simple;
	bh=zGVoYuexyNAYTW+12AY61QB9oJUhu0/d1dOlv0Die0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZp8dYPMLPDPOa/a6yd30Qa5cnKZ+rEOQ3wXKB2nA9aDKmA6h8AEN6UWfc2aL84/FJHCj4qcdI9WzERqOdcSna2tkJf9ya83O9z/5f1RVxuEBmpfh/FsoH1r0MwJCBMkwgSomta3aXUI6IEnQPM4MTK6mXnDGKcs3Eexcfb9BRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.1])
	by APP-05 (Coremail) with SMTP id zQCowADn7qLC4Ntn6cmWFg--.39879S2;
	Thu, 20 Mar 2025 17:32:51 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: qiaozhe@iscas.ac.cn,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: Adjust the position of code lines.
Date: Thu, 20 Mar 2025 17:29:43 +0800
Message-Id: <20250320092943.92790-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7qLC4Ntn6cmWFg--.39879S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFykXF18Zr4fAFWrCw15Jwb_yoWDXFc_WF
	nxJFs3XFWFyF1xWw10qa4fWr4av3y7uFWxKFy7try3Aw1xZry2v34UCr1fZa1Ykw4F9Fsx
	X3yDXryfAr9F9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUUKFAJUUUUU==
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

In the acpica/utcache.c file, adjust the position of the
"ACPI_MEM_TRACKING(cache->total_allocated++);" code line
to ensure that the increment operation on total_allocated
is included within the ACPI_DBG_TRACK_ALLOCATIONS configuration.

Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
 drivers/acpi/acpica/utcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
index 85a85f7cf750..046e6ba127d4 100644
--- a/drivers/acpi/acpica/utcache.c
+++ b/drivers/acpi/acpica/utcache.c
@@ -251,9 +251,9 @@ void *acpi_os_acquire_object(struct acpi_memory_list *cache)
 	} else {
 		/* The cache is empty, create a new object */
 
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 		ACPI_MEM_TRACKING(cache->total_allocated++);
 
-#ifdef ACPI_DBG_TRACK_ALLOCATIONS
 		if ((cache->total_allocated - cache->total_freed) >
 		    cache->max_occupied) {
 			cache->max_occupied =
-- 
2.34.1


