Return-Path: <linux-acpi+bounces-8276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7D97733A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 22:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FD91C240DE
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6781C1AC9;
	Thu, 12 Sep 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="mQcIUfKt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic314-20.consmr.mail.sg3.yahoo.com (sonic314-20.consmr.mail.sg3.yahoo.com [106.10.240.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACB15098A
	for <linux-acpi@vger.kernel.org>; Thu, 12 Sep 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174790; cv=none; b=ZIj9PjEyTSHQwn5gp+OmqPjiGXovorNPwK85HtOe6A9/v2cxY8HMJzZjJJYRj00uii2MGWte0Jm/ta6XCEOyWSwcf80zSQGeKuYrJpo+I+cZyD044LhPzkdlWY+7LfBwNRJF8Oips85ls3rIgS18Rfmf/jfzJGkN3ILYX1ffJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174790; c=relaxed/simple;
	bh=LUsjhXjA8R09WUdrhbG2u2DIfwEBw3KH4drZdVkfRkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=URrzLDW07NkRBZ3FoV5WDndez+QTIrNE6i+ageKvgLtmPYIjYgUI/uyBaU/vNwpZjZUxHgXJMdYCyR9I6MMdwuXEdDFFE+VOfTa/ESZBS4WTbxH6c0YG1b64p/9BOhT5OSPqu78nivPb7Izeu3VOuIpFRpOVW+3mcDQiOA1js9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=mQcIUfKt; arc=none smtp.client-ip=106.10.240.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726174780; bh=94Q9a+075SmQezW4neaY7XefCzLDWbgo6ES4DknRTgA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=mQcIUfKtLrTXePBg+fwavuxMbm3lauqx3nAkvAGaWXIYN8+CJFTsTMs70Mvyw/Az1lSa+NoFh479z64U52SIeZXY7/fRurZ/cJ93erG6A0XCMecHcQzur+QcSWtBG7UGUctVElLVkh3UkBRZhLSjpd/kDbpdvy2mA0pR7Qom4e9BsCMGg6l5pM4PUVj7lL5iznEqz1pggA7AOdbliN2fD2rssL439AbDArqBEaBRdQVOOGE0VBfrzxeC5vFzsXr4SsINphyOn8YhnQuwmK6D8F1u6KJhJtf/qxc9bYvBebt4ZXr7X+qzxfGk9DjTfew0exxVbDOUc1CCbGc+6Q+n4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726174780; bh=NpjoOtpyGcgR8z2Jm7mOj1Ibd+7s4NyyEcaphKJLAD/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JJugJVHzZdpqMuWBHOua1cAcJsMfu9g1T1w4785QT6HHFnTtWIf09mnIRxXhhd4FYVcobPCjSqkYAoe7y0T19y6F2LkYKCbLzwbIUSYO4cXZxUyuZcu1n5AxTg8+fl5silsO7mJypyrftrPSPBenQ0aA9yjHAftBug6CpJ5Fbuj0RlSvZl6VfTOXw8HCmBP0zvdz7t9/t4jPnAfd/LEJEtWK12/l8Gn3UpOqvKXjWVyai+3fBJq2Xl9dIzUPcTTL+9IhZ9F7Sn+nXUephYE4zZIpr4gRBOtionXY1im11HsVcIK08D2WXKBBJmRzypIYxJZVvtOrVB0VoYgtMO2TVg==
