Return-Path: <linux-acpi+bounces-10959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F32FA2F0BC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B83A1169
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856F22E412;
	Mon, 10 Feb 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0Q7wIU3D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321C204876
	for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199667; cv=none; b=aSTBa9Te5AEaNuNVxQBNEa4HAlE3WsOXyN7tKG+ut3nzVBtD14gMt7eI6Aj6OhNV+S3GfLG68L2NtHz2Rx2f1io7TXBKUR0/SN+ISapZKqGv9wMnaqo/nmzolCjDyOt9GkJjTrkUV9+Lk2GSCyPmDEovE758kkQyJRNUk1+DnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199667; c=relaxed/simple;
	bh=fVQe7FtP+OpE2IuHgthL6tJfR3NJCdI4MJHX2aafst8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=es1fnhiI2ekO0i7mp52bM8DtU3HA+HHyDUp4mYVjALBuzopG5xCeasR/tBCt1f7aN49G2bIH5QwjKV4jJtCUZYhIbN79Tn8+M9ztgJE7xm5JQY3GvyL8hikZnNl4vgMJimfIR/04aX0aLmrlmRiWOS9NMTsPLAjdcPK4C4NJ5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0Q7wIU3D; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=11DGxb4a1Y8n3ecmd9h71gvxW+k4Ylr1+01HbNn1NSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=0Q7wIU3DeeVZRHYEVGUD9jXpN/Wsf1vL+mDSInUgDbA/xsw3VSmGLjt7HPkbpFZ9N
	 hUom93oDKKsccv1uDOcSzGlriFD6P3HlvtgH8Hc6bAvF4PphO/rV2+KhfIptkWAYSu
	 HLm7XqktBApg6gOKFXGCF4TbveckTfTZmNfVxJuLVLD6dWd5i/bvm8onXx4hsYYOPj
	 Yv/UcfZraALmMTnmuQmtbgu2gaDFvcpjQkUOQO/Z2WMbBDYILmWO09DIDfWGYcFgMa
	 2RYm/gEg+EHzNi8R/yrM7GbUxDNYpPVvzMLkSyIZUxQMeX7I+/0tUYnoj+O64l98ky
	 zskagxtp9BQTA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 1F6337402CB;
	Mon, 10 Feb 2025 15:00:54 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 10 Feb 2025 23:00:32 +0800
Subject: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI8UqmcC/2WOQQ6CMBREr2K69htaqIAr72EMKeUX/kKqLTQaw
 t0tyELjcibzXmZiHh2hZ6fdxBwG8mT7GNL9julO9S0CNTEzkQiZcJ6BoWelXFtpO/YD5KlBhWV
 itK5ZZO4O42D1Xa4xd+QH616rPvCl3UxJCdZEicMqAhAyyKGpC5WLjMu60OfHSJp6fdD2xhZTE
 F/0348ggAMalUrEo8xF/cvPn2sOY+tp2P7N8xsYcxcJ/wAAAA==
X-Change-ID: 20250114-fix_arg_count-73feae90fccb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Len Brown <lenb@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Xwm3tEk53_pJi1cncIFOCcVY0X0gfQeT
X-Proofpoint-ORIG-GUID: Xwm3tEk53_pJi1cncIFOCcVY0X0gfQeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502100125
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Currently, the following two macros have different values:

// The maximal argument count for firmware node reference
 #define NR_FWNODE_REFERENCE_ARGS	8
// The maximal argument count for DT node reference
 #define MAX_PHANDLE_ARGS 16

It may cause firmware node reference's argument count out of range if
directly assign DT node reference's argument count to firmware's.

drivers/of/property.c:of_fwnode_get_reference_args() is doing the direct
assignment, so may cause firmware's argument count @args->nargs got out
of range, namely, in [9, 16].

Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet DT requirement.

Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
May remove MAX_PHANDLE_ARGS and use NR_FWNODE_REFERENCE_ARGS instead later.
---
Changes in v3:
- Remove RFC, correct title and commit message.
- Link to v2: https://lore.kernel.org/r/20250114-fix_arg_count-v2-1-efa35ee6572b@quicinc.com

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
base-commit: 40fc0083a9dbcf2e81b1506274cb541f84d022ed
change-id: 20250114-fix_arg_count-73feae90fccb

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


