Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6076A239F0B
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgHCFUp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 01:20:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:41483 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgHCFUn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Aug 2020 01:20:43 -0400
IronPort-SDR: xvES9ju6SqM798uej27RmDJLWVXWBbMu0xNcDY2HXYv5VDWeF4zJ9r3O7gySybAhcp4B1PloBh
 LIhajZ2bNYvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149847260"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="149847260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:43 -0700
IronPort-SDR: U/rM5DhcxpE7WZh4bHtjOp8I1vx1/1gMeTlx03D1ZbeBttQuqYJI2akDB473GZ9U0J8YdTqELW
 sgRUKKnaB3Xw==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="305681342"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:20:42 -0700
Subject: [PATCH v4 22/23] dax/hmem: Introduce dax_hmem.region_idle parameter
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Joao Martins <joao.m.martins@oracle.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, vishal.l.verma@intel.com,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        joao.m.martins@oracle.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Sun, 02 Aug 2020 22:04:24 -0700
Message-ID: <159643106460.4062302.5868522341307530091.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Introduce a new module parameter for dax_hmem which
initializes all region devices as free, rather than allocating
a pagemap for the region by default.

All hmem devices created with dax_hmem.region_idle=1 will have full
available size for creating dynamic dax devices.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Link: https://lore.kernel.org/r/20200716172913.19658-4-joao.m.martins@oracle.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1a3347bb6143..1bf040dbc834 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -5,6 +5,9 @@
 #include <linux/pfn_t.h>
 #include "../bus.h"
 
+static bool region_idle;
+module_param_named(region_idle, region_idle, bool, 0644);
+
 static int dax_hmem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -30,7 +33,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = resource_size(res),
+		.size = region_idle ? 0 : resource_size(res),
 	};
 	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))

