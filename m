Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9813D41C313
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbhI2K6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 06:58:20 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:43976 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbhI2K6Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2021 06:58:16 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Sep 2021 06:58:15 EDT
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 9314B1008CBCD;
        Wed, 29 Sep 2021 18:46:36 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 7EFD4200BC2D9;
        Wed, 29 Sep 2021 18:46:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yANxG9gyx2dr; Wed, 29 Sep 2021 18:46:36 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 57718200B5751;
        Wed, 29 Sep 2021 18:46:28 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: [PATCH] acpi/processor_idle.c: Fix kernel pointer leak
Date:   Wed, 29 Sep 2021 18:46:25 +0800
Message-Id: <20210929104625.1112192-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to 'long' and pinted with %ld.
Change %ld to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 drivers/acpi/processor_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f37fba9e5ba0..a9f4ab072583 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -73,9 +73,9 @@ static int set_max_cstate(const struct dmi_system_id *id)
 	if (max_cstate > ACPI_PROCESSOR_MAX_POWER)
 		return 0;
 
-	pr_notice("%s detected - limiting to C%ld max_cstate."
+	pr_notice("%s detected - limiting to C%p max_cstate."
 		  " Override with \"processor.max_cstate=%d\"\n", id->ident,
-		  (long)id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
+		id->driver_data, ACPI_PROCESSOR_MAX_POWER + 1);
 
 	max_cstate = (long)id->driver_data;
 
-- 
2.33.0

