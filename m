Return-Path: <linux-acpi+bounces-559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0D7BF605
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F2E281B92
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC09F15AC1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF763D9F
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 08:22:32 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C6197
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 01:22:29 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S4TNC0s7Rz1M92P;
	Tue, 10 Oct 2023 16:19:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 16:22:26 +0800
From: Hanjun Guo <guohanjun@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Hanjun Guo <guohanjun@huawei.com>, D Scott Phillips
	<scott@os.amperecomputing.com>
Subject: [PATCH] ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()
Date: Tue, 10 Oct 2023 16:21:23 +0800
Message-ID: <20231010082123.4167603-1-guohanjun@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
it needs the SDEI subsystem to be initialized (which is done in
acpi_ghes_init()) before the AGDI driver probing.

In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
initialisation into acpi_arm_init()"), the acpi_agdi_init() was
called before acpi_ghes_init() and it causes following failure:

| [    0.515864] sdei: Failed to create event 1073741825: -5
| [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
| [    0.515867] agdi: probe of agdi.0 failed with error -5
| ...
| [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.

Fix it by moving acpi_arm_init() to the place of after
acpi_ghes_init().

Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()")
Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

I did a test on a ARM server and I didn't see regressions, but
I don't have a AGDI table firmware, so Scott please give a 
test to see if it fixes your issue.

 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f41dda2d3493..a4aa53b7e2bb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1410,10 +1410,10 @@ static int __init acpi_init(void)
 	acpi_init_ffh();
 
 	pci_mmcfg_late_init();
-	acpi_arm_init();
 	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
+	acpi_arm_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
-- 
2.25.1


