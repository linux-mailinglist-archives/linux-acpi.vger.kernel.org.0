Return-Path: <linux-acpi+bounces-853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6687D410F
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A805128136B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA512B78
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="migciIyc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9051CF86
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 19:33:28 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864F94
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 12:33:26 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
	by smtp.orange.fr with ESMTPSA
	id v0fzqGEQclciav0fzqWHCB; Mon, 23 Oct 2023 21:33:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698089604;
	bh=MlLlyO5nmPmV+Of5dabISHH05s0yAgNbg1lqfnhBiDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=migciIycEHHxVSLdlbD0OWW2VjQcd388g4a4U6rPubKQtgb7HRtjFpJ689ZOdUYfJ
	 M4DjVn6rYm2JxOdyf/1Iv8L43HNqSsvwlKONI+C/7GXglHEqf3PJXDuA3QavdkyrQe
	 p0Ub2Cah2/euUBdqZnOBr/06U7KJDK+7wDHYJSYKqMN/EVMycRrdJPzEBvRfg6sLz0
	 ToJ4IBNGuk04t0PpFcPhck9S0I+d+73KNfWr+J7PcswUyNqVpMLLYXM5F9DJ9f2cL/
	 ud6XVZF0TjAnFY3ldTZLfVSVJjXUzRrKUTjGqr+mM6UaMwgZKN2dc0NXOComv7RoB8
	 kDofSZJzzAWWg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 21:33:24 +0200
X-ME-IP: 141.170.221.62
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in create_of_modalias()
Date: Mon, 23 Oct 2023 21:33:16 +0200
Message-Id: <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remaining size of the buffer used by snprintf() is not updated after
the first write, so subsequent write in the 'for' loop a few lines below
can write some data past the end of the 'modalias' buffer.

Correctly update the remaining size.

Note that this pattern is already correctly written in
create_pnp_modalias().

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 4deb36dccb73..7ec3142f3eda 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -215,6 +215,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 	if (len >= size)
 		return -ENOMEM;
 
+	size -= len;
+
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
 		nval = of_compatible->package.count;
-- 
2.32.0


