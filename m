Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C133A691AD7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjBJJIM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjBJJHc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:07:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152BDBDF;
        Fri, 10 Feb 2023 01:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020013; x=1707556013;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kiq8SiWxreJ/WplvYfP6rIo46j43k+e9EnBH+6Fzm+Q=;
  b=L2BSlSYB+kESKX/5othgWdaeXwqbvFYTDA3nSKCx425ekiJubiWR2IS/
   UZF/hzfKT54qhEIDUUFCERkJaHY6Itk9JfI9Qh4jn/Ao6Sp42jJJ8y8Ui
   FMYF75+WyVUJX1/wXug49r1z0+TNRUjACY9tRj6lzYODUiVm2F07l9Smv
   GfbenDy/5GVOnZuWTKSi06Mh4l30rPZhxC9XHQrK51qv4dZEs2FSZeAd8
   OEr3n/eBgixzS9ocRtJXOvBuNxo34iuNQcTpg7hhuYQKu4qteYSG8k0Es
   j5zfXWN727pNhPyv7HN1xuuZFFRE7aDUp2JJAtNU7nVWwrZU2lipMsy3g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328062586"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328062586"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700392732"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="700392732"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:51 -0800
Subject: [PATCH v2 15/20] dax/hmem: Move HMAT and Soft reservation probe
 initcall level
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:51 -0800
Message-ID: <167602001107.1924368.11562316181038595611.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for moving more filtering of "hmem" ranges into the
dax_hmem.ko module, update the initcall levels. HMAT range registration
moves to subsys_initcall() to be done before Soft Reservation probing,
and Soft Reservation probing is moved to device_initcall() to be done
before dax_hmem.ko initialization if it is built-in.

Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564542109.847146.10113972881782419363.stgit@dwillia2-xfh.jf.intel.com
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

