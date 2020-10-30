Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68F32A0C5A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgJ3R0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 13:26:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:15562 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgJ3R0G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 13:26:06 -0400
IronPort-SDR: r4I57xSwzLa7n23RDVfSTz7XlKNZMQ8P6T8KIMbbHBoOhZud90ODY1C45SdUbFhh+m7wPQC4B0
 iVG5Wa02GC+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="186450272"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="186450272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:26:05 -0700
IronPort-SDR: IMoHJYQwvVKurxjwmRkw5jnMeNCBiCufrFXUWRVP+AjP1QDmQzN6xn2PUACUMCE+dn/DkAd+K/
 1XnJS3/j1MpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351935839"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 10:26:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 525972A0; Fri, 30 Oct 2020 19:26:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/6] resource: introduce union(), intersection() API
Date:   Fri, 30 Oct 2020 19:25:50 +0200
Message-Id: <20201030172556.21686-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some users may want to use resource library to manage their own resources,
besides existing users that open code union() and intersection()
implementations.

Provide a generic API for wider use.

Changelog v3:
- rebased on top of v5.10-rc1
- dropped upstreamed dependencies
- added Rb tag to the last patch (Mika)

Andy Shevchenko (6):
  resource: Simplify region_intersects() by reducing conditionals
  resource: Group resource_overlaps() with other inline helpers
  resource: Introduce resource_union() for overlapping resources
  resource: Introduce resource_intersection() for overlapping resources
  PCI/ACPI: Replace open coded variant of resource_union()
  ACPI: watchdog: Replace open coded variant of resource_union()

 drivers/acpi/acpi_watchdog.c |  6 +-----
 drivers/acpi/pci_root.c      |  4 +---
 include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
 kernel/resource.c            | 10 +++++-----
 4 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.28.0

