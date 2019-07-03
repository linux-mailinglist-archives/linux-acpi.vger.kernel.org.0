Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFB5ED6F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCU0g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 16:26:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:5192 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCU0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158088362"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:26:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 0/5] ACPICA version 20190703
Date:   Wed,  3 Jul 2019 13:15:35 -0700
Message-Id: <20190703201540.26054-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains ACPICA version 20190703 changes that are relevant
to Linux kernel. This patch set is available for viewing at:
https://github.com/SchmErik/linux/tree/acpica201907

Overall, this release contains several patches that simplify ACPICA
initialization by removing unnecessary ACPI namespace walks.

Bob Moore (3):
  ACPICA: Namespace: simplify creation of the initial/default namespace
  ACPICA: Update for object initialization sequence
  ACPICA: Update table load object initialization
  ACPICA: Update version to 20190703

Erik Schmauss (2):
  ACPICA: remove legacy module-level code due to deprecation

 drivers/acpi/acpica/acglobal.h |   1 -
 drivers/acpi/acpica/acnamesp.h |   2 -
 drivers/acpi/acpica/dsinit.c   |   2 +-
 drivers/acpi/acpica/exconfig.c |  16 ++-
 drivers/acpi/acpica/nsaccess.c |  54 ++++++++--
 drivers/acpi/acpica/nseval.c   | 190 ---------------------------------
 drivers/acpi/acpica/nsinit.c   |  49 ++++-----
 drivers/acpi/acpica/nsload.c   |  12 ---
 drivers/acpi/acpica/nsutils.c  |  12 ---
 drivers/acpi/acpica/tbdata.c   |  13 ---
 drivers/acpi/acpica/tbxfload.c |  10 +-
 drivers/acpi/acpica/utinit.c   |   1 -
 drivers/acpi/acpica/utxfinit.c |  18 ++--
 include/acpi/acpixf.h          |   2 +-
 14 files changed, 79 insertions(+), 303 deletions(-)

-- 
2.17.2

