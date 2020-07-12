Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE021CA61
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGLQn5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:43:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:25486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgGLQny (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:54 -0400
IronPort-SDR: W/uVagDg6QODjyUKwjwOTuYALFu6fdxpVClUmTtGylNqlMopOsBYyDRxqe43EBG9r4UwoT231V
 762eT/2dM5xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="233371314"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="233371314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:53 -0700
IronPort-SDR: 6TzdCRE2fzwUtJmRD/9EfCFIElciJvmPqXsWPc0c8rNKEeKxhxcSvMuVYcR8Bq7fJeQlwMajAd
 GEvT4hAHTm6g==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="325264264"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:53 -0700
Subject: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:27:37 -0700
Message-ID: <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use sysfs_streq() in device_find_child_by_name() to allow it to use a
sysfs input string that might contain a trailing newline.

The other "device by name" interfaces,
{bus,driver,class}_find_device_by_name(), already account for sysfs
strings.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c..5d31b962c898 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
 
 	klist_iter_init(&parent->p->klist_children, &i);
 	while ((child = next_device(&i)))
-		if (!strcmp(dev_name(child), name) && get_device(child))
+		if (sysfs_streq(dev_name(child), name) && get_device(child))
 			break;
 	klist_iter_exit(&i);
 	return child;

