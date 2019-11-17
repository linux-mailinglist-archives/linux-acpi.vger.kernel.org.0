Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9353AFFB2E
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKQR74 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:26315 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR74 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:55 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="230950798"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:55 -0800
Subject: [PATCH v2 12/18] dax: Add numa_node to the default device-dax
 attributes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:45:39 -0800
Message-ID: <157401273948.43284.12093409202345381503.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is confusing that device-dax instances publish a 'target_node'
attribute, but not a 'numa_node'. The 'numa_node' information is
available elsewhere in the sysfs device hierarchy, but it is not obvious
and not reliable from one device-dax instance-type (e.g. child devices
of nvdimm namespaces) to the next (e.g. 'hmem' devices defined by EFI
Specific Purpose Memory and the ACPI HMAT).

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/dax/bus.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ce6d648d7670..0879b9663eb7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -322,6 +322,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t numa_node_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -329,6 +336,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
 		return 0;
+	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
+		return 0;
 	return a->mode;
 }
 
@@ -337,6 +346,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_size.attr,
 	&dev_attr_target_node.attr,
 	&dev_attr_resource.attr,
+	&dev_attr_numa_node.attr,
 	NULL,
 };
 

