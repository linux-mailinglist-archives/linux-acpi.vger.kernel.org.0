Return-Path: <linux-acpi+bounces-5951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFD8CC830
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 23:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C31F22011
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 21:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826D146A8F;
	Wed, 22 May 2024 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cstvXarK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFD7FBCF;
	Wed, 22 May 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413823; cv=none; b=jDD3j+zre+cWQJlFPWPe4FQoFSoVmCWbuYaMB0cw8PZh99j1L61FV3Bic2huuGnEG3t8cXiiZwqpfopJxQ13VmlwJhv42msBexAIC1ux5n7/zvsyNTaboDfHz2Due8q+/NSLVliNsg0sd2clc2vH1XPAcHrAuHxpFt7hMb1tUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413823; c=relaxed/simple;
	bh=+aI/IRjah/lsTblI2//u7vmxvM6d/MYv/JtHH8kkYvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouN9okYpFx+4F6IKUa3PXNtkTHfdcw2kr2Jc4VFnL4HWxqMkGPGCQhc77tzWHCDknLJ5wB8XpncKwbSMUtNq8+H0faRXGIBCB7IpmIcyVAHO0Mf/Nq3cxSPtrChQPKa/7wT4zk4is5CcoJv5vKkF817tzHFEDycT8V9drn/iDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cstvXarK; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716413815; x=1717018615; i=w_armin@gmx.de;
	bh=2D8nAm4MctRuFF1pGWD5+lc7xhTXQPBA8z6v1wGk//c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cstvXarKTVlJPquh8eOTr/XZCVDVA97gOjpAmwi6EJgDakeIVSfuvKnHvLNx98oW
	 8OO3FPYYv2ihkLyvG4Jt2e86x1kGc6zuHPuMzZ2lTHh6r8TxJt2XPK8Te/nMXl0rn
	 nWPD3RFxbz6ecrO6atwCrLrNpDaVG/Q+b4+3o6mQ+vIJbXlSz5pjYLqURAToDvbm6
	 EWUo6/njgl2s9tdy/1kWpHWabMUtCVAKZ2Y/yev6E07mdKgF4NGCNiPKWRJiNsPtw
	 mnjfYUZ5IKVvE7wKYroXiikRjC2DQ+M8vdX4Uq5T2w1r5cEv+QQRx1iWwNtoEMTjO
	 uAWodBGLJK71jck/1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M4axq-1s8FDF2XAc-0034QO; Wed, 22 May 2024 23:36:55 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: EC: Avoid returning AE_OK upon unknown error
Date: Wed, 22 May 2024 23:36:49 +0200
Message-Id: <20240522213649.2860-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522213649.2860-1-W_Armin@gmx.de>
References: <20240522213649.2860-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oS/SFcZwqPRcZmsAO7DxxSBH3yt6wc74l/TbPeiaibL7fPURIn/
 ACDwX0Wvug8VXeNOxHuSBh1rEEdW7ZnPjjSwck4NBn+mROV47gjN/XDbjLhVFQfhjZ1rU34
 AxAbG3qw3krjUa2rgtFIJVSy6FE88XU3J1kcKj/nBOtGnpiEwBn+OLw9TaxVFQKoRhxRiDo
 fz5f+6jPh6to1+LLYWx0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uoA38NJva0I=;uO5++yFAdl61e8qKV386s3mNyA5
 gNpU0FHkt+//OyPa6y+x9ONAPQCYduKSHwbc0LJtB9QslJZj96e7OzI4u839YMkgIEfwHvINu
 UQfqPNHpkxthwDvhrDW+QfPrU5f7FA6hU3rCERHTnTO2qj7DMcFk+tIOYcViUjDj+rdKVG0+6
 qv3+KkDtte7XNU8CUsrc0nMQejf6NOdIZ9j22BaWKF+s5byuTtR9hzdcMjtRg4tBBpRli4TjB
 w+YE8Hvkaxch+IwHmJUi5swRFXNo6FdtqLITjCr0rruZtw4IMtJ2aILnUGAUpv12nnHnjh+V/
 HBAONo0xTQnryXeBXNEku9+X/IGzGk2T69OfhhtPDAhs/w6PLTK135OgHG9ARQhTPE70+1op6
 MazIhprkZ15TUJ5ymix0EbWhRESL70l/2sziuDV3E1tH68SFjsJOc4dJvx8YNQtrMmP4qYdHZ
 qsPvCIz5xOiM8C3qgbn1uJpQtHjKnFleM29/ylLdsBFthNBsX0AWL7aPfo4RQ4ZY+t3Mdfu+E
 oLhmdaJFpehOW5hdRRrF/Q4tQkzUM0g9hJNSLVAgb/2r1vuKPh106eihBNt6r4PuanrHuD4S4
 EX+Ee4cttQFtc4i7OkYtKCJAbH/SUUbIIWEXefQhQNwe78e3VfBmBEXzWm/BBTO916SbSuBZz
 J2M+ZyOyLDx2txkn+r/5KSOy9azA+tyjiaZc1/EfTsSq1AIEOWNzBOgobYixGC0CsPIOS/QjK
 W067iA2O2gc+0kuBfwZxTlfOu6ktVpbXwUGxpgCwXjRs+cTM+AUvXD7nFqM/M7UWY5CBcXkTx
 vI7Gw6lh5cZmDtXhP2NpceYutCArLchIDIgYpeimL5Zck=

If an error code other than EINVAL, ENODEV or ETIME is returned
by acpi_ec_read()/acpi_ec_write(), then AE_OK is wrongly returned.

Fix this by only returning AE_OK if the return code is 0, and
return AE_ERROR otherwise.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a68dce2147a4..68dd17f96f63 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1351,8 +1351,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_a=
ddress address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }

=2D-
2.39.2


