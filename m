Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC3226D9D
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGTRzA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 13:55:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:29589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgGTRzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 13:55:00 -0400
IronPort-SDR: Tgybqp1Pol1apO510ZwsvOBTTP+UImRe1CQaKJ6raANrIvViij8i8fx2xtFSaeuft1dm4WRWGg
 33WitOeIeOwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137463851"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="137463851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:54:54 -0700
IronPort-SDR: wXppVZgJRmRH1EKLqPF4uFTs/GqEYeh8JYskNKLnU4GlhP7Z3hqQUCPhgsbrJbMsKD/PYa0bPn
 pSdAfaLe/UvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392105225"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2020 10:54:53 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/3] ACPICA release 20200717
Date:   Mon, 20 Jul 2020 10:31:18 -0700
Message-Id: <20200720173121.2580755-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains patches relevant to linux kernel from ACPICA's
20200717 release. This ACPICA release contains a change in the ACPI
object reference counting mechanism to allow firmware to declare a
large amount of OperationRegion field units without overflowing the
reference count.

Bob Moore (1):
  ACPICA: Update version to 20200717 Version 20200717.

Erik Kaneda (1):
  ACPICA: Do not increment operation_region reference counts for field
    units

Gustavo A. R. Silva (1):
  ACPICA: Replace one-element array with flexible-array

 drivers/acpi/acpica/exprep.c   | 4 ----
 drivers/acpi/acpica/utdelete.c | 6 +-----
 drivers/acpi/acpica/utids.c    | 3 +--
 include/acpi/acpixf.h          | 2 +-
 include/acpi/actypes.h         | 2 +-
 5 files changed, 4 insertions(+), 13 deletions(-)

-- 
2.25.1

