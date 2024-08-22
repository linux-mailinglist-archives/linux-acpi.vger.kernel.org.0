Return-Path: <linux-acpi+bounces-7790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0595BD81
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AE31C22F77
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3701D04A1;
	Thu, 22 Aug 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jgq3bykE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E61CFEC1;
	Thu, 22 Aug 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348345; cv=none; b=bAuWSk625thx3vSwpgi53Ov3cmjKbm0CwJJhB3cRkLy01BjAR3u+7/zMgiiUl4oSCd5LU++tnnQs8YNDTaMo+BBAZc7oaGiLfBwJ1Mom50/KFi1WTZacANnmDfb4//mj3Pfo/nORqA883aHEdnWfVzgjMtf03GqJgGQFmJ/WWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348345; c=relaxed/simple;
	bh=aLRBxg9o/yW/gnTo+4DGF+WN5uvzAM4YVy9Ll5L3diY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBDFmUGLpP6/8sZYJYMbzj+4ULycYHJKkSD61gUZ2I096Z8a9lvXGexQP53qtLpJEhadv7FZ/UFnUXnCGYl/wQlkswEPF8tdd/3+Mr8pxUZYI0N/7YkVZ4W5pMlWREkG4BWaTjp7wb2KbONklqH0xyIRoK05/bFTTSfuTjpj/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jgq3bykE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348328; x=1724953128; i=w_armin@gmx.de;
	bh=HZH34bEBWlECtrEyEvw7QJJLZAR8h5MgcQYgkL9ydUw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Jgq3bykERWn1YjJPUDHi1Lsd/baR4sidlKyMJ/bCNjxH82FX4HJFyODeKzIROFV0
	 b4MTj/wcCtgYjqOmLRCrF0LgJwgQ/qIOayUH0DaFXxe4n0X3CyNrWruBJflbiLI9w
	 wiBLuVtNWyDsjL1FJUbA2yE0gRR4jd0I+fMn3PU+8obGmlx4mqw1whSHO/FYtDoEK
	 umNvgRm2CgihhDzie0wSRam32jFRzBpPzj3Nynt/A526AAIh5gRHT7g3guSlNVz0J
	 SVdr87iebBaEHnffMTXiHwRdbgXg0PwIAqAxYRjLk/vNGo9DnPFy5VrOqjkFFE1X8
	 e2iJgWHTlcAfMCmF2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbirE-1s8gEQ2KHm-00cP0F; Thu, 22 Aug 2024 19:38:48 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: wmi: Call both legacy and WMI driver notify handlers
Date: Thu, 22 Aug 2024 19:38:10 +0200
Message-Id: <20240822173810.11090-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
References: <20240822173810.11090-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDipBvfTGNVeeZOaR1S4jNMHIrRiufY8GfCw0i127xvQJ0w3fMD
 ZGXZCDkqLGcFzdEsSFacxryvgnqzLgvgFdiouWsa9KRgk8jaZ6XPtxMO53rZo+3tysKzdiE
 Kr8lZmMiNR5KnNactGWgNZvBRiaQoW4UFksUi3aXaEi06LgdAndRqDolTOdfTU0oenw2P8U
 Eh16ZMFoQejWq8aoXyXqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b4JDTVPIRoE=;2eionCkk0qauEx+jTUfW5w2gyht
 UIUXJq7eSuONwX+oMvDRxKVEBMGQZ0Lt+11RjYFj39lXgU9rVFWzNIE6rFi/noiVdCQbFOsEx
 Q484DWC9TMlDGE1gh6EKzYuaoxy3eS0SJ45G28gEbuumGCL2gci9XhUQZwOAoQUBq5PvTEMkE
 7niFw48CFV4Mns9IzyGOl9jQu/DBblRk2OjBfoXiG4MGJJ9QYueDHZ/HpjtOpUR3Rnkj9je23
 6875vUcZbHIOZ/x05NR3D4cgYAZ8A4Ow/QQSg4CnT1TVPwZ414Jjqk+E/oLLJayom22VGOr0u
 vvXEnqvoxfhj4uZQWREqQYSjMzMtP1bjbMq+GXoPH3TNQx8x8US+zwbvzuTmSBAOUMJpAUNjL
 63/jL8Joc6HVhi6E9So2Fx3YswRRoyvRjpPSAQsipLJxjlSI0F2Tuw4xbQNc5oUHZmGhjoUB/
 L3XreYGKleYbNdoudvTtYDAfTazCnH5sTGaSOISaRZdu78gbc/Ero0P9yVD3dqeZ3aIGHlakM
 TRT9od1xdfNIHPpCIHhqF3o1goohMayS9IZgH5BSrKWEISh7sNtCCinZDohJy6eIYrqAUReSj
 qvky1aul2s14MZXwp44WNWOlv5YWSEQeM1TjQfiQdEjJrieLohdGNok8cnXccVFp2IUUVYN5U
 7KHsVGRnCbpfJvvWPlP+xLDgjVTZ/Efd5Jv25gsZhOM24cSxQ22S8TUm01OcRozCu80Q0fOcp
 IZ6PeC8/8ogxP5RUenyf2YfP/pAH2KTzIN2ViIjQ7T0jqPkndUQ9xWw/KnknOF4Oa610es2kW
 Rt9yd5DBiHjGK+mdFfoRuxvQ==

Since the legacy WMI notify handlers are now using the WMI event data
provided by the WMI driver core, they can coexist with modern WMI
driver notify handlers.

Remove the precedence of WMI driver notify handlers and call both
when receiving an event.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6b27833ba5d9..3cbe180c3fc0 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1175,15 +1175,13 @@ static int wmi_notify_device(struct device *dev, v=
oid *data)
 	}

 	down_read(&wblock->notify_lock);
-	/* The WMI driver notify handler conflicts with the legacy WMI handler.
-	 * Because of this the WMI driver notify handler takes precedence.
-	 */
-	if (wblock->dev.dev.driver && wblock->driver_ready) {
+
+	if (wblock->dev.dev.driver && wblock->driver_ready)
 		wmi_notify_driver(wblock, obj);
-	} else {
-		if (wblock->handler)
-			wblock->handler(obj, wblock->handler_data);
-	}
+
+	if (wblock->handler)
+		wblock->handler(obj, wblock->handler_data);
+
 	up_read(&wblock->notify_lock);

 	kfree(obj);
=2D-
2.39.2


