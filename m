Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8E15F665
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgBNTIZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:26791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388080AbgBNTIZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702908"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 09/10] ACPICA: Fix a couple of typos
Date:   Fri, 14 Feb 2020 10:48:03 -0800
Message-Id: <20200214184804.15114-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Squashed ACPICA commit e93a53d4d312a83a3ec72aa9cfb12d781b4fefca
and df52c574572344cd9095b66a0f580d51249deb2a

Submitted by: ehaouas@noos.fr

Link: https://github.com/acpica/acpica/commit/e93a53d4
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/utobject.c | 2 +-
 include/acpi/actbl1.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 3e60bdac2200..bbec04c291d2 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -44,7 +44,7 @@ acpi_ut_get_element_length(u8 object_type,
  *
  * NOTE:        We always allocate the worst-case object descriptor because
  *              these objects are cached, and we want them to be
- *              one-size-satisifies-any-request. This in itself may not be
+ *              one-size-satisfies-any-request. This in itself may not be
  *              the most memory efficient, but the efficiency of the object
  *              cache should more than make up for this!
  *
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 02d06b79e1cd..43549547ed3e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -862,7 +862,7 @@ enum acpi_erst_instructions {
 /* Command status return values */
 
 enum acpi_erst_command_status {
-	ACPI_ERST_SUCESS = 0,
+	ACPI_ERST_SUCCESS = 0,
 	ACPI_ERST_NO_SPACE = 1,
 	ACPI_ERST_NOT_AVAILABLE = 2,
 	ACPI_ERST_FAILURE = 3,
-- 
2.21.0

