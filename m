Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9335C3688B5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhDVVrw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 17:47:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVVrv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:47:51 -0400
IronPort-SDR: cQjrM/f+uLMWloLseWQGiakuo8FZ0ORNLGzQXxt32i1QA6XBCtJZBlJGVUHVVvUXDo1hl7nXWp
 sdwMKhM7Sc+g==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281306569"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281306569"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:16 -0700
IronPort-SDR: qaoU98k/mhRZoQ1fRosIOisWuC5+QkRFINfykCIsfg670jutDn024bnoGUHyLMG6SqJCwdbSLb
 9LkPHOlIgvLA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455965113"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:15 -0700
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
Subject: [PATCH v2 0/3] Add multiprocessor wake-up support
Date:   Thu, 22 Apr 2021 14:47:05 -0700
Message-Id: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v1:
 * Removed signoff from Rob and Erik.

Kuppuswamy Sathyanarayanan (3):
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
  ACPI/table: Print MADT Wake table information
  x86/acpi, x86/boot: Add multiprocessor wake-up support

 arch/x86/include/asm/apic.h     |  3 ++
 arch/x86/kernel/acpi/boot.c     | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c |  8 +++++
 arch/x86/kernel/apic/probe_64.c |  8 +++++
 drivers/acpi/tables.c           | 11 +++++++
 include/acpi/actbl2.h           | 14 +++++++++
 6 files changed, 100 insertions(+)

-- 
2.25.1

