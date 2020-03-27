Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5170196165
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgC0WnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgC0WnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:12 -0400
IronPort-SDR: Iy23H/0a0SjLyrD08rfp4zi0wfVzO+uWAJWV2U6y/hNNY35o4zOF6Xi0gHhDVDw8XpAr2IFzOp
 OUkI8jL3skbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:12 -0700
IronPort-SDR: YH6fKoN5MJj4MjUdpTgZo7KDYHch5037njn8qLZHQg/UkK5Vw1oZTIwXccnhY/aR3UekzK3iOf
 2+AXETWxGulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051972"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:11 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/10] ACPICA: Change PlatformCommChannel ASL keyword to PCC
Date:   Fri, 27 Mar 2020 15:21:04 -0700
Message-Id: <20200327222110.1204634-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 811e69a59cb4189ebf8b882eba74c881f598a239

The former was proposed during specification discussions but it was
dropped. This keyword was introduced to the ACPICA code base by
mistake so this commit changes the keyword representing Platform
Communication Channel to be PCC.

Link: https://github.com/acpica/acpica/commit/811e69a5
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index befdd13b403b..177ab88d95de 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -78,7 +78,7 @@ const char *acpi_gbl_region_types[ACPI_NUM_PREDEFINED_REGIONS] = {
 	"IPMI",			/* 0x07 */
 	"GeneralPurposeIo",	/* 0x08 */
 	"GenericSerialBus",	/* 0x09 */
-	"PlatformCommChannel"	/* 0x0A */
+	"PCC"			/* 0x0A */
 };
 
 const char *acpi_ut_get_region_name(u8 space_id)
-- 
2.25.1

