Return-Path: <linux-acpi+bounces-12946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4689A8446C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356471BA2111
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4128C5BF;
	Thu, 10 Apr 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zp/qk9b+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596328CF78
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290809; cv=none; b=oc8cTUGFNIhPSuMz2j76ree/+Pqtj4kn5ooadmFhnHC4QIU4Kjd1YeeuIlzYGaIQZrbG7D7kMonB9UgUBFVVEvsCqby1/10OVkBSxvt7wMhmlu5wzNCo952gJhhF+jbgI1IoRoOiiQDCTJPKgCv3mYa7iJjns8Xduyp0mzP5KTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290809; c=relaxed/simple;
	bh=okLu9SL/4lMTeIKpXctHNzDwBRueDotmZLx2CTvlCYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2OUZahonY1IDoeIhxILbheNjdJLvk8cqXINI0rLXqRdCfGsRm6cYuDghu12yTEBV+sSIJbbTtH31QtJxoIkrgnmQMtAHBMBuWHmQ+e5O+eoCV3kU73JEoVzuzlYIdFtxBTHpE1BIAyxF2UF45uVgVWdXoP2bxjyDiQx1G/lLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zp/qk9b+; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=qfdOmA929ss2VBH4r6vggvOMo5WDgflLngWiJ/B/VDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=zp/qk9b+gAlI9uglZmYGId+sDOzg7rm0wVQoF8IHXmdb/dA37v5yRRpiwwluXpJ70
	 6jLoI2Z/cDNDSMFNVF8XceDWwti2XsxK3FBtndVXBtoDz9bEDgFLblG296pMF9FFab
	 NkHTLO0m44wLRoOq/R++j5wwCzRQ7/sBSXNKobf8KptYj4dnV4Z7JTcoBDXZorD/5d
	 1KKf4v5rGhY+cpcYPYFd/AEojC++wfKfxuZ6yzf0eAl3WrushcOy/p8AbM4vVVJI+O
	 7qyLi5GogdR8FR/XPIkdm73gMwnxY5fYkZTYrOWJ73D0ztXc1HlnpZZL8ZWgVAWJNd
	 pXNK2ssPwP8vg==
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPS id D57693118B10;
	Thu, 10 Apr 2025 13:13:20 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id DC70131189B2;
	Thu, 10 Apr 2025 13:12:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 21:12:11 +0800
Subject: [PATCH 1/2] software node: Add comment for the first ERR_CAST() in
 fwnode_create_software_node()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_swnode-v1-1-081c95cf7cf9@quicinc.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
In-Reply-To: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: i4J2DPP0jL0OOZ85ev1LH7eB3JN1ce_G
X-Proofpoint-ORIG-GUID: i4J2DPP0jL0OOZ85ev1LH7eB3JN1ce_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504100096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

ERR_CAST() is normally used to cast an error-valued pointer type to
another different type, But the first ERR_CAST() is to cast away the
const in fwnode_create_software_node().

Add comment for this unusual ERR_CAST() usage.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/swnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b1726a3515f6fbe13c2186af1f74479263798e42..67040fff99b02c43999b175c2ba7e6d04322a446 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -933,6 +933,7 @@ fwnode_create_software_node(const struct property_entry *properties,
 	struct software_node *node;
 	struct swnode *p;
 
+	/* Only cast away the const by ERR_CAST() */
 	if (IS_ERR(parent))
 		return ERR_CAST(parent);
 

-- 
2.34.1


