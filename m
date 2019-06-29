Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E985A898
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2019 04:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF2Coy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jun 2019 22:44:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbfF2Coy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Jun 2019 22:44:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2F130804E4552ACA6848;
        Sat, 29 Jun 2019 10:44:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 29 Jun 2019 10:44:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
Date:   Sat, 29 Jun 2019 10:42:32 +0800
Message-ID: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
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

Changelog:

v1 -> v2:
	rebase the thrid patch to the lastest kernel

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

