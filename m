Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE77B1EECCC
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFDVI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 17:08:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:47944 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgFDVI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jun 2020 17:08:27 -0400
IronPort-SDR: r91txLaDMJV4JhA/GG+HLPc0OIQ3KyfT4EgypPEq/uCgE8izVlSTJLD+688GZswK2H2JRLA4g6
 1NF4+W4tRjcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:08:25 -0700
IronPort-SDR: yiUE1jH+n6unwtB5LqlibYGD1Fwovjs/BksSZmiMTRBJY7VVEPmnyxswiL6z9u19L5wZuA/W+Y
 pVW8bPCjXzCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="287510408"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2020 14:08:25 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/3] ACPICA release 20200528
Date:   Thu,  4 Jun 2020 13:44:18 -0700
Message-Id: <20200604204421.592003-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch set contains the linux-ized patches of the ACPICA 20200528
release. This is a small release containing changes to iASL and
acpidump.

Bob Moore (2):
  ACPICA: acpidump: Removed dead code from oslinuxtbl.c ACPICA BZ 1119.
  ACPICA: Update version to 20200528 Version 20200528.

Erik Kaneda (1):
  ACPICA: iASL: add new OperationRegion subtype keyword
    PlatformRtMechanism

 drivers/acpi/acpica/dbdisply.c                        |  2 ++
 drivers/acpi/acpica/utdecode.c                        |  3 ++-
 include/acpi/acpixf.h                                 |  2 +-
 include/acpi/actypes.h                                |  3 ++-
 .../acpi/os_specific/service_layers/oslinuxtbl.c      | 11 ++++++-----
 5 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.25.1

