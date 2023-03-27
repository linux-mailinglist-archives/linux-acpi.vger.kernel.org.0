Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA66CB0EC
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC0VqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjC0Vpb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E2F2703;
        Mon, 27 Mar 2023 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953530; x=1711489530;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zh8urJq+jR9Vil1i9aljmOMFom/6ygKszDzVGbSr91A=;
  b=MzdzO/u6mOZBVwbDEAkTaPF9DpC384zW7TzhfzHp+0IOUYOFDdWYgk4g
   /gga98epimt8kzWP6DQJ9bEJORyttr88MyiWivku7FZM+LAM4zhcEIcnT
   i9vORRyx//2CWEQTepaIiEXoW7awttJAdmzutHMcAvE+69akaKdrzAIGG
   MYu1qk0ww3wR12y/eX3ZDV325Tl5H54gnH/i+gba87J8gg9fdtW3OcBN6
   ZX+xHpWzToVzvtdCVaPxj8dyE/pmj86WOe0FD32bPJIWG+f5QQC7jIus2
   IisRybRF896wH6GtpOieBlKG+mxfwbv2CJf6SXH5x5RhwIHvvE7Eie57Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320799102"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320799102"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="660958509"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="660958509"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:29 -0700
Subject: [PATCH v2 14/21] ACPI: NUMA: Add helper function to retrieve the
 performance attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:28 -0700
Message-ID: <167995352876.2857312.5148434994393894318.stgit@djiang5-mobl3>
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

Add helper to retrieve the performance attributes based on the device
handle.  The helper function is exported so the CXL driver can use that
to acquire the performance data between the CPU and the CXL host bridge.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |    6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8879c4576cf5..9952a9bafe70 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -100,6 +100,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
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
+		*val = target->hmem_attrs[0].read_latency;
+		break;
+	case ACPI_HMAT_WRITE_LATENCY:
+		*val = target->hmem_attrs[0].write_latency;
+		break;
+	case ACPI_HMAT_ACCESS_BANDWIDTH:
+	case ACPI_HMAT_READ_BANDWIDTH:
+		*val = target->hmem_attrs[0].read_bandwidth;
+		break;
+	case ACPI_HMAT_WRITE_BANDWIDTH:
+		*val = target->hmem_attrs[0].write_bandwidth;
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
index efff750f326d..1a727053fabb 100644
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
+static inline int acpi_get_genport_attrs(u8 *device_handle, u64 *val, int type);
+{
+	return -EOPNOTSUPP;
+}
 #endif
 extern int acpi_paddr_to_node(u64 start_addr, u64 size);
 


