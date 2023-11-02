Return-Path: <linux-acpi+bounces-1169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE47DFC6E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 23:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC66B20C33
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199AD224C0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UASSTAzU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD901F94C;
	Thu,  2 Nov 2023 22:09:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE303138;
	Thu,  2 Nov 2023 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698962986; x=1730498986;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RdrELgEI40/IeGMsMXr5njTveEmApLg4gvx3TlLbQT0=;
  b=UASSTAzU2y+I5adnga1aZpAfuaUVx17pRr4VnCZD6F72FAE7pFvwteC2
   aOLaEUdyBoMSRos+U/NeFc/rg7EJV3SbYAUyMIvDxAmLoOs1Lj42zjqhB
   xQcOu3mej2lM/I3TObsu/6mnRVmOFPxM83AAKq9TT+WBMZD11g/utQMkF
   i5xPF6F37l69cSZQWSWUfExsWqRfsmOfTArAN5oY55sSG63nQTTZjQ6CX
   ftWPhMrV2DbGEuXHVrwJU9+iTnviC59PWwGBjYU8B9DzgYDX9dNq7kbx/
   yia7Y/W2Qmp9oDfVQl0vq8n3xXtWRQVI6NzSO0dA0h+R6ycVG4g9phoT/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387713889"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387713889"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878408009"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878408009"
Received: from lmhoover-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.76.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:07:02 -0700
Subject: [PATCH] lib/fw_table: Remove acpi_parse_entries_array() export
From: Dan Williams <dan.j.williams@intel.com>
To: linux-acpi@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-cxl@vger.kernel.org
Date: Thu, 02 Nov 2023 15:07:02 -0700
Message-ID: <169896282222.70775.940454758280866379.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Stephen reports that the ACPI helper library rework,
CONFIG_FIRMWARE_TABLE, introduces a new compiler warning:

    WARNING: modpost: vmlinux: acpi_parse_entries_array: EXPORT_SYMBOL used
    for init symbol. Remove __init or EXPORT_SYMBOL.

Delete this export as it turns out it is unneeded, and future work wraps
this in another exported helper. Note that in general
EXPORT_SYMBOL_ACPI_LIB() is needed for exporting symbols that are marked
__init_or_acpilib, but in this case no export is required.

Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
Cc: Dave Jiang <dave.jiang@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: http://lore.kernel.org/r/20231030160523.670a7569@canb.auug.org.au
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 lib/fw_table.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/fw_table.c b/lib/fw_table.c
index e84bd0866e10..b51f30a28e47 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -186,4 +186,3 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 
 	return errs ? -EINVAL : count;
 }
-EXPORT_SYMBOL_GPL(acpi_parse_entries_array);


