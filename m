Return-Path: <linux-acpi+bounces-19563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651FCBBB70
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Dec 2025 15:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3A63003BCD
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Dec 2025 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FD26E179;
	Sun, 14 Dec 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8vrkags"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB3248F66;
	Sun, 14 Dec 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765722309; cv=none; b=GzjYvPe10NT9VilygPUDhaNgn2dr6839aaRwQU+/ZgtGd1wG2ZOxpzyoyI8pfTjjKo9uu7ZQp+w8TgJojNxjtf8HzhLekIamZ8e4ME0H4uQSth/nU/VkcV4vc/lfmcjxMxOOJ4QV99JDdDv+S8zAla8e96GRf8otFFuYop1FRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765722309; c=relaxed/simple;
	bh=D89inXxAzPSKzgtdyHzgYEovkaf/BrULmI0e7Z3rVVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOkKAR3UG+SLH25ImG2KvxBahOdoLUkkh4WJVtN5EKhc0PI401l7Y1ZSGOxdjaBMh61bvGo5H6KfmAUmV/d44QAWpI+kzPI5+BVWIFl6PZagqmzuEO7B7Dl5xqDJiXXnxxadrjn1O0nQYBvCKbGnO5wWELHHo1Qje7i8nQxCMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8vrkags; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C286C4CEF1;
	Sun, 14 Dec 2025 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765722308;
	bh=D89inXxAzPSKzgtdyHzgYEovkaf/BrULmI0e7Z3rVVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8vrkagsvIj1y0XNs6tSJPrtDgbj2gehYWYpQiqLtcjt2O4l+95LKU2PQdTnJ4JiD
	 P5EOV+ODmWNPug9Tpb58Z2Fao//z0tDNmPjJHfB6a55hVDXPPSjFN75PDYlUxOAW6+
	 9JXKy0nf41rz/Sth38ceto9pFaqSUf5Qm8TWGGHii/etcjkoZ+MypJg2uDkDyymmKk
	 Z6uMpgIlyEoNWu9xbq5gG64O3p9Dp01SrJ+bxW0NT1l8nqnNlVTW4tyI8M8Ohis1PK
	 VwTAI6HE2YSdDlCviISyohG/0Eax3TRUXXrlKlC3VmUA29PA0zhxOJBF2od6QgODjO
	 +m8hIraFr1ckw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Subject: [PATCH v2] ACPI: NFIT: core: Convert the driver to a platform one
