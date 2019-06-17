Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133984802C
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 13:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfFQLEm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 07:04:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfFQLEl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 07:04:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A9A6B995AE611DD51A8;
        Mon, 17 Jun 2019 19:04:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 19:04:28 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Update my email address
Date:   Mon, 17 Jun 2019 19:02:15 +0800
Message-ID: <1560769335-62944-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The @linaro.org address is not working and bonucing, so update the
references.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

v2: update the .mailmap to redirect the older email address which               
    is suggested by Marc.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 07a777f..fd9b497 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,6 +81,7 @@ Greg Kroah-Hartman <greg@echidna.(none)>
 Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
+Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
 Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496c..2fed10f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -364,7 +364,7 @@ F:	drivers/acpi/fan.c
 
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-M:	Hanjun Guo <hanjun.guo@linaro.org>
+M:	Hanjun Guo <guohanjun@huawei.com>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.7.12.4

