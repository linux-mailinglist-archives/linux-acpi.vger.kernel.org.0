Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0AB750215
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGLIyC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGLIxy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 04:53:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB844BE
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689152028; x=1720688028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLJLLarSnNDpw44tioEvbf2Y47RvKBWuaObIn4/hPXU=;
  b=BVvEbkSMlIju81eH5M9doRaOCLmvS7SNYssEn+bVKTCGnMvEXjJzxfST
   Hd5SyRCvEK0bhHUN8iI1ZQjxmEDvjKow5JZmcM65i5Sd2/azZcGWZw6uq
   COQHXtHzMn7M0798Vc6ISMR/FJJMyeYXAJRHMoHzkhb1QG7VbnU6c2VAp
   rxuPd9tt0Q9MblXLEEqnbIjHnsgcndIJhqN9OyuA451FJ+RIY1NZ4W5gl
   sRvPjIkgZr9B6LWCnq+rXS3kwEtiBRtfn3rsWi992vMzHtwF/7ZJr2jf8
   CSE6p7IYdbCBoE2erI6m0FzVbuLb/8GraU08s47oq9fxgfVBasXeTYS8p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363704594"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="363704594"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 01:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724798350"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="724798350"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 01:53:27 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, erik.kaneda@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 3/4] ACPI: NHLT: Table manipulation helpers
Date:   Wed, 12 Jul 2023 11:10:47 +0200
Message-Id: <20230712091048.2545319-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712091048.2545319-1-cezary.rojewski@intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
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
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/acpi/nhlt.h | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index a2b93b08218f..076aac41a74e 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -81,4 +81,72 @@ static inline void acpi_nhlt_put_gbl_table(void)
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
+ * The for_each_nhlt_xxx() macros rely on an iterator to deal with the
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
+		((ep) = __acpi_nhlt_get_endpoint(tb, ep, __i));		\
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
+		((fmt) = __acpi_nhlt_get_fmtcfg(fmts, fmt, __i));	\
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
 #endif /* __ACPI_NHLT_H__ */
-- 
2.25.1

