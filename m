Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2B226DAD
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgGTRzv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 13:55:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:8007 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgGTRzu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 13:55:50 -0400
IronPort-SDR: k9dzmk+9wvNAD2S9U1mpxzA6l5oPPCdtGZIyFSO4F7DpfTwJuv8Azy7/T2eohcFZtFsgLBSVaw
 XcfPpb7dngEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147930519"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="147930519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:55:49 -0700
IronPort-SDR: xroiom4VsHEP+Pqst2rbN2EulLxRHB+1kQjtUEg+riv88ZZbnHXnM8yO852ZHItXBSvwnlO3P/
 cm95BRuU8N/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392105453"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2020 10:55:49 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 3/3] ACPICA: Update version to 20200717 Version 20200717.
Date:   Mon, 20 Jul 2020 10:31:21 -0700
Message-Id: <20200720173121.2580755-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720173121.2580755-1-erik.kaneda@intel.com>
References: <20200720173121.2580755-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c1adb9a2a775df7a85df0103342ebf090e1b2016

Link: https://github.com/acpica/acpica/commit/c1adb9a2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 459d6981ca96..9dc816641286 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20200528
+#define ACPI_CA_VERSION                 0x20200717
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.25.1

