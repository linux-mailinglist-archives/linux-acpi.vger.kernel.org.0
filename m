Return-Path: <linux-acpi+bounces-131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2D7AECF3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 08E0C281746
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F128DAB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112A846A
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 12:28:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94898FB;
	Tue, 26 Sep 2023 05:28:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4541DFEC;
	Tue, 26 Sep 2023 05:28:55 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0D6F3F6C4;
	Tue, 26 Sep 2023 05:28:15 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 26 Sep 2023 13:28:01 +0100
Subject: [PATCH 2/3] i2c: xgene-slimpro: Migrate to use generic PCC shmem
 related macros
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-pcc_defines-v1-2-0f925a1658fd@arm.com>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
In-Reply-To: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
To: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=+8XMvgcBZDMKcEA3RRExPbyScwOjYNRYC/UYX8cjwNs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlEs5cfOigpBTgwA3trZcDjDYUNOuJ51IVXqpow
 VpCpVfAt5iJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRLOXAAKCRAAQbq8MX7i
 mLYREADFHDxsCs80lSs+CHiNM7u1QjKyEiZvh1oO21L58p2dSnEpXO5KTn/8gaHrGgNXRITYAR/
 AQl7bUxBB1DbBHNfXXBJYTWDt0lm/isxKeLWjf78m5iGGhzzy4H8Plica2fY9nb9hAJFd2ihrXy
 mFFOwVbBHRspyG5NC6VOBC34Bm6GW66uI4QdlojLvgI9TICajc/+cx2IsGxhj+/9/3IA38YppVV
 qr5RZd1Am7bfqnASPL8g5w/xzJ18+AZy/vHZA0SfSl+ydrCyU6cPrk464cpdQ8CGIcKD4auc3Su
 Wvi4Dkxs2FyMfqhXEFty5ZoSFo8DkJkdKCu8+9m0gQfKlgMDoOlhguPRf/Oj6rRdIGBrt2NVqwD
 uGsvB/80NInJDTHInikJnfdGA32oj/dBTNjsGcvZpQz3c1W2lRaELloIi9xuO2hkX/SMvlANu7B
 R6Ni1YEY9efER9h0MEJzO5e3B/ScoxkFgo7G0hC0qhDqqA3YuhgZdNTlQGwj6dc1PUeNqS5Io1F
 8aYExSp/b9tWh5OjR4fTXcedw3+RbaJrlYlF0K/VNxYvMhizfr5D395YbL7NRbDZSxMWxXFG57B
 xI9Bp6YcVTi4qJbAeDXIUQx+U20XmCihVcgBaFtO+tDVA8pDJo0LwEM7tw/qguBrFY9KpxQYQ/M
 rMfLqsD9tRrCtug==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the newly defined common and generic PCC shared memory region
related macros in this driver to replace the locally defined ones.

Cc: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index fbc1ffbd2fa7..658396c9eeab 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -91,14 +91,6 @@
 
 #define SLIMPRO_IIC_MSG_DWORD_COUNT			3
 
-/* PCC related defines */
-#define PCC_SIGNATURE			0x50424300
-#define PCC_STS_CMD_COMPLETE		BIT(0)
-#define PCC_STS_SCI_DOORBELL		BIT(1)
-#define PCC_STS_ERR			BIT(2)
-#define PCC_STS_PLAT_NOTIFY		BIT(3)
-#define PCC_CMD_GENERATE_DB_INT		BIT(15)
-
 struct slimpro_i2c_dev {
 	struct i2c_adapter adapter;
 	struct device *dev;
@@ -160,11 +152,11 @@ static void slimpro_i2c_pcc_rx_cb(struct mbox_client *cl, void *msg)
 
 	/* Check if platform sends interrupt */
 	if (!xgene_word_tst_and_clr(&generic_comm_base->status,
-				    PCC_STS_SCI_DOORBELL))
+				    PCC_STATUS_SCI_DOORBELL))
 		return;
 
 	if (xgene_word_tst_and_clr(&generic_comm_base->status,
-				   PCC_STS_CMD_COMPLETE)) {
+				   PCC_STATUS_CMD_COMPLETE)) {
 		msg = generic_comm_base + 1;
 
 		/* Response message msg[1] contains the return value. */
@@ -186,10 +178,10 @@ static void slimpro_i2c_pcc_tx_prepare(struct slimpro_i2c_dev *ctx, u32 *msg)
 		   cpu_to_le32(PCC_SIGNATURE | ctx->mbox_idx));
 
 	WRITE_ONCE(generic_comm_base->command,
-		   cpu_to_le16(SLIMPRO_MSG_TYPE(msg[0]) | PCC_CMD_GENERATE_DB_INT));
+		   cpu_to_le16(SLIMPRO_MSG_TYPE(msg[0]) | PCC_CMD_GENERATE_DB_INTR));
 
 	status = le16_to_cpu(READ_ONCE(generic_comm_base->status));
-	status &= ~PCC_STS_CMD_COMPLETE;
+	status &= ~PCC_STATUS_CMD_COMPLETE;
 	WRITE_ONCE(generic_comm_base->status, cpu_to_le16(status));
 
 	/* Copy the message to the PCC comm space */

-- 
2.42.0


