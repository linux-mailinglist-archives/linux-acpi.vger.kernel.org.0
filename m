Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13B1EECCF
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgFDVIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 17:08:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:13291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgFDVIi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jun 2020 17:08:38 -0400
IronPort-SDR: 0p1L6JQkW9DF5MC+T8wVAxvIMbIgsg/3+VTK+nlsLNSB4tEcPKCu6HTok8zh4ORUieSIexr5pK
 O0rhy+iQI1SQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:08:37 -0700
IronPort-SDR: 4Al3QW0Yiya9GC34zmErStkuLjlkO4jUexxQvy2QMDHt4m7HDMgEZLaynprOXg5VXtKl5zENDg
 z8nwraB8qYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="287510516"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2020 14:08:37 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 3/3] ACPICA: Update version to 20200528 Version 20200528.
Date:   Thu,  4 Jun 2020 13:44:21 -0700
Message-Id: <20200604204421.592003-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604204421.592003-1-erik.kaneda@intel.com>
References: <20200604204421.592003-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 30ceafb55b59724f73ae6f2b35523417c4e569ea

Link: https://github.com/acpica/acpica/commit/30ceafb5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1dc8d262035b..459d6981ca96 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20200430
+#define ACPI_CA_VERSION                 0x20200528
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.25.1

