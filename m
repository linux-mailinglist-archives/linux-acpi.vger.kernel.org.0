Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C59767EDE
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jul 2023 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjG2Lx0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Jul 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2LxZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Jul 2023 07:53:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050F1FC8;
        Sat, 29 Jul 2023 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690631601; x=1722167601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Qo9I2qd0qfbW5s4OC1WUDOmQ8Rj6S3X2KvJgX3OnQ7c=;
  b=ZLs9a5YPLkiy9zfb5mV8JVJnnzG4eGsWQ2vF+VYePvuSldxg5oHr3Rya
   bQ5qPOlqd+QraAeXJ9EMFPfghBGCwA4BXL1cyD4lOHfModFQGsfoQVnpb
   2zzXqhcHuqEWPB++aqAKBBsrl+pKpknMVU9KnTnpmGIy8LAtx1pEyaWXc
   VILtJC1N74S5vSL70QRj8QodxhbNJOsXQ9GRpQBGKBSicNPF2KZcA0DUe
   gwbIiO9ooOBf0XJhXLeuH1w36Zf5lt7quCCDydkFNSXCV0+IF2IYSz4eZ
   F1aCQQm7sfymVOCeWa+7AmqS0gJ8Zbw+qIh0+0aTu1nkIUyJ+1obtV427
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="455116349"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455116349"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 04:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762848868"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="762848868"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2023 04:53:18 -0700
From:   Wentong Wu <wentong.wu@intel.com>
To:     sakari.ailus@linux.intel.com, hdegoede@redhat.com,
        djrscally@gmail.com, laurent.pinchart@ideasonboard.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     bingbu.cao@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com,
        Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v10 2/3] media: pci: intel: ivsc: Add ACE submodule
Date:   Sat, 29 Jul 2023 19:52:54 +0800
Message-Id: <1690631575-15124-3-git-send-email-wentong.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
References: <1690631575-15124-1-git-send-email-wentong.wu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACE is a submodule of IVSC which controls camera sensor's
ownership, belonging to host or IVSC. When IVSC owns camera
sensor, it is for algorithm computing. When host wants to
control camera sensor, ACE module needs to be informed of
ownership with defined interface.

The interface is via MEI. There is a separate MEI UUID, which
this driver uses to enumerate.

To switch ownership of camera sensor between IVSC and host,
the caller specifies the defined ownership information which
will be sent to firmware by sending MEI command.

Device link(device_link_add) is used to set the right camera
sensor ownership before accessing the sensor via I2C. With
DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE, the supplier device
will be PM runtime resumed before the consumer(camera sensor).
So use runtime PM callbacks to transfer the ownership between
host and IVSC.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 drivers/media/pci/intel/ivsc/Makefile  |   3 +
 drivers/media/pci/intel/ivsc/mei_ace.c | 579 +++++++++++++++++++++++++++++++++
 2 files changed, 582 insertions(+)
 create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.c

diff --git a/drivers/media/pci/intel/ivsc/Makefile b/drivers/media/pci/intel/ivsc/Makefile
index cbd194a..00fad29 100644
--- a/drivers/media/pci/intel/ivsc/Makefile
+++ b/drivers/media/pci/intel/ivsc/Makefile
@@ -4,3 +4,6 @@
 
 obj-$(CONFIG_INTEL_VSC) += ivsc-csi.o
 ivsc-csi-y += mei_csi.o
