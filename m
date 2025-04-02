Return-Path: <linux-acpi+bounces-12643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00512A78DD1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C123AE7C9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04F237701;
	Wed,  2 Apr 2025 12:03:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1823817C;
	Wed,  2 Apr 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595388; cv=none; b=VRDHaJj6QyYX8ZqY8xGYxA3NO1LFep+mVSwRULY7aGd5HwubUaBCwzV8ndWL9g8d35EKm6U9Iyi/Lxmu+ADhrFZIvHlXcRG1XCilkqc5wYjhD0sRpPMA8MSYSwUJEjCy/iu4t/0gXCUMDuwAw513sfa1VwTMNsIyKppd651+0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595388; c=relaxed/simple;
	bh=djVg3v2s/B7Xeguc0OZR2LQkaN3F/bDYYQJcMmn6X6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3xp/FfcKKrwquqUBPDV1MtKyCNcvEsB5LdXS342HCwtTRlWihtvMLeSnKlHYR2+Uti7wvv/f1f5g6mhL1Mx45ffwmHggztvMgrzdhJ21lxcOZj/swr1SBtEYAn+PfgBzgC7Nt28TlT82a+dMqEHKl6YOEc+S65iY6IY6ijAZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZSNhC1RLBz6K9LL;
	Wed,  2 Apr 2025 19:59:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id F06F11400D9;
	Wed,  2 Apr 2025 20:02:57 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.171.80) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 14:02:56 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <rafael@kernel.org>, <tony.luck@intel.com>,
	<lenb@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <jonathan.cameron@huawei.com>, <linux-mm@kvack.org>,
	<linuxarm@huawei.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Date: Wed, 2 Apr 2025 13:02:28 +0100
Message-ID: <20250402120230.596-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250402120230.596-1-shiju.jose@huawei.com>
References: <20250402120230.596-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table (RAS2) defined in the
ACPI 6.5 Specification, section 5.2.21.
Driver defines RAS2 Init, which extracts the RAS2 table and driver
adds auxiliary device for each memory feature which binds to the
RAS2 memory driver.

Driver uses PCC mailbox to communicate with the ACPI HW and the
driver adds OSPM interfaces to send RAS2 commands.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/Kconfig  |  11 ++
 drivers/acpi/Makefile |   1 +
 drivers/acpi/bus.c    |   3 +
 drivers/acpi/ras2.c   | 420 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ras2.h   |  44 +++++
 5 files changed, 479 insertions(+)
 create mode 100644 drivers/acpi/ras2.c
 create mode 100644 include/acpi/ras2.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d81b55f5068c..bae9a47c829d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -293,6 +293,17 @@ config ACPI_CPPC_LIB
 	  If your platform does not support CPPC in firmware,
 	  leave this option disabled.
 
+config ACPI_RAS2
+	bool "ACPI RAS2 driver"
+	select AUXILIARY_BUS
+	select MAILBOX
+	select PCC
+	help
+	  The driver adds support for ACPI RAS2 feature table(extracts RAS2
+	  table from OS system table) and OSPM interfaces to send RAS2
+	  commands via PCC mailbox subspace. Driver adds platform device for
+	  the RAS2 memory features which binds to the RAS2 memory driver.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || ARM64 || LOONGARCH || RISCV
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0f5dfb..797b38cdc2f3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
+obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 058910af82bc..9a0a1582b8c3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -29,6 +29,7 @@
 #include <linux/acpi_viot.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
+#include <acpi/ras2.h>
 #include <linux/suspend.h>
 #include <linux/prmt.h>
 
@@ -1472,6 +1473,8 @@ static int __init acpi_init(void)
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
+	acpi_ras2_init();
+
 	return 0;
 }
 
diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
new file mode 100644
index 000000000000..69d8afe99b6e
--- /dev/null
+++ b/drivers/acpi/ras2.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of ACPI RAS2 driver.
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited.
+ *
+ * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
+ *
+ * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table and
+ * get the PCC channel subspace for communicating with the ACPI compliant
+ * HW platform which supports ACPI RAS2. Driver adds platform devices
+ * for each RAS2 memory feature which binds to the memory ACPI RAS2 driver.
+ */
+
+#define pr_fmt(fmt) "ACPI RAS2: " fmt
+
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/iopoll.h>
+#include <linux/ktime.h>
+#include <acpi/pcc.h>
+#include <acpi/ras2.h>
+
+static struct acpi_table_ras2 *__read_mostly ras2_tab;
+
+/* Data structure for PCC communication */
+struct ras2_pcc_subspace {
+	struct mbox_client mbox_client;
+	struct pcc_mbox_chan *pcc_chan;
+	struct acpi_ras2_shmem __iomem *comm_addr;
+	struct list_head elem;
+	/* Lock to provide mutually exclusive access to PCC channel */
+	struct mutex pcc_lock;
+	unsigned int deadline_us;
+	unsigned int pcc_mpar;
+	unsigned int pcc_mrtt;
+	ktime_t last_cmd_cmpl_time;
+	ktime_t last_mpar_reset;
+	int mpar_count;
+	int pcc_id;
+	u16 ref_count;
+	bool pcc_chnl_acq;
+};
+
+/*
+ * Arbitrary retries for PCC commands because the remote processor
+ * could be much slower to reply. Keeping it high enough to cover
+ * emulators where the processors run painfully slow.
+ */
+#define RAS2_NUM_RETRIES 600ULL
+
+#define RAS2_FEAT_TYPE_MEMORY 0x00
+
+/* Static variables for the RAS2 PCC subspaces */
+static DEFINE_MUTEX(ras2_pcc_list_lock);
+static LIST_HEAD(ras2_pcc_subspaces);
+
+static int ras2_report_cap_error(u32 cap_status)
+{
+	switch (cap_status) {
+	case ACPI_RAS2_NOT_VALID:
+	case ACPI_RAS2_NOT_SUPPORTED:
+		return -EPERM;
+	case ACPI_RAS2_BUSY:
+		return -EBUSY;
+	case ACPI_RAS2_FAILED:
+	case ACPI_RAS2_ABORTED:
+	case ACPI_RAS2_INVALID_DATA:
+		return -EINVAL;
+	default: /* 0 or other, Success */
+		return 0;
+	}
+}
+
+static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
+{
+	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
+	u32 cap_status;
+	u16 status;
+	u32 rc;
+
+	/*
+	 * As per ACPI spec, the PCC space will be initialized by
+	 * platform and should have set the command completion bit when
+	 * PCC can be used by OSPM
+	 *
+	 * Poll PCC status register every 3us(delay_us) for maximum of
+	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
+	 */
+	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
+					status & PCC_STATUS_CMD_COMPLETE, 3,
+					pcc_subspace->deadline_us);
+	if (rc) {
+		pr_warn("PCC check channel failed for : %d rc=%d\n",
+			pcc_subspace->pcc_id, rc);
+		return rc;
+	}
+
+	if (status & PCC_STATUS_ERROR) {
+		cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
+		ras2_report_cap_error(cap_status);
+
+		status &= ~PCC_STATUS_ERROR;
+		writew_relaxed(status, &gen_comm_base->status);
+		return -EIO;
+	}
+
+	if (status & PCC_STATUS_CMD_COMPLETE)
+		return 0;
+
+	return -EIO;
+}
+
+/**
+ * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
+ * @ras2_ctx:	pointer to the RAS2 context structure
+ * @cmd:	command to send
+ *
+ * Returns: 0 on success, an error otherwise
+ */
+int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
+{
+	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
+	struct acpi_ras2_shmem *gen_comm_base = pcc_subspace->comm_addr;
+	struct mbox_chan *pcc_channel;
+	unsigned int time_delta;
+	int rc;
+
+	rc = ras2_check_pcc_chan(pcc_subspace);
+	if (rc < 0)
+		return rc;
+
+	pcc_channel = pcc_subspace->pcc_chan->mchan;
+
+	/*
+	 * Handle the Minimum Request Turnaround Time(MRTT)
+	 * "The minimum amount of time that OSPM must wait after the completion
+	 * of a command before issuing the next command, in microseconds"
+	 */
+	if (pcc_subspace->pcc_mrtt) {
+		time_delta = ktime_us_delta(ktime_get(),
+					    pcc_subspace->last_cmd_cmpl_time);
+		if (pcc_subspace->pcc_mrtt > time_delta)
+			udelay(pcc_subspace->pcc_mrtt - time_delta);
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
+	if (pcc_subspace->pcc_mpar) {
+		if (pcc_subspace->mpar_count == 0) {
+			time_delta = ktime_ms_delta(ktime_get(),
+						    pcc_subspace->last_mpar_reset);
+			if (time_delta < 60 * MSEC_PER_SEC) {
+				dev_dbg(ras2_ctx->dev,
+					"PCC cmd not sent due to MPAR limit");
+				return -EIO;
+			}
+			pcc_subspace->last_mpar_reset = ktime_get();
+			pcc_subspace->mpar_count = pcc_subspace->pcc_mpar;
+		}
+		pcc_subspace->mpar_count--;
+	}
+
+	/* Write to the shared comm region. */
+	writew_relaxed(cmd, &gen_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew_relaxed(0, &gen_comm_base->status);
+
+	/* Ring doorbell */
+	rc = mbox_send_message(pcc_channel, &cmd);
+	if (rc < 0) {
+		dev_warn(ras2_ctx->dev,
+			 "Err sending PCC mbox message. cmd:%d, rc:%d\n", cmd, rc);
+		return rc;
+	}
+
+	/*
+	 * If Minimum Request Turnaround Time is non-zero, we need
+	 * to record the completion time of both READ and WRITE
+	 * command for proper handling of MRTT, so we need to check
+	 * for pcc_mrtt in addition to CMD_READ
+	 */
+	if (cmd == PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
+		rc = ras2_check_pcc_chan(pcc_subspace);
+		if (pcc_subspace->pcc_mrtt)
+			pcc_subspace->last_cmd_cmpl_time = ktime_get();
+	}
+
+	if (pcc_channel->mbox->txdone_irq)
+		mbox_chan_txdone(pcc_channel, rc);
+	else
+		mbox_client_txdone(pcc_channel, rc);
+
+	return rc >= 0 ? 0 : rc;
+}
+EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
+
+static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
+{
+	struct ras2_pcc_subspace *pcc_subspace;
+	struct pcc_mbox_chan *pcc_chan;
+	struct mbox_client *mbox_cl;
+
+	if (pcc_id < 0)
+		return -EINVAL;
+
+	mutex_lock(&ras2_pcc_list_lock);
+	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
+		if (pcc_subspace->pcc_id != pcc_id)
+			continue;
+		ras2_ctx->pcc_subspace = pcc_subspace;
+		ras2_ctx->comm_addr = pcc_subspace->comm_addr;
+		ras2_ctx->dev = pcc_subspace->pcc_chan->mchan->mbox->dev;
+		ras2_ctx->pcc_lock = &pcc_subspace->pcc_lock;
+		pcc_subspace->ref_count++;
+		mutex_unlock(&ras2_pcc_list_lock);
+		return 0;
+	}
+	mutex_unlock(&ras2_pcc_list_lock);
+
+	pcc_subspace = kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
+	if (!pcc_subspace)
+		return -ENOMEM;
+
+	mbox_cl = &pcc_subspace->mbox_client;
+	mbox_cl->knows_txdone = true;
+
+	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
+	if (IS_ERR(pcc_chan)) {
+		kfree(pcc_subspace);
+		return PTR_ERR(pcc_chan);
+	}
+
+	*pcc_subspace = (struct ras2_pcc_subspace) {
+		.pcc_id = pcc_id,
+		.pcc_chan = pcc_chan,
+		.comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
+					     pcc_chan->shmem_size),
+		.deadline_us = RAS2_NUM_RETRIES * pcc_chan->latency,
+		.pcc_mrtt = pcc_chan->min_turnaround_time,
+		.pcc_mpar = pcc_chan->max_access_rate,
+		.mbox_client = {
+			.knows_txdone = true,
+		},
+		.pcc_chnl_acq = true,
+	};
+
+	mutex_lock(&ras2_pcc_list_lock);
+	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
+	pcc_subspace->ref_count++;
+	mutex_unlock(&ras2_pcc_list_lock);
+	ras2_ctx->pcc_subspace = pcc_subspace;
+	ras2_ctx->comm_addr = pcc_subspace->comm_addr;
+	ras2_ctx->dev = pcc_chan->mchan->mbox->dev;
+	mutex_init(&pcc_subspace->pcc_lock);
+	ras2_ctx->pcc_lock = &pcc_subspace->pcc_lock;
+
+	return 0;
+}
+
+static DEFINE_IDA(ras2_ida);
+static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx)
+{
+	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
+
+	guard(mutex)(&ras2_pcc_list_lock);
+	if (pcc_subspace->ref_count > 0)
+		pcc_subspace->ref_count--;
+
+	if (!pcc_subspace->ref_count) {
+		list_del(&pcc_subspace->elem);
+		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
+		kfree(pcc_subspace);
+	}
+}
+
+static void ras2_release(struct device *device)
+{
+	struct auxiliary_device *auxdev = container_of(device, struct auxiliary_device, dev);
+	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
+
+	ida_free(&ras2_ida, auxdev->id);
+	ras2_remove_pcc(ras2_ctx);
+	kfree(ras2_ctx);
+}
+
+static int ras2_add_aux_device(char *name, int channel)
+{
+	struct ras2_mem_ctx *ras2_ctx;
+	int id, rc;
+
+	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
+	if (!ras2_ctx)
+		return -ENOMEM;
+
+	rc = ras2_register_pcc_channel(ras2_ctx, channel);
+	if (rc < 0) {
+		pr_debug("failed to register pcc channel rc=%d\n", rc);
+		goto ctx_free;
+	}
+
+	id = ida_alloc(&ras2_ida, GFP_KERNEL);
+	if (id < 0) {
+		rc = id;
+		goto pcc_free;
+	}
+
+	ras2_ctx->id = id;
+	ras2_ctx->adev.id = id;
+	ras2_ctx->adev.name = RAS2_MEM_DEV_ID_NAME;
+	ras2_ctx->adev.dev.release = ras2_release;
+	ras2_ctx->adev.dev.parent = ras2_ctx->dev;
+
+	rc = auxiliary_device_init(&ras2_ctx->adev);
+	if (rc)
+		goto ida_free;
+
+	rc = auxiliary_device_add(&ras2_ctx->adev);
+	if (rc) {
+		auxiliary_device_uninit(&ras2_ctx->adev);
+		return rc;
+	}
+
+	return 0;
+
+ida_free:
+	ida_free(&ras2_ida, id);
+pcc_free:
+	ras2_remove_pcc(ras2_ctx);
+ctx_free:
+	kfree(ras2_ctx);
+
+	return rc;
+}
+
+static int acpi_ras2_parse(void)
+{
+	struct acpi_ras2_pcc_desc *pcc_desc_list;
+	u16 i, count;
+	int pcc_id;
+	int rc;
+
+	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
+		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short #1)\n");
+		return -EINVAL;
+	}
+
+	if (!ras2_tab->num_pcc_descs) {
+		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
+		return -EINVAL;
+	}
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
+	/* Double scan for the case of only one actual controller */
+	pcc_id = -1;
+	for (i = 0, count = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
+			continue;
+		if (pcc_id == -1) {
+			pcc_id = pcc_desc_list->channel_id;
+			count++;
+		}
+		if (pcc_desc_list->channel_id != pcc_id)
+			count++;
+	}
+
+	/*
+	 * Workaround for the client platform with multiple scrub devices
+	 * but uses single PCC subspace for communication.
+	 */
+	if (count == 1) {
+		/* Add auxiliary device and bind ACPI RAS2 memory driver */
+		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
+		if (rc)
+			return rc;
+
+		return 0;
+	}
+
+	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
+	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
+		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
+			continue;
+
+		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_desc_list->channel_id);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+void __init acpi_ras2_init(void)
+{
+	acpi_status status;
+	int rc;
+
+	status = acpi_get_table(ACPI_SIG_RAS2, 0,
+				(struct acpi_table_header **)&ras2_tab);
+	if (ACPI_FAILURE(status) || !ras2_tab) {
+		pr_err("Failed to get table, %s\n", acpi_format_exception(status));
+		return;
+	}
+
+	rc = acpi_ras2_parse();
+	if (rc) {
+		acpi_put_table((struct acpi_table_header *)ras2_tab);
+		pr_err("Failed to parse RAS2 table\n");
+	}
+}
diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
new file mode 100644
index 000000000000..50530b7cbca2
--- /dev/null
+++ b/include/acpi/ras2.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ACPI RAS2 driver header file
+ *
+ * Copyright (c) 2024-2025 HiSilicon Limited
+ */
+
+#ifndef _ACPI_RAS2_H
+#define _ACPI_RAS2_H
+
+#include <linux/acpi.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct device;
+
+/* ACPI spec 6.5 Table 5.82: PCC command codes used by
+ * RAS2 platform communication channel.
+ */
+#define PCC_CMD_EXEC_RAS2 0x01
+
+#define RAS2_AUX_DEV_NAME "ras2"
+#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
+
+/* Data structure RAS2 table */
+struct ras2_mem_ctx {
+	struct auxiliary_device adev;
+	/* Lock to provide mutually exclusive access to PCC channel */
+	struct mutex *pcc_lock;
+	struct device *dev;
+	struct acpi_ras2_shmem __iomem *comm_addr;
+	void *pcc_subspace;
+	int id;
+};
+
+#ifdef CONFIG_ACPI_RAS2
+void __init acpi_ras2_init(void);
+int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
+#else
+static inline void acpi_ras2_init(void) { }
+#endif
+#endif /* _ACPI_RAS2_H */
-- 
2.43.0


