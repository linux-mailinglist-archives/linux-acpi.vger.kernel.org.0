Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9EB40F94C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245568AbhIQNf6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:35:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245234AbhIQNfm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81636113E;
        Fri, 17 Sep 2021 06:34:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CAB03F719;
        Fri, 17 Sep 2021 06:34:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 11/14] mailbox: pcc: Drop handling invalid bit-width in {read,write}_register
Date:   Fri, 17 Sep 2021 14:33:54 +0100
Message-Id: <20210917133357.1911092-12-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pcc_chan_reg_init now checks if the register bit width is within the
list [8, 16, 32, 64] and flags error if that is not the case. Therefore
there is no need to handling invalid bit-width in both read_register
and write_register. We can drop that along with the return values for
these 2 functions.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ed635f7d3f60..4bace1fa48f0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -110,10 +110,8 @@ static struct mbox_controller pcc_mbox_ctrl = {};
  * The below read_register and write_registers are used to read and
  * write from perf critical registers such as PCC doorbell register
  */
-static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
+static void read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
 {
-	int ret_val = 0;
-
 	switch (bit_width) {
 	case 8:
 		*val = readb(vaddr);
@@ -127,19 +125,11 @@ static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
 	case 64:
 		*val = readq(vaddr);
 		break;
-	default:
-		pr_debug("Error: Cannot read register of %u bit width",
-			bit_width);
-		ret_val = -EFAULT;
-		break;
 	}
-	return ret_val;
 }
 
-static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
+static void write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
 {
-	int ret_val = 0;
-
 	switch (bit_width) {
 	case 8:
 		writeb(val, vaddr);
@@ -153,13 +143,7 @@ static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
 	case 64:
 		writeq(val, vaddr);
 		break;
-	default:
-		pr_debug("Error: Cannot write register of %u bit width",
-			bit_width);
-		ret_val = -EFAULT;
-		break;
 	}
-	return ret_val;
 }
 
 static int pcc_chan_reg_read(struct pcc_chan_reg *reg, u64 *val)
@@ -172,7 +156,7 @@ static int pcc_chan_reg_read(struct pcc_chan_reg *reg, u64 *val)
 	}
 
 	if (reg->vaddr)
-		ret = read_register(reg->vaddr, val, reg->gas->bit_width);
+		read_register(reg->vaddr, val, reg->gas->bit_width);
 	else
 		ret = acpi_read(val, reg->gas);
 
@@ -187,7 +171,7 @@ static int pcc_chan_reg_write(struct pcc_chan_reg *reg, u64 val)
 		return 0;
 
 	if (reg->vaddr)
-		ret = write_register(reg->vaddr, val, reg->gas->bit_width);
+		write_register(reg->vaddr, val, reg->gas->bit_width);
 	else
 		ret = acpi_write(val, reg->gas);
 
-- 
2.25.1

