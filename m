Return-Path: <linux-acpi+bounces-12998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC0A87875
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527763A93ED
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055723718F;
	Mon, 14 Apr 2025 07:11:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B231ACED9;
	Mon, 14 Apr 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614704; cv=none; b=F43v5LX+6Ayybjq8xbLrNCxTF8VoSHmOsIljHgD7k71PisfbvuUu5L9zDlTBHxTayZNeeSzN4cmda7XA1i23GpjST23JyJTureakn4gg99IsY0L/h/uaK8B8iwlmnrimCfaG1g11pYn4o5D2nZnqnulUZxn/ztzcbVvlJhzw2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614704; c=relaxed/simple;
	bh=a3z2gobzf/ht5/7LLqmStK8wn2Ktd7QyL6AJSjQ4fRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZN9RwtfHlbxGJQxq7m3/zq794SgilTAK+GrMvFDx16p0Ticy+c775cai0IxHzqAoQHAbK1oXn8oMuo+A7kU1VcMBhgcoJRjV5Lr+F/JuhPQwDxSvrk2Q1OMsBC2ePu+4D+T+eu2Iik1FYx2kHg7WEcra4o5I0VA5ZMvDVPNppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E6eWLu005022;
	Mon, 14 Apr 2025 07:11:29 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yf58hp32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Apr 2025 07:11:29 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 14 Apr 2025 00:11:28 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 14 Apr 2025 00:11:24 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <dakr@kernel.org>, <djrscally@gmail.com>, <dvyukov@google.com>,
        <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>,
        <jgg@nvidia.com>, <kevin.tian@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <nicolinc@nvidia.com>, <rafael@kernel.org>,
        <sakari.ailus@linux.intel.com>,
        <syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <yi.l.liu@intel.com>
Subject: [PATCH V2] software node: Prevent link creation failure from causing kobj reference count imbalance
Date: Mon, 14 Apr 2025 15:11:23 +0800
Message-ID: <20250414071123.1228331-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
References: <Z_ypLhYQwGf41hVK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=67fcb521 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=jCU8iyBe7FSsQOJyWVcA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: JmkLrTrDFaAacdP3HHIuJLTkWap88zL4
X-Proofpoint-ORIG-GUID: JmkLrTrDFaAacdP3HHIuJLTkWap88zL4
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=721 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504140050

syzbot reported a uaf in software_node_notify_remove. [1]

When any of the two sysfs_create_link() in software_node_notify() fails,
the swnode->kobj reference count will not increase normally, which will
cause swnode to be released incorrectly due to the imbalance of kobj reference
count when executing software_node_notify_remove().

Increase the reference count of kobj before creating the link to avoid uaf.

[1]
BUG: KASAN: slab-use-after-free in software_node_notify_remove+0x1bc/0x1c0 drivers/base/swnode.c:1108
Read of size 1 at addr ffff888033c08908 by task syz-executor105/5844
Freed by task 5844:
 software_node_notify_remove+0x159/0x1c0 drivers/base/swnode.c:1106
 device_platform_notify_remove drivers/base/core.c:2387 [inline]

Fixes: 9eb59204d519 ("iommufd/selftest: Add set_dev_pasid in mock iommu")
Reported-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2ff22910687ee0dfd48e
Tested-by: syzbot+2ff22910687ee0dfd48e@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: reduce calltrace

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


