Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9849F6CB0F4
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC0Vqf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC0VqS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:46:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9A2D67;
        Mon, 27 Mar 2023 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953577; x=1711489577;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UAeaeee3yTvKLvqJ/XX58s7B1Cuu8AmvKhY4rlK+DI=;
  b=eQ5IHQzoTyBDsrhA2KTR22sGcVUpUcCLomh5njS2dhJQPlykXfX3wRC/
   DJp13usJrobPq+5Rlja1H/6B4WGQNYbXTTTh4kZjSDB8eARlcTzc9E2Iw
   L8zXESTDeDlkLuvo92hCPlpuIp8z+nNtE+lzPVui9JSvsUQgpKQCQ1Jjt
   5tQJatoqwj8zDYENvuR1hUNpxpILcY8rJjL9RP9+KIqRwsRkdcxlwGPAI
   AQAdxAMSRCydlzL5QsRIiS7rsJHho8YLK3C5jLdb9W6b9xbybRL6EDepE
   jvB4+wJ09Bw9Bs+zxNUF4VyzqVW4Bd/q3ibivAYJyXiWVgUobnOcPuoy4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337900401"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337900401"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114808"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114808"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:46:06 -0700
Subject: [PATCH v2 20/21] cxl: Export sysfs attributes for memory device QTG
 ID
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:46:06 -0700
Message-ID: <167995356611.2857312.4634198260468536572.stgit@djiang5-mobl3>
In-Reply-To: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Export qtg_id sysfs attributes for the CXL memory device. The QTG ID
should show up as /sys/bus/cxl/devices/memX/qtg_id. The QTG ID is
retrieved via _DSM after supplying the caluclated bandwidth and latency
for the entire CXL path from device to the CPU. This ID is used to match
up to the root decoder QTG ID to determine which CFMWS the memory range
of a hotplugged CXL mem device should be assigned under.

While there may be multiple DSMAS exported by the device CDAT, the driver
will only expose the first QTG ID in sysfs for now. In the future when
multiple QTG IDs are necessary, they can be exposed. [1]

[1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
 drivers/cxl/core/memdev.c               |   15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 471ac9a37078..a018f0a21aca 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -58,6 +58,17 @@ Description:
 		affinity for this device.
 
 
+What:		/sys/bus/cxl/devices/memX/qtg_id
+Date:		March, 2024
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Show the first QoS Throttling Group ID for the device.
+		The ID is used to match against the CFMWS (root decoder)
+		QTG ID so that the memory range under a hot-plugged device
+		is assigned under the appropriate CFMWS.
+
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d2605fc39240..974eff833edd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,27 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t qtg_id_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct qos_prop_entry *qos;
+
+	if (list_empty(&cxlmd->qos_list))
+		return 0;
+
+	qos = list_first_entry(&cxlmd->qos_list, struct qos_prop_entry, list);
+	return sysfs_emit(buf, "%u\n", qos->qtg_id);
+}
+static DEVICE_ATTR_RO(qtg_id);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_qtg_id.attr,
 	NULL,
 };
 


