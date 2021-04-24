Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0FF36A1A4
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Apr 2021 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhDXOkI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Apr 2021 10:40:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:10999 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhDXOkF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 24 Apr 2021 10:40:05 -0400
IronPort-SDR: iC+Si5H8TPS4Cfzd+vuw/f2frozbJuRuojCYbTWWBA8X/MvAJ27QaJyNsSk9sQ9niBe0kgBpPY
 6Xh9s41F1b6g==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="281510338"
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="281510338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 07:39:26 -0700
IronPort-SDR: 1UFCjT/JIVgQx7pO60sjzp0nWUEdweTuGDkLnc3yyMB9L+5ERsdwehb7oFk0LuTBjUUcywowPz
 9yPKwz+Kmv+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,248,1613462400"; 
   d="scan'208";a="428763423"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2021 07:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E66611E; Sat, 24 Apr 2021 17:39:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties: Add note to SPI CS case
Date:   Sat, 24 Apr 2021 17:39:35 +0300
Message-Id: <20210424143935.69487-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Historically ACPI has no means of the GPIO polarity and thus
the SPISerialBus() resource defines it on the per-chip basis.
In order to avoid an ambiguity, the GPIO polarity is considered
being always Active High.

Add note about this to the respective documentation file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/gpio-properties.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index 4e264c16ddff..df4b711053ee 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -99,6 +99,12 @@ native::
       }
   }
 
+Note, that historically ACPI has no means of the GPIO polarity and thus
+the SPISerialBus() resource defines it on the per-chip basis. In order
+to avoid a chain of negations, the GPIO polarity is considered being
+Active High. Even for the cases when _DSD() is involved (see the example
+above) the GPIO CS polarity must be defined Active High to avoid ambiguity.
+
 Other supported properties
 ==========================
 
-- 
2.30.2

