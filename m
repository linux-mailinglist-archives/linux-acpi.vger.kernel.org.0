Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898BE15AB88
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgBLO7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 09:59:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:32755 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgBLO7q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 09:59:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 06:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="237729494"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 06:59:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A13251F6; Wed, 12 Feb 2020 16:59:41 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/3] ACPI / watchdog: Fix two reported issues
Date:   Wed, 12 Feb 2020 17:59:38 +0300
Message-Id: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This is an updated version of the patch series posted here:

  https://lore.kernel.org/linux-watchdog/20200212110540.83559-1-mika.westerberg@linux.intel.com/

This should fix the two issues reported by Jean Delvare. I also addressed
all the review comments and fixed the bugs in the previous version.

This time I actually tested these on Intel Joule board and the watchdog
still works as expected.

I'm now including ACPICA maintainers as well to get some feedback regarding
the first patch of the series.

Mika Westerberg (3):
  ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
  ACPI / watchdog: Fix gas->access_width usage
  ACPI / watchdog: Set default timeout in probe

 drivers/acpi/acpi_watchdog.c |  3 +--
 drivers/watchdog/wdat_wdt.c  | 25 ++++++++++++++++++++++++-
 include/acpi/actypes.h       |  3 ++-
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.25.0

