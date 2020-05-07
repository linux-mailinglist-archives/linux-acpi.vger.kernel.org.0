Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1C1C8580
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGJQQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbgEGJQQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5D328569DE4C27DD665D;
        Thu,  7 May 2020 17:16:06 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:15:58 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/9] ACPI: Call acpi_put_table() to release the ACPI table mappings
Date:   Thu, 7 May 2020 17:09:12 +0800
Message-ID: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if the
mapped table is not used for runtime after the initialization, or the
error path or the initialization, to release the table mapping.

This patchset just scan for every acpi_get_table() in ACPI subsystem to
see if acpi_put_table() is needed, this is not urgent and I think can
be merged for 5.8 if this patchset makes sense.

Hanjun Guo (9):
  ACPI: LPIT: Put the low power idle table after using it
  ACPI: watchdog: Put the watchdog action table after parsing
  ACPI: APEI: Put the boot error record table after parsing
  ACPI: APEI: Put the error injection table for error path and module
    exit
  ACPI: APEI: Put the error record serialization table for error path
  ACPI: APEI: Put the HEST table for error path
  ACPI: EC: Put the ACPI table after using it
  ACPI: scan: Put SPCR and STAO table after using it
  ACPI: sleep: Put the FACS table after using it

 drivers/acpi/acpi_lpit.c     |  3 ++-
 drivers/acpi/acpi_watchdog.c |  7 +++++--
 drivers/acpi/apei/bert.c     |  6 ++++--
 drivers/acpi/apei/einj.c     |  5 ++++-
 drivers/acpi/apei/erst.c     |  4 +++-
 drivers/acpi/apei/hest.c     |  5 +++--
 drivers/acpi/ec.c            | 14 ++++++++++----
 drivers/acpi/scan.c          | 15 ++++++++++-----
 drivers/acpi/sleep.c         |  4 +++-
 9 files changed, 44 insertions(+), 19 deletions(-)

-- 
1.7.12.4

