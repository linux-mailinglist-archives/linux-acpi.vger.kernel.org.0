Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A372C8B7C
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 18:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgK3Rkq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 12:40:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8889 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgK3Rkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 12:40:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ClCCp0bcGz76Ms;
        Tue,  1 Dec 2020 01:39:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 01:39:49 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 0/5] Support managed interrupts for platform devices
Date:   Tue, 1 Dec 2020 01:35:54 +0800
Message-ID: <1606757759-6076-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

So far, managed interrupts are only used for PCI MSIs. This series adds
platform device support for managed interrupts. Initially this topic was
discussed at [0].

The method to enable managed interrupts is to allocate a group of IRQs for
the device, and then switch the interrupts to managed - this is done
through new function irq_update_affinity_desc().

Function devm_platform_get_irqs_affinity() is added as a helper to manage
this work, such that we don't need to export irq_update_affinity_desc() or
irq_create_affinity_masks().

In the devm_platform_get_irqs_affinity() release call a new platform
method is used to "put" an irq. The reason for this is that per-irq
mapping (and irq_desc) needs to be recreated anew for re-probing the LLDD,
such that we don't attempt to reconfigure the managed or any other flag
for an irq_desc.

For now, the HiSilicon SAS v2 hw driver is switched over. This is used
in the D05 dev board.

Performance gain observed for 6x SAS SSDs is ~357K -> 420K IOPs for fio read.

This series is tested based on Marc's "MSI: Track device proxying when
allocating MSIs" series, [1].

[0] https://lore.kernel.org/lkml/84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com/
[1] https://lore.kernel.org/lkml/20201129135208.680293-1-maz@kernel.org/

Changes since v3:
- Fix genirq change to re-activate interrupt if we have deactivated it
- Remove standalone platform_put_irq(), and combine code into
  devm_platform_get_irqs_affinity_release()
- Add new inline function in ioport.h rather than making
  acpi_dev_irqresource_disabled() public

Changes since v2:
- Update genirq change as follows:
 - Handle when the irq is started, active, or already managed
 - Reject update when CONFIG_GENERIC_IRQ_RESERVATION_MODE is set
- Revamp platform.c API as follows:
 - Make it devm type
 - Add platform_put_irq() and associated change in ACPI code to allow irq
   resource to be reset
 - Unmap irqs for driver removal
 - Change API to accept min and max vectors

John Garry (5):
  genirq/affinity: Add irq_update_affinity_desc()
  resource: Add irqresource_disabled()
  ACPI: Drop acpi_dev_irqresource_disabled()
  Driver core: platform: Add devm_platform_get_irqs_affinity()
  scsi: hisi_sas: Expose HW queues for v2 hw

 drivers/acpi/resource.c                |  17 +---
 drivers/base/platform.c                | 121 +++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas.h       |   4 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  11 +++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  66 +++++++++++---
 include/linux/interrupt.h              |   8 ++
 include/linux/ioport.h                 |   7 ++
 include/linux/platform_device.h        |   6 ++
 kernel/irq/manage.c                    |  63 +++++++++++++
 9 files changed, 278 insertions(+), 25 deletions(-)

-- 
2.26.2

