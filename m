Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E884419616B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgC0WnP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgC0WnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:14 -0400
IronPort-SDR: NMoiuUNwf9Qp8IReRVEqZ4MW1DlWx19EFHSnXgpIHrM+AAxZED5Ktw2iglz4iFb8TAr8YPPiHy
 nXw0L5mZOxCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:13 -0700
IronPort-SDR: ukyJlJWr9IbK9L18ZmIolpywqWsXupUS2oBj9ta1hTy0jJRhu/tgLM3DxOKlMF8Xo9aE+TfAfD
 R4LJ389RgMxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051993"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:12 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 10/10] ACPICA: Update version 20200326
Date:   Fri, 27 Mar 2020 15:21:10 -0700
Message-Id: <20200327222110.1204634-11-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 994fe943d93fe18eaaed1b6cd725023399f8a5c6

Version 20200326.

Link: https://github.com/acpica/acpica/commit/994fe943
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 87fc14e97d2b..49b519f36b69 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20200214
+#define ACPI_CA_VERSION                 0x20200326
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.25.1

