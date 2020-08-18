Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23D247E81
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRGgu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 02:36:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbgHRGgq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 02:36:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB9B1CB4D72242937965;
        Tue, 18 Aug 2020 14:36:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:36:34 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 0/2] ACPI/IORT: Code cleanups
Date:   Tue, 18 Aug 2020 14:36:23 +0800
Message-ID: <20200818063625.980-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

* From v1 [1]:
  - As pointed out by Hanjun, remove two now unused inline functions.
    Compile tested with CONFIG_IOMMU_API is not selected.

[1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com

Zenghui Yu (2):
  ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
  ACPI/IORT: Remove the unused inline functions

 drivers/acpi/arm64/iort.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.19.1

