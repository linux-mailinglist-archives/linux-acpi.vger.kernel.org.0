Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23B2196161
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0WnM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgC0WnL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:11 -0400
IronPort-SDR: zfxCffLH+XHALRiGDuXris5Eim3VA8dASGTvTaA/U5fBx7BAJJxhxz/6LT3QshGD9QMCyebVaQ
 hpRC2YpSJZig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:11 -0700
IronPort-SDR: BB7k24liULIHfQcX0jqnd94/qgziqdT9uEHSnjOHkQ3Q6l7Tm0nUH3QE27LbXwAfm8dvkqtWxF
 3K/xOe6qcEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051959"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:10 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 00/10] ACPICA release 20200326
Date:   Fri, 27 Mar 2020 15:21:00 -0700
Message-Id: <20200327222110.1204634-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch set contains the linux-ized patches of the ACPICA release
version 20200326

This release mostly consists of changes in the iASL compiler and the
acpiexec utility so linux changes are quite small. The acpiexec
change is specifically intended for the userspace utility's custom
initialization feature so there is no functional change in the kernel
space AML interpreter. Other than that, there were several additions to
ACPI tables such a new IVRS subtype and NHLT as well as trivial typo
fixes.

Bob Moore (3):
  ACPICA: Fix a typo in a comment field
  ACPICA: Fixes for acpiExec namespace init file
  ACPICA: Update version 20200326

Cezary Rojewski (1):
  ACPICA: Add NHLT table signature

Erik Kaneda (3):
  ACPICA: Change PlatformCommChannel ASL keyword to PCC
  ACPICA: acpiexec: remove redeclaration of
    acpi_gbl_db_opt_no_region_support
  ACPICA: WSMT: Fix typo, no functional change

John Levon (1):
  ACPICA: utilities: fix sprintf()

Michał Żygowski (2):
  ACPICA: Implement IVRS IVHD type 11h parsing
  ACPICA: Fix IVRS IVHD type 10h reserved field name

 drivers/acpi/acpica/acnamesp.h |  2 ++
 drivers/acpi/acpica/dbinput.c  | 16 +++++++--------
 drivers/acpi/acpica/dbxface.c  |  1 +
 drivers/acpi/acpica/dswexec.c  | 33 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dswload.c  |  2 --
 drivers/acpi/acpica/dswload2.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsnames.c  |  6 +-----
 drivers/acpi/acpica/utdecode.c |  2 +-
 drivers/acpi/acpica/utdelete.c |  9 +++++----
 drivers/acpi/acpica/utprint.c  |  7 ++++++-
 drivers/acpi/tables.c          |  2 +-
 include/acpi/acpixf.h          |  2 +-
 include/acpi/actbl2.h          | 21 +++++++++++++++++---
 include/acpi/actbl3.h          |  6 +++---
 include/acpi/acuuid.h          |  2 +-
 15 files changed, 116 insertions(+), 31 deletions(-)

-- 
2.25.1

