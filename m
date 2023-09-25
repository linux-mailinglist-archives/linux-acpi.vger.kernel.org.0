Return-Path: <linux-acpi+bounces-73-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110B7AD36D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD41928158D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B553A11CA1
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 08:32:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FFA10A22;
	Mon, 25 Sep 2023 07:44:49 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AC112;
	Mon, 25 Sep 2023 00:44:46 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vsmvt0t_1695627882;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsmvt0t_1695627882)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 15:44:43 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ardb@kernel.org,
	robert.moore@intel.com
Cc: linux-hardening@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com
Subject: [RFC PATCH v2 6/9] ACPI: APEI: GHES: export ghes_report_chain
Date: Mon, 25 Sep 2023 15:44:23 +0800
Message-Id: <20230925074426.97856-7-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Export ghes_report_chain so that it can be kicked by other drivers.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 include/acpi/ghes.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 306bced16884..8acd3d56719a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -95,7 +95,7 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
-static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 3c8bba9f1114..151567353e33 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -126,7 +126,7 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
-struct notifier_block;
+extern struct atomic_notifier_head ghes_report_chain;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
 #endif /* GHES_H */
-- 
2.41.0


