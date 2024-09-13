Return-Path: <linux-acpi+bounces-8290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FB978A79
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 23:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893FDB2452D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA97154445;
	Fri, 13 Sep 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="gmU668Pk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic312-20.consmr.mail.sg3.yahoo.com (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4CB1474B2
	for <linux-acpi@vger.kernel.org>; Fri, 13 Sep 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261991; cv=none; b=ePG7hzyRzAdqgAbqNJbJSiBNTSgxyaylqKGj4M3KfL6stuO54Y1D0S4+/qxa9FkNCC6JNIMpn6h71821IhrkmSZN3HzmNMr8uLG0XsVSx018MGpw0IbLj9xUBTCVbmVFhyH34ZXkmMLpH7c0ut31T5QTCkvtqKR53koGdBZsX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261991; c=relaxed/simple;
	bh=2so5/dlwuaehvsB5jpWp6d3aG+AwuUtDaEHHBeVGxAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=SVrp0olMg4EFvXXKWokVlChvHbHgG34UHiZAs22cZQnQtesxNXQQyBq7NRq1yykqVMwhMs7xou9Y6wczQmuqo8v5dPZxAVKtL03pTdMafY2MaHeAHTVGxYCJowsimKyUsUSWDPrQ4Wz2ydgPoPXKTaezk6v9B4P8eeUwJj7240Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=gmU668Pk; arc=none smtp.client-ip=106.10.244.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726261986; bh=1EOOzYwmZxr/eQ2GSdm3AxrZXyHasBU1ASee1LLS1z8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=gmU668Pk7heU4Ay546tEJndsAjm1g2g510fpEdLaVszKJi2kPZT76q7EuBG/D2aT76kHqL37t7wfsBgIWm0h7H/zEp9fTv5ua5pyX9C35Gda/CdHG26waR8qCuY6sJDdOD8hGSvVawu86OjwCbLH51R08hD72v3SvHf0U330Y5h9cddKpfhitLPTpiT/hOMk/g0gVUSLJxKdv16QpWyk9cTnZGSxQLmQfiVMPkNRaIDBk4+/vjIQUCy1528tyVP9wCONgDAAcVNNLD42gaNKrQFbax5IwJdjo7btaikfoQnQAy6UuWKnl4TKLOBRuGdi1inT0cP/yobb7KFz4sBTBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726261986; bh=WPq+O9N+spu+46Ch4h7/bdNUPibvIhat5Hb58x0IMf4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Mevs2nx9JFtqcPfZTYGFPrWru8zN+ZAj8h2wMoJZ9GL61AuYLbJhrn71OBEZJrkPH3+24WhotAQkBBrF5K+98bJkMA36SxTlJRBzF62yHnJc8sXY4xzKw1vlyDUAjoqE/p/VDdquznEocruJeIM5Ujtvt1tls+It1SAQllfxcLsQMU86rqCdKWmukVu4s35FyDR0i1t7FNFuvJiwD7vo1V6SqRzf2ReTEVt8hRqlw+rbTnYaMNzM4XNDkhby6wi0DIfMABvMv6Xg/diYAbazWd+PBuQYlJIfOLgLUTlyvpWeAKdaa8HfgG8xby0cNnwZ3bLKwUrmvAyXtg0JE/hX0Q==