Date: Sun, 14 Dec 2025 15:25:04 +0100
Message-ID: <12798648.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <693c9f628c7fc_c04a91001f@iweiny-mobl.notmuch>
References:
 <5066996.31r3eYUQgx@rafael.j.wysocki> <2028345.PYKUYFuaPT@rafael.j.wysocki>
 <693c9f628c7fc_c04a91001f@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Saturday, December 13, 2025 12:04:02 AM CET Ira Weiny wrote:
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > While binding drivers directly to struct acpi_device objects allows
> > basic functionality to be provided, at least in the majority of cases,
> > there are some problems with it, related to general consistency, sysfs
> > layout, power management operation ordering, and code cleanliness.
> > 
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the ACPI NFIT core driver to a platform one.
> > 
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> 
> I'm not sure right off why but when I run the libndctl test with this patch I
> get the following panic.
> 
> [   17.483472] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   17.484116] #PF: supervisor read access in kernel mode
> [   17.484593] #PF: error_code(0x0000) - not-present page
> [   17.485056] PGD 9def067 P4D 9def067 PUD 9df3067 PMD 0
> [   17.485516] Oops: Oops: 0000 [#1] SMP NOPTI
> [   17.485886] CPU: 2 UID: 0 PID: 1191 Comm: libndctl Tainted: G           O        6.18.0ira+ #34 PREEMPT(voluntary)
> [   17.486804] Tainted: [O]=OOT_MODULE
> [   17.487125] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-18.fc42 08/12/2025
> [   17.487749] RIP: 0010:acpi_nfit_ctl+0x40b/0xa00 [nfit]
> [   17.488222] Code: 48 48 c7 44 24 28 28 f1 8c a1 48 8b 83 c8 01 00 00 44 89 e7 48 89 44 24 50 e8 01 83 fd ff 48 c7 44 24 40 10 58 8c a1 48 89 c3 <49> 8b 47 08 48 c7 44 24 30 30 f1 8c a1 48 89 44 24 18 e9 24 fd
> ff
> [   17.491668] RSP: 0018:ffffc9000f11ba28 EFLAGS: 00010286
> [   17.492422] RAX: ffffffffa18679f0 RBX: ffffffffa18679f0 RCX: ffffc9000f11bb40
> [   17.492903] RDX: 000000000000041e RSI: ffffffffa18cf116 RDI: 0000000000000003
> [   17.493408] RBP: ffffc9000f11bb40 R08: 0000000000000008 R09: ffffc9000f11bafc
> [   17.493888] R10: ffffc9000f11bae0 R11: 0000000000004019 R12: 0000000000000003
> [   17.494396] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   17.494878] FS:  00007f432f5fd7c0(0000) GS:ffff8880f9fdd000(0000) knlGS:0000000000000000
> [   17.495436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   17.495826] CR2: 0000000000000008 CR3: 0000000009e0c005 CR4: 0000000000770ef0
> [   17.496324] PKRU: 55555554
> [   17.496516] Call Trace:
> [   17.496691]  <TASK>
> [   17.496844]  ? __kmalloc_noprof+0x410/0x650
> [   17.497138]  ? setup_result+0x1b/0xa0 [nfit_test]
> [   17.497474]  nfit_ctl_test+0x21a/0x780 [nfit_test]
> [   17.497803]  ? preempt_count_add+0x51/0xd0
> [   17.498086]  ? up_write+0x13/0x60
> [   17.498333]  ? up_write+0x35/0x60
> [   17.498565]  ? preempt_count_add+0x51/0xd0
> [   17.498846]  ? kernfs_next_descendant_post+0x1b/0xe0
> [   17.499196]  nfit_test_probe+0x350/0x4d0 [nfit_test]
> [   17.499535]  platform_probe+0x38/0x70
> [   17.499791]  really_probe+0xde/0x380
> [   17.500039]  ? _raw_spin_unlock_irq+0x18/0x40
> [   17.500354]  __driver_probe_device+0xc0/0x150
> [   17.500656]  driver_probe_device+0x1f/0xa0                                                                                                                                                                       [   17.500939]  ? __pfx___driver_attach+0x10/0x10
> [   17.501263]  __driver_attach+0xc7/0x200
> [   17.501529]  bus_for_each_dev+0x63/0xa0
> [   17.501794]  bus_add_driver+0x114/0x200
> [   17.502059]  driver_register+0x71/0xe0
> [   17.502480]  nfit_test_init+0x24e/0xff0 [nfit_test]
> [   17.502956]  ? __pfx_nfit_test_init+0x10/0x10 [nfit_test]
> [   17.503483]  do_one_initcall+0x42/0x210
> [   17.503891]  do_init_module+0x62/0x230
> [   17.504296]  init_module_from_file+0xb1/0xe0
> [   17.504732]  idempotent_init_module+0xed/0x2d0
> [   17.505184]  __x64_sys_finit_module+0x6d/0xe0
> [   17.505626]  do_syscall_64+0x62/0x390
> [   17.506016]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   17.506563] RIP: 0033:0x7f432f8920cd
> [   17.506946] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 4d 0f 00 f7 d8 64 89 01
> 48
> [   17.508548] RSP: 002b:00007fff0a6ccd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   17.509209] RAX: ffffffffffffffda RBX: 000000001f5def50 RCX: 00007f432f8920cd
> [   17.509831] RDX: 0000000000000000 RSI: 00007f432f9aa965 RDI: 0000000000000003                                                                                                                                    [   17.510472] RBP: 00007fff0a6cce50 R08: 0000000000000000 R09: 00007fff0a6cce00
> [   17.511091] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000020000
> [   17.511727] R13: 000000001f5deb60 R14: 00007f432f9aa965 R15: 0000000000000000
> [   17.512353]  </TASK>
> [   17.512638] Modules linked in: nfit_test(O+) device_dax(O) nd_pmem(O) dax_pmem(O) kmem nd_btt(O) nfit(O) dax_cxl cxl_pci nd_e820(O) cxl_mock_mem(O) cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cx
> l_mock(O) libnvdimm(O) nfit_test_iomap(O) cxl_core(O) fwctl
> [   17.514512] CR2: 0000000000000008
> [   17.514878] ---[ end trace 0000000000000000 ]---
> 
> 
> I'll try and find some time to dig into it but perhaps yall have a quick
> idea of what it could be?
> 
> Ira
> 
> > 
> > This change was mostly developed by Michal Wilczynski [1].
> > 
> > Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/nfit/core.c |   34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> > 
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
> >   */
> > +#include <linux/platform_device.h>
> >  #include <linux/list_sort.h>
> >  #include <linux/libnvdimm.h>
> >  #include <linux/module.h>
> > @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(s
> >  			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
> >  		return NULL;
> >  
> > -	return to_acpi_device(acpi_desc->dev);
> > +	return ACPI_COMPANION(acpi_desc->dev);
> >  }

