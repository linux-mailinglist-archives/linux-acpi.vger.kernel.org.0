Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D819E21DAF6
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgGMP7E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jul 2020 11:59:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2466 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729027AbgGMP7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 11:59:04 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 68D2B7C9E692F0ED5634;
        Mon, 13 Jul 2020 16:59:03 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 16:59:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 3/6] ACPI: Let ACPI know we support Generic Initiator Affinity Structures
Date:   Mon, 13 Jul 2020 23:55:57 +0800
Message-ID: <20200713155600.2272743-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200713155600.2272743-1-Jonathan.Cameron@huawei.com>
References: <20200713155600.2272743-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Until we tell ACPI that we support generic initiators, it will have
to operate in fall back domain mode and all _PXM entries should
be on existing non GI domains.

This patch sets the relevant OSC bit to make that happen.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 54002670cb7a..0ac96fb67515 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -302,6 +302,7 @@ static void acpi_bus_osc_support(void)
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
 
 #ifdef CONFIG_X86
 	if (boot_cpu_has(X86_FEATURE_HWP)) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1414b7e0a486..40ec5f2544ed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -546,6 +546,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.19.1

