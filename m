Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CCC2F5B2B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 08:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhANHUW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 02:20:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:59166 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbhANHUV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 02:20:21 -0500
IronPort-SDR: EYAHR2M3RGDGSDELNCEN5t5Bu/mqtoZVZ86a5ee/nAEGGhHqB4xOu2JcaiBAAUMSlbsxnR14bA
 q5rhlL04crsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="174813107"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="174813107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 23:19:41 -0800
IronPort-SDR: mIzgSRZ6QZJcAS6CKpmgiAFberHjnnaQ8VHER7sLZX7qQrhYf06TSQp7jP9I3jwYvtR5JWGNLW
 egoZp43p4dQg==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="382169975"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 23:19:39 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, ying.huang@intel.com, tony.luck@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 1/1] Documentation: ACPI: EINJ: Fix error type value for PCIe error
Date:   Thu, 14 Jan 2021 15:19:23 +0800
Message-Id: <20210114071923.14920-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the error type value for PCI Express uncorrectable non-fatal
error to 0x00000080 and fix the error type value for PCI Express
uncorrectable fatal error to 0x00000100.

See Advanced Configuration and Power Interface Specification,
version 6.2, table "18-409 Error Type Definition".

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reported-by: Lijian Zhao <lijian.zhao@intel.com>
---
The error type values used in file drivers/acpi/apei/einj.c
function available_error_type_show() are correct.


 Documentation/firmware-guide/acpi/apei/einj.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index e588bccf5158..c042176e1707 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -50,8 +50,8 @@ The following files belong to it:
   0x00000010        Memory Uncorrectable non-fatal
   0x00000020        Memory Uncorrectable fatal
   0x00000040        PCI Express Correctable
-  0x00000080        PCI Express Uncorrectable fatal
-  0x00000100        PCI Express Uncorrectable non-fatal
+  0x00000080        PCI Express Uncorrectable non-fatal
+  0x00000100        PCI Express Uncorrectable fatal
   0x00000200        Platform Correctable
   0x00000400        Platform Uncorrectable non-fatal
   0x00000800        Platform Uncorrectable fatal
-- 
2.17.1

