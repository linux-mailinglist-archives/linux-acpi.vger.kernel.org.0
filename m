Return-Path: <linux-acpi+bounces-11456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8AA44192
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735BB16F492
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7A26B093;
	Tue, 25 Feb 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yUEHRhis"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CD26B2C6
	for <linux-acpi@vger.kernel.org>; Tue, 25 Feb 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491919; cv=none; b=lFCo+gY2wYvqCrV0jSVTukFczvuDH+UbCNYFvefJXrpZjkFRGcRc8f9B5fzXm5KUuYkbLXRssJcQoxqsWMQSpmaBNzsc6HAsxpFJ08bKWc97hhJTIsaqq6ehH9f0WZpjw0Z8zw0SUvj7J2H1ADdt1UD/9BYUNa9H9J8SZ8spetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491919; c=relaxed/simple;
	bh=I6vIdo5caMDfgodjkmCj0aPi0uiu+W/a0z9fSb5kuUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpog1Q01VRZEzMtorQ9dD+XU6AgzOxyJ002wBr3roCk/jPOr2q7DHCrKwCNYNwSA6/yi73Mzdd39G1uxSxPPGCrkg9MrCAlhUVorBoJc9ov17nr6n+oKLHe6Gpg4XZDOdU56du/O7HBER4ZpNtDGeghUE26vG8NRInA+9pvhy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yUEHRhis; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=U8YUCglIDwUVoRlxt3ZLEgCNvlGpMK2uk9RfQ5HAMgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=yUEHRhishJt/22Ui8i/ValjZ88t8uIgIt5fbv58NR5BsvGbPUMX84Oea4m/qC3wup
	 KsyDp88IM184WepB2U1IgakapXxNegJDmuEsyvj6mkWEBKwK9wMCb2768i6K4NNiT4
	 PMZwZpjtHXlWO8vf5RRev+Y1nONco5jc4iOcBnbUONodCaVZt0Xk4aIiafGZ63HyFZ
	 8lSkwH57eZAEjirQ5XPq0swTphMc553i248nexmSeo3Rfu/W4pLXydEW+HTcgkr0mO
	 aMJUQagJy1CU+VTdwHau/2thxsyeC/u1WzILTXdECFdz+tEy1Oi4erwcOrQjVpmj/C
	 wJC97g6dy3gPA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 7DE73A028B;
	Tue, 25 Feb 2025 13:58:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 25 Feb 2025 21:58:06 +0800
Subject: [PATCH v4 1/2] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-fix_arg_count-v4-1-13cdc519eb31@quicinc.com>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
In-Reply-To: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 96cRp-a3OAKXGHWqE5_OEgQWo7UnDmYz
X-Proofpoint-GUID: 96cRp-a3OAKXGHWqE5_OEgQWo7UnDmYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=940
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250096
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
Will align both macros later to avoid such inconsistency.

Fixes: 3e3119d3088f ("device property: Introduce fwnode_property_get_reference_args")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
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

-- 
2.34.1


