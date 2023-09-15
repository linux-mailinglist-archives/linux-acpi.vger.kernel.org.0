Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC737A24C0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjIOR3m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjIOR3O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 13:29:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F72111;
        Fri, 15 Sep 2023 10:29:08 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLdz49S5z67nH3;
        Sat, 16 Sep 2023 01:24:23 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:06 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <dave.hansen@linux.intel.com>, <david@redhat.com>,
        <jiaqiyan@google.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <rientjes@google.com>, <duenwen@google.com>,
        <Vilas.Sridharan@amd.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 5/9] ACPI:RASF: Add common library for RASF and RAS2 PCC interfaces
Date:   Sat, 16 Sep 2023 01:28:14 +0800
Message-ID: <20230915172818.761-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: A Somasundaram <somasundaram.a@hpe.com>

The code contains PCC interfaces for RASF and RAS2 table, functions to send
RASF commands as per ACPI 5.1 and RAS2 commands as per ACPI 6.5 & upwards
revision.

References for this implementation,
ACPI specification, section 5.2.20 for RASF table, section 5.2.21 for RAS2
table and chapter 14 for PCC (Platform Communication Channel).

Driver uses PCC interfaces to communicate to the ACPI HW.
This code implements PCC interfaces and the functions to send the RASF/RAS2
commands to be used by OSPM.

Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig            |  12 +-
 drivers/acpi/Makefile           |   2 +-
 drivers/acpi/rasf_acpi.c        |  26 ---
 drivers/acpi/rasf_acpi_common.c | 272 ++++++++++++++++++++++++++++++++
 include/acpi/rasf_acpi.h        |  40 +++++
 5 files changed, 322 insertions(+), 30 deletions(-)
 create mode 100755 drivers/acpi/rasf_acpi_common.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e5fd8edc5b35..057f7fbc9887 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -283,10 +283,16 @@ config ACPI_RASF
 	bool "ACPI RASF driver"
 	depends on ACPI_PROCESSOR
 	select MAILBOX
+	select PCC
 	help
-	  The driver adds support for extraction of RASF table from OS
-	  system table. Driver adds platform device which binds to the
-	  RASF memory driver.
+	  The driver adds support for PCC (platform communication
+	  channel) interfaces to communicate with the ACPI complaint
+	  hardware platform supports RASF(RAS Feature table) or
+	  and RAS2(RAS2 Feature table).
+	  The driver adds support for RASF(extraction of RASF tables
+	  from OS system table), PCC interfaces and OSPM interfaces to
+	  send RASF & RAS2 commands. Driver adds platform device which
+	  binds to the RASF/RAS2 memory driver.
 
 config ACPI_PROCESSOR
 	tristate "Processor"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index f8a1263f6128..dd62d936cbe1 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -104,7 +104,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
-obj-$(CONFIG_ACPI_RASF)		+= rasf_acpi.o
+obj-$(CONFIG_ACPI_RASF)		+= rasf_acpi_common.o rasf_acpi.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/rasf_acpi.c b/drivers/acpi/rasf_acpi.c
index b30ba2a5e4ff..4c752fab9c4c 100755
--- a/drivers/acpi/rasf_acpi.c
+++ b/drivers/acpi/rasf_acpi.c
@@ -25,32 +25,6 @@
 #include <acpi/rasf_acpi.h>
 #include <acpi/acpixf.h>
 
