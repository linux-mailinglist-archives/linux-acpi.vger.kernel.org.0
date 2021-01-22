Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F412C2FF9B4
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAVA7W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:59:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:34968 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAVA7U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 19:59:20 -0500
IronPort-SDR: l8KI4Wp2FqrqBCCMA7CRRREMDEGSY9KkirQFnLlwqO3hSb/yNbMOQMxPBRd6s+wIUwEB37ccBl
 Mus9Dt7D3dMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240908716"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240908716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:56:22 -0800
IronPort-SDR: iKkpDLjM1kyx+9MB2xSDAN8z8PgKVeApbKYvJ1xjo6SjdOSDnTkB3fiqom+7enObaMzmkVxJ+E
 V5JkttFfxj0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427595553"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 16:56:22 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 9/9] ACPICA: Update version to 20210105
Date:   Thu, 21 Jan 2021 16:23:57 -0800
Message-Id: <20210122002357.370836-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122002357.370836-1-erik.kaneda@intel.com>
References: <20210122002357.370836-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 28cb42013541950cf378582a5a5a5587061498ca

Version 20210105.

Link: https://github.com/acpica/acpica/commit/28cb4201
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index be76ba3166cf..370293ee8399 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20201217
+#define ACPI_CA_VERSION                 0x20210105
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.29.2

