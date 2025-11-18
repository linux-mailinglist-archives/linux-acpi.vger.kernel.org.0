Return-Path: <linux-acpi+bounces-19017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF3C69D32
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67C7D4EB73D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49C35BDC6;
	Tue, 18 Nov 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="w3Zcc6iS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC235E555;
	Tue, 18 Nov 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474377; cv=none; b=eOJIClS1F+c6NbFTGlk+JJMcVTW2HNa/lwSMUdTLDKrAh+rBwW+SD2RQH6k4kh2bVkgQaK63meyv6z0JK5S3WlXM6qNtx0ObvngWqlohureKEnJWdQl0L0adw2UKRDsmFgP9pnkgGvIoRTaaiZrRqGVDoMT1plUcKSvHDykdgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474377; c=relaxed/simple;
	bh=pwiu8ziI2sxSfx9nVda/sNhp3sjtaPc2HGq0sUEUZtA=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=PxdF4t3dBHZlBzz8j4vBgl7UEY7nNK8Tq8CSWUOXSMeIHdRndLmg+EyBF3zyk+zgKVRu3WvO0855MIZ2TAY8gub8ghGjr0M6AzwKnPJl+QMyPKLhdfHN08Lh0WNwnLK9vgOdcCSXT7KXjck4qFMydR8TkQRZ6siQ8HNURzYspkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=w3Zcc6iS; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=B+sV8SHTPYN9GYYkMBbr3NNK6Q6vIAndWnIvW/p3Mus=; b=w
	3Zcc6iSl/Smnq2B+WddA2iWVZ8gKQ2RanEv0z4cSk4Jv73csH5rxbIarTHAUY9wMlxmw5zt7PIPxs
	DyDqtTY6CR+FSiZZHtXEIvIpgMHQLt/PusC3XL75b5k7uzu5Mgmf1K90OwiBa22Ma8ZtGi2+5uk3g
	CKDoN+rS0KklfJ052DE1/EG+xvY16qnDN3Zc3lsQfH5/PH7V2f+rhr/CUxw4yZsegVzk+KmqvG8il
	XQ1wXVT4hIu2j6bl+luLPYjA+x9hztNjT6oRLEp2RSYCj8EfPlQALAMIWgVlSgs3BZ1vE2iFSjFzO
	t7JEmDsWIxMgOUes3SiOdcxUHxrcwH92w==;
Date: Tue, 18 Nov 2025 14:59:42 +0100 (CET)
Message-Id: <20251118.145942.1445519082574147037.rene@exactco.de>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] PNP: Fix ISAPNP to generetae uevent to auto-load modules
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Currently ISAPNP devices do not generate an uevent for udev to
auto-load the driver modules for Creative SoundBlaster or Gravis
UltraSound to just work.

Signed-off-by: René Rebe <rene@exactco.de>
---
Tested for a while in T2/Linux already.
---
 drivers/pnp/driver.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 7de7aabb275e..05e9840bc3d4 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -150,6 +150,24 @@ static void pnp_device_shutdown(struct device *dev)
 		drv->shutdown(pnp_dev);
 }
 
+static int pnp_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct pnp_id *pos;
+	const struct pnp_dev *pnp_dev = to_pnp_dev(dev);
+
+	if (!dev)
+		return -ENODEV;
+
+	pos = pnp_dev->id;
+	while (pos) {
+		if (add_uevent_var(env, "MODALIAS=pnp:d%s", pos->id))
+			return -ENOMEM;
+		pos = pos->next;
+	}
+
+	return 0;
+}
+
 static int pnp_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	struct pnp_dev *pnp_dev = to_pnp_dev(dev);
@@ -259,6 +277,7 @@ static const struct dev_pm_ops pnp_bus_dev_pm_ops = {
 const struct bus_type pnp_bus_type = {
 	.name    = "pnp",
 	.match   = pnp_bus_match,
+	.uevent  = pnp_uevent,
 	.probe   = pnp_device_probe,
 	.remove  = pnp_device_remove,
 	.shutdown = pnp_device_shutdown,
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

