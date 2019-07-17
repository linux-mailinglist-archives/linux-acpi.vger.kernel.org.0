Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C506BAD3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2019 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfGQKzr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jul 2019 06:55:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:12864 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGQKzr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jul 2019 06:55:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 03:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="167930871"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2019 03:55:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7E2E16A; Wed, 17 Jul 2019 13:55:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v1] ACPI / APEI: Get rid of NULL_UUID_LE constant
Date:   Wed, 17 Jul 2019 13:55:43 +0300
Message-Id: <20190717105543.76244-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a missed part of the commit 5b53696a30d5
("ACPI / APEI: Switch to use new generic UUID API"), i.e.
replacing old definition with a global constant variable.

Cc: Borislav Petkov <bp@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a66e00fe31fe..451269a2f47c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -483,7 +483,7 @@ static void ghes_do_proc(struct ghes *ghes,
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
-	guid_t *fru_id = &NULL_UUID_LE;
+	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 
 	sev = ghes_severity(estatus->error_severity);
-- 
2.20.1

