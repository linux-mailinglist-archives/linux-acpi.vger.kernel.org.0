Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE7243293
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Aug 2020 04:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgHMCyr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Aug 2020 22:54:47 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:31978 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgHMCyr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2020 22:54:47 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 22:54:46 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id B1D5E4E1586;
        Thu, 13 Aug 2020 10:49:24 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] acpi/nfit: Use kobj_to_dev() instead
Date:   Thu, 13 Aug 2020 10:49:10 +0800
Message-Id: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0xMHRoYSkkZQ01JVkpOQkxJQ01CTU5KQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6GSo4ST8tH0MvTDIJPDA#
        MhcKFBZVSlVKTkJMSUNNQk1OTUhJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFJSU9DNwY+
X-HM-Tid: 0a73e5b8df529376kuwsb1d5e4e1586
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/acpi/nfit/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index fa4500f..3bb350b
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
 
 static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
 	if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
@@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
 static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 
-- 
2.7.4

