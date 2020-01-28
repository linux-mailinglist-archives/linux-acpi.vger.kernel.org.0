Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD514BCBB
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgA1PVy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 10:21:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:8859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgA1PVy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 10:21:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 07:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="427657414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2020 07:21:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB79913F; Tue, 28 Jan 2020 17:21:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Sort entries in database for ACPICA
Date:   Tue, 28 Jan 2020 17:21:51 +0200
Message-Id: <20200128152151.47445-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Run parse-maintainers.pl and choose ACPICA record. Fix it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddfbddd95744..bb25407e665a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -349,13 +349,13 @@ M:	Erik Kaneda <erik.kaneda@intel.com>
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	devel@acpica.org
+S:	Supported
 W:	https://acpica.org/
 W:	https://github.com/acpica/acpica/
-Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
 B:	https://bugs.acpica.org
-S:	Supported
 F:	drivers/acpi/acpica/
 F:	include/acpi/
 F:	tools/power/acpi/
-- 
2.24.1