X-YMail-OSG: 2NFnT6MVM1m8Lzd75MTmvh3WPZAb2ySByuOuLgDmrej3Dp_76pihgdEgSl3jGu4
 ISBOoPW_QbridWJcF49gM7gjZphiXwssyZO3o.sM45MzucpoeGGSFOS10c2A1w9bwa1foVWLoSfG
 uOHWrMhlikXQfMCBUA0P8XZaYkkAdbgApeVS.Ebbfcwm7CpuTPW7Upel5h0TI.1kEAX9jSW7wBq4
 1p98In4T_hn08ErFozbqmlgCddKjD_5NptFI5tOkkCai3MW8OUKW24vAbh3O_Dek8.wmYTK7awYa
 WIs.PCDhJFJxzjUQJGfundBXj7LlUsjnG0uhZ7_7PgOz3gsPnzc5PoDNzEvbmj6fCbrXW4D7EO4y
 C2yk8QplLIY1OBgx5rScF7xs3VOr4s3DrRaJtyo2BY_XA7To6esciLmLa_O6SFq5OWqertKLNduz
 scnbdHDfd8C4Z1v1AtJGmzz_anhj3kALW.SH.dX38lcEx1czoWzqcXmQCqX5k8W9eyNsJHd5R1UW
 dDH591blNv3YGHMyXrTpjzyUb3ZTMMNF6elTJ2jS..yGCGqge1nEGg8ddY0M.ULZKmWshFU8kz7k
 gmnjO9FDzeaoASoVfrOQFApKb.m_2uBjj1jJPRbKYwKXH2XQEUo6sWkIqxhnIOH2ypMSZpFionB4
 g75VLdMd3UwRX0S3mPkhg_1XPtdDhj4RZ8PdzaRk8ntvV5NqnyUz.xZqY3XAIP1ACnP4GQYCbE4x
 ClWTUsaGdfH3sjLKyv64aqpjVyRTI9WduReqd64K6ZTm5DJeFAaarIjzRHNyrhMhZVp9HhuGyPFW
 aLMO1KN4VrZsBc7O1JwtB7uhuPVvoTNmSQQNH8v1Y0D4cR2U6zGI.dt4dlUyjP3_0cOF8fWLZjen
 2j2.gjktSoXWKP3X7e78m8ZJYKyWDtHXMDANBWvpjbESVqJ2BNR5N9iG8WiyG4bQpXYzEe.oklA7
 SgMbUqzjMm9c_psaN8BWyhEKkR5_llSqiFO13M02NJfIK3xfcZqCIpHTI3IoWj2krU9QwkjNrJ86
 GIfCuJVTmXrBZRtgfjaWYhvHkDpnIhQgF33_ifIoAjMx8VmKvqN4c5TLfykSZw0RFbTucV33bYfZ
 YvUTrtNedmf9YN_it.TVUu8ToX.VcsP049fbM34fzEX26ocZv79PKEU.Krj.914ahFvPWQyGsEaL
 UIDkmwARa6uD7IyeosVxOVxv9Smcz.2xk4czG_Cy0pDAzypQf8UNgxO.DE0vu3Olfml.DVJY7D_M
 _9U_8KeoKi79EzR2LOJO7M6rYdtXepU8XyJRMDs0r9M3BcNku4cVMxXsaYfMMlhWRDie7hcjCcHS
 cDGu5eGzzEvF45kSeQEO_YynJ1.xYjcCypykSYNmUbHYB2VYA6vdKDXWB4Z4eRks605vaEK167xg
 fi26Sn7WqCN0CCJ0Mby5b5r80hcjuKhzQ5u0zfiUjIxLqnsLVGCByQ9i3.JZjz9taK0Iz3Gj.uFF
 9MU1ocSwnGt3WLsQRbKdbycMfDtC0sAEMuITg2KYWKAuZerGCrJyaSGC1RsYCKjOLzE32cFVcin8
 UJAG6Qi4m5E5gEKswlM1Vunj_mTmovhajDxnN4ja9dyo2FexQXHs_69w5E5GUAXi62BfvqO3yL2q
 oeWpw7hWp60r6x8wcXWlQYyRWBjAC4Fv3JMbveGTZ8ZVNFIvkY1u1IfIZ3w6WPXmAggGlJGaM9eD
 lTToZeyFus8xS1wyqKXN_y4aZLQKYZl_XJT4bsZnIVBqT_7VZ3WxDXo0ymRWV1WZHA_mDOaXsYb0
 nS5bestOydYrfHp_s6LxfHdTnEKtxj4i9XhZvTjZwNTQY8FzbborVk3LVo0Gmk84kiVXYCkFC0PJ
 xnCBJ9CUFu0KaUTd4yDyQw6br.h1du_b6MIhm.NYTZepXeu4IXsipd2Ue1MaInJoJ5s534caK2hI
 kJ2SKubfzLuM5By5WWAIAbstWgnOpjUihZFTMPhw.3e2R3lA4oyZkpK.xm_DQPZYmxQicmWOvBAM
 EzBmu5_PiBYkPl2bdo_fTw1gQ2CFK9WD_acdu7Pw7K_mvbdnP2uPxiVktITSJVwz2HsDuF5v6sAK
 0G.mmqse1L_Ap5jd3sOm3UuPGGoRXPj8MVpcH22pGnK469lX3xUGhF72Z8Sz_ODXUsFNHHcDyOwS
 3UjuaJlygrFQwOzWK1hVbPhWjm2685XiUKtUuiBHfYrAtJRibTLF_gT.xMrf7fkf7ZCMha35WDQW
 rt3KUK0ieE.4mQme1yhV3jqYz3lmsSJIa_rGnjO_KFvZeMlW.hVOrnhrs9tMZ
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 800d228a-dc28-4feb-b880-57b6f9c12796
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Fri, 13 Sep 2024 21:13:06 +0000
Received: by hermes--production-sg3-fc85cddf6-kdpzj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9bebe123c7193dfe864d6d02fc719e39;
          Fri, 13 Sep 2024 21:13:05 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: rafael@kernel.org,
	rui.zhang@intel.com,
	lenb@kernel.org,
	christophe.jaillet@wanadoo.fr
Cc: Abdul Rahim <abdul.rahim@myyahoo.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: thermal: Use strscpy() instead of strcpy()
Date: Sat, 14 Sep 2024 02:41:35 +0530
Message-ID: <20240913211156.103864-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240913211156.103864-1-abdul.rahim.ref@myyahoo.com>

strcpy() is generally considered unsafe and use of strscpy() is
recommended [1]

this fixes checkpatch warning:
	WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---

Changes in v2:

    - Remove an unneeded extra parameter (MAX_ACPI_DEVICE_NAME_LEN) in
      the 2nd strscpy() call

v1:
https://lore.kernel.org/all/20240912205922.302036-1-abdul.rahim@myyahoo.com/

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


