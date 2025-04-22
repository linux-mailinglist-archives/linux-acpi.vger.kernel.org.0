Return-Path: <linux-acpi+bounces-13175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74003A963D2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 11:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E923AC2C8
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F482512CD;
	Tue, 22 Apr 2025 09:11:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45D238C2F;
	Tue, 22 Apr 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313070; cv=none; b=NB/4e70bWlCOcvCf5wou8Ec5B9fEHx6h/Cc7NYdVyEhS9XweqZaUgE4gtfbGDSn8dCswrfYSXC7QJ8OJH9coJvnjJYwNTgVBA5mmXIWp0IMp7pEQEGcnvIoQ8zM3lIJsv+jFPKArQlo+2vB2xQ6hCOCrZqyOUEi3gIqDMQX1XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313070; c=relaxed/simple;
	bh=f9deQhR1Q1RCnOm2h2vN8BQsniXjGP3x0y8ywwgWRtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJAhQii1YMkz6PPVHpSGduZMXz5Tknvh/sxsypIlOZMKpObQegvCWswo4fSQ4IdeSFLu+nBpUehTJrfjlcut9ZIhzu5/gpIEOET2rq7MvG38qXG1JM0cWkFGapvlowDMStfgqY6JkjkA50m0Bgt6opnTdTkIgPTJivO8CCQIUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b5c0a77c1f5911f0a216b1d71e6e1362-20250422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:045f0ceb-7dcd-4879-9c5a-e6eb51568785,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:494d66d8953aae14750653e069c5005b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5c0a77c1f5911f0a216b1d71e6e1362-20250422
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1169028749; Tue, 22 Apr 2025 17:11:01 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D5C54E000F3B;
	Tue, 22 Apr 2025 17:11:00 +0800 (CST)
X-ns-mid: postfix-68075D24-730977898
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5BE65E000F3A;
	Tue, 22 Apr 2025 17:11:00 +0800 (CST)
From: zhangzihuan <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangzihuan <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] ACPI: battery: Reduce unnecessary calls to acpi_battery_update()
Date: Tue, 22 Apr 2025 17:10:56 +0800
Message-Id: <20250422091056.972734-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When entering the acpi_mattery_notify function, no matter what the event
is, acpi_mattery_update will definitely be called.
Use the acpi_listen command to listen, sometimes the log looks like this:

battery xxx:00 00000081 00000001
battery xxx:00 00000000 00000001
battery xxx:00 00000080 00000001

Firmware manufacturers will customize some events like 0x0, so
non-matching events will be ignored.
Signed-off-by: zhangzihuan <zhangzihuan@kylinos.cn>
---
 drivers/acpi/battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8af5..9446c57b77e7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1083,7 +1083,8 @@ static void acpi_battery_notify(acpi_handle handle,=
 u32 event, void *data)
 		msleep(battery_notification_delay_ms);
 	if (event =3D=3D ACPI_BATTERY_NOTIFY_INFO)
 		acpi_battery_refresh(battery);
-	acpi_battery_update(battery, false);
+	if (event =3D=3D ACPI_BATTERY_NOTIFY_STATUS)
+		acpi_battery_update(battery, false);
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
 					dev_name(&device->dev), event,
 					acpi_battery_present(battery));
--=20
2.25.1