-static struct platform_device *rasf_add_platform_device(char *name, const void *data,
-							size_t size)
-{
-	int ret;
-	struct platform_device *pdev;
-
-	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
-	if (!pdev)
-		return NULL;
-
-	ret = platform_device_add_data(pdev, data, size);
-	if (ret)
-		goto dev_put;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-		goto dev_put;
-
-	return pdev;
-
-dev_put:
-	platform_device_put(pdev);
-
-	return NULL;
-}
-
 int __init rasf_acpi_init(void)
 {
 	acpi_status status;
diff --git a/drivers/acpi/rasf_acpi_common.c b/drivers/acpi/rasf_acpi_common.c
new file mode 100755
index 000000000000..3ee34f5d12d3
--- /dev/null
+++ b/drivers/acpi/rasf_acpi_common.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rasf_acpi_common.c - ACPI RASF table processing common functions
+ *
+ * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises.
+ *
+ * Copyright (c) 2023 HiSilicon Limited.
+ *
+ * Support for
+ * RASF - ACPI 6.5 Specification, section 5.2.20
+ * RAS2 - ACPI 6.5 Specification, section 5.2.21
+ * PCC(Platform Communications Channel) - ACPI 6.5 Specification,
+ * chapter 14.
+ *
+ * Code contains common functions for RASF.
+ * PCC(Platform communication channel) interfaces for the RASF & RAS2
+ * and the functions for sending RASF & RAS2 commands to the ACPI HW.
+ */
+
+#define pr_fmt(fmt)	"ACPI RASF COMMON: " fmt
+
+#include <linux/export.h>
+#include <linux/delay.h>
+#include <linux/ktime.h>
+#include <linux/platform_device.h>
+#include <acpi/rasf_acpi.h>
+#include <acpi/acpixf.h>
+
+static int rasf_check_pcc_chan(struct rasf_context *rasf_ctx)
+{
+	int ret = -EIO;
+	struct acpi_rasf_shared_memory  __iomem *generic_comm_base = rasf_ctx->pcc_comm_addr;
+	ktime_t next_deadline = ktime_add(ktime_get(), rasf_ctx->deadline);
+
+	while (!ktime_after(ktime_get(), next_deadline)) {
+		/*
+		 * As per ACPI spec, the PCC space wil be initialized by
+		 * platform and should have set the command completion bit when
+		 * PCC can be used by OSPM
+		 */
+		if (readw_relaxed(&generic_comm_base->status) & RASF_PCC_CMD_COMPLETE) {
+			ret = 0;
+			break;
+		}
+		/*
+		 * Reducing the bus traffic in case this loop takes longer than
+		 * a few retries.
+		 */
+		udelay(10);
+	}
+
+	return ret;
+}
+
+/**
+ * rasf_send_pcc_cmd() - Send RASF command via PCC channel
+ * @rasf_ctx:	pointer to the rasf context structure
+ * @cmd:	command to send
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_send_pcc_cmd(struct rasf_context *rasf_ctx, u16 cmd)
+{
+	int ret = -EIO;
+	struct acpi_rasf_shared_memory  *generic_comm_base =
+		(struct acpi_rasf_shared_memory *)rasf_ctx->pcc_comm_addr;
+	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
+	static int mpar_count;
+	unsigned int time_delta;
+
+	if (cmd == RASF_PCC_CMD_EXEC) {
+		ret = rasf_check_pcc_chan(rasf_ctx);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT)
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds"
+	 */
+	if (rasf_ctx->pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
+		if (rasf_ctx->pcc_mrtt > time_delta)
+			udelay(rasf_ctx->pcc_mrtt - time_delta);
+	}
+
+	/*
+	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
+	 * "The maximum number of periodic requests that the subspace channel can
+	 * support, reported in commands per minute. 0 indicates no limitation."
+	 *
+	 * This parameter should be ideally zero or large enough so that it can
+	 * handle maximum number of requests that all the cores in the system can
+	 * collectively generate. If it is not, we will follow the spec and just
+	 * not send the request to the platform after hitting the MPAR limit in
+	 * any 60s window
+	 */
+	if (rasf_ctx->pcc_mpar) {
+		if (mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				pr_debug("PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			last_mpar_reset = ktime_get();
+			mpar_count = rasf_ctx->pcc_mpar;
+		}
+		mpar_count--;
+	}
+
+	/* Write to the shared comm region. */
+	writew_relaxed(cmd, &generic_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew_relaxed(0, &generic_comm_base->status);
+
+	/* Ring doorbell */
+	ret = mbox_send_message(rasf_ctx->pcc_channel, &cmd);
+	if (ret < 0) {
+		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
+				cmd, ret);
+		return ret;
+	}
+
+	/*
+	 * For READs we need to ensure the cmd completed to ensure
+	 * the ensuing read()s can proceed. For WRITEs we dont care
+	 * because the actual write()s are done before coming here
+	 * and the next READ or WRITE will check if the channel
+	 * is busy/free at the entry of this call.
+	 *
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ
+	 */
+	if (cmd == RASF_PCC_CMD_EXEC || rasf_ctx->pcc_mrtt) {
+		ret = rasf_check_pcc_chan(rasf_ctx);
+		if (rasf_ctx->pcc_mrtt)
+			last_cmd_cmpl_time = ktime_get();
+	}
+
+	if (rasf_ctx->pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(rasf_ctx->pcc_channel, ret);
+	else
+		mbox_client_txdone(rasf_ctx->pcc_channel, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rasf_send_pcc_cmd);
+
+/**
+ * rasf_register_pcc_channel() - Register PCC channel
+ * @rasf_ctx:	pointer to the rasf context structure
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_register_pcc_channel(struct rasf_context *rasf_ctx)
+{
+	u64 usecs_lat;
+	unsigned int len;
+	struct pcc_mbox_chan *pcc_chan;
+	struct mbox_client *rasf_mbox_cl;
+	struct acpi_pcct_hw_reduced *rasf_ss;
+
+	rasf_mbox_cl = &rasf_ctx->mbox_client;
+	if (!rasf_mbox_cl || rasf_ctx->pcc_subspace_idx < 0)
+		return -EINVAL;
+
+	pcc_chan = pcc_mbox_request_channel(rasf_mbox_cl,
+				rasf_ctx->pcc_subspace_idx);
+
+	if (IS_ERR(pcc_chan)) {
+		pr_err("Failed to find PCC channel for subspace %d\n",
+		       rasf_ctx->pcc_subspace_idx);
+		return -ENODEV;
+	}
+	rasf_ctx->pcc_chan = pcc_chan;
+	rasf_ctx->pcc_channel = pcc_chan->mchan;
+	/*
+	 * The PCC mailbox controller driver should
+	 * have parsed the PCCT (global table of all
+	 * PCC channels) and stored pointers to the
+	 * subspace communication region in con_priv.
+	 */
+	rasf_ss = rasf_ctx->pcc_channel->con_priv;
+
+	if (!rasf_ss) {
+		pr_err("No PCC subspace found for RASF\n");
+		pcc_mbox_free_channel(rasf_ctx->pcc_chan);
+		return -ENODEV;
+	}
+
+	/*
+	 * This is the shared communication region
+	 * for the OS and Platform to communicate over.
+	 */
+	rasf_ctx->comm_base_addr = rasf_ss->base_address;
+	len = rasf_ss->length;
+	pr_debug("PCC subspace for RASF=0x%llx len=%d\n",
+		  rasf_ctx->comm_base_addr, len);
+
+	/*
+	 * rasf_ss->latency is just a Nominal value. In reality
+	 * the remote processor could be much slower to reply.
+	 * So add an arbitrary amount of wait on top of Nominal.
+	 */
+	usecs_lat = RASF_NUM_RETRIES * rasf_ss->latency;
+	rasf_ctx->deadline = ns_to_ktime(usecs_lat * NSEC_PER_USEC);
+	rasf_ctx->pcc_mrtt = rasf_ss->min_turnaround_time;
+	rasf_ctx->pcc_mpar = rasf_ss->max_access_rate;
+	rasf_ctx->pcc_comm_addr = acpi_os_ioremap(rasf_ctx->comm_base_addr, len);
+	pr_debug("pcc_comm_addr=%p\n", rasf_ctx->pcc_comm_addr);
+
+	/* Set flag so that we dont come here for each CPU. */
+	rasf_ctx->pcc_channel_acquired = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rasf_register_pcc_channel);
+
+/**
+ * rasf_unregister_pcc_channel() - Unregister PCC channel
+ * @rasf_ctx:	pointer to the rasf context structure
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int rasf_unregister_pcc_channel(struct rasf_context *rasf_ctx)
+{
+	if (!rasf_ctx->pcc_chan)
+		return -EINVAL;
+
+	pcc_mbox_free_channel(rasf_ctx->pcc_chan);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rasf_unregister_pcc_channel);
+
+/**
+ * rasf_add_platform_device() - Add a platform device for RASF
+ * @name:	name of the device we're adding
+ * @data:	platform specific data for this platform device
+ * @size:	size of platform specific data
+ *
+ * Returns: pointer to platform device on success, an error otherwise
+ */
+struct platform_device *rasf_add_platform_device(char *name, const void *data,
+						 size_t size)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return NULL;
+
+	ret = platform_device_add_data(pdev, data, size);
+	if (ret)
+		goto dev_put;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto dev_put;
+
+	return pdev;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return NULL;
+}
diff --git a/include/acpi/rasf_acpi.h b/include/acpi/rasf_acpi.h
index 1c4c3e94d472..e91a451c5dc1 100755
--- a/include/acpi/rasf_acpi.h
+++ b/include/acpi/rasf_acpi.h
@@ -11,9 +11,49 @@
 #define _RASF_ACPI_H
 
 #include <linux/acpi.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
 #include <linux/types.h>
+#include <acpi/pcc.h>
+
+#define RASF_PCC_CMD_COMPLETE 1
+
+/* RASF specific PCC commands */
+#define RASF_PCC_CMD_EXEC 0x01
 
 #define RASF_FAILURE 0
 #define RASF_SUCCESS 1
 
+/*
+ * Arbitrary Retries for PCC commands.
+ */
+#define RASF_NUM_RETRIES 600
+
+/*
+ * Data structures for PCC communication and RASF table
+ */
+struct rasf_context {
+	struct device *dev;
+	int id;
+	struct mbox_client mbox_client;
+	struct mbox_chan *pcc_channel;
+	struct pcc_mbox_chan *pcc_chan;
+	void __iomem *pcc_comm_addr;
+	u64 comm_base_addr;
+	int pcc_subspace_idx;
+	bool pcc_channel_acquired;
+	ktime_t deadline;
+	unsigned int pcc_mpar;
+	unsigned int pcc_mrtt;
+	spinlock_t spinlock; /* Lock to provide mutually exclusive access to PCC channel */
+	struct device *scrub_dev;
+	u8 n_regions;
+	const struct rasf_hw_scrub_ops *ops;
+};
+
+struct platform_device *rasf_add_platform_device(char *name, const void *data,
+						 size_t size);
+int rasf_send_pcc_cmd(struct rasf_context *rasf_ctx, u16 cmd);
+int rasf_register_pcc_channel(struct rasf_context *rasf_ctx);
+int rasf_unregister_pcc_channel(struct rasf_context *rasf_ctx);
 #endif /* _RASF_ACPI_H */
-- 
2.34.1

