Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B328BF7B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfHMRPg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 13:15:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfHMRPg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Aug 2019 13:15:36 -0400
Received: from zn.tnic (p200300EC2F0D2400C42B856AF2D9BBDA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:c42b:856a:f2d9:bbda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49F971EC0716;
        Tue, 13 Aug 2019 19:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565716535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MKvPtw39k4N+Zo5QrzcqmJCmYa89E6ty+9O3MiOg9Ak=;
        b=os+6Yx7mfVvvbD3vz96XGojt+UlOedAh80BEC277yi4t5QHIpvWaAk9RljyVjdfTMf+BaJ
        Tw0cUi+Qnm1PXYP5WQrewkSI+jrMejlzpZcv+K7M0+tgGV0WIDbkhmSqYVCNwJsK7ZIZMp
        WDokZfmoRPq5o5F41lwQj2ep0LHtz5M=
Date:   Tue, 13 Aug 2019 19:16:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     luanshi <zhangliguang@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
Subject: [PATCH v4.1] ACPI / APEI: release resources if gen_pool_add fails
Message-ID: <20190813171619.GH16770@zn.tnic>
References: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

here's v4.1 with the labels properly balanced.

Thx.

---
From: Liguang Zhang <zhangliguang@linux.alibaba.com>
Date: Mon, 15 Jul 2019 14:58:44 +0800
Subject: [PATCH] ACPI / APEI: Release resources if gen_pool_add() fails

Destroy ghes_estatus_pool and release memory allocated via vmalloc() on
errors in ghes_estatus_pool_init() in order to avoid memory leaks.

 [ bp: do the labels properly and with descriptive names and massage. ]

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: James Morse <james.morse@arm.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1563173924-47479-1-git-send-email-zhangliguang@linux.alibaba.com
---
 drivers/acpi/apei/ghes.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a66e00fe31fe..66205ec54555 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -153,6 +153,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
 int ghes_estatus_pool_init(int num_ghes)
 {
 	unsigned long addr, len;
+	int rc;
 
 	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
 	if (!ghes_estatus_pool)
@@ -164,7 +165,7 @@ int ghes_estatus_pool_init(int num_ghes)
 	ghes_estatus_pool_size_request = PAGE_ALIGN(len);
 	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
 	if (!addr)
-		return -ENOMEM;
+		goto err_pool_alloc;
 
 	/*
 	 * New allocation must be visible in all pgd before it can be found by
@@ -172,7 +173,19 @@ int ghes_estatus_pool_init(int num_ghes)
 	 */
 	vmalloc_sync_all();
 
-	return gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
+	if (rc)
+		goto err_pool_add;
+
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	gen_pool_destroy(ghes_estatus_pool);
+
+	return -ENOMEM;
 }
 
 static int map_gen_v2(struct ghes *ghes)
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
