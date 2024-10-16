Return-Path: <linux-acpi+bounces-8820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D879A0D2B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE31B26137
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65D20C012;
	Wed, 16 Oct 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="eqz+ZzEe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EF20C030;
	Wed, 16 Oct 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090041; cv=none; b=VVrrLpntXRxnULnq8PikCAI2scC2fXgZxX70Fr6p/FcQpFQHGDBZUFCj5Zs7ihw6MUEVZlP4pjBPmUy5MjP11YZ5ibm6IWmBrG6maUe/fV4MJucZVGBmyIv72j28xpOGmKGJuFyWsVhziqAdUOfKAKUuWlnayz0E6O1q5JS+bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090041; c=relaxed/simple;
	bh=e+TIRciza/vvufbwrNW5J03twMSw4vY0BZ4AxLju8EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c6tedjcQOahJshbbMkWoKAHdohdnW9YFjNc42WUGl+VVGt04hsS9BX2+vtuVfj5hdV2FDKIQT/Fgll5b4GsJFY2AYN7bHDEhmsngukEMFASQGWQYv9sDxw7dCmU8b9iWfyAOTxvxYUsfUibtLju38LIjmtsy5H2p4oY4B78JJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=eqz+ZzEe; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1729090031; x=1729694831; i=christian@heusel.eu;
	bh=hjnT9M4mEwhQcX6HN2oREWy4Xe5jdIaWnGiY896x81k=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eqz+ZzEeah6q2ZR+Zuvouq3dXYdS/UXzyVccb06xRwZKu9G0T3GNQg9W1DA7Geh4
	 hKwElefB3HPQcPe+buMcN6y5gJ4ikSamB1ClXWXnGGDVs8ETyJmY092/nhTNxeKU0
	 n6h7VScVQNqtcSBzh7VFcXolkmq3vuRhJFUCs2UDCL02Utp/CDJy3sV4JqCI2d5fY
	 H0AdQocSZKLX+rDFiZNZHdr2cD7VfrKF8snfVzI981mzuxj3SBQdO4G42dEIEwERG
	 TKhwt6b+QFCd91YflMkN8WgODIyiecrAZUM6pRdWHkAoz0omWeZCsBj+b6BodtYOW
	 H+vz/1LqQJHmSdAu+Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mnq0K-1tkcVb2WHi-00nqvu; Wed, 16 Oct 2024 16:41:41 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Wed, 16 Oct 2024 16:41:27 +0200
Subject: [PATCH] ACPI: resource: Add LG 16T90SP to
 irq1_level_low_skip_override[]
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241016-lg-gram-pro-keyboard-v1-1-34306123102f@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAJbQD2cC/x3MQQqEMAxA0atI1gasiFqvIi6ijTU4YyUFUcS7W
 1y+xf83RFbhCF12g/IhUcKWYPIMpoU2zyguGcqirExhavx59Ep/3DXgytcYSB1asq4dLVFdNZD
 SXXmW89v2w/O8MOqaRmYAAAA=
X-Change-ID: 20241016-lg-gram-pro-keyboard-9a9d8b9aa647
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dirk Holten <dirk.holten@gmx.de>, stable@vger.kernel.org, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=christian@heusel.eu;
 h=from:subject:message-id; bh=CSPiURth0ATt48Q8xTO87pn/66S/ELojo8qP5nvbFFU=;
 b=owEBbQKS/ZANAwAIAcBH1PMotSWFAcsmYgBnD9ClZkJ7s6RmWtZl1ofj7hD8Pr2TvjbTnPD0u
 aT4RHwRhO2JAjMEAAEIAB0WIQRvd5reJHprig9yzBPAR9TzKLUlhQUCZw/QpQAKCRDAR9TzKLUl
 hewrEACvguxZXxIFb1IfOcbjzJ0YxfkwzJB5Llg+tMmYn/sv2TfXc0iyoUu24AS8j9m5B68L4Wk
 bXzkBwlx/gsONGhUgZn7dJ6vrSNInIJaI60f/2Rx0cl5Andemm97aRu0QbWUs8cegID/NREvde1
 cQ2KdCkPV3iBfaSPmBWOjRhJqn5rVeMOTTXri0fVVDR4R1qmNYYOX3tZxr4GcQ2ch+8TsSSkVbj
 8eJ0cv7DUYzR+nA/hXw45wd1eg7wbbIsIKhShJ/94pL1bnZfSJsZOWLkfto5sIghWyBmy1Ehy7a
 NJKf5lU5Vp3zHRcyWTYFgI3E995SjyYVoyHm+c3LeZyEAd+0HVybEq92U4AnJg9dea2+XTiUzHU
 5elBxrc5616qfQNz0HSzsu4H8WeGqTbngyJmvstuvW3k42pgUvfhcuSe3XklhCfPRhhRygsIawC
 XA6kPFjK1oWVHDbvLhSQWIwTiBo4tyf0fDVMdjaiHT2vsbcGE+Q7qOEFs7mgUekfayHqfVI+/GQ
 HZPQTKpwBPBZ0XgFN2hZfbFGE4QPTJ8tX4MnBD+lOTG+6NfbWgTYXsZKtWNFPNI2LHS0X7Bt/ld
 f75SOm2QfboIkv0l8DvuKMGYshkP9Mnl+EI2+D+QuB7nt4yWTPzQLD09gyJwqZBdGR9jr6PJPEb
 MdhhEifijWH8dTg==
