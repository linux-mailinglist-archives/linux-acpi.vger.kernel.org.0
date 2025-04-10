Return-Path: <linux-acpi+bounces-12944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA56A84455
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB57A91E4
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750202836A5;
	Thu, 10 Apr 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dgtkAHbX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1911372
	for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290761; cv=none; b=hwDM22ZQF0QuVsNhsuhFkG+rz6xmchn+Lgc0SXlCDS2XlotbQ7VUdYn3Noyq+TKHOQilSt+2JemZJvTydHMAPU9nLUuIg+a/c9fmXT+jDacm/jFR4i+TLZIli0bbRAcmAEDHDXpxGro5kbGbl+SK1s2CZBUj8Ff6Gp6/3ubddac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290761; c=relaxed/simple;
	bh=NA5G4ydnWAWqc3QEFJTbXFnSVWsn4IihhOrceoILLlU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qHhP5yWMdxgbahatbH8dMoOg0hMQStdjkJn5LPwfaN5Bkle958LgfMTIR+k7/BKfS2QmiY5R3D1jk2PwVDHIR9ND8W1GlhxS4FazDgxRh2UmtNlmREKWoEStmiuePqxJ+qYSyoQaRlQiVrsZwtirgcCIvXKBkbHPUBa3508/uN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dgtkAHbX; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=3GZWjv30uaC5+ExIu1t4hgMEc2szLbjnqqNMWecvZMc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=dgtkAHbXO3Pa+1iOIronGEAlLQHGl+Fjtn4erHlmF70h8xiNA3Tin6jVxydqeKldo
	 hMNQOjt0qjj4oYHC26N40yXbQLdoyZfjR4REHWxXpFCn2Lej4li9kX0hlrdjPPvYLC
	 OqWdfZJcPC5kT8qeQsusmFy3noxhvXJ9owZoJlmoX0t+63A4vGi1MUGHcg4wPfsV4m
	 uPmy8xhkzh/jzfk5Im05F0ifaP+shHmOmq2kWXLSTd5F8raF9oZN2EDv14aDyQcXd8
	 yXKMCRSLX0oRykcPEy4+62aJ/HJMDR998ruKKn/35WTeXB0eg2CytMFbnq7a3S6RcU
	 WgWKDsoJ0WkoQ==
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPS id 78BF531189D0;
	Thu, 10 Apr 2025 13:12:36 +0000 (UTC)
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 019CE31188DA;
	Thu, 10 Apr 2025 13:12:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/2] software node: bug fixes
Date: Thu, 10 Apr 2025 21:12:10 +0800
Message-Id: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrD92cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0MD3bTMivji8rz8lFRdE0sLs7Q0wyRjU2MTJaCGgqJUoCzYsOjY2lo
 ALEV0flwAAAA=
X-Change-ID: 20250410-fix_swnode-4986ff1b3534
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Uwh1wSVS1TFfNgXuATiLwO0rAJhu-Xpd
X-Proofpoint-GUID: Uwh1wSVS1TFfNgXuATiLwO0rAJhu-Xpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=719
 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2504100095
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      software node: Add comment for the first ERR_CAST() in fwnode_create_software_node()
      software node: Correct a OOB check in software_node_get_reference_args()

 drivers/base/swnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-fix_swnode-4986ff1b3534

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


