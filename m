Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6E18C123
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Mar 2020 21:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgCSUPN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Mar 2020 16:15:13 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.102]:42830 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSUPN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Mar 2020 16:15:13 -0400
X-Greylist: delayed 1464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 16:15:13 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id AD784BBD9EB
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2020 14:50:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F1BojDGyKSl8qF1BojlwOe; Thu, 19 Mar 2020 14:50:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Wv3jbj7V3+afTv1zkiRc6/kzb45qZM0mlCOpT5a6Vw=; b=GqMq4pnkbHIJSyj16jS/IXGon5
        AEK/9C5A6VCq+zyljXQCj3ZPDd6r0vwMi+/18RhWGw3wWgiXIa0/QH9fFbUimH8EX8ZLLhraHmjHS
        snmVD9enTefCRw9Y1O1txFkR4D40WMSnEL8tPoDHUxDhN7oUCGn2s2nRt8huwibaYN9e3Abq9iixp
        vgWV6VI3P07cp9/Yb2VonQwMzLAI+Z+Hk0o917cOW297KF/7ozJnexvQcsrF1psDNFLBGY1KKeCX7
        hWb2RYznbyyH9IwB4sr2lBO0J40VD0KxaadhtPCTSakKVqQ0Ir8sROTfJvSFpMYVXvxVfnZ7g6Gwz
        4kIpaSow==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:52652 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF1Bm-000mHI-HG; Thu, 19 Mar 2020 14:50:46 -0500
Date:   Thu, 19 Mar 2020 14:50:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] acpi: nfit.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319195046.GA452@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jF1Bm-000mHI-HG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:52652
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/acpi/nfit/nfit.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 24241941181c..af09143ce403 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -144,32 +144,32 @@ struct nfit_spa {
 	unsigned long ars_state;
 	u32 clear_err_unit;
 	u32 max_ars;
-	struct acpi_nfit_system_address spa[0];
+	struct acpi_nfit_system_address spa[];
 };
 
 struct nfit_dcr {
 	struct list_head list;
-	struct acpi_nfit_control_region dcr[0];
+	struct acpi_nfit_control_region dcr[];
 };
 
 struct nfit_bdw {
 	struct list_head list;
-	struct acpi_nfit_data_region bdw[0];
+	struct acpi_nfit_data_region bdw[];
 };
 
 struct nfit_idt {
 	struct list_head list;
-	struct acpi_nfit_interleave idt[0];
+	struct acpi_nfit_interleave idt[];
 };
 
 struct nfit_flush {
 	struct list_head list;
-	struct acpi_nfit_flush_address flush[0];
+	struct acpi_nfit_flush_address flush[];
 };
 
 struct nfit_memdev {
 	struct list_head list;
-	struct acpi_nfit_memory_map memdev[0];
+	struct acpi_nfit_memory_map memdev[];
 };
 
 enum nfit_mem_flags {
-- 
2.23.0

