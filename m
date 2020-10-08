Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C946286D1A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgJHDV5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:21:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:29850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbgJHDV5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:21:57 -0400
IronPort-SDR: 0c8akyUyht1W0Mvl/MDDMdMHDJ0iXZZtWFBBqdB1sFUh2WtSXCVNj0YKh8NcARhQOxYGbjZugw
 dNxRwSBW35Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613624"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:21:56 -0700
IronPort-SDR: SP58rj+J3f2NZ+kp//4peLnoY1lvlqMtH9i+iyKMQsBimhkuZTf+abrSVTBpPO5npK9wwqfm51
 WSI21gWx5osw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229319"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:21:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/9] ACPICA release 20200925
Date:   Wed,  7 Oct 2020 19:53:54 -0700
Message-Id: <20201008025403.2401736-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This release contains the ACPICA patches from the 20200925 release.
This contains patches that are mostly for user space tools such as iASL,
acpihelp. The only direct impact to the linux kernel is the addition of
several predefined names that were found in the SMBus specification.

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>

Bob Moore (6):
  ACPICA: Add predefined names found in the SMBus sepcification
  ACPICA: acpi_help: Update UUID list
  ACPICA: iASL: Return exceptions for string-to-integer conversions
  ACPICA: Debugger: Add a new command: "ALL <NameSeg>"
  ACPICA: Remove unnecessary semicolon
  ACPICA: Update version to 20200925 Version 20200925.

Colin Ian King (2):
  ACPICA: Add support for 64 bit risc-v compilation.
  ACPICA: Tree-wide: fix various typos and spelling mistakes

Randy Dunlap (1):
  ACPICA: Drop the repeated word "an" in a comment.

 drivers/acpi/acpica/acdebug.h                 |   4 +
 drivers/acpi/acpica/acpredef.h                |  33 +++-
 drivers/acpi/acpica/dbexec.c                  |  39 +++-
 drivers/acpi/acpica/dbinput.c                 |  14 +-
 drivers/acpi/acpica/dbmethod.c                | 167 +++++++++++++++---
 drivers/acpi/acpica/nsalloc.c                 |   2 +-
 drivers/acpi/acpica/nsarguments.c             |   4 +-
 drivers/acpi/acpica/nsxfobj.c                 |   3 +-
 drivers/acpi/acpica/psparse.c                 |   4 +-
 drivers/acpi/acpica/utpredef.c                |   5 +-
 drivers/acpi/acpica/utstrsuppt.c              |  33 +++-
 include/acpi/acconfig.h                       |   2 +-
 include/acpi/acexcep.h                        |   4 +-
 include/acpi/acpixf.h                         |   2 +-
 include/acpi/actypes.h                        |   2 +-
 include/acpi/acuuid.h                         |   7 +
 include/acpi/platform/aclinux.h               |   3 +-
 .../os_specific/service_layers/oslinuxtbl.c   |   2 +-
 18 files changed, 270 insertions(+), 60 deletions(-)

-- 
2.25.1

