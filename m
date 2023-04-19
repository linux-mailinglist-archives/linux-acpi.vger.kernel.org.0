Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C46E828F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjDSUY7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjDSUYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ABB270E;
        Wed, 19 Apr 2023 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935758; x=1713471758;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RThwyeTcu5MAe4Du35/dHWTx27Co7ouODWd/rmD0lQE=;
  b=lka1UD4eX3AofjyarkPekO1HvFWubr0MPuIec0uG8Xs29K6qZgtdFJlI
   6b+RBi5jzl2lhN1RIJ4SO9sr37olcSjNUlaVWnyGtUAKME13nqYGynZIO
   UtNOH/dPWAJCdai0kQrLBXPj3xRZK099GFLPt4Mntvb5yhU4b56gNtTm2
   9uTcXKMJDhHoz2HwgVBTG0AyE01op/iNQeZQ6JGp16CIsUHyMrFhlyL2D
   Z3XnTeXgm4zmtXsAiw2wzXVv6j/ezlAxszkhlUKe9VRMTBg/N/gwftPLL
   3yO4mrPAWtdkVZPnuMmkCmVP0K3Xfscry8TywB/iwDuby47wRYkMJO+vm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347408414"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="347408414"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="669112604"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="669112604"
Received: from jdgarvey-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:37 -0700
Subject: [PATCH v4 16/23] ACPI: NUMA: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:22:36 -0700
Message-ID: <168193575676.1178687.5715986116891389206.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index ad0cf21700a1..768df2f3e6bc 100644
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
+		*val = target->hmem_attrs[NODE_ACCESS_CLASS_GENPORT].read_latency;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		*val = target->hmem_attrs[NODE_ACCESS_CLASS_GENPORT].write_latency;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+	case ACPI_HMAT_READ_BANDWIDTH:
+		*val = target->hmem_attrs[NODE_ACCESS_CLASS_GENPORT].read_bandwidth;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		*val = target->hmem_attrs[NODE_ACCESS_CLASS_GENPORT].write_bandwidth;
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
 


