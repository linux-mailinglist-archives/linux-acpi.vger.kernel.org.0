Return-Path: <linux-acpi+bounces-4551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66281891670
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 11:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980BA1C21C7E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Mar 2024 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997642AAB;
	Fri, 29 Mar 2024 10:03:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505D364BA
	for <linux-acpi@vger.kernel.org>; Fri, 29 Mar 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706584; cv=none; b=lcOZ7G4SLjZUXBl6PEUN9fAcKBrzpyLKv5c1ZKugBEtpc6sDnv3ThFJ3ndf8c49J0psM2xY9dKuTf8yD/vwMERoAOViWQvO7u5DTzzKOiY/0hgIf8RDCBa4VfhhUUKqIFguv7GDbNzkUm5lsWkNjK+LJQM6kfvwQFz9bmvXrekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706584; c=relaxed/simple;
	bh=6TLnavroWbrB3Qh1+d2+jfOC/VLbKDcybOsddoY9FzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoVuNaOXaRdRATfBDRwey+01V94R1258BB5nZ/zsQwmuFq54go60VmhbLiZY8pMZM2ap7ZHMKuN3YKcTj87XvsOGK2TiLdZLUJ2TFrt9QKVixDClbmH8ez0YhjCjsJVLAZQAQ1H5m4kI9TG5ftGzjoHJkFwn9C3J9W+wvdSYjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq949-0007zJ-HQ; Fri, 29 Mar 2024 11:02:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq946-009ARY-6v; Fri, 29 Mar 2024 11:02:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq946-00DOvt-0M;
	Fri, 29 Mar 2024 11:02:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Avadhut Naik <Avadhut.Naik@amd.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] ACPI: APEI: EINJ: mark remove callback as __exit
Date: Fri, 29 Mar 2024 11:02:01 +0100
Message-ID: <20240329100203.540368-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6TLnavroWbrB3Qh1+d2+jfOC/VLbKDcybOsddoY9FzI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBpGbsiabw4Kd/zrgrrZgh7H6dXAZb4CzxQxBC NjggBuhh7WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgaRmwAKCRCPgPtYfRL+ Th+lCACkeA6OTIwkIJBUMfdgaUud/OhUZTLiGmA5974fG1Zmh3MrbJTD3BhutqEzsyLj79zIRN5 vx+k8cqh6NA2o2qnG2Qo2DDWThJff4O8oL3talc1sNOVK7dfyP5QSVpqj9kmzw61c1z76Znydvk FqTbDRfdC+r0gxgl5LnJK1pfo9qXjl0kKnpaYoQ2hK06p0mwUU/8L08R01qh9fd0+8wTRRwgvgh tUnmSdLdt3gSIEY6FOt5W3F8rKoy9KP8Yv4iJZteB77hzALT60yt2UM1M33ogO9nlIi2/KnSpvK 9emPqyAzgVgeo323v6KqZcV+4LHxsRKsVf/oSOStEyG+exM2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

The einj_driver driver is registered using platform_driver_probe(). In
this case it cannot get unbound via sysfs and it's ok to put the remove
callback into an exit section. To prevent the modpost warning about
einj_driver referencing .exit.text, mark the driver struct with
__refdata and explain the situation in a comment.

This is an improvement over commit a24118a8a687 ("ACPI: APEI: EINJ: mark
remove callback as non-__exit") which recently addressed the same issue,
but picked a less optimal variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/apei/einj-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 01faca3a238a..9515bcfe5e97 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -851,7 +851,7 @@ static int __init einj_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static void einj_remove(struct platform_device *pdev)
+static void __exit einj_remove(struct platform_device *pdev)
 {
 	struct apei_exec_context ctx;
 
@@ -873,8 +873,14 @@ static void einj_remove(struct platform_device *pdev)
 }
 
 static struct platform_device *einj_dev;
-static struct platform_driver einj_driver = {
-	.remove_new = einj_remove,
+/*
+ * einj_remove() lives in .exit.text. For drivers registered via
+ * platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver einj_driver __refdata = {
+	.remove_new = __exit_p(einj_remove),
 	.driver = {
 		.name = "acpi-einj",
 	},
-- 
2.43.0


