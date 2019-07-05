Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7202160395
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfGEJ6I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:58:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:55406 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbfGEJ6I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 02:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="185144841"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2019 02:58:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 34385715; Fri,  5 Jul 2019 12:58:01 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 8/8] ACPI / property: Add two new Thunderbolt property GUIDs to the list
Date:   Fri,  5 Jul 2019 12:58:00 +0300
Message-Id: <20190705095800.43534-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ice Lake Thunderbolt controller includes two new device property
compatible properties that we need to be able to extract in the driver
so add them to the growing array of GUIDs.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index da3ced297f19..07cbacbab861 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -39,6 +39,12 @@ static const guid_t prp_guids[] = {
 	/* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
 	GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
 		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
+	/* TBT GUID for IMR_VALID: c44d002f-69f9-4e7d-a904-a7baabdf43f7 */
+	GUID_INIT(0xc44d002f, 0x69f9, 0x4e7d,
+		  0xa9, 0x04, 0xa7, 0xba, 0xab, 0xdf, 0x43, 0xf7),
+	/* TBT GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
+	GUID_INIT(0x6c501103, 0xc189, 0x4296,
+		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
-- 
2.20.1

