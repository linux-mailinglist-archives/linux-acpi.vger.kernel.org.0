Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4795990C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2019 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF1LP6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 07:15:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfF1LP6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 07:15:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 061F98E3C0FF2DE709F3;
        Fri, 28 Jun 2019 19:15:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 19:15:49 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH RFC 0/3] Support CPU hotplug for ARM64
Date:   Fri, 28 Jun 2019 19:13:09 +0800
Message-ID: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset mark all the GICC node in MADT as possible CPUs even though it
is disabled. But only those enabled GICC node are marked as present CPUs.
So that kernel will initialize some CPU related data structure in advance before
the CPU is actually hot added into the system. This patchset also implement 
'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
needed to enable CPU hotplug.

To support CPU hotplug, we need to add all the possible GICC node in MADT
including those CPUs that are not present but may be hot added later. Those
CPUs are marked as disabled in GICC nodes.

Xiongfeng Wang (3):
  ACPI / scan: evaluate _STA for processors declared via ASL Device
    statement
  arm64: mark all the GICC nodes in MADT as possible cpu
  arm64: Add CPU hotplug support

 arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
 arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
 arch/arm64/kernel/smp.c   | 11 +++++------
 drivers/acpi/scan.c       | 12 ++++++++++++
 4 files changed, 57 insertions(+), 7 deletions(-)

-- 
1.7.12.4

