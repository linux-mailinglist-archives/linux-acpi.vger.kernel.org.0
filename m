Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA5D0F8A
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2019 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJINEi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Oct 2019 09:04:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:5507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfJINEi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Oct 2019 09:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 06:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="223580488"
Received: from skassina-mobl.ccr.corp.intel.com (HELO caravaggio.ger.corp.intel.com) ([10.251.93.62])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 06:04:34 -0700
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 0/2] acpi: Unconditional GED build
Date:   Wed,  9 Oct 2019 15:04:31 +0200
Message-Id: <20191009130433.29134-1-sameo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Generic Event Device is a hardware-reduced ACPI specific device, but
kernels supporting both fixed and hardware-reduced ACPI hardware should
be able to probe it dynamically.

For that purpose, here are 2 patches:

- The first one makes the GED device probe fail on non hardware-reduced
  platforms.
- The second one disable the conditional evged build.

Arjan van de Ven (1):
  acpi: Always build evged in

Samuel Ortiz (1):
  acpi: Fail GED probe when not on hardware-reduced

 drivers/acpi/Makefile | 2 +-
 drivers/acpi/evged.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.21.0

