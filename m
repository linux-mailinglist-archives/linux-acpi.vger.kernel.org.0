Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F140A86BBC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2019 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfHHUlp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Aug 2019 16:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:38420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390148AbfHHUlp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Aug 2019 16:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D1A1596;
        Thu,  8 Aug 2019 13:41:44 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45EBB3F694;
        Thu,  8 Aug 2019 13:41:44 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rric@kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 0/2]  arm64/PPTT ACPI 6.3 thread flag support
Date:   Thu,  8 Aug 2019 15:40:05 -0500
Message-Id: <20190808204007.30110-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 adds a flag to the CPU node to indicate whether
the given CPU is a thread. Add a function to return that
information for a given linux logical CPU and then utilize
it while building the arm64 topology.

v4->v5: Add Sudeep's Reviewed tag
	Trivial comment tweaks
	Move is_threaded logic from parse_acpi_topology()
	      to apci_cpu_is_threaded()

v3->v4: Remove table revision cache as this code path is only
	      called during boot and there aren't any
	      indications that it presents a perf issue.
	Rebase to 5.3

v2->v3: Clarify and tweak the return from check_acpi_cpu_flag()
	Cache the PPTT table revision to avoid repeat
	      acpi_table_get/put calls in the case of
	      missing or old PPTT tables.

v1->v2:
	Return ENOENT instead on ENONET.

Jeremy Linton (2):
  ACPI/PPTT: Add support for ACPI 6.3 thread flag
  arm64: topology: Use PPTT to determine if PE is a thread

 arch/arm64/kernel/topology.c | 19 ++++++++++---
 drivers/acpi/pptt.c          | 53 +++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h         |  5 ++++
 3 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.21.0

