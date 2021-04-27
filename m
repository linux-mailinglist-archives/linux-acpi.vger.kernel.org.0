Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2334A36BCFA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0Bm3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 21:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhD0Bm2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 21:42:28 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70B51C061574;
        Mon, 26 Apr 2021 18:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=RNKcazazG5
        hbxjr+fd3/Dgnsb37D/vx3vsCQ/sLh6hE=; b=oVFUJryol8JZtLoBR/825afMG9
        +N9RkNAK8c/6NEAzbPQYdwjmkWUhtRWSDlbQ/lV5zet/lKOYKIbBAwGv/eis4nph
        Lghled2vAeMm3klwlo7DpcahsDHrwOZ2jtVT2gjHueitYBIGBPkZ3o3GNXSCNghw
        cH4vy9fpocyFgunrw=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC3vq7Qa4dgTqZOAA--.291S4;
        Tue, 27 Apr 2021 09:41:36 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] ACPICA:dbnames: Fix a error free in acpi_db_walk_for_fields
Date:   Mon, 26 Apr 2021 18:41:34 -0700
Message-Id: <20210427014134.3568-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygC3vq7Qa4dgTqZOAA--.291S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyUtF4rGrW7JrW8Xr1rtFb_yoWkKrX_ua
        s5GF48W3WYkr1xAF17A3s3ZFy0vw43Zrn7Gr4kKr1I9rZ5Zr1rAwn7Zwn0q3s7GF90grsx
        ua4Utrn5uw1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUmNtcUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In acpi_db_walk_for_fields, buffer.pointer is freed in the first
time via ACPI_FREE() after acpi_os_printf("%s ", (char *)buffer.pointer).
But later, buffer.pointer is assigned to ret_value, and the freed
pointer is dereferenced by ret_value, which is use after free.

In addition, buffer.pointer is freed by ACPI_FREE() again after
acpi_os_printf("}\n"), which is a double free.

My patch removes the first ACPI_FREE() to avoid the uaf and double
free bugs.

Fixes: 5fd033288a866 ("ACPICA: debugger: add command to dump all fields of particular subtype")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/acpi/acpica/dbnames.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 3615e1a6efd8..dabd76df15ec 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -547,7 +547,6 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
 	}
 
 	acpi_os_printf("%s ", (char *)buffer.pointer);
-	ACPI_FREE(buffer.pointer);
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-- 
2.25.1


