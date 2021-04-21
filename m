Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4218367066
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Apr 2021 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbhDUQoD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Apr 2021 12:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236214AbhDUQoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Apr 2021 12:44:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476C461445;
        Wed, 21 Apr 2021 16:43:28 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lZFwj-008jPD-UL; Wed, 21 Apr 2021 17:43:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
Date:   Wed, 21 Apr 2021 17:43:15 +0100
Message-Id: <20210421164317.1718831-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, guohanjun@huawei.com, dann.frazier@canonical.com, wefu@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dann recently reported that his ThunderX machine failed to boot since
64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
interrupts"), with a not so pretty crash while trying to send an IPI.

It turned out to be caused by a mix of broken firmware and a buggy
GTDT watchdog driver. Both have forever been buggy, but the above
commit revealed that the error handling path of the driver was
probably the worse part of it all.

Anyway, this short series has two goals:
- handle broken firmware in a less broken way
- make sure that the route cause of the problem can be identified
  quickly

Thanks,

	M.

Marc Zyngier (2):
  ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
  ACPI: irq: Prevent unregistering of GIC SGIs

 drivers/acpi/arm64/gtdt.c | 10 ++++++----
 drivers/acpi/irq.c        |  6 +++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.29.2
