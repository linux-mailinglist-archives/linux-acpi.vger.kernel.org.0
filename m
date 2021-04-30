Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76636FACC
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhD3Mom (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 08:44:42 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:40852 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhD3Mn1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2021 08:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rQfL+
        bUtJX+3ZYhcK0QhJ3DHdXKx/pQWNF2tJzAgEVw=; b=WE8tgmFpRW+iST57T/pFO
        /5I7M/g0tvmAIjKjPaGc7oz5WrlvZT0IZxG0S297v3mGvdxHGa9+4raRweNiQhWi
        YVMWaWnBSDRQhmufyafxIRUDxF1wpb+56hJ1lOxyRdRAN09vUV3FW0dd0qJx6ekD
        fth4a69TKQS6Zhm4oZs7Zg=
Received: from localhost.localdomain (unknown [117.10.160.91])
        by smtp2 (Coremail) with SMTP id GtxpCgA3JRox+4tgsgT1HA--.294S2;
        Fri, 30 Apr 2021 20:42:26 +0800 (CST)
From:   Shujun Wang <wsj20369@163.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shujun Wang <wsj20369@163.com>
Subject: [PATCH] Revert "ACPI: power: Turn off unused power resources unconditionally"
Date:   Fri, 30 Apr 2021 20:42:24 +0800
Message-Id: <20210430124224.6383-1-wsj20369@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA3JRox+4tgsgT1HA--.294S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4UKrW3uF4xXFyUKr45ZFb_yoW8ZrWkpF
        92gw17Cr4kXF17tFsIvF1jqFZ5uw429a1qkryxCwnxuanrWr98tr9rtry5Z345Jr18WF4Y
        qr4DXr18tFWUuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jCXdbUUUUU=
X-Originating-IP: [117.10.160.91]
X-CM-SenderInfo: hzvmjiqtwzqiywtou0bp/1tbiTBKEF1SInabxIgAAs5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
It may cause some NVMe device probes to fail, and the system may get
stuck when using an NVMe device as the root filesystem.

In the function nvme_pci_enable(struct nvme_dev *dev), as shown below,
readl(NVME_REG_CSTS) always returns -1 with the commit, which results in
the probe failed.

  if (readl(dev->bar + NVME_REG_CSTS) == -1) {
	result = -ENODEV;
	goto disable;
  }

dmesg:
  [    1.106280] nvme 0000:04:00.0: platform quirk: setting simple suspend
  [    1.109111] nvme nvme0: pci function 0000:04:00.0
  [    1.113066] nvme 0000:04:00.0: enabling device (0000 -> 0002)
  [    1.121040] nvme nvme0: Removing after probe failure status: -19

lspci:
  Non-Volatile memory controller: KIOXIA Corporation Device 0001

device uevent:
  DRIVER=nvme
  PCI_CLASS=10802
  PCI_ID=1E0F:0001
  PCI_SUBSYS_ID=1E0F:0001
  PCI_SLOT_NAME=0000:04:00.0
  MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02

This patch was tested in Lenovo Thinkpad X1.

Signed-off-by: Shujun Wang <wsj20369@163.com>
---
 drivers/acpi/power.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 56102eaaa2da..8bf10abeb2e0 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1004,9 +1004,18 @@ void acpi_turn_off_unused_power_resources(void)
 	mutex_lock(&power_resource_list_lock);
 
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
+		int result, state;
+
 		mutex_lock(&resource->resource_lock);
 
-		if (!resource->ref_count) {
+		result = acpi_power_get_state(resource->device.handle, &state);
+		if (result) {
+			mutex_unlock(&resource->resource_lock);
+			continue;
+		}
+
+		if (state == ACPI_POWER_RESOURCE_STATE_ON
+		    && !resource->ref_count) {
 			dev_info(&resource->device.dev, "Turning OFF\n");
 			__acpi_power_off(resource);
 		}
-- 
2.25.1

