Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF990A91
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfHPV6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:56323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfHPV6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381386"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:33 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 5/9] ACPICA: iASL,acpi_dump: Improve y/n query
Date:   Fri, 16 Aug 2019 14:43:24 -0700
Message-Id: <20190816214328.3900-6-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

 The y/n query is used for file overwrite. Use fgetc, check for
 standalone newline.

ACPICA commit f9eb60ead76e5b2b6e578b553f592452ccfca47a

Link: https://github.com/acpica/acpica/commit/f9eb60ea
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 tools/power/acpi/tools/acpidump/apfiles.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index a42cfcaa3293..16d919bd133b 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -29,18 +29,24 @@ static int ap_is_existing_file(char *pathname)
 {
 #if !defined(_GNU_EFI) && !defined(_EDK2_EFI)
 	struct stat stat_info;
+	int in_char;
 
 	if (!stat(pathname, &stat_info)) {
 		fprintf(stderr,
 			"Target path already exists, overwrite? [y|n] ");
 
-		if (getchar() != 'y') {
+		in_char = fgetc(stdin);
+		if (in_char == '\n') {
+			in_char = fgetc(stdin);
+		}
+
+		if (in_char != 'y' && in_char != 'Y') {
 			return (-1);
 		}
 	}
 #endif
 
-	return 0;
+	return (0);
 }
 
 /******************************************************************************
-- 
2.17.2

