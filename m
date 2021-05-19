Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1238987F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 23:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhESVUl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 17:20:41 -0400
Received: from fgw23-7.mail.saunalahti.fi ([62.142.5.84]:29298 "EHLO
        fgw23-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhESVUl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 May 2021 17:20:41 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 17:20:40 EDT
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id a0466097-b8e5-11eb-8ccd-005056bdfda7;
        Thu, 20 May 2021 00:03:15 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 1/1] ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
Date:   Thu, 20 May 2021 00:02:53 +0300
Message-Id: <20210519210253.3578025-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently it's possible to iterate over the dangling pointer in case the device
suddenly disappears. This may happen becase callers put it at the end of a loop.

Instead, let's move that call inside acpi_dev_get_next_match_dev().

Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/acpi/utils.c                       | 5 +----
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
 include/acpi/acpi_bus.h                    | 5 -----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 3b54b8fd7396..ccfc484dbffd 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
  * Return the next match of ACPI device if another matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
- * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
- * in the case of a hotplug event. That said, the caller should ensure that
- * this will never happen.
- *
  * The caller is responsible for invoking acpi_dev_put() on the returned device.
  *
  * See additional information in acpi_dev_present() as well.
@@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
 	match.hrv = hrv;
 
 	dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
+	acpi_dev_put(adev);
 	return dev ? to_acpi_device(dev) : NULL;
 }
 EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index e8511787c1e4..477417261b6e 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -178,13 +178,11 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 
 		if (bridge->n_sensors >= CIO2_NUM_PORTS) {
 			dev_err(&cio2->dev, "Exceeded available CIO2 ports\n");
-			cio2_bridge_unregister_sensors(bridge);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_put_adev;
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
-		sensor->adev = adev;
 		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
@@ -214,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 			goto err_free_swnodes;
 		}
 
+		sensor->adev = acpi_dev_get(adev);
 		adev->fwnode.secondary = fwnode;
 
 		dev_info(&cio2->dev, "Found supported sensor %s\n",
@@ -227,8 +226,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 err_free_swnodes:
 	software_node_unregister_nodes(sensor->swnodes);
 err_put_adev:
-	acpi_dev_put(sensor->adev);
-err_out:
+	acpi_dev_put(adev);
 	return ret;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a82faac5767..bff6a11bb21f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -698,11 +698,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
  * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
  *
  * The caller is responsible for invoking acpi_dev_put() on the returned device.
- *
- * FIXME: Due to above requirement there is a window that may invalidate @adev
- * and next iteration will use a dangling pointer, e.g. in the case of a
- * hotplug event. That said, the caller should ensure that this will never
- * happen.
  */
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);	\
-- 
2.31.1

