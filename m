Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C5D855C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbfJPBOc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 21:14:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:44380 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfJPBOc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 21:14:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:14:32 -0700
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="195454448"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 18:14:31 -0700
Subject: [PATCH v7 09/12] dax: Fix alloc_dax_region() compile warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        kbuild test robot <lkp@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Tue, 15 Oct 2019 18:00:13 -0700
Message-ID: <157118761391.2063440.5389041529550571033.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PFN flags are (unsigned long long), fix the alloc_dax_region() calling
convention to fix warnings of the form:

>> include/linux/pfn_t.h:18:17: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))

Cc: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    2 +-
 drivers/dax/bus.h         |    2 +-
 drivers/dax/dax-private.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8fafbeab510a..eccdda1f7b71 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -227,7 +227,7 @@ static void dax_region_unregister(void *region)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align,
-		unsigned long pfn_flags)
+		unsigned long long pfn_flags)
 {
 	struct dax_region *dax_region;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 8619e3299943..9e4eba67e8b9 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -11,7 +11,7 @@ struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align,
-		unsigned long flags);
+		unsigned long long flags);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 6ccca3b890d6..3107ce80e809 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -32,7 +32,7 @@ struct dax_region {
 	struct device *dev;
 	unsigned int align;
 	struct resource res;
-	unsigned long pfn_flags;
+	unsigned long long pfn_flags;
 };
 
 /**