It's likely this change and it is not even necessary.

If possible, please check the v2 below.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: NFIT: core: Convert the driver to a platform one

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI NFIT core driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

This change is based on an earlier one from Michal Wilczynski [1].

Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/nfit/core.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2,6 +2,7 @@
 /*
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
+#include <linux/platform_device.h>
 #include <linux/list_sort.h>
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
@@ -3328,9 +3329,10 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
-static int acpi_nfit_add(struct acpi_device *adev)
+static int acpi_nfit_probe(struct platform_device *pdev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct acpi_nfit_desc *acpi_desc;
 	struct device *dev = &adev->dev;
 	struct acpi_table_header *tbl;
@@ -3343,7 +3345,7 @@ static int acpi_nfit_add(struct acpi_dev
 	if (rc)
 		return rc;
 
-	rc = devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
+	rc = devm_add_action_or_reset(&pdev->dev, acpi_nfit_remove_notify_handler,
 					adev);
 	if (rc)
 		return rc;
@@ -3361,12 +3363,12 @@ static int acpi_nfit_add(struct acpi_dev
 		return 0;
 	}
 
-	rc = devm_add_action_or_reset(dev, acpi_nfit_put_table, tbl);
+	rc = devm_add_action_or_reset(&pdev->dev, acpi_nfit_put_table, tbl);
 	if (rc)
 		return rc;
 	sz = tbl->length;
 
-	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
+	acpi_desc = devm_kzalloc(&pdev->dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
 		return -ENOMEM;
 	acpi_nfit_desc_init(acpi_desc, &adev->dev);
@@ -3395,7 +3397,7 @@ static int acpi_nfit_add(struct acpi_dev
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	return devm_add_action_or_reset(&pdev->dev, acpi_nfit_shutdown, acpi_desc);
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3474,11 +3476,11 @@ static const struct acpi_device_id acpi_
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
-static struct acpi_driver acpi_nfit_driver = {
-	.name = KBUILD_MODNAME,
-	.ids = acpi_nfit_ids,
-	.ops = {
-		.add = acpi_nfit_add,
+static struct platform_driver acpi_nfit_driver = {
+	.probe = acpi_nfit_probe,
+	.driver = {
+		.name = "acpi-nfit",
+		.acpi_match_table = acpi_nfit_ids,
 	},
 };
 
@@ -3516,7 +3518,7 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
-	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	ret = platform_driver_register(&acpi_nfit_driver);
 	if (ret) {
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
@@ -3529,7 +3531,7 @@ static __init int nfit_init(void)
 static __exit void nfit_exit(void)
 {
 	nfit_mce_unregister();
-	acpi_bus_unregister_driver(&acpi_nfit_driver);
+	platform_driver_unregister(&acpi_nfit_driver);
 	destroy_workqueue(nfit_wq);
 	WARN_ON(!list_empty(&acpi_descs));
 }




