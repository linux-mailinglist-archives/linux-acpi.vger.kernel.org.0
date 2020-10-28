Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5CC29D4BF
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 22:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgJ1VyU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 17:54:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:8280 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgJ1VyT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:19 -0400
IronPort-SDR: lXMe2L9reAvuAOhF4ErITgZkdpC3i6xMX3dkYRUjMaoex9h1BK4/g72RO1hUoHUgwAklsOKVq8
 onfx8H+8tqsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164836920"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="164836920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:51:04 -0700
IronPort-SDR: SfjNCCXD+bgYb1SVS9RoqG1Lldgu+olNWhbJEyvcqFZ0/h9SmtfEeSFLXUZ0GakNBk6l2/9x8d
 QJLia7ywrc4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="468877655"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2020 13:51:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48F7F2A0; Wed, 28 Oct 2020 22:51:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v1 2/3] Documentation: firmware-guide: gpio-properties: active_low only for GpioIo()
Date:   Wed, 28 Oct 2020 22:51:00 +0200
Message-Id: <20201028205101.47583-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It appears that people may misinterpret active_low field in _DSD
for GpioInt() resource. Add a paragraph to clarify this.

Reported-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/gpio-properties.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index e6e65ceb2ca1..370fe46c6af9 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -55,6 +55,9 @@ Since ACPI GpioIo() resource does not have a field saying whether it is
 active low or high, the "active_low" argument can be used here.  Setting
 it to 1 marks the GPIO as active low.
 
+Note, active_low in _DSD does not make sense for GpioInt() resource and
+must be 0. GpioInt() resource has its own means of defining it.
+
 In our Bluetooth example the "reset-gpios" refers to the second GpioIo()
 resource, second pin in that resource with the GPIO number of 31.
 
-- 
2.28.0

