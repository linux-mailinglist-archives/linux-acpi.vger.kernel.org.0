Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA653DDC50
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhHBPYV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 11:24:21 -0400
Received: from foss.arm.com ([217.140.110.172]:37474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234359AbhHBPYU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 11:24:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3E711D4;
        Mon,  2 Aug 2021 08:24:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376BC3F66F;
        Mon,  2 Aug 2021 08:24:08 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 0/3] ACPI: Fix acpi_os_map_memory() memory semantics
Date:   Mon,  2 Aug 2021 16:23:56 +0100
Message-Id: <20210802152359.12623-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Patch series is a v2 of a previous version[1]:

v1->v2
	- Added patch 1 and 2 according to feedback received on[1]

[1] https://lore.kernel.org/linux-acpi/20210726100026.12538-1-lorenzo.pieralisi@arm.com

Lorenzo Pieralisi (3):
  ACPI: osl: Add __force attribute in acpi_os_map_iomem() cast
  ACPI: osl: Reorder acpi_os_map_iomem() __ref annotation
  ACPI: Add memory semantics to acpi_os_map_memory()

 arch/arm64/include/asm/acpi.h |  3 +++
 arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
 drivers/acpi/osl.c            | 23 ++++++++++++++++-------
 include/acpi/acpi_io.h        | 12 ++++++++++--
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.31.0

