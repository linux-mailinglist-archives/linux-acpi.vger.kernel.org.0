Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11107219AA6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGIITK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 04:19:10 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:53156 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgGIITK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 04:19:10 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 04:15:06 EDT
Received: from localhost (unknown [159.226.5.99])
        by APP-03 (Coremail) with SMTP id rQCowAD3_79p0AZfhAC1Aw--.17523S2;
        Thu, 09 Jul 2020 16:08:09 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     robert.moore@intel.com, erik.kaneda@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, vulab@iscas.ac.cn,
        linux-acpi@vger.kernel.org, devel@acpica.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] service_layers: osunixmap: Remove unnecessary brackets in acpi_os_map_memory()
Date:   Thu,  9 Jul 2020 08:08:06 +0000
Message-Id: <20200709080806.14328-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAD3_79p0AZfhAC1Aw--.17523S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW8Cr13uFWUZFW3Xr4ruFg_yoWDtwb_t3
        Wvgr1UXFZ8XayF9F1qqr9rZFZ3Cay3CFs5Xa47tw47WFyrWay7J3WxArZFvr4UWF4q9r9x
        Gw4q9r1rt3ZFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5eOJUUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAw4MA13qZM7azAABsI
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove extra brackets.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 tools/power/acpi/os_specific/service_layers/osunixmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index c565546e85bc..52f3e70b5c81 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -70,7 +70,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
 	fd = open(SYSTEM_MEMORY, O_RDONLY | O_BINARY);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open %s\n", SYSTEM_MEMORY);
-		return (NULL);
+		return NULL;
 	}
 
 	/* Align the offset to use mmap */
@@ -85,7 +85,7 @@ void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
 	if (mapped_memory == MAP_FAILED) {
 		fprintf(stderr, "Cannot map %s\n", SYSTEM_MEMORY);
 		close(fd);
-		return (NULL);
+		return NULL;
 	}
 
 	close(fd);
-- 
2.17.1

