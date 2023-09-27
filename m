Return-Path: <linux-acpi+bounces-234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B27B0A47
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5B9262814E8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441727476
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FD499A6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 16:26:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5731EF3;
	Wed, 27 Sep 2023 09:26:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C6E71042;
	Wed, 27 Sep 2023 09:27:22 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCEE13F59C;
	Wed, 27 Sep 2023 09:26:42 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 27 Sep 2023 17:26:11 +0100
Subject: [PATCH v2 2/4] i2c: xgene-slimpro: Migrate to use generic PCC
 shmem related macros
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-pcc_defines-v2-2-0b8ffeaef2e5@arm.com>
References: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
In-Reply-To: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
To: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Huisong Li <lihuisong@huawei.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=JYykwJW8XnX9bo7n2AWrUiKdtKD+V2jncnVPIPftAhE=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFFe/kjTk37+UIHVvdqo4aE1ihgoJB5WsPQumt
 WCQ1neeOPGJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRRXvwAKCRAAQbq8MX7i
 mAHxD/9Eih5z660Z/lKcUVaW6jT5yfjUKRURQGGhAnVuHOFGYYDdBCFJ8UFUiqW5pI+luvSUeY4
 4RNpxVacMkHJ0Oy1vsSmyCoSAVI6hqo4vchQoFKfc38+0FOBpgxFMznMtSYSaoXVFIx05pvb7k4
 i5Qfh4KoFpC0vVyy1NE3e9zkuvbkHuI+kGx5k5m5JAZ7iC88qohCnXlf7zRnUgSdFg11y6j2KKR
 3RpQdL9TmfvfpROUoKM/+nYyYceMTZP+QeLCvWAdLNkp+Edcx5WRUa3kuOS7ewi0oOqRTdNvOs7
 FlfJ0F8VFxgMysgFXm4tO96pf6z3cUohVC24K5/DLI2AykHtCIrSb5z5eNoHL1bHBP4raCh9eh7
 LKlxYY8NV+IGCnX+9+JzRTzh8h4FjZ2te2wpCcVm5k4XUl98nDyW5vzOJoeKcOi8KHFBzGISccd
 /9FpMkD+sjURiwIV7s8ElxiRaQrYPOtb2S5Y4IgtAvMGyOhSIshdAh4FnURKzi8fW/C+VP4fxi0
 UruBvnclcuw5wNRGxLdtCqaYXpesh9NX59UDk6DM3UbmMS8SIxm3nh7o90rZuwRLQHOY7X3899x
 wD4nnb61QR2b+lzKqrDoAt6Rh1mL6I+nVuu8IL9c2u3Zowi8xbAx6VReVNGIhiC78mys6G5gnT0
 ZAiVRtT17oRQ45A==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the newly defined common and generic PCC shared memory region
related macros in this driver to replace the locally defined ones.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
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


