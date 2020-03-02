Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37017677C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 23:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCBWg0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 17:36:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:11848 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgCBWg0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 17:36:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:25 -0800
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="228639191"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 14:36:25 -0800
Subject: [PATCH 4/5] resource: Report parent to walk_iomem_res_desc()
 callback
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, peterz@infradead.org,
        ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 14:20:20 -0800
Message-ID: <158318762012.2216124.16408566404290491508.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 76036a41143b..6e22e312fd55 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -386,6 +386,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 		res->end = min(end, p->end);
 		res->flags = p->flags;
 		res->desc = p->desc;
+		res->parent = p->parent;
 	}
 
 	read_unlock(&resource_lock);

