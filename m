Return-Path: <linux-acpi+bounces-8287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5B9788DB
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 21:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75A81C21F46
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 19:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15A13212B;
	Fri, 13 Sep 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="prh0KXo0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic312-20.consmr.mail.sg3.yahoo.com (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5E81ACA
	for <linux-acpi@vger.kernel.org>; Fri, 13 Sep 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255392; cv=none; b=XDw33MlYDtS9eCCPSjZUtQ1sq45BhPg0B7Wxl8XcuMveKMfa06Uu1M5cTFgLl6IRN6BwE6+ujNaSodQtw2OcDFqxVTVb/HmLjoIr0N/IaYeRcD9yvR1pOo0a6b+jGbmuliGJHMzKiyM0tE83BEc+RRyqWGB7/xjZq8OpeiFH+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255392; c=relaxed/simple;
	bh=Yw3776WKS9ia5etI8DbaKho23ePP64KPB8wqyVoPAT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=C9OcXODdfioQ0pEHLYHgX51YCz567Dtm5HmV2n1fEeMxlQrFfFZ5p+rY6B9eL4EZugx/hexez1r4NN6G6yX6OgD9mB7wxwQAtobotvPMcWS4li0ldblw8bX5W1R26tuOmlIjR0Sgv5T0fZY4n4y+dXC6+aU3JLFzOo0q+/pomkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=prh0KXo0; arc=none smtp.client-ip=106.10.244.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726255387; bh=DRskhHXVllGtD1jjaKx3voZH0LlbhZ3PTYPp3M4Mee4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=prh0KXo063tuRUz5U+yPVXjxcFN4EhLycmgr8QDn75xZXNG52SnWD1orhvu8KleatiAKCYHAzKALtCCmfXjAZO7lvPQLrrRnV78T9JzY1I6zdoPScteDIz2xCm8miWzVIT/vzaL0BeTS+EVqfALpqZriLMGhOdHQDkyt9cA0lEBEFXZYUG8yzQLi968mjUs+gBKCgwoL80Gr6CGIGcUJDMIc+cWiftZMaPGfT9/LkY1yu8447gwwuE7fL6uCRskmbYdXFW6bQk5OnkVR/vR+4fLnUWHxR/9Up5pIUX2Wg/jACz5RqYIKAnovJhVS93irlPEBE9lzWeZqKzngNQ9plQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726255387; bh=5k2FfjPvQN17t/rNnjRq8e8aF5XbINC7RQT6dH9QAkv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ej26zaWS3bSawpssLgWX4I2uZ11hajYwwcRv8cREagMUkpLfRsTljcjXGb6aJzIJ2uOx+vdKl9LxkOhPl4WkGVn5a9lIHG8IDTpNHMrx0bk+CoID9fwwHUnF6CczKWs04BxvXFGpRT7ZafUtI+uyElATZdjNx97lhSjv0k1a2evkaA9LGhKvaKrEGm/ZFoQa9vYsue+SL5s75mClkLzR7apvuGJ6Dkz7B4lA2wsFS2ijsZY12rvIGTYUr1XWK3k46fIZAydebxv72+s/Kb0W0VvicsKOL3hvEAVmpuM3Flgr2psbbaIiIoIMJDE8oQXRFAP0oO8l+5KVAvgG4PBZkQ==
