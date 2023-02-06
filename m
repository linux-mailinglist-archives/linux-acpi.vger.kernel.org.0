Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6668B387
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjBFBDZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFBDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D447144B5;
        Sun,  5 Feb 2023 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645402; x=1707181402;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeIQeRHiJX+pQkHKAuoYi54yr8qg0sN4RL762t1p8Jc=;
  b=bx49lvqJ4e8uv2OvNwbT3WZ5NpqFhkCUeqsUs9woWs3AymVqkit2JdnO
   VqJ2HOcySlldDGhb3WFd2/OI6DKAX7YilwP7ChfYS2N/jEmGbjbr8GJl4
   sKEimG8+avDUIt7H5zRZfhGjgrtPqQToelaAJRk7I7gEerF2GVPWkz3rw
   4s8ST54R4tMZw5L17v//qNXjzJFCSR7OkayENtmZU029jlgxUBZS1P+EZ
   D8Y4nCTlf8NYG7h6kd00B0iyihin9C+D8HnAFVYZZtuKbZh7rHMfD2gnn
   Eq11ApoGoLhjfG7enK3eFmAju5NOl3f4lwRX4/CqLUgprYXyLWg7Z8YO7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312763198"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312763198"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="616291316"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616291316"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:13 -0800
Subject: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:13 -0800
Message-ID: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

