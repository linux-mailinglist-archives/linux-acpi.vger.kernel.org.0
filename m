Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0E36AAAC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhDZCkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Apr 2021 22:40:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:49066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhDZCkb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 25 Apr 2021 22:40:31 -0400
IronPort-SDR: oheH4d976Fmt9mGxDL1t3M9e27m61A7KVAuhhf5o2mhTdSY7j8I5zHfhH9Rx98OS7L3CxRRC0S
 9lTFiYnuR70Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260224232"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260224232"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:50 -0700
IronPort-SDR: fqCevIdyEnl1vWnFmb5PF9fcyurMGUXvvqv7SPIWqBwPynyi/B0IzQzwlu4V7zMQ2bzHbjiTMJ
 9qFHgVJiH38w==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="454081394"
Received: from angelata-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.149])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 19:39:49 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 0/3] Add multiprocessor wake-up support
Date:   Sun, 25 Apr 2021 19:39:38 -0700
Message-Id: <20210426023941.729334-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add multiprocessor wakeup support using MADT ACPI table for x86
platforms. It uses mailbox based mechanism to wake up the APs. You
can get more details about the ACPI table and mailbox protocol in
Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
Extensions (Intel TDX) specification document (sec 4.1)

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Changes since v2:
 * Moved acpi_wake_cpu_handler_update() definition to
   arch/x86/kernel/apic/apic.c
 * Added comments for WRITE_ONCE() usage.
 * Added error handling support to prevent re-trigger of
   acpi_wakeup_cpu() and to detect the failure case.

Changes since v1:
 * Removed signoff from Rob and Erik.

Kuppuswamy Sathyanarayanan (3):
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
  ACPI/table: Print MADT Wake table information
  x86/acpi, x86/boot: Add multiprocessor wake-up support

 arch/x86/include/asm/apic.h |  3 ++
 arch/x86/kernel/acpi/boot.c | 79 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c |  8 ++++
 drivers/acpi/tables.c       | 11 ++++++
 include/acpi/actbl2.h       | 14 +++++++
 5 files changed, 115 insertions(+)

-- 
2.25.1

