Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF9C442152
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 21:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKAUHS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 16:07:18 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:25416 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhKAUHQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2021 16:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635797082; x=1667333082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WdrwZn4ky8KCT9Yu6bhsOCixKbTKsCZbSgQPCcKL9eg=;
  b=zOIgKMN4oS5+E2u8AanqHbrE2SABHELr2j0koZzcA62ezIqSEOwhzJa8
   cRh0NjVIAN40JSC8mdt22qAMSyO9ERm6HXSpk2zfVYNwSx6tBZrBZCeiR
   S8HYO/Y6uQYuYvY6hwLNUDAXYeur08IrbBdPHOd7Nkb7HjgtS5G6t3e5d
   E=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Nov 2021 13:04:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 13:04:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 1 Nov 2021 13:04:41 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 1 Nov 2021 13:04:39 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [RFC PATCH] software node: Skip duplicated software_node sysfs
Date:   Mon, 1 Nov 2021 16:03:46 -0400
Message-ID: <20211101200346.16466-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A recent commit allowed device_create_managed_software_node() to call
software_node_notify() which could generate duplicated "software_node"
sysfs files. For example,

"/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node"

Since it was created earlier from another path,

  sysfs_create_link
  software_node_notify
  device_add
  platform_device_add
  dwc3_host_init
  dwc3_probe
  platform_probe
  really_probe.part.0
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  __platform_driver_register
  dwc3_driver_init at drivers/usb/dwc3/core.c:2072
  do_one_initcall

Fixed it by using sysfs_create_link_nowarn() in software_node_notify() to
avoid those bad messages during booting,

sysfs: cannot create duplicate filename '/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node'
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  sysfs_warn_dup
  sysfs_do_create_link_sd.isra.0
  sysfs_create_link
  software_node_notify
  device_create_managed_software_node
  iort_named_component_init
  iort_iommu_configure_id
  acpi_dma_configure_id
  platform_dma_configure
  really_probe.part.0
  really_probe
  __driver_probe_device
  driver_probe_device
  __driver_attach
  bus_for_each_dev
  driver_attach
  bus_add_driver
  driver_register
  __platform_driver_register
  xhci_plat_init
  do_one_initcall
  kernel_init_freeable
  kernel_init
  ret_from_fork

Fixes: 5aeb05b27f81 ("software node: balance refcount for managed software nodes")
Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 drivers/base/swnode.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4debcea4fb12..0a266c312aa3 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1126,17 +1126,15 @@ void software_node_notify(struct device *dev)
 	if (!swnode)
 		return;
 
-	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
-	if (ret)
+	ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
+				       "software_node");
+	if (ret && ret != -EEXIST)
 		return;
 
-	ret = sysfs_create_link(&swnode->kobj, &dev->kobj, dev_name(dev));
-	if (ret) {
+	if (!sysfs_create_link(&swnode->kobj, &dev->kobj, dev_name(dev)))
+		kobject_get(&swnode->kobj);
+	else if (!ret)
 		sysfs_remove_link(&dev->kobj, "software_node");
-		return;
-	}
-
-	kobject_get(&swnode->kobj);
 }
 
 void software_node_notify_remove(struct device *dev)
-- 
2.30.2

