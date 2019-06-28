Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935365A345
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 20:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF1SO6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 14:14:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfF1SO6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 14:14:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC442B;
        Fri, 28 Jun 2019 11:14:57 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51FC83F718;
        Fri, 28 Jun 2019 11:14:57 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/2] arm64/PPTT ACPI 6.3 thread flag support
Date:   Fri, 28 Jun 2019 13:14:55 -0500
Message-Id: <20190628181457.6609-1-jeremy.linton@arm.com>
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

v2->v3: Clarify and tweak the return from check_acpi_cpu_flag()
	Cache the PPTT table revision to avoid repeat
	      acpi_table_get/put calls in the case of
	      missing or old PPTT tables.

v1->v2:
	Return ENOENT instead on ENONET.

Jeremy Linton (2):
  ACPI/PPTT: Add support for ACPI 6.3 thread flag
  arm64: topology: Use PPTT to determine if PE is a thread

 arch/arm64/kernel/topology.c |  8 +++--
 drivers/acpi/pptt.c          | 62 +++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h         |  5 +++
 3 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.21.0

