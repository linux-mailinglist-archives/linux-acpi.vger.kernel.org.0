Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B207196163
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgC0WnM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgC0WnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:12 -0400
IronPort-SDR: 3tZDiJip0Rk80SpZZL+UvVeh7/DjKQYXaH4uKbOeiwQw+w9tGfH6fl84eB8nyfsm9mDI1XVYaw
 +ahtnF4tKpmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:11 -0700
IronPort-SDR: aYZ6ppsJB56oAUO9AfJjoOiukDHNFmebYyhoYhbNCcNtF2W0XIz5VO+jIwq7RBn0MDTzM99P0O
 zexVrICc6fIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051963"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:10 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 01/10] ACPICA: Fix a typo in a comment field
Date:   Fri, 27 Mar 2020 15:21:01 -0700
Message-Id: <20200327222110.1204634-2-erik.kaneda@intel.com>
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

ACPICA commit f3504c591c8766c70402dcc786391ff6748b515a

Link: https://github.com/acpica/acpica/commit/f3504c59
Reported-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acuuid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 9dd4689a39cf..9e1367b19069 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -57,4 +57,4 @@
 #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
 #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
 
-#endif				/* __AUUID_H__ */
+#endif				/* __ACUUID_H__ */
-- 
2.25.1

