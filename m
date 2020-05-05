Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320101C4B3E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEEBIf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:50714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgEEBIf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:35 -0400
IronPort-SDR: uzgTF1zdiVs0CX3EjmJPvJOl9Y9ATCA/BdUfdwHaGwV7e/tP1c+5QHHmf5c4Hsaj4muInY99+z
 GDQ5qCBMEfsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:34 -0700
IronPort-SDR: ZEliSZhdmcO8tbbZVzukINvlDsQx6pepLMhyE0QWTYfJmNn+qcKwsw8RQQRyKuZh8pNJgObIJh
 mMXeJBrfJ+fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865782"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:34 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/6] ACPICA release 20200430
Date:   Mon,  4 May 2020 17:46:48 -0700
Message-Id: <20200505004654.2870591-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains the linux-ized patches of the 20200430 ACPICA
release. There are two patches to fix sparse warnings that are
generated from global variables, and a fix to avoid null pointer
dereferences in the dispatcher. Aside from that, there is a fix to
correct the required parameters for the predefined ACPI methods _NIH
and _NIG.

Bob Moore (1):
  ACPICA: Update version to 20200430

Erik Kaneda (4):
  ACPICA: Move acpi_gbl_next_cmd_num definition to acglobal.h
  ACPICA: Disassembler: ignore AE_ALREADY_EXISTS status when parsing
    create operators
  ACPICA: Dispatcher: add status checks to avoid NULL pointer
    dereference on field objects
  ACPICA: Fix required parameters for _NIG and _NIH

Yue Haibing (1):
  ACPICA: Make acpi_protocol_lengths static

 drivers/acpi/acpica/acglobal.h |  1 +
 drivers/acpi/acpica/acpredef.h |  4 ++--
 drivers/acpi/acpica/dbhistry.c |  1 -
 drivers/acpi/acpica/dsfield.c  | 22 ++++++++++++++++------
 drivers/acpi/acpica/exfield.c  |  2 +-
 include/acpi/acpixf.h          |  2 +-
 6 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.25.1