X-YMail-OSG: b7v6AUEVM1n8eWHC9tAYUc.EeVkD7o8T5vrLtoJMruikpx.KpMqIcvVUzdvnGZi
 X6sgIeBY2ZTMSj.shEhitbAfXw8lVD0O97RBb6GwXycBsx.WcsgwZHDn88EqpmI_gyESQMGCGqIM
 z2YA7GLXJKF3yJNap6cp3HDLk0WfPHvHpUDSqM20aPRcXBp8AbmVVaVRa4_TbGdUAjA9EyXwD9Ea
 xyKmse1NM83K79BcUZcX10dRmAep0YnxIrnJRsNUTkdJTCN2qDlRt2D44P0vOm8uhw5X8F3uqH.E
 VCyn5ZeWjyIW4XqRtrXcg.3ixZWGvFo7EnvLOxHYVR1.o2HPOKjk4TfRa5p2kFqUzTXdt5Ucb_hS
 q7Ym4IosqM8FPkV5RUWwy76TyS2idTKcFaFMtxWE1cQnSWtabpQyBy2FQXecnIdt2tBr70rkoQZJ
 bpCAhiVx_vuO_CJ3ktE8sciLrJ8czlLQP.mGzhw3c_uKulBmE86_q5aXZ8fskgvgUo1QAE7sesPQ
 IvFEjoEQ0q1rRDxYOqj5LcG508wJvZ7iDmbRKT25o4Y98kHNUSRA_XtGMQaNxARqyW_V13wuBOWg
 GRNg2u4RNF8qD6gmonQaoJfqSrnfoh_LDOQ9JzGdkohDfICUUbOISz8gaQ8eZ28vv4LkV2CX.DGR
 64YxsKjYNQpp8zB.fGnbVC3VQ3JcntdnjzHYFJy5FbBgCKfmtyb1.xuijgEn.8x7AV27zFaSOzlf
 GCQgberL0UpI3PH9qNsdVm6foqCZgCUGj2Lz35DAD0fXnmgwjZEk58QwAn3QE8oAR9vV_FVSRyyC
 0cV1HUcZ4n0m4noE0nEK6GWlGREx.4yqTNLm9I_yqCIDXqqRxp9VWeVbqmuN5EzLdmUraxSeMEBj
 MU8iHi_GDVq8Kt9PdYh_8.u6GU0xyOTuQy4.qc3NfNDD3hTVmnnMNxKv3h2wbTsGXyRNm3VSGI05
 Fz3GPH9iMfyAYaWA51iofih4eM9IoJ.K8y5q.J4_QoEhPCuBBS_oRx_EHEzUz2GlPJqz2D.GvX7H
 C2gSAqh2E6BeLxbIaoxtErv2IhzvmXf0uUFETigUewffRAzPNf9_X3zPA45M3soSJ0NTDgN6hm0c
 lEQPsJX8orNmCEO5vEjZMGlsURGf3bKsWBV8Zd2V5RZqc0PrwZIl9WD6JVFErjRsEYh.dsUaIunj
 tFu5XvdwqFtLR0gnS.KjsC2GCrtInAMTVJ_HRLbvAHrKV5MhvZhEz1LnWjRMKuto2yvzl4i8.9np
 13yR72Q8Dl8HDmqx1Mdo.i5opBN_O.DB1MWikydEpcPbpWA8_s.ZgroW01BoTMrMBKlqDLU5Kx65
 NRJbPSxtvzvzJa5iJctFRbhRALf4E1Fivy8pU8dvjcoUqlHzror_qmvtAAfnii0688aDDusE3vNi
 0fXLgbFeYgvDhMuCiTIcjs_6TmAig6Vq1EulS1SHEJGHwnj.ityXvAUouSrcBdUz9D9ihXWrB21M
 ca.5sfJkewEAFBU8ZTWvHJmVs71WMGWILLSm6KHjVcqWyiEEMBymu9ERx8DkSLpvR0mS4qoICVuK
 dl70fEsghjAigjOrvAz7gs_OApXKULzQvHGGgwojvZ0ZjZyGZh0zGagtUtScvIwz5KJxnAwgcjVR
 rLpPc0u0efTOQc2fvzWIsAPzz7MBl3hT2lCIvHjUR6eG4icG_CxLaQ71YvyQ57A9WXy7XTYjN7jk
 E72Sf8YbcNVYLCxan11lIv7zjiArx07lJc0v98IJlpPz4dRYwfSh4iFmx3HKuHRDd1QJEShykm2Y
 bJLgKGcaI6a_xdHks8hhlTc7Gvh8GKrJwRIoYuoOX6l2jyxhQkWUaqzlqjT3qin_FoO8vzevnVTF
 JSq3P0ftOYF8drahukZPY9Tva400oplwIgws0ZfTbhsF1EErEJXH1QAbke2dSt0h0ZRTypn1PN30
 h0AihJOL6XXZOgeoWIzb6WbjIfi_BgVzzJxcdmbFx.NkwteG6xYW_I9aiA.9hMsIn9oPb6obC.K_
 tqLz4hHMz0Saux1A1AgRndjrJK.MkMMCQWEwVJWOJXCE7_FFda40bnW7Xbhv4PNqxd52ttAQWLHX
 uFZyl2.x_cUS6RXxex5f7WcxeXD_jN9ImY33169pBAuMwMoQQ0t5z_s4QgN3ikGYWsHlRpGKedkO
 58UsikBQi8aiMJIXb0m2Q0ACxl.DU.VkskqwWYueNd.QF4DSWJekJLVJe.GojtDQcWiXI.tw_WkD
 DPqF6CK5T7XHAA15FsdCESXtu.9rEoAvAlPsf5X5uSFOGY62.VDJWTyDnFiMSNA--
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: c3f43d41-eb64-4ccd-82cc-425d2756e797
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Fri, 13 Sep 2024 19:23:07 +0000
Received: by hermes--production-sg3-fc85cddf6-9p6n9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5341d66e59e0ab8320caf088ee6b6923;
          Fri, 13 Sep 2024 19:12:55 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: rafael@kernel.org,
	christophe.jaillet@wanadoo.fr,
	rui.zhang@intel.com,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdul Rahim <abdul.rahim@myyahoo.com>
Subject: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
Date: Sat, 14 Sep 2024 00:42:49 +0530
Message-ID: <20240913191249.51822-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240913191249.51822-1-abdul.rahim.ref@myyahoo.com>

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
index 78db38c7076e..6671537cb4b7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
-	strcpy(tz->name, device->pnp.bus_id);
-	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
+	strscpy(tz->name, device->pnp.bus_id);
+	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
-- 
2.46.0