X-Developer-Key: i=christian@heusel.eu; a=openpgp;
 fpr=6F779ADE247A6B8A0F72CC13C047D4F328B52585
X-Provags-ID: V03:K1:MJM/TLh4Ctyc8wpwKqDucvI2zOXawtRtTOlJ77LFKB6sHy/kl19
 BfN0pTfwDQnpa3Icx0eBeJCRu0ROHuNuv9N0ObH9yOCQO8ph6LSOHxvJPdhp+uLxGI6/Klg
 qmCfTNBDWVMxghpN5qNrxuJV55eOHQoozIeHzuoNWS81HcaYIryMuuHH1i8QrkA1ZEa0mCB
 OMPqQYLEoM3kVZ5iZwLTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/2GXG50CAgg=;bQdeS8ufVytJk4SLtXIMDdx0H0Y
 qdEGfoXCIghtSoF0IRJ4Z/FlVaTxp+gLTcMGlEoH8MPkA25HV7TOuUYDcA3okYgoExN4K+UAx
 qkuQndo/e9hyN0/hEwuD1EMJrr0N7NRlPVOUuEKnzlPreZEfCtwDnh6a1Qp86eJFy1RvPZDca
 EKJG//i4IUk8c1RCRfX+mqsUAZC8v6CpluI6+fIiocXFWs+pMprwlW4OTRcZUHXp7fzwpPVGP
 SXCztAbJ0jQatfKeM2Y8E3R5YI5sqBugEir6p/i1IM+v34f4pt1CMjIv0ItmFUgy/tT+ZtKas
 ovp71IiR77P4p5an74yxNQ9yfuv+8f1044KXfrxc/qMFtGZDaXrLnegDNX4e+KQFAl39Vmrry
 JzvPM6XXLcV6QEhTzc5ioRJ5BvrnTiW8kPB1uRacEnm7Dt4NW7evZ+4MsKi/0rQFLm4LgBXYo
 TZAOOckTPOOBqjG925bUt5lcfw/qgck2BzvBWDE2LRl9KHNekvPINMwg2EaAmyK0RIwWUaHiv
 vK75bRYggZtA87ad6TgQeEFnKkawixmR8V01CkBgd3ip8LTdfKouS8Qr7+Wy7WY+t34vOsuCM
 5/IorfgK9twBlpJZIyj5J+IhbIMik6oguHF2GgKIgJbjpiDuR2AWsK1oe0F/7jbUzkBemRxhS
 FPmIvzLk6EVjAziNADYJWkCbjOOJMJ0ZudZ7pglFkI7+nu6xBSBK65/4YMOTl+03ziT4FHHBG
 r8+ljvoXdlUwmJcucleL3RwFsbNzl3PWg==

The LG Gram Pro 16 2-in-1 (2024) the 16T90SP has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the 16T90SP to the irq1_level_low_skip_override[] quirk table to fix
this.

Reported-by: Dirk Holten <dirk.holten@gmx.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219382
Cc: stable@vger.kernel.org
Suggested-by: Dirk Holten <dirk.holten@gmx.de>
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
Note that I do not have the relevant hardware since I'm sending in this
quirk at the request of someone else.

Also does this change need a "Fixes: ..." tag?
=2D--
 drivers/acpi/resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 129bceb1f4a27df93439bcefdb27fd9c91258028..dd6249fb76c24f08db4149883b=
e4548130d0ef1e 100644
=2D-- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -502,6 +502,11 @@ static const struct dmi_system_id irq1_level_low_skip=
_override[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
 		},
+		/* LG Electronics 16T90SP */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
+		},
 	},
 	{ }
 };

=2D--
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241016-lg-gram-pro-keyboard-9a9d8b9aa647

Best regards,
=2D-
Christian Heusel <christian@heusel.eu>


