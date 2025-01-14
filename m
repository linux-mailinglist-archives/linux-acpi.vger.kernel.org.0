Return-Path: <linux-acpi+bounces-10620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19FA10B7F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D333A5827
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB3172BA9;
	Tue, 14 Jan 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="03EVrNlZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB11ACE12
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869896; cv=none; b=sAbYUlIP4su80lMy/ic7FCpg8PsMqrdbIrUa+UB0IiFHbbidOYb1bWCJ/Wnq9DV+rjfVXyDfuXi5Fr9KvxtyZA01VjuVip24I6zMpmtCXoqbVqVkddkxOs69gligy4F3pD1SuJ1Z5lH25qkprMXSMnMpQin4ym+RpMV0RG28PcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869896; c=relaxed/simple;
	bh=+kVsothwP0Hv3rWPge2YVTwrTovKRH7/82um9mDF/V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DOQLd78BP4EUnshiCToSBTl0KhrLziU0GZKYSBXceW+okq+UQcc6k4wCMgugSH4C4TbpbBsCxnW2YgQKGA4y+1pR4DQaFKtU5e68zjygv+Ok8cQ+EjttjvMJblnfUs34bJEatWTLz7e41tNQUFqFMx7vyx2JW2cLC2MJh3yT82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=03EVrNlZ; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736869894;
	bh=WEqBZbCKGzojkMAFcVFIw+mlBK5Vnc3gqGgEz0WmL30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=03EVrNlZ92/TzPUMZGQSfjOLiAOVuRTOWjn+R51xMCrVLDzkIeJZ1br8G9M6HxI5m
	 /ekWvGNDjC6ZXerQ/X6DcmWA+DpNbBlYAoTLKJ8Poe2JwjA/tThFiWqgiIs/UxglTW
	 wIjr/mi7J2hGZGYGgpZjbT+/+m+ElAEL9tssqwTUtC33kaFs6mS0Pf8rdsoTqsE+9q
	 au4P80/pfp4fVYuiNxGXmc2cX8IbpzUftAwltKHbkG3JrL0sJnrgg/XxwCftCJ4mVl
	 BpgGKx82EAuLomKBAe+YKR9Wki+jWbJaFJcuSWL+rZVnhicQAKu7BlcyEKAHAJ6bao
	 Jg9/UJ5XFknjQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 52D6F80872;
	Tue, 14 Jan 2025 15:51:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 14 Jan 2025 23:51:13 +0800
Subject: [PATCH RFC v2] of: property: Fix potential firmware node
 reference's argument count got out of range
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPCHhmcC/yWNTQ6CMBCFr2JmbU1bIYArExMP4NYQUsoUZmGrL
 RAN4e5OYPn+vrdAwkiY4HJYIOJMiYJnoY8HsIPxPQrqWIOWOpdKZcLRtzGxb2yY/CiKs0ODlXT
 WtsCbd0QubLwnPO43qNkcKI0h/raPWW3RjpOVCI5JERteiTkTheja0hQ6U3lb2utnIkvenmx4Q
 b3u/IjsJhr3k3pd/yB3/SHEAAAA
X-Change-ID: 20250114-fix_arg_count-73feae90fccb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Len Brown <lenb@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Gqvpzp9NeW_cCwbn8eFEN2JE19wjHugz
X-Proofpoint-GUID: Gqvpzp9NeW_cCwbn8eFEN2JE19wjHugz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501140124
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Currently, the following two macros have different values:

// The maximal argument count for firmware node reference
 #define NR_FWNODE_REFERENCE_ARGS	8
// The maximal argument count for OF node reference
 #define MAX_PHANDLE_ARGS 16

But of_fwnode_get_reference_args() directly assigns OF node
reference argument count @of_args.args_count to frimware
@args->nargs, and may cause firmware node reference argument
count @of_args.args_count got out of range, namely, in [9, 16].

Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet OF requirement.

Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
May remove MAX_PHANDLE_ARGS and use NR_FWNODE_REFERENCE_ARGS instead later.
---
Changes in v2:
- Increase macro @NR_FWNODE_REFERENCE_ARGS to align with @MAX_PHANDLE_ARGS.
- Correct fix tag and send as RFC patch.
- Link to v1: https://lore.kernel.org/r/20250109-of_core_fix-v4-7-db8a72415b8c@quicinc.com
---
 include/linux/fwnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0731994b9d7c832cae8a30063f3a64194e4f19aa..6fa0a268d53827a376d7f258c6194a2a088e4325 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -91,7 +91,7 @@ struct fwnode_endpoint {
 #define SWNODE_GRAPH_PORT_NAME_FMT		"port@%u"
 #define SWNODE_GRAPH_ENDPOINT_NAME_FMT		"endpoint@%u"
 
-#define NR_FWNODE_REFERENCE_ARGS	8
+#define NR_FWNODE_REFERENCE_ARGS	16
 
 /**
  * struct fwnode_reference_args - Fwnode reference with additional arguments

---
base-commit: c141ecc3cecd764799e17c8251026336cab86800
change-id: 20250114-fix_arg_count-73feae90fccb

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