X-YMail-OSG: zzC_1M0VM1kYVrKgJ6pn6WQLR4l0YjdLQuA.llo2ktSJIaGxs7Qtn1I5dz5X8lA
 Igc1okPsjV9GAy0q5jTRrI5KKQqKRLGTtAh3tuXaPYj3paCAtlJ_jGrImmbqMfC_usoUP3k62mh3
 KbSZCQN0wU4rM7AIw6e4ldmHdDUHWaTfIKyGr.snZY7Gc7jljwTigMsveLBcKhVuYwkK8YEW.d1y
 rMs8Ic1RyB5p0mPF_hUnvuHPmT.vqb6l3iTYKfH9wI1nlNssqJ2NLKv.4u6nLpVmrlt8ZlDwHyIu
 6HxtvZCpk6QQ272I8fet9skb7Aw1Sj_PG8kC2JUiPj0mOA3vaWLzZZnCUWsqfTWAE1KfvmW4Iyhx
 maNE.RMJshyYizAKAJU4up2abPdbo7zW3yqBR5W7jeqsBALVbCvnwo.uKGFMDLS_zKIelyRDh5OB
 Fnmdw4YWzJMQsWny1uf.9LSXs5dgJV.Hve6oMw5hqO9cRawCJ4ssuOyxdD1PFmOEPgLG0_Y2W6F1
 9nP4PEYivX.lFoqw3qbM35yVNXjhseq0dCJHswZMYQ.w88Q3gtTtG7QhVkEFqcYePGkec_OddOOs
 NU4gXScD2XquHlIn0fM5agM4qMXDhrPv5L8t.rI7r1CKUNL6KcQ1Elu0A8nM0Sx03fcCRDanKpVB
 QcwyA0c3MVzemYI6YdshDtL1c5ufOJBgUygqqDq8Z91_yalLvTqkhAzSAkQ4pTBMotSdS1YYxa84
 jS10LJ1jhV.gGsYFpDcGb2VW3DHq_6oGBvZz3pfkT_6JRPj0O.OQVCrhXSYGU.WMt6GM9CvA7GaM
 nwLCXGPAm.jXqCvITa00WQ6aEptPmjXRuAUe5RLPswdvBTJK6SzpMctqszEtA8rpq64YVILtybMS
 AoGDLHey0841Gdph8So4rhMWF.H6Kszu4YV5h9Z0Us0WmelbsXQJ3tBbYImUSt6Yos73RwNnzyUT
 d6_pGiOw.GjBM.WyjZ30u4kBr.PAaZGXtQAG1.1G1hmukrV5QqW4LD2twvDYyJ2n0SmvHqs4oWHJ
 V_LhV6fNPoM1HS5A7xDd.IU9v3949CVQa0PZD54eQtGXiEbW9RP_2Yhm.YuOB2_4kqLleZnNiA0Y
 vLOWtIFftnY5xXaC8_eGto5odCjo3hCqy3aW6MYSPsIm.xzEj5Lluzc8IVV2bT7zGDa4roQoxHrz
 5cs_KvRUjGt1QPJ7Hy8lofCaIre2bGU1jLrWlwcovNw5ZyVqK1P3euics0ja0YXtP47IRSJF0PXE
 EDcOxKKTey0.e4Ek9McfOhK8zlD3OuAPjQELFk_gvI1rLhyh373BSGM8fhO8.wPc.CHTAhXbLEEo
 iL7xwskvPN6BYv23uC9I6c2wlP4zmgsDr0eBmJB13cvacpThTBEqH9jcmK32OdgpoTOjhn1owTXG
 7T7CtVdU2ckKdC_M_mXbheGtQRukDHjDgx9KDbL1Kktxr.TbBHDxcUVfQOStGlvwDxoOY.aRDOc4
 r8s84cqg9ypLGHS_bGHtuhBgFQdq72urzrEdD7k4qEpL3GS_qCZzLy_bK8j5ADbgsuVgtp7R7mkQ
 59UF7VLKsi_24LfAY08LCue.6EKgk0Pty4Gg0t03sDF2Z030506jpPcyczdpeDHPSe6qt3zAdn5J
 ZgbdlLFWf3Gxi7uSCvdT_jJwmKdvMkFb4X.vblGHJ8O7M0M.UKfd0yq8er1epowjkPb4kyyUUQJW
 Ys1I92CBki3W_8hcn_ti2loV4FVemoO6uyVfBVmykqFU65fMCxBVu17Du6vIYvixT_HGLbl13sEJ
 m748d.K7yGnY5ezI4tFsHDfLtQdR9NvlwIJs.SsL91FmVPEo6MXXSPyKeG5559YQ4eF38WJufCqC
 FhY8RnychLRuFzSuzntNRoO0vuqEbtY_qw78y_Ds.pQGWt2LcD2CvG6DyisoWu2Uyezo1kK14Tkl
 FJ262hts9TGoTX4Y9_v47bEZRc5F0mKV9qV2bAYgowZt5yY0JfteekDfON0EhrXWA52lqPQ1MjgQ
 2I5aZDLFPKkISHmDHwkKntPXEOJrQWaThSYb_qMo6hBfswXNWGDKpU2XgeC5rexoElbLn2LvodDM
 LW.169yZEfqdohs7qViUq9dbyK5kvIPNfyB2GyZZ0hVfqOkLbq7eCq_NR3bIQ2XNlu_aeq.dzsmm
 56boAag3Ou04QPD7lroAjo0t_06jtbE4DU8Ui4WlSXmAZ0TB9m3.rbrCO63mvXrd_i3NvGriu5G_
 VsKuXVWC_ZJerXxaXCM_oJTOfDH1vB4tkpC5VvdzbYUuANxAu2VZ6oWZKogHS
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 537d67d4-8153-420b-bf00-c0f2bfaf22a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Thu, 12 Sep 2024 20:59:40 +0000
Received: by hermes--production-sg3-fc85cddf6-qj99b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 936a2007f212483d89f3628f4710acfa;
          Thu, 12 Sep 2024 20:59:36 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdul Rahim <abdul.rahim@myyahoo.com>
Subject: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
Date: Fri, 13 Sep 2024 02:29:22 +0530
Message-ID: <20240912205922.302036-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240912205922.302036-1-abdul.rahim.ref@myyahoo.com>

thermal: prefer strscpy() over strcpy()

strcpy() is generally considered unsafe and use of strscpy() is
recommended [1]

this fixes checkpatch warning:
	WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 drivers/acpi/thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 78db38c7076e..a35e40976763 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
-	strcpy(tz->name, device->pnp.bus_id);
-	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
+	strscpy(tz->name, device->pnp.bus_id);
+	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME, MAX_ACPI_DEVICE_NAME_LEN);
+	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
-- 
2.43.0


