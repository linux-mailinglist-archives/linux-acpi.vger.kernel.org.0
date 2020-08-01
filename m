Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B04234FEE
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 05:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgHADls (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 23:41:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:46865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHADlr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 23:41:47 -0400
IronPort-SDR: hQuKz9bHwjrp0etibrcwWTihhJDYFJKuJ9gbKPg/ucf0aqPhjloW1KygMu8GcF8bdt2KxJitgJ
 BZty5ohI5D4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="149715999"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="149715999"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:47 -0700
IronPort-SDR: e3n7QjNdU9Y2kvg/YuTFVsHi/u3CvHT/O+EWhzOCkRhj3ddVnVfce6sMGJY08fskipYBVKlcP+
 3mllkaRHMBNQ==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="321647307"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:47 -0700
Subject: [PATCH v3 05/23] resource: Report parent to walk_iomem_res_desc()
 callback
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, ard.biesheuvel@linaro.org,
        vishal.l.verma@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 31 Jul 2020 20:25:29 -0700
Message-ID: <159625232903.3040297.3259451012924415121.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In support of detecting whether a resource might have been been claimed,
report the parent to the walk_iomem_res_desc() callback. For example,
the ACPI HMAT parser publishes "hmem" platform devices per target range.
However, if the HMAT is disabled / missing a fallback driver can attach
devices to the raw memory ranges as a fallback if it sees unclaimed /
orphan "Soft Reserved" resources in the resource tree.

Otherwise, find_next_iomem_res() returns a resource with garbage data
from the stack allocation in __walk_iomem_res_desc() for the res->parent
field.

There are currently no users that expect ->child and ->sibling to be
valid, and the resource_lock would be needed to traverse them. Use a
compound literal to implicitly zero initialize the fields that are not
being returned in addition to setting ->parent.

Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 841737bbda9e..f1175ce93a1d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -382,10 +382,13 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	if (p) {
 		/* copy data */
-		res->start = max(start, p->start);
-		res->end = min(end, p->end);
-		res->flags = p->flags;
-		res->desc = p->desc;
+		*res = (struct resource) {
+			.start = max(start, p->start),
+			.end = min(end, p->end),
+			.flags = p->flags,
+			.desc = p->desc,
+			.parent = p->parent,
+		};
 	}
 
 	read_unlock(&resource_lock);

