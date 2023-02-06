Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8E168B38D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBFBDo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBFBDm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:42 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31EF144B5;
        Sun,  5 Feb 2023 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645421; x=1707181421;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efc+FneV0jKpVBpxm5XWbyZ/alUdKgjj2AHpNBEopmM=;
  b=QuD+LaJh/jx2c/zkUgdfIpNkBA83Y+y8LkZhlaNy52yLpt7LdRcn7dnR
   Dl1Ju3SXaveEBpyi54gpugW2xCqq0t7JtkR0yIq18lo/rmgnoFDMPvfzU
   9UNnOqUgL9nkswx+XXa3LLfQVSFG3CI8GWqJ2Bznf+INiKF9QDOXTNlUo
   jhg7HqL1gbwxVLeN82fnVQOe1HGZwcI39e0Q2Z0YiibvSnXLaI8x/Jyo2
   LIqB/5YvDROE1vtFzpsYUdqxvMlTMJBFE+Fc6hgxQrsCm7/cAWJeLXefG
   DFYuYElemXlV6Ca8020cjnZxgk9x5cSBNWPvwh6PILmoy0r6z+iBC7yrb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309442667"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309442667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775006670"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775006670"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:41 -0800
Subject: [PATCH 13/18] dax/hmem: Move HMAT and Soft reservation probe
 initcall level
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:41 -0800
Message-ID: <167564542109.847146.10113972881782419363.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for moving more filtering of "hmem" ranges into the
dax_hmem.ko module, update the initcall levels. HMAT range registration
moves to subsys_initcall() to be done before Soft Reservation probing,
and Soft Reservation probing is moved to device_initcall() to be done
before dax_hmem.ko initialization if it is built-in.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c  |    2 +-
 drivers/dax/hmem/Makefile |    3 ++-
 drivers/dax/hmem/device.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 605a0c7053be..ff24282301ab 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -869,4 +869,4 @@ static __init int hmat_init(void)
 	acpi_put_table(tbl);
 	return 0;
 }
-device_initcall(hmat_init);
+subsys_initcall(hmat_init);
diff --git a/drivers/dax/hmem/Makefile b/drivers/dax/hmem/Makefile
index 57377b4c3d47..d4c4cd6bccd7 100644
--- a/drivers/dax/hmem/Makefile
+++ b/drivers/dax/hmem/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
+# device_hmem.o deliberately precedes dax_hmem.o for initcall ordering
 obj-$(CONFIG_DEV_DAX_HMEM_DEVICES) += device_hmem.o
+obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
 
 device_hmem-y := device.o
 dax_hmem-y := hmem.o
diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
index 903325aac991..20749c7fab81 100644
--- a/drivers/dax/hmem/device.c
+++ b/drivers/dax/hmem/device.c
@@ -104,4 +104,4 @@ static __init int hmem_init(void)
  * As this is a fallback for address ranges unclaimed by the ACPI HMAT
  * parsing it must be at an initcall level greater than hmat_init().
  */
-late_initcall(hmem_init);
+device_initcall(hmem_init);

