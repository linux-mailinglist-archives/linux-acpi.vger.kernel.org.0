Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F466DB14F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDGRNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDGRNm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0C1AD13;
        Fri,  7 Apr 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887620; x=1712423620;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tvzis9vZH6ocAk1I9hJKqp0bsV1H0EBYTkN66XhAdA=;
  b=PlZaRIDcnmIK0rRUsrMlSfCPhS/VjipYLYF/8tUNk7zVFIpTTErgBg5f
   VgpJxfE7dOKWKmUdGEz18FlYJlrW7Alf9YY54e08jab14EFBx4OFbGnbp
   jOELNUgos0Cn+zkwp+qQlE6CzT5ClmMbgu8xyJ8JUuu8jG5Ovq6TMCeRZ
   +DQA+AY4mHGR55Ff6BGO7y1C0ys87n0B1YoYW+0huCnTyL2eeNW+LbC3e
   YzCnM8FRU20iPUx8/g3F2g80yxTtXU7mAzu/uyAfBMAd0BIW964lrfXvR
   ZyZC94SRErIWEH+/WPr2jcK9geiIQg2txqQpdSJt9UWQIA11aR2wlLVBD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340520004"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340520004"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690119162"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690119162"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:36 -0700
Subject: [PATCH 3 16/23] ACPI: NUMA: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:36 -0700
Message-ID: <168088761615.1441063.15822678926474147168.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
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

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Fix 0-day report on extra ';'
---
 drivers/acpi/numa/hmat.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |    6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2596eb9eb419..c3598ddeed1c 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -107,6 +107,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
 	return NULL;
 }
 
+static struct memory_target *acpi_find_genport_target(u8 *device_handle)
+{
+	struct memory_target *target;
+
+	list_for_each_entry(target, &targets, node) {
+		if (!strncmp(target->device_handle, device_handle,
+			     ACPI_SRAT_DEVICE_HANDLE_SIZE))
+			return target;
+	}
+
+	return NULL;
+}
+
+int acpi_get_genport_attrs(u8 *device_handle, u64 *val, int type)
+{
+	struct memory_target *target;
+
+	target = acpi_find_genport_target(device_handle);
+	if (!target)
+		return -ENOENT;
+
+	switch (type) {
+	case ACPI_HMAT_ACCESS_LATENCY:
+	case ACPI_HMAT_READ_LATENCY:
+		*val = target->hmem_attrs[ACCESS_NODE_GENPORT].read_latency;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		*val = target->hmem_attrs[ACCESS_NODE_GENPORT].write_latency;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+	case ACPI_HMAT_READ_BANDWIDTH:
+		*val = target->hmem_attrs[ACCESS_NODE_GENPORT].read_bandwidth;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		*val = target->hmem_attrs[ACCESS_NODE_GENPORT].write_bandwidth;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_genport_attrs);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..2dc49ef3e28a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -451,6 +451,7 @@ extern bool acpi_osi_is_win8(void);
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+int acpi_get_genport_attrs(u8 *device_handle, u64 *val, int type);
 
 /**
  * pxm_to_online_node - Map proximity ID to online node
@@ -485,6 +486,11 @@ static inline int acpi_get_node(acpi_handle handle)
 {
 	return 0;
 }
+
+static inline int acpi_get_genport_attrs(u8 *device_handle, u64 *val, int type)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 extern int acpi_paddr_to_node(u64 start_addr, u64 size);
 


