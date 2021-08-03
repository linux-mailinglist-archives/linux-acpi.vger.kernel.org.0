Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE23DEFFE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhHCORl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbhHCOR2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2021 10:17:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746BC0617A1;
        Tue,  3 Aug 2021 07:17:15 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMJPHZD2s+0akhWH3YgNv+6eVV1Mfo5CwlnWd2fY9Fc=;
        b=knDYNN7oqKQkW6EyhbgbzY3g1ZjOBj+WkUJTF2aZrOwtBfFMkSg/b31nhnU94waKtRjKp9
        byuORjIFyjLmCDKrrp4WFq8IPcbOhlVPF5Ts8UACbvNghHzDPxAWWGqxwjlRQNzhOehj/Z
        1sCFGsq4of84zwEN+vy2rNKxL3wA9Y0k1NPGTI4HMBhMDmwnbymSF7J/g35jf2Y9otyTxm
        UZlNaDdBc5BPDdBbmPzro08esnhbw74R2CYk4QDzlAH29nS5S+2t+oozooy63nyT39EjUm
        xKzO0KAg6w5hyfPvX1E9LKrwHIcMc23xHXLzI8X2Ghi/UpWXo0IkAcIPzhY3ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMJPHZD2s+0akhWH3YgNv+6eVV1Mfo5CwlnWd2fY9Fc=;
        b=LX8Rv+JvZctrjyb8bXnhBwSbulrlp7m2lysmW/lkz8bKG+I8RASI+y/WDO+y/fqjJzm9bR
        3AbAjn+2fl319+Aw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 29/38] ACPI: processor: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:12 +0200
Message-Id: <20210803141621.780504-30-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The functions cpu_hotplug_begin, cpu_hotplug_done, get_online_cpus() and
put_online_cpus() have been deprecated during the CPU hotplug rework. They =
map
directly to cpus_write_lock(), cpus_write_unlock, cpus_read_lock() and
cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/acpi/acpi_pad.c       | 4 ++--
 drivers/acpi/acpi_processor.c | 8 ++++----
 drivers/acpi/processor_idle.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index df4adeb335b24..f45979aa2d648 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -249,12 +249,12 @@ static void set_power_saving_task_num(unsigned int nu=
m)
=20
 static void acpi_pad_idle_cpus(unsigned int num_cpus)
 {
-	get_online_cpus();
+	cpus_read_lock();
=20
 	num_cpus =3D min_t(unsigned int, num_cpus, num_online_cpus());
 	set_power_saving_task_num(num_cpus);
=20
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static uint32_t acpi_pad_idle_cpus_num(void)
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 2d5bd2a6ddcef..6737b1cbf6d69 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,7 +182,7 @@ static int acpi_processor_hotadd_init(struct acpi_proce=
ssor *pr)
 		return -ENODEV;
=20
 	cpu_maps_update_begin();
-	cpu_hotplug_begin();
+	cpus_write_lock();
=20
 	ret =3D acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
 	if (ret)
@@ -203,7 +203,7 @@ static int acpi_processor_hotadd_init(struct acpi_proce=
ssor *pr)
 	pr->flags.need_hotplug_init =3D 1;
=20
 out:
-	cpu_hotplug_done();
+	cpus_write_unlock();
 	cpu_maps_update_done();
 	return ret;
 }
@@ -454,13 +454,13 @@ static void acpi_processor_remove(struct acpi_device =
*device)
 	per_cpu(processors, pr->id) =3D NULL;
=20
 	cpu_maps_update_begin();
-	cpu_hotplug_begin();
+	cpus_write_lock();
=20
 	/* Remove the CPU. */
 	arch_unregister_cpu(pr->id);
 	acpi_unmap_cpu(pr->id);
=20
-	cpu_hotplug_done();
+	cpus_write_unlock();
 	cpu_maps_update_done();
=20
 	try_offline_node(cpu_to_node(pr->id));
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 095c8aca141eb..f37fba9e5ba0b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1301,7 +1301,7 @@ int acpi_processor_power_state_has_changed(struct acp=
i_processor *pr)
 	if (pr->id =3D=3D 0 && cpuidle_get_driver() =3D=3D &acpi_idle_driver) {
=20
 		/* Protect against cpu-hotplug */
-		get_online_cpus();
+		cpus_read_lock();
 		cpuidle_pause_and_lock();
=20
 		/* Disable all cpuidle devices */
@@ -1330,7 +1330,7 @@ int acpi_processor_power_state_has_changed(struct acp=
i_processor *pr)
 			}
 		}
 		cpuidle_resume_and_unlock();
-		put_online_cpus();
+		cpus_read_unlock();
 	}
=20
 	return 0;
--=20
2.32.0

