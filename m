Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355D75C38F
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGUJtl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjGUJsy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 05:48:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600273AAA
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932902; x=1721468902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PlqKy6hW9kRFjbpiqtqOjs5qDex2xducMY9u7GQQluk=;
  b=XgncFPzWa24rBzeaxWpNzTqAsrWlyfLSHzBSOjSM60ZcjVy4O8yahsDi
   KJ1kMxZSASo4SbK9mTnsOzeRAPvDg82eQVZi5rB9cjloUFGzqBR1dOWt9
   1fYoUJ7uqmyXL/7EqiJGTnVeoT7I6rAh9l7itgH2xUtMuXvzKN9YfGe6O
   EwuGsA+HeDkRpco8GaycLfxPLuzj5BIpbUUMIt71V7n01F8n1xcURV8JP
   LY5IP05o0JTxrGxNgWUUlI+bcpmNiPAG2QnWDij/0EOIH526qXmrw9ZN5
   CUdsZbqtIFs9rBP0yBgQ9ZcXjmg1gv53uMUsAYSPCanpLp2KHpqvGpWme
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367022178"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367022178"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055508037"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055508037"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 02:47:35 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 3/4] ACPI: NHLT: Table manipulation helpers
Date:   Fri, 21 Jul 2023 11:47:21 +0200
Message-Id: <20230721094722.300586-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721094722.300586-1-cezary.rojewski@intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The table is composed of a range of endpoints with each describing
audio formats they support. Thus most of the operations involve
iterating over elements of the table. Simplify the process by
implementing range of getters.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/acpi/nhlt.h | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index e68e0534412d..9a2e47e49de7 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -63,6 +63,74 @@
 	__cfg->capabilities_size == struct_size(__cfg, mics, __cfg->num_mics) ?		\
 		__cfg : NULL; })
 
+/**
+ * acpi_nhlt_endpoint_fmtscfg - Get the formats configuration space.
+ * @ep:		the endpoint to retrieve the space for.
+ *
+ * Return: A pointer to the formats configuration space.
+ */
+static inline struct acpi_nhlt_formats_config *
+acpi_nhlt_endpoint_fmtscfg(const struct acpi_nhlt_endpoint *ep)
+{
+	struct acpi_nhlt_cfg *cfg = __acpi_nhlt_endpoint_cfg(ep);
+
+	return (struct acpi_nhlt_formats_config *)((u8 *)(cfg + 1) + cfg->capabilities_size);
+}
+
+#define __acpi_nhlt_first_endpoint(tb) \
+	((void *)(tb + 1))
+
+#define __acpi_nhlt_next_endpoint(ep) \
+	((void *)((u8 *)(ep) + (ep)->descriptor_length))
+
+#define __acpi_nhlt_get_endpoint(tb, ep, i) \
+	((i) ? __acpi_nhlt_next_endpoint(ep) : __acpi_nhlt_first_endpoint(tb))
+
+#define __acpi_nhlt_first_fmtcfg(fmts) \
+	((void *)(fmts + 1))
+
+#define __acpi_nhlt_next_fmtcfg(fmt) \
+	((void *)((u8 *)((fmt) + 1) + (fmt)->capability_size))
+
+#define __acpi_nhlt_get_fmtcfg(fmts, fmt, i) \
+	((i) ? __acpi_nhlt_next_fmtcfg(fmt) : __acpi_nhlt_first_fmtcfg(fmts))
+
+/*
+ * The for_each_nhlt_*() macros rely on an iterator to deal with the
+ * variable length of each endpoint structure and the possible presence
+ * of an OED-Config used by Windows only.
+ */
+
+/**
+ * for_each_nhlt_endpoint - Iterate over endpoints in a NHLT table.
+ * @tb:		the pointer to a NHLT table.
+ * @ep:		the pointer to endpoint to use as loop cursor.
+ */
+#define for_each_nhlt_endpoint(tb, ep)					\
+	for (unsigned int __i = 0;					\
+	     __i < (tb)->endpoint_count &&				\
+		(ep = __acpi_nhlt_get_endpoint(tb, ep, __i));		\
+	     __i++)
+
+/**
+ * for_each_nhlt_fmtcfg - Iterate over format configurations.
+ * @fmts:	the pointer to formats configuration space.
+ * @fmt:	the pointer to format to use as loop cursor.
+ */
+#define for_each_nhlt_fmtcfg(fmts, fmt)					\
+	for (unsigned int __i = 0;					\
+	     __i < (fmts)->formats_count &&				\
+		(fmt = __acpi_nhlt_get_fmtcfg(fmts, fmt, __i));	\
+	     __i++)
+
+/**
+ * for_each_nhlt_endpoint_fmtcfg - Iterate over format configurations in an endpoint.
+ * @ep:		the pointer to an endpoint.
+ * @fmt:	the pointer to format to use as loop cursor.
+ */
+#define for_each_nhlt_endpoint_fmtcfg(ep, fmt) \
+	for_each_nhlt_fmtcfg(acpi_nhlt_endpoint_fmtscfg(ep), fmt)
+
 #if IS_ENABLED(CONFIG_ACPI_NHLT)
 
 /*
-- 
2.25.1

