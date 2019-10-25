Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF379E562E
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfJYVyv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:27336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYVyv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936030"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:50 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 00/12] ACPICA version 20191018v2
Date:   Fri, 25 Oct 2019 14:36:48 -0700
Message-Id: <20191025213700.14685-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

V2 - fixed build warnings

This patchset contains the linuxized patches for ACPICA version
20191018. There are several debugger changes but they are meant for
acpiexec at this time. acpi_load_table definition has been modified and
a new acpi_unload_table has been added. These new interfaces can be used
as a part of config fs to load and unload tables.

Other than that, Bob has run clang on our code base and removed several
compiler warnings.

This patchset is also available here:
https://github.com/SchmErik/linux/tree/v20191018


Bob Moore (5):
  ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly
    "set but never read" warnings.
  ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
  ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment"
    warnings.
  ACPICA: Add new external interface, acpi_unload_table
  ACPICA: Update version to 20191018

Erik Schmauss (6):
  ACPICA: utilities: add flag to only display data when dumping buffers
  ACPICA: debugger: add command to dump all fields of a particular
    subtype
  ACPICA: debugger: surround field unit output with braces '{'
  ACPICA: debugger: add field unit support for acpi_db_get_next_token
  ACPICA: acpiexec: initialize all simple types and field units from
    user input
  ACPICA: debugger: remove leading whitespaces when converting a string
    to a buffer

Nikolaus Voss (1):
  ACPICA: make acpi_load_table() return table index

 drivers/acpi/acpi_configfs.c    |   2 +-
 drivers/acpi/acpica/acdebug.h   |   2 +
 drivers/acpi/acpica/acstruct.h  |  10 +++
 drivers/acpi/acpica/acutils.h   |   9 +--
 drivers/acpi/acpica/dbconvert.c |   4 ++
 drivers/acpi/acpica/dbdisply.c  |   2 -
 drivers/acpi/acpica/dbfileio.c  |   2 +-
 drivers/acpi/acpica/dbinput.c   |  36 +++++++++-
 drivers/acpi/acpica/dbmethod.c  |   4 ++
 drivers/acpi/acpica/dbnames.c   | 114 ++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbobject.c  |   1 -
 drivers/acpi/acpica/dscontrol.c |   2 +-
 drivers/acpi/acpica/dsfield.c   |  12 +---
 drivers/acpi/acpica/evgpeblk.c  |  11 +--
 drivers/acpi/acpica/evgpeinit.c |   3 -
 drivers/acpi/acpica/evmisc.c    |  12 +++-
 drivers/acpi/acpica/evregion.c  |   4 +-
 drivers/acpi/acpica/evrgnini.c  |   1 -
 drivers/acpi/acpica/hwxfsleep.c |   3 +
 drivers/acpi/acpica/nsconvert.c |   2 +-
 drivers/acpi/acpica/nsdump.c    |   6 +-
 drivers/acpi/acpica/nsxfname.c  |   4 +-
 drivers/acpi/acpica/psobject.c  |   7 +-
 drivers/acpi/acpica/rscreate.c  |   3 +
 drivers/acpi/acpica/tbdata.c    |   3 +
 drivers/acpi/acpica/tbxfload.c  |  40 ++++++++++-
 drivers/acpi/acpica/utbuffer.c  |  52 ++++++++-------
 drivers/acpi/acpica/utids.c     |   2 -
 drivers/acpi/acpica/uttrack.c   |   2 +-
 drivers/firmware/efi/efi.c      |   2 +-
 include/acpi/acpixf.h           |   8 ++-
 31 files changed, 291 insertions(+), 74 deletions(-)

-- 
2.21.0

