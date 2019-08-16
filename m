Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3390A8E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfHPV6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:56320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfHPV6c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381365"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:31 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 0/9] ACPICA 20190816 release
Date:   Fri, 16 Aug 2019 14:43:19 -0700
Message-Id: <20190816214328.3900-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset contains the ACPICA 20190816 release. Most notable changes
include the new _OSI string and increasing the max owner ID.

Bob Moore (6):
  ACPICA: Increase total number of possible Owner IDs
  ACPICA: Macros: remove pointer math on a null pointer
  ACPICA: Fix issues with arg types within printf format strings
  ACPICA: iASL,acpi_dump: Improve y/n query
  ACPICA: Fully deploy ACPI_PRINTF_LIKE macro
  ACPICA: Update version to 20190816.

Colin Ian King (1):
  ACPICA: Debugger: remove redundant assignment on obj_desc

Jung-uk Kim (2):
  ACPICA: Differentiate Windows 8.1 from Windows 8.
  ACPICA: Add "Windows 2019" string to _OSI support.

 drivers/acpi/acpica/aclocal.h             |  4 +-
 drivers/acpi/acpica/acobject.h            |  2 +-
 drivers/acpi/acpica/acstruct.h            |  2 +-
 drivers/acpi/acpica/acutils.h             | 10 ++-
 drivers/acpi/acpica/dbhistry.c            |  2 +-
 drivers/acpi/acpica/dbinput.c             | 10 +--
 drivers/acpi/acpica/dbmethod.c            |  4 +
 drivers/acpi/acpica/dbobject.c            |  1 -
 drivers/acpi/acpica/dbstats.c             | 92 +++++++++++------------
 drivers/acpi/acpica/exdump.c              |  6 +-
 drivers/acpi/acpica/nsaccess.c            |  2 +-
 drivers/acpi/acpica/nsalloc.c             |  2 +-
 drivers/acpi/acpica/nsdump.c              |  2 +-
 drivers/acpi/acpica/nsrepair2.c           |  2 +-
 drivers/acpi/acpica/tbdata.c              |  1 +
 drivers/acpi/acpica/utdebug.c             |  4 +-
 drivers/acpi/acpica/uterror.c             |  6 +-
 drivers/acpi/acpica/utosi.c               |  3 +-
 drivers/acpi/acpica/utownerid.c           | 12 +--
 include/acpi/acconfig.h                   |  4 +-
 include/acpi/acpiosxf.h                   |  1 +
 include/acpi/acpixf.h                     |  2 +-
 include/acpi/actypes.h                    | 20 ++---
 tools/power/acpi/tools/acpidump/apfiles.c | 10 ++-
 24 files changed, 110 insertions(+), 94 deletions(-)

-- 
2.17.2

