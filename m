Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA68227C7E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGUKGH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jul 2020 06:06:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgGUKGH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Jul 2020 06:06:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BA12267E6C47B09E14B;
        Tue, 21 Jul 2020 18:06:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 18:05:59 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/3] Minor cleanups
Date:   Tue, 21 Jul 2020 17:59:03 +0800
Message-ID: <1595325546-63774-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When reviewing patchset "[PATCH v2 0/6] ACPI: Only create NUMA nodes
from entries in SRAT or SRAT emulation." [0] from Jonathan, I found some
code can be improved, here are some cleanup patches.

[0]: https://www.spinics.net/lists/linux-mm/msg220777.html

Hanjun Guo (3):
  ACPI: tables: Remove the duplicated checks for
    acpi_parse_entries_array()
  ACPI: NUMA: Remove the useless sub table pointer check
  ACPI: NUMA: Remove the useless 'node >= MAX_NUMNODES' check

 drivers/acpi/numa/srat.c | 10 +---------
 drivers/acpi/tables.c    | 17 +++--------------
 2 files changed, 4 insertions(+), 23 deletions(-)

-- 
1.7.12.4

