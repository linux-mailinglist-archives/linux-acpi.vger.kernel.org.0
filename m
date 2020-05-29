Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612161E87CC
	for <lists+linux-acpi@lfdr.de>; Fri, 29 May 2020 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgE2T3T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 May 2020 15:29:19 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58336 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgE2T3T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2020 15:29:19 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 15:29:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nWUYMx7yFOccSvZQj8
        5/cWl6pSsdiTHo/Sk8Hgme89M=; b=iewhKqpsZZ014EN0nJAWL0qD8ZEamvK/bu
        CPfv5UdCwiE7i5YtLadh1v/wceH3rScP94tO8vRQ0shyTOkNKkiC22blqLcg4dSF
        gaOHAt+gN5uu2/0vusXku9DCci4fJnrTuCeliJggU3hih5QYh6ch6zxgOkfxUyxu
        a3jwyjGx0=
Received: from SHZ-L10-RUIHDIA.amd.com (unknown [27.38.244.88])
        by smtp4 (Coremail) with SMTP id HNxpCgAXmvLoXtFekHt4BQ--.187S4;
        Sat, 30 May 2020 03:13:45 +0800 (CST)
From:   dianruihui@163.com
To:     ruihui.dian@amd.com, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Ruihui Dian <dianruihui@163.com>
Subject: [PATCH] drivers: GHES_ASSIST feature cause kernel to have a 5ms scheduling latency on AMD ROME's platform
Date:   Sat, 30 May 2020 03:13:43 +0800
Message-Id: <20200529191343.1788-1-dianruihui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HNxpCgAXmvLoXtFekHt4BQ--.187S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr45ZrWUuFWrZF13AFykGrg_yoW5JF4fpF
        Z5uw4xtr17GF17tr42yFn8WFWfJ3yxuFyxWF92gw1aya1Ykr4jqr1jg348J3ZFqayrZa4I
        vr95KF4DWas5K3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uy6wtUUUUU=
X-Originating-IP: [27.38.244.88]
X-CM-SenderInfo: hgld025xlk3xi6rwjhhfrp/1tbiZQkzU1WBoGVa8gAAs1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Ruihui Dian <dianruihui@163.com>

 AMD ROME's BIOS implement a feature(GHES_ASSIST)which is
 declared in ACPI 6.3,and can't be disabled by BIOS setting.
 This feature make kerenl register more than 10K poll timer.
 There are more than 10K GHESdevices under
 "/sys/bus/platform/drivers/GHES". These 10K timers will
 preempt the CPU resources and affect kernel's schedule.
 How to reproduce:
 running cyclictest benchmark on AMD ROME platform
 GHES_ASSIST still don't be supported by upsteam, and the
 ACPI 6.2 still isn't published, So we should disable it
 in drivers.

Signed-off-by: Ruihui Dian <dianruihui@163.com>
---
 drivers/acpi/apei/hest.c | 10 ++++++----
 include/acpi/actbl1.h    |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 8224024..f929bab 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -141,8 +141,9 @@ static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void
 {
 	int *count = data;
 
-	if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
-	    hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+	if ((hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR &&
+	   !(hest_hdr->source_id&ACPI_HEST_GHES_ASSIST_MSK)) ||
+	   hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
 		(*count)++;
 	return 0;
 }
@@ -153,8 +154,9 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 	struct ghes_arr *ghes_arr = data;
 	int rc, i;
 
-	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
-	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+	if ((hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
+	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2) ||
+	    hest_hdr->source_id&CPI_HEST_GHES_ASSIST_MSK)
 		return 0;
 
 	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4354954..5dbbab4 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1155,7 +1155,8 @@ struct acpi_hest_aer_common {
 #define ACPI_HEST_FIRMWARE_FIRST        (1)
 #define ACPI_HEST_GLOBAL                (1<<1)
 #define ACPI_HEST_GHES_ASSIST           (1<<2)
-
+/* If type==9 and Source ID bit [15:12] =!0, It is GHES_ASSIT structure*/
+#define ACPI_HEST_GHES_ASSIST_MSK	(0xF000)
 /*
  * Macros to access the bus/segment numbers in Bus field above:
  *  Bus number is encoded in bits 7:0
-- 
1.8.3.1