+
+obj-$(CONFIG_INTEL_VSC) += ivsc-ace.o
+ivsc-ace-y += mei_ace.o
diff --git a/drivers/media/pci/intel/ivsc/mei_ace.c b/drivers/media/pci/intel/ivsc/mei_ace.c
new file mode 100644
index 0000000..bc37f6d
--- /dev/null
+++ b/drivers/media/pci/intel/ivsc/mei_ace.c
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Intel Corporation. All rights reserved.
+ * Intel Visual Sensing Controller ACE Linux driver
+ */
+
+/*
+ * To set ownership of camera sensor, there is specific command, which
+ * is sent via MEI protocol. That's a two-step scheme where the firmware
+ * first acks receipt of the command and later responses the command was
+ * executed. The command sending function uses "completion" as the
+ * synchronization mechanism. The notification for command is received
+ * via a mei callback which wakes up the caller. There can be only one
+ * outstanding command at a time.
+ *
+ * The power line of camera sensor is directly connected to IVSC instead
+ * of host, when camera sensor ownership is switched to host, sensor is
+ * already powered up by firmware.
+ */
+
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mei_cl_bus.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/uuid.h>
+#include <linux/workqueue.h>
+
+#define	MEI_ACE_DRIVER_NAME	"ivsc_ace"
+
+/* indicating driver message */
+#define	ACE_DRV_MSG		1
+/* indicating set command */
+#define	ACE_CMD_SET		4
+/* command timeout determined experimentally */
+#define	ACE_CMD_TIMEOUT		(5 * HZ)
+/* indicating the first command block */
+#define	ACE_CMD_INIT_BLOCK	1
+/* indicating the last command block */
+#define	ACE_CMD_FINAL_BLOCK	1
+/* size of camera status notification content */
+#define	ACE_CAMERA_STATUS_SIZE	5
+
+/* UUID used to get firmware id */
+#define ACE_GET_FW_ID_UUID UUID_LE(0x6167DCFB, 0x72F1, 0x4584, 0xBF, \
+				   0xE3, 0x84, 0x17, 0x71, 0xAA, 0x79, 0x0B)
+
+/* UUID used to get csi device */
+#define MEI_CSI_UUID UUID_LE(0x92335FCF, 0x3203, 0x4472, \
+			     0xAF, 0x93, 0x7b, 0x44, 0x53, 0xAC, 0x29, 0xDA)
+
+/* identify firmware event type */
+enum ace_event_type {
+	/* firmware ready */
+	ACE_FW_READY = 0x8,
+
+	/* command response */
+	ACE_CMD_RESPONSE = 0x10,
+};
+
+/* identify camera sensor ownership */
+enum ace_camera_owner {
+	ACE_CAMERA_IVSC,
+	ACE_CAMERA_HOST,
+};
+
+/* identify the command id supported by firmware IPC */
+enum ace_cmd_id {
+	/* used to switch camera sensor to host */
+	ACE_SWITCH_CAMERA_TO_HOST = 0x13,
+
+	/* used to switch camera sensor to IVSC */
+	ACE_SWITCH_CAMERA_TO_IVSC = 0x14,
+
+	/* used to get firmware id */
+	ACE_GET_FW_ID = 0x1A,
+};
+
+/* ACE command header structure */
+struct ace_cmd_hdr {
+	u32 firmware_id : 16;
+	u32 instance_id : 8;
+	u32 type : 5;
+	u32 rsp : 1;
+	u32 msg_tgt : 1;
+	u32 _hw_rsvd_1 : 1;
+	u32 param_size : 20;
+	u32 cmd_id : 8;
+	u32 final_block : 1;
+	u32 init_block : 1;
+	u32 _hw_rsvd_2 : 2;
+} __packed;
+
+/* ACE command parameter structure */
+union ace_cmd_param {
+	uuid_le uuid;
+	u32 param;
+};
+
+/* ACE command structure */
+struct ace_cmd {
+	struct ace_cmd_hdr hdr;
+	union ace_cmd_param param;
+} __packed;
+
+/* ACE notification header */
+union ace_notif_hdr {
+	struct _confirm {
+		u32 status : 24;
+		u32 type : 5;
+		u32 rsp : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 param_size : 20;
+		u32 cmd_id : 8;
+		u32 final_block : 1;
+		u32 init_block : 1;
+		u32 _hw_rsvd_2 : 2;
+	} __packed ack;
+
+	struct _event {
+		u32 rsvd1 : 16;
+		u32 event_type : 8;
+		u32 type : 5;
+		u32 ack : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 rsvd2 : 30;
+		u32 _hw_rsvd_2 : 2;
+	} __packed event;
+
+	struct _response {
+		u32 event_id : 16;
+		u32 notif_type : 8;
+		u32 type : 5;
+		u32 rsp : 1;
+		u32 msg_tgt : 1;
+		u32 _hw_rsvd_1 : 1;
+		u32 event_data_size : 16;
+		u32 request_target : 1;
+		u32 request_type : 5;
+		u32 cmd_id : 8;
+		u32 _hw_rsvd_2 : 2;
+	} __packed response;
+};
+
+/* ACE notification content */
+union ace_notif_cont {
+	u16 firmware_id;
+	u8 state_notif;
+	u8 camera_status[ACE_CAMERA_STATUS_SIZE];
+};
+
+/* ACE notification structure */
+struct ace_notif {
+	union ace_notif_hdr hdr;
+	union ace_notif_cont cont;
+} __packed;
+
+struct mei_ace {
+	struct mei_cl_device *cldev;
+
+	/* command ack */
+	struct ace_notif cmd_ack;
+	/* command response */
+	struct ace_notif cmd_response;
+	/* used to wait for command ack and response */
+	struct completion cmd_completion;
+	/* lock used to prevent multiple call to send command */
+	struct mutex lock;
+
+	/* used to construct command */
+	u16 firmware_id;
+
+	struct device *csi_dev;
+
+	/* runtime PM link from ace to csi */
+	struct device_link *csi_link;
+
+	struct work_struct work;
+};
+
+static inline void init_cmd_hdr(struct ace_cmd_hdr *hdr)
+{
+	memset(hdr, 0, sizeof(struct ace_cmd_hdr));
+
+	hdr->type = ACE_CMD_SET;
+	hdr->msg_tgt = ACE_DRV_MSG;
+	hdr->init_block = ACE_CMD_INIT_BLOCK;
+	hdr->final_block = ACE_CMD_FINAL_BLOCK;
+}
+
+static int construct_command(struct mei_ace *ace, struct ace_cmd *cmd,
+			     enum ace_cmd_id cmd_id)
+{
+	union ace_cmd_param *param = &cmd->param;
+	struct ace_cmd_hdr *hdr = &cmd->hdr;
+
+	init_cmd_hdr(hdr);
+
+	hdr->cmd_id = cmd_id;
+	switch (cmd_id) {
+	case ACE_GET_FW_ID:
+		param->uuid = ACE_GET_FW_ID_UUID;
+		hdr->param_size = sizeof(param->uuid);
+		break;
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+		param->param = 0;
+		hdr->firmware_id = ace->firmware_id;
+		hdr->param_size = sizeof(param->param);
+		break;
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		hdr->firmware_id = ace->firmware_id;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return hdr->param_size + sizeof(cmd->hdr);
+}
+
+/* send command to firmware */
+static int mei_ace_send(struct mei_ace *ace, struct ace_cmd *cmd,
+			size_t len, bool only_ack)
+{
+	union ace_notif_hdr *resp_hdr = &ace->cmd_response.hdr;
+	union ace_notif_hdr *ack_hdr = &ace->cmd_ack.hdr;
+	struct ace_cmd_hdr *cmd_hdr = &cmd->hdr;
+	int ret;
+
+	mutex_lock(&ace->lock);
+
+	reinit_completion(&ace->cmd_completion);
+
+	ret = mei_cldev_send(ace->cldev, (u8 *)cmd, len);
+	if (ret < 0)
+		goto out;
+
+	ret = wait_for_completion_killable_timeout(&ace->cmd_completion,
+						   ACE_CMD_TIMEOUT);
+	if (ret < 0) {
+		goto out;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (ack_hdr->ack.cmd_id != cmd_hdr->cmd_id) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* command ack status */
+	ret = ack_hdr->ack.status;
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (only_ack)
+		goto out;
+
+	ret = wait_for_completion_killable_timeout(&ace->cmd_completion,
+						   ACE_CMD_TIMEOUT);
+	if (ret < 0) {
+		goto out;
+	} else if (!ret) {
+		ret = -ETIMEDOUT;
+		goto out;
+	} else {
+		ret = 0;
+	}
+
+	if (resp_hdr->response.cmd_id != cmd_hdr->cmd_id)
+		ret = -EINVAL;
+
+out:
+	mutex_unlock(&ace->lock);
+
+	return ret;
+}
+
+static int ace_set_camera_owner(struct mei_ace *ace,
+				enum ace_camera_owner owner)
+{
+	enum ace_cmd_id cmd_id;
+	struct ace_cmd cmd;
+	int cmd_size;
+	int ret;
+
+	if (owner == ACE_CAMERA_IVSC)
+		cmd_id = ACE_SWITCH_CAMERA_TO_IVSC;
+	else
+		cmd_id = ACE_SWITCH_CAMERA_TO_HOST;
+
+	cmd_size = construct_command(ace, &cmd, cmd_id);
+	if (cmd_size >= 0)
+		ret = mei_ace_send(ace, &cmd, cmd_size, false);
+	else
+		ret = cmd_size;
+
+	return ret;
+}
+
+/* the first command downloaded to firmware */
+static inline int ace_get_firmware_id(struct mei_ace *ace)
+{
+	struct ace_cmd cmd;
+	int cmd_size;
+	int ret;
+
+	cmd_size = construct_command(ace, &cmd, ACE_GET_FW_ID);
+	if (cmd_size >= 0)
+		ret = mei_ace_send(ace, &cmd, cmd_size, true);
+	else
+		ret = cmd_size;
+
+	return ret;
+}
+
+static void handle_command_response(struct mei_ace *ace,
+				    struct ace_notif *resp, int len)
+{
+	union ace_notif_hdr *hdr = &resp->hdr;
+
+	switch (hdr->response.cmd_id) {
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		memcpy(&ace->cmd_response, resp, len);
+		complete(&ace->cmd_completion);
+		break;
+	case ACE_GET_FW_ID:
+		break;
+	default:
+		break;
+	}
+}
+
+static void handle_command_ack(struct mei_ace *ace,
+			       struct ace_notif *ack, int len)
+{
+	union ace_notif_hdr *hdr = &ack->hdr;
+
+	switch (hdr->ack.cmd_id) {
+	case ACE_GET_FW_ID:
+		ace->firmware_id = ack->cont.firmware_id;
+		fallthrough;
+	case ACE_SWITCH_CAMERA_TO_IVSC:
+	case ACE_SWITCH_CAMERA_TO_HOST:
+		memcpy(&ace->cmd_ack, ack, len);
+		complete(&ace->cmd_completion);
+		break;
+	default:
+		break;
+	}
+}
+
+/* callback for receive */
+static void mei_ace_rx(struct mei_cl_device *cldev)
+{
+	struct mei_ace *ace = mei_cldev_get_drvdata(cldev);
+	struct ace_notif event;
+	union ace_notif_hdr *hdr = &event.hdr;
+	int ret;
+
+	ret = mei_cldev_recv(cldev, (u8 *)&event, sizeof(event));
+	if (ret < 0) {
+		dev_err(&cldev->dev, "recv error: %d\n", ret);
+		return;
+	}
+
+	if (hdr->event.ack) {
+		handle_command_ack(ace, &event, ret);
+		return;
+	}
+
+	switch (hdr->event.event_type) {
+	case ACE_CMD_RESPONSE:
+		handle_command_response(ace, &event, ret);
+		break;
+	case ACE_FW_READY:
+		/*
+		 * firmware ready notification sent to driver
+		 * after HECI client connected with firmware.
+		 */
+		dev_dbg(&cldev->dev, "firmware ready\n");
+		break;
+	default:
+		break;
+	}
+}
+
+static int mei_ace_setup_dev_link(struct mei_ace *ace)
+{
+	struct device *dev = &ace->cldev->dev;
+	uuid_le uuid = MEI_CSI_UUID;
+	struct device *csi_dev;
+	char name[64];
+	int ret;
+
+	snprintf(name, sizeof(name), "%s-%pUl", dev_name(dev->parent), &uuid);
+
+	csi_dev = device_find_child_by_name(dev->parent, name);
+	if (!csi_dev) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+
+	/* setup link between mei_ace and mei_csi */
+	ace->csi_link = device_link_add(csi_dev, dev, DL_FLAG_PM_RUNTIME |
+					DL_FLAG_RPM_ACTIVE | DL_FLAG_STATELESS);
+	if (!ace->csi_link) {
+		ret = -EINVAL;
+		dev_err(dev, "failed to link to %s\n", dev_name(csi_dev));
+		goto err_put;
+	}
+
+	ace->csi_dev = csi_dev;
+
+	return 0;
+
+err_put:
+	put_device(csi_dev);
+
+err:
+	return ret;
+}
+
+/* switch camera to host before probe sensor device */
+static void mei_ace_post_probe_work(struct work_struct *work)
+{
+	struct acpi_device *adev;
+	struct mei_ace *ace;
+	struct device *dev;
+	int ret;
+
+	ace = container_of(work, struct mei_ace, work);
+	dev = &ace->cldev->dev;
+
+	ret = ace_set_camera_owner(ace, ACE_SWITCH_CAMERA_TO_HOST);
+	if (ret) {
+		dev_err(dev, "switch camera to host failed: %d\n", ret);
+		return;
+	}
+
+	adev = ACPI_COMPANION(dev->parent);
+	if (!adev)
+		return;
+
+	acpi_dev_clear_dependencies(adev);
+}
+
+static int mei_ace_probe(struct mei_cl_device *cldev,
+			 const struct mei_cl_device_id *id)
+{
+	struct device *dev = &cldev->dev;
+	struct mei_ace *ace;
+	int ret;
+
+	ace = devm_kzalloc(dev, sizeof(struct mei_ace), GFP_KERNEL);
+	if (!ace)
+		return -ENOMEM;
+
+	ace->cldev = cldev;
+	mutex_init(&ace->lock);
+	init_completion(&ace->cmd_completion);
+	INIT_WORK(&ace->work, mei_ace_post_probe_work);
+
+	mei_cldev_set_drvdata(cldev, ace);
+
+	ret = mei_cldev_enable(cldev);
+	if (ret < 0) {
+		dev_err(dev, "mei_cldev_enable failed: %d\n", ret);
+		goto destroy_mutex;
+	}
+
+	ret = mei_cldev_register_rx_cb(cldev, mei_ace_rx);
+	if (ret) {
+		dev_err(dev, "event cb registration failed: %d\n", ret);
+		goto err_disable;
+	}
+
+	ret = ace_get_firmware_id(ace);
+	if (ret) {
+		dev_err(dev, "get firmware id failed: %d\n", ret);
+		goto err_disable;
+	}
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = mei_ace_setup_dev_link(ace);
+	if (ret)
+		goto disable_pm;
+
+	schedule_work(&ace->work);
+
+	return 0;
+
+disable_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
+err_disable:
+	mei_cldev_disable(cldev);
+
+destroy_mutex:
+	mutex_destroy(&ace->lock);
+
+	return ret;
+}
+
+static void mei_ace_remove(struct mei_cl_device *cldev)
+{
+	struct mei_ace *ace = mei_cldev_get_drvdata(cldev);
+
+	cancel_work_sync(&ace->work);
+
+	device_link_del(ace->csi_link);
+	put_device(ace->csi_dev);
+
+	pm_runtime_disable(&cldev->dev);
+	pm_runtime_set_suspended(&cldev->dev);
+
+	ace_set_camera_owner(ace, ACE_SWITCH_CAMERA_TO_IVSC);
+
+	mutex_destroy(&ace->lock);
+}
+
+static int __maybe_unused mei_ace_runtime_suspend(struct device *dev)
+{
+	struct mei_ace *ace = dev_get_drvdata(dev);
+
+	return ace_set_camera_owner(ace, ACE_SWITCH_CAMERA_TO_IVSC);
+}
+
+static int __maybe_unused mei_ace_runtime_resume(struct device *dev)
+{
+	struct mei_ace *ace = dev_get_drvdata(dev);
+
+	return ace_set_camera_owner(ace, ACE_SWITCH_CAMERA_TO_HOST);
+}
+
+static const struct dev_pm_ops mei_ace_pm_ops = {
+	SET_RUNTIME_PM_OPS(mei_ace_runtime_suspend,
+			   mei_ace_runtime_resume, NULL)
+};
+
+#define MEI_ACE_UUID UUID_LE(0x5DB76CF6, 0x0A68, 0x4ED6, \
+			     0x9B, 0x78, 0x03, 0x61, 0x63, 0x5E, 0x24, 0x47)
+
+static const struct mei_cl_device_id mei_ace_tbl[] = {
+	{ MEI_ACE_DRIVER_NAME, MEI_ACE_UUID, MEI_CL_VERSION_ANY },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(mei, mei_ace_tbl);
+
+static struct mei_cl_driver mei_ace_driver = {
+	.id_table = mei_ace_tbl,
+	.name = MEI_ACE_DRIVER_NAME,
+
+	.probe = mei_ace_probe,
+	.remove = mei_ace_remove,
+
+	.driver = {
+		.pm = &mei_ace_pm_ops,
+	},
+};
+
+module_mei_cl_driver(mei_ace_driver);
+
+MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
+MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
+MODULE_DESCRIPTION("Device driver for IVSC ACE");
+MODULE_LICENSE("GPL");
-- 
2.7.4

