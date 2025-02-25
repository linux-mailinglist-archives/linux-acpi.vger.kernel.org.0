Return-Path: <linux-acpi+bounces-11457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB39A441B3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6DD19C2283
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AEB26D5B9;
	Tue, 25 Feb 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KjjU/zZs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2026D5A4
	for <linux-acpi@vger.kernel.org>; Tue, 25 Feb 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491926; cv=none; b=ZIsJHKEXHUMcItqV9acOQhSgYq3V+Kby6Lun1W5O/5E6oRzRGTE5b9xSfQ01BSPFF7US4VyeK7s8725NoIygo3tzXFJrlvsczLQPIgFxJvIUafGpwND7CQ+2c/T354yJzq+M3yg5WhX0ClOdZEaYxCa31U8Bx+lBQYvqAS/IjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491926; c=relaxed/simple;
	bh=lYnh9cag/qdmM0gRcOPI0rbUoImfpNYAtw0yMy4YEgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3wGvZYos7GCLHtUbu+cCchiML3O/WqvQ0mvMeY6fL55RW0NDGLqnFZvImgNsJuPUdAZQKg6JNll3SlPLxRGBItv+PBu+2lEjR20WaHbovn5slwmRjzledM8KxCVJXz3P/jKVZ/dcMca/q4DSFW6cZwMm7Y5w3amdVehPnSTegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KjjU/zZs; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=vI5r59d5YOmMKHKn/SFWGb6d4OFsSfcWTw3AWHhptzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=KjjU/zZsITzDja+TG09Iv8mEj5bnPJZTjqjwBDoEzu5Bk8b1cbV0JnJ27WhbDnLlX
	 uuPKJbOVzH0PcN82b2YojCL56LnS0rMpfCQKiyAZEDAlPkDARmaYE66O5FQUYQjcXI
	 oCyIvxtGeR/bbVEESKmHt0S5399LIIOk+kcgBGjEaM6msOldaW3Bt49pRfV9iCH2rP
	 NEgn7WMVAEC/ijjsyoHQyWzzGtA33y2JmsmtH82m5ULam0J4kfspj6voMRNMaWr7VQ
	 puI+JFfOnq5rMAVb8fnVLuC22A63i+SULo0N/k0f5JostjgRRWHq8p0vZwhnnIDLAV
	 vhNtuUKhEPOQg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id C6538A0311;
	Tue, 25 Feb 2025 13:58:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 25 Feb 2025 21:58:07 +0800
Subject: [PATCH v4 2/2] of: Align macro MAX_PHANDLE_ARGS with
 NR_FWNODE_REFERENCE_ARGS
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4LxbNFqmX_nUJGaZLdx3hkpv0c4zmcDs
X-Proofpoint-GUID: 4LxbNFqmX_nUJGaZLdx3hkpv0c4zmcDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=737
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Macro NR_FWNODE_REFERENCE_ARGS defines the maximal argument count
for firmware node reference, and MAX_PHANDLE_ARGS defines the maximal
argument count for DT node reference, both have the same value now.

To void argument count inconsistency between firmware and DT, simply
align both macros by '#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS'.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index eaf0e2a2b75cbe4769a77f68965298c84d57e62c..86bf8f0731112456b3efc2e5ee00e73000c6af56 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -67,7 +67,7 @@ struct device_node {
 #endif
 };
 
-#define MAX_PHANDLE_ARGS 16
+#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS
 struct of_phandle_args {
 	struct device_node *np;
 	int args_count;

-- 
2.34.1


