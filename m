Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB255A49C
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jun 2022 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiFXXFe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiFXXFe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 19:05:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6598896E
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2022 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656111931; x=1687647931;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sTirgUrkotzGrSH6qecJSFz4C/4Jp50Wc83W3PgFw0M=;
  b=SUBemZwJv5TEFUbg7b4skPvyHrNDra9BQhz90RzkaZ+OBRCqxBI3ZMxk
   o14wxSZxR3tHr3Y2IEuPclZHJyzOO+tza+ZPhM5rkQ2xNfRNl1eUA95ky
   vdgZC99YR82hMRpfvC5FIkBeBUr0vjh5KBEU9/q4C0lkokWlUR/6xjYFH
   Q7Z8vsV6BMzDI+E+eoXbCHYBRFYkmexKm1IZPQ12qQazJc0r4bCX/cOBb
   Q/Qz1RBr1gQgzYc2IZVOkC1aczrlkFcSovLJ0JVR+dpyBnjCuT6DX6asm
   SyaCwuU4TDBCr0aaRpi+VbnDd3j/MuXkk1OUbVl0Oe8HdxDdiza1V3fO6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="306580049"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="306580049"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 16:05:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="678735414"
Received: from jooyoun1-mobl1.amr.corp.intel.com (HELO [192.168.1.117]) ([10.209.31.49])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 16:05:26 -0700
Subject: [PATCH] ACPI: Fix _EINJ vs EFI_MEMORY_SP
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Mustafa Hajeer <mustafa.hajeer@intel.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Omar Avelar <omar.avelar@intel.com>,
        linux-acpi@vger.kernel.org, patches@lists.linux.dev
Date:   Fri, 24 Jun 2022 16:05:26 -0700
Message-ID: <165611192645.990447.9154951000881269149.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When a platform marks a memory range as "special purpose" it is not
onlined as System RAM by default. However, it is still suitable for
error injection. Add IORES_DESC_SOFT_RESERVED to einj_error_inject() as
a permissible memory type in the sanity checking of the arguments to
_EINJ.

Fixes: 262b45ae3ab4 ("x86/efi: EFI soft reservation to E820 enumeration")
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Mustafa Hajeer <mustafa.hajeer@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/apei/einj.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index d4326ec12d29..6b583373c58a 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -546,6 +546,8 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				!= REGION_INTERSECTS) &&
 	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
 				!= REGION_INTERSECTS) &&
+	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
+				!= REGION_INTERSECTS) &&
 	     !arch_is_platform_page(base_addr)))
 		return -EINVAL;
 

