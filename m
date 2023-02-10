Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF2D691ACF
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjBJJHj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjBJJGm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F9937736;
        Fri, 10 Feb 2023 01:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019982; x=1707555982;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8q/1cNxswZmepEnA6xfwY56HjCTVePeFSsIba+FKR6Y=;
  b=ZRw+M68WmKFVF6bJwkp4m1Iz0TY4IiDKTg9mJihnQITd8NYxwCewiXPu
   RMW/vsvcqDs0/mfWROB+RyIlOxp8IjTuGNGXwfqjC+ZwUkL2N+ahz/2eR
   mnLDwb7atBSOI4wT5wm95zhlZ2EfMIcIMK9sU481djoVQhhFG4NWfsSUi
   ejrHxOZ2WsyrEDOk8kXWvZ24AwaJSX/fRZgvfKvvsVKlaHBNmQRgHgVAw
   V6hiYHSrxnSifW54/blm1CAk8dV7OQVa4qYsDCSsx91wLuBFKxRNNEKYB
   9hTmm0DzHhDfCkYeu5YHE84huZTfK1lchPm+c88L92NzBevV2cariRkck
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329003055"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329003055"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913463813"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="913463813"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:22 -0800
Subject: [PATCH v2 10/20] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:21 -0800
Message-ID: <167601998163.1924368.6067392174077323935.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In support of the CXL subsystem's use of 'struct range' to track decode
address ranges, add a common range_contains() implementation with
identical semantics as resource_contains();

The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
with a 'stackinit_' prefix.

Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |    5 -----
 include/linux/range.h  |    5 +++++
 lib/stackinit_kunit.c  |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1d1492440287..9ed2120dbf8a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -214,11 +214,6 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
 }
 
-static bool range_contains(struct range *r1, struct range *r2)
-{
-	return r1->start <= r2->start && r1->end >= r2->end;
-}
-
 /* require dvsec ranges to be covered by a locked platform window */
 static int dvsec_range_allowed(struct device *dev, void *arg)
 {
diff --git a/include/linux/range.h b/include/linux/range.h
index 274681cc3154..7efb6a9b069b 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,6 +13,11 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
+static inline bool range_contains(struct range *r1, struct range *r2)
+{
+	return r1->start <= r2->start && r1->end >= r2->end;
+}
+
 int add_range(struct range *range, int az, int nr_range,
 		u64 start, u64 end);
 
diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
index 4591d6cf5e01..05947a2feb93 100644
--- a/lib/stackinit_kunit.c
+++ b/lib/stackinit_kunit.c
@@ -31,8 +31,8 @@ static volatile u8 forced_mask = 0xff;
 static void *fill_start, *target_start;
 static size_t fill_size, target_size;
 
-static bool range_contains(char *haystack_start, size_t haystack_size,
-			   char *needle_start, size_t needle_size)
+static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
+				     char *needle_start, size_t needle_size)
 {
 	if (needle_start >= haystack_start &&
 	    needle_start + needle_size <= haystack_start + haystack_size)
@@ -175,7 +175,7 @@ static noinline void test_ ## name (struct kunit *test)		\
 								\
 	/* Validate that compiler lined up fill and target. */	\
 	KUNIT_ASSERT_TRUE_MSG(test,				\
-		range_contains(fill_start, fill_size,		\
+		stackinit_range_contains(fill_start, fill_size,	\
 			    target_start, target_size),		\
 		"stack fill missed target!? "			\
 		"(fill %zu wide, target offset by %d)\n",	\

