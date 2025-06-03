Return-Path: <linux-acpi+bounces-14082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9781ACC664
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F05188AC8F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4A15573F;
	Tue,  3 Jun 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="K/xGcdWJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E791E86E;
	Tue,  3 Jun 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953414; cv=none; b=STG9Vx113itm2e5Lx/1vbbjrnG0i8Y24SUzCWWjRgYkR4vwUhYF3fcuCpK44/WyKJ14hsPdG7GPNsgNbiXSXdEcVpKL4Lizm6M1aMiegLijAtJpvB7nTr4tb33r3nGL1QFZUG9G0aG9ELhSkdK8Bme3+tIREnuH3NYcf4BfiR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953414; c=relaxed/simple;
	bh=OEK/f5CaiNyz/xBuv7aXXmmL7lR6fhPK/6FW1pebLD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRbniHx/tBmgf+0ZaHxWVdNYV/zDdBM/+ATGTJLNINkQNejC65Z1qmfri0AKSkjRxSBYAsUzHX6lrneVtfQPSa44KC/ggNNKoB9tGlt4ShFKBUOoTxNoPnYXWB7GdKeIpVaK/WsbM7UWRRU9XNkqLp2ymrYcW3W4zkZEHOJknuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=K/xGcdWJ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1748953391;
	bh=TsmZxwNJubi/l+jWw99A1gx9yAKtIS3NFyNUO+RUoRY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=K/xGcdWJDTz7iLo++wJ5XLW0SlsezN723IiILkBxO8/AX0OzuiW97FQso1zkjZKQs
	 9I1lxuvDMDK03ouMlYeBpCfaowwtUOQFDFOIA1yh+JUGFHwT3jOIhpuOqmFppUy0RS
	 73Prqna51spqey+KTJr0r4Fa4POkGheVT0tyXdY8=
X-QQ-mid: esmtpgz16t1748953352td528b7f0
X-QQ-Originating-IP: zpN3+3M470aN4tNXJoS4ynIC7LHmh4K27nTY8IT6MbY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Jun 2025 20:22:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16096456668742914142
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: rafael@kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] ACPI: resource: Use IRQ override on MACHENIKE 16P
Date: Tue,  3 Jun 2025 20:20:59 +0800
Message-Id: <20250603122059.1072790-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NOIkHYnr7Vzd+aCjip4r30sFNVwkqJJHJg4RriXDVhdHi7wVBPTvT2dH
	2e0Lj7SvPr812hK2E0v0PL5xqabDRO5IYLIJBnkXkPhxk/sWCSHnV5P82QBI/DSFFZGFWru
	YJgMj/vk42hsdBqhxDtd/PuaZZb3DooAl5GWbAvG1FJSw4XpACe+dRgSAJ8HOgZKEwZqvqK
	wEwEhr0pn1EX4PxmmNd85e1qOiUaP+/X+RCorG+lub8O888uIg2KIhdEnqzSG+zxKD0xLEA
	Ae/SVLkFFGaNXzQYhYNGrR5a6oUEqz8EdAjjbhuuXObyl1edOEvkSvsWV6X/CfQZbZyDOi5
	2AB3f8RQUF3upeqWzwAj3/4azdAsuKa1tzCMXLdbdaCry6zyrYiohyr1bibSZOt7IFRqtRI
	3xUEFaaJRVmWY3RGQYdA1JSapgCV0vo+RbIzO8xlm0t0wwjcpKQaO1+qFEgG5NFxufXOQgh
	gEUfN2Ogm9i9910YZ9n8FVGIKS795LKmk25cJrVkgEV38BvLjkz7u4cNKgc0zu666R5OKp/
	iLtRPhAOll0GuP7FO1r0kzcOVYytfqkt4khFAQBX5z2BK9aXdp6Lp1qsa2S5bNCu0xeBF/n
	LoS3mC577GKT3wVeq4eOIMP00rIHSCPRPlSbjh+rwnGzmZ4wribx81p3rGb2cPgNszrot9N
	BgZAaxCkXqSZeWK7KfC6HNd+apulAL8sSLkGRajDsWKS5XQ+1g/09gTlMviENbqU6cssJq0
	pxE0z31756JsFI3jhpa47FHVr7ZoVIGccNwvak+uM+6QSFYvQ9KGNwYlJ61OV0uSBw0g4QR
	UOJ0Va8ih7jOCc2bBC24KWqYoozJfX76At0thHXVpC08Ms+tFUSxzeDZW02niG3S+34v+8G
	mGh9RGTIKRgZ24+XjGe3Gq1qzH/yv9O5zZMx5VQQ932DoQwHt7Dh3jZmEbwMxe0uYg9tB8T
	dBODgunVhQwo9HLr8hjfUN+Zxi2JQIhC6whrC3BfJgsNheGBOvXHhIRRHeP9uEQl9e6yX+T
	+d4QeQb5AybKTZ48yTYc7d4TLzZlYUFXm6ZNJAyHPO09geVassbqe1ff32xcsI8f+LoEU+t
	w==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Use ACPI IRQ override on MACHENIKE laptop to make the internal
keyboard work.

Add a new entry to the irq1_edge_low_force_override structure, similar
to the existing ones.

Link: https://bbs.deepin.org.cn/zh/post/287628
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 531684a69c645..e12a318b38bec 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -653,6 +653,13 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/* MACHENIKE L16P/L16P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MACHENIKE"),
+			DMI_MATCH(DMI_BOARD_NAME, "L16P"),
+		},
+	},
 	{
 		/*
 		 * TongFang GM5HG0A in case of the SKIKK Vanaheim relabel the
-- 
2.20.1


