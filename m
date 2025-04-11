Return-Path: <linux-acpi+bounces-12962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55428A850B9
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 02:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D0A3BE383
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8BDDC3;
	Fri, 11 Apr 2025 00:42:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC71F92E;
	Fri, 11 Apr 2025 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332149; cv=none; b=L4tldt3E34JpGxJR2QTgI9YOCWSFLp+jpQWTjVV3W8H36xkFhzBTwahZA87Mh0VrGp7i2+qbQmv8P7yKntehBp5SmeMZfkIn14R+C+yY+iATto4HKQYlDU8mYxaim8LXdc+VtyipxGDgopryOIAIcpUHRU53k6ZRlNe7U907Ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332149; c=relaxed/simple;
	bh=C6uoDGWwX7Xmn5POMHExErF0OV6F9xl+H1iPWzj/XL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZ+DbhXPTWYMreimFOBhjR7SjD/3jvne/3eqvOwFmZrwKdQXxkizOGBuIzV8ihTgUSFyWFfGQtD+jOU2ysBbklmndixRXhajaZzQGwszReSMcLNwAQEFkBF+TjQhvYzEl0nn+KXluZQq/9tNCmuMsaI69BxtC5JBK27QYaOLUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B0Ql0v007423;
	Thu, 10 Apr 2025 17:42:08 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4fecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Apr 2025 17:42:08 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 10 Apr 2025 17:42:07 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 10 Apr 2025 17:42:03 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>
CC: <andriy.shevchenko@linux.intel.com>, <dakr@kernel.org>,
        <djrscally@gmail.com>, <gregkh@linuxfoundation.org>,
        <heikki.krogerus@linux.intel.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nicolinc@nvidia.com>,
        <rafael@kernel.org>, <sakari.ailus@linux.intel.com>,
        <syzkaller-bugs@googlegroups.com>, <yi.l.liu@intel.com>
Subject: [PATCH] software node: Prevent link creation failure from causing kobj reference count imbalance
Date: Fri, 11 Apr 2025 08:42:02 +0800
Message-ID: <20250411004203.2932899-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67f26778.050a0220.0a13.0265.GAE@google.com>
References: <67f26778.050a0220.0a13.0265.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y6GffptamSfDAkF_ANMUsv8vmNUiJxe9
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f86560 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=_M_gq6cjJWGxT9GtEoAA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Y6GffptamSfDAkF_ANMUsv8vmNUiJxe9
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=776 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110004

syzbot reported a uaf in software_node_notify_remove. [1]

When any of the two sysfs_create_link() in software_node_notify() fails,
the swnode->kobj reference count will not increase normally, which will
cause swnode to be released incorrectly due to the imbalance of kobj reference
count when executing software_node_notify_remove().

Increase the reference count of kobj before creating the link to avoid uaf.

[1]
BUG: KASAN: slab-use-after-free in software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
Read of size 1 at addr ffff888033c08908 by task syz-executor105/5844

CPU: 0 UID: 0 PID: 5844 Comm: syz-executor105 Not tainted 6.14.0-syzkaller-12456-gacc4d5ff0b61 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
 device_platform_notify_remove drivers/base/core.c:2387 [inline]
 device_del+0x594/0x9b0 drivers/base/core.c:3858
 device_unregister+0x20/0xc0 drivers/base/core.c:3896
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:960 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1022 [inline]
 iommufd_test+0x3715/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14c7b0b6e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff388f87b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff388f87d0 RCX: 00007f14c7b0b6e9
RDX: 0000200000000200 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 0000000000000002 R08: 00007fff388f8556 R09: 00000000000000a0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fff388f87cc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x9d/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x236/0x370 mm/slub.c:4362
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 swnode_register+0x5a/0x540 drivers/base/swnode.c:790
 fwnode_create_software_node+0x199/0x1f0 drivers/base/swnode.c:949
 device_create_managed_software_node+0xd5/0x1f0 drivers/base/swnode.c:1060
 mock_dev_create drivers/iommu/iommufd/selftest.c:942 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:989 [inline]
 iommufd_test+0x3335/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2389 [inline]
 slab_free mm/slub.c:4646 [inline]
 kfree+0x198/0x430 mm/slub.c:4845
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 software_node_notify_remove+0x159/0x1c0 drivers/base/swnode.c:1106
 device_platform_notify_remove drivers/base/core.c:2387 [inline]
 device_del+0x594/0x9b0 drivers/base/core.c:3858
 device_unregister+0x20/0xc0 drivers/base/core.c:3896
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:960 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:1022 [inline]
 iommufd_test+0x3715/0x56a0 drivers/iommu/iommufd/selftest.c:1866
 iommufd_fops_ioctl+0x4fc/0x610 drivers/iommu/iommufd/main.c:419
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/base/swnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b1726a3515f6..5c78fa6ae772 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -1080,6 +1080,7 @@ void software_node_notify(struct device *dev)
 	if (!swnode)
 		return;
 
+	kobject_get(&swnode->kobj);
 	ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
 	if (ret)
 		return;
@@ -1089,8 +1090,6 @@ void software_node_notify(struct device *dev)
 		sysfs_remove_link(&dev->kobj, "software_node");
 		return;
 	}
-
-	kobject_get(&swnode->kobj);
 }
 
 void software_node_notify_remove(struct device *dev)
-- 
2.43.0


