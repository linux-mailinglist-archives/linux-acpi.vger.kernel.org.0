Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD73A2326
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 06:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhFJESj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 00:18:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:23380 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhFJESj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 00:18:39 -0400
IronPort-SDR: xjMViGWqW0G/8MP8Me4wzZWlfbx6lAHyHD6yQdSVqlvHwveDyocaf5GPSaroM2swLQJOU7UEkp
 GH6i2DD02njg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202196873"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="202196873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 21:16:41 -0700
IronPort-SDR: 4QLk7qCOyfHhaoeUf0FF40r+1PIb0p+oyv/RqTyL1uZjQkHtXv6X2FfK+dLQblLnFv17cPcEE+
 y8IKvlo2uwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="441064184"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2021 21:16:40 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 0/3] Update PRM patches to fix some issues...
Date:   Wed,  9 Jun 2021 20:41:50 -0700
Message-Id: <20210610034153.3882311-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, I found out that there were several misspelled struct fields
that resulted from merging my PRM code with ACPICA material that caused
build errors. This patch set resolves build issues by 

  1) fixing the spelling errors
  2) defining the struct acpi_prmt_module_header that got left off.
     This struct is used by acpi_parse_table_entries and is not used by
     ACPICA so it was left out accidentally.

This patch set also fixes a crash that was caused when I split up
acpi_table_prmt and acpi_table_prmt_header. These structs used to be
defined in a single struct acpi_table_prmt but it was split up in
order to facilitate iASL compiler implementation. The size of the
36-byte ACPI table header + the size of any additional fields are
needed as parameter to the acpi_parse_table_entries function. When I
split up acpi_table_prmt into two different structs, I did not adjust
the parameter to acpi_parse_table_entries and this ended up breaking
the PRMT parsing. I've fixed this by changing the parameter to
acpi_parse_table_entries to account for this additional struct.

Sorry for the confusion! This patchset should clear things up and
runs the PRM handler in the edk2 PRM samples without any issues.

I've based this on rc-5.

Thanks and sorry for the noise!
	Erik

Erik Kaneda (3):
  ACPICA: Add PRMT module header to facilitate parsing
  PRM: implement OperationRegion handler for the PlatformRtMechanism
    subtype
  ACPI: Add \_SB._OSC bit for PRM

 drivers/acpi/Kconfig  |   5 +
 drivers/acpi/Makefile |   1 +
 drivers/acpi/bus.c    |   3 +
 drivers/acpi/prmt.c   | 303 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c |   9 ++
 include/acpi/actbl2.h |   5 +
 include/linux/acpi.h  |   2 +
 include/linux/prmt.h  |   7 +
 8 files changed, 335 insertions(+)
 create mode 100644 drivers/acpi/prmt.c
 create mode 100644 include/linux/prmt.h

-- 
2.29.2

