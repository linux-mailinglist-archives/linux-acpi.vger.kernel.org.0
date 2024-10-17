Return-Path: <linux-acpi+bounces-8841-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F091D9A20CA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB7B23C1B
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DF1DC1A4;
	Thu, 17 Oct 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="hA98FVAK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9D1DB928;
	Thu, 17 Oct 2024 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163823; cv=none; b=COh27maJOfH4H4VCazN8fEdCofeua/pT41hbjDwFnJ2/XY9Fo/Iw+hent9Iv0cn4HNsF/FBxGZuwfK9fFz2DAgWSCoXiE15yPbz+l2G0eGs1qJ/hsIYp8I/ZjEgRVW0qsCv1N0SZ/AqXRPm4AjUQi4E/4evfi9q5TBkRArMTnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163823; c=relaxed/simple;
	bh=0yaoLxJbOxWyLtPANIsfLD1xW9iR9qHzQjahbw5tjtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p00S3wqxVzzcI1U3ok6/HInYVje5U/qMcX2m7vqVtrOhunK9Lm9mj9fdXtB4UnpD3uoVlAk6ij/Mev7tFDq0Um6wRuu0u0zMM1CpZmlHNqVZfAnke3nGsx2c2myXq5rVj7JSMHt/NjjDN+MniC1+8f0ZfMTcCUQLqxTQqvxKNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=hA98FVAK; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1729163799; x=1729768599; i=christian@heusel.eu;
	bh=b4RFWUlG95a7zzsAjfo+11QIK8fFjg8ifanQBIduRjQ=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hA98FVAKBN3Gp4rtXfiKutwYuROAFoZhenm3pOZp7g8uPq/60MBBFw9a+tpoi0Uu
	 5ujSstECBlp0bV2rIjsDoFJQSS6/UbQdexJUt4aJoLA89jmyR4iqi+9g9XnjLlgpM
	 OL8I19n8SGQ4RsO4rmrV2YZNYnSI2VYlxIV3moK/tYU4aepU06VRR7qb+/irZdy8K
	 6yrCdS2L1sNEPOKWFTdQERBfBsrwhWV5Jrj80b/5xmp7aDztmbd27L7davE/Ig5/a
	 XNOd8DMuCpGxuWkuPpjpW4Cb2zaD+WhG/Y9urd0XkjNuIsr5iDxNmg+vLNUWX0Sfn
	 K/4nt0f8lIp5+Kva5A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.localdomain ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFJfN-1t8E7r3Ak5-009h76; Thu, 17 Oct 2024 13:16:39 +0200
From: Christian Heusel <christian@heusel.eu>
Date: Thu, 17 Oct 2024 13:16:26 +0200
Subject: [PATCH v2] ACPI: resource: Add LG 16T90SP to
 irq1_level_low_skip_override[]
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241017-lg-gram-pro-keyboard-v2-1-7c8fbf6ff718@heusel.eu>
X-B4-Tracking: v=1; b=H4sIAAnyEGcC/4WNQQ6CMBBFr0Jm7ZhOISiuuIdhUWRoG5GSqRAJ4
 e5WLuDyveS/v0Fk8Rzhlm0gvPjow5hAnzJ4ODNaRt8lBq10QYpKHCxaMS+cJOCT1zYY6bAyVXd
 tK2PK4gJpOgn3/nNk701i5+M7yHq8LPSzf4ILIWFe5KoknZPSfe14jjyceYZm3/cvcqF/a7gAA
 AA=
X-Change-ID: 20241016-lg-gram-pro-keyboard-9a9d8b9aa647
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dirk Holten <dirk.holten@gmx.de>, stable@vger.kernel.org, 
 Christian Heusel <christian@heusel.eu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=christian@heusel.eu;
 h=from:subject:message-id; bh=rZN8elJMVtQyGlS6orsu87BDGXA7zxYzT7zBW/Dz9VQ=;
 b=owEBbQKS/ZANAwAIAcBH1PMotSWFAcsmYgBnEPIV+QDlBBuBK4fORkG9/uE4mHysS8/bIBjmB
 d+PUI+otx2JAjMEAAEIAB0WIQRvd5reJHprig9yzBPAR9TzKLUlhQUCZxDyFQAKCRDAR9TzKLUl
 hYXqEAC/trxyBAnvxmYa+r6axrbmcXsknvXkyUOsRMrdMzx8WPR+q7bqzoI0L64pKgpPnEtZd6f
 EH9kUdFcNcSqCYgKWU+/XQMQmipsCN/cklG9bk65zlzRmoLITUDshrJSQA+IHWRKyB+e7bbRbXt
 yNmA3eAKU5AUZoyBlXZJJ8x1D+szcxeRM/yhBJ44vjTObRS39SKtYyw6CeK9BS5T9T9oCvhDqYQ
 OMAzVKx3dLP05yuBEqVdJl5iJsIjqEFmP3AZBffDtU48E+SwyPSe9zkOR5vDrKIFRolzxrk8UVo
 n9jF8RZ+whFkbnG5LwuTWSt39ge8IUOkjOULmDknds79KEX4J1KCLQsSPsa4siKnBesFEaKeOgF
 cjkRnqHZzYCRWH+IX1LW6OlBEcY/QQNx8jaQXZh5v9mD1/UELn5zaEkS0ip8NbkRwE8teewytRW
 gkniwd3yO+Jo6xa4/v0xLqd4NFuloGJQfpOgEzZzV6AbN8FspxjkWhRpobDs+tOHwYw38IEWYJi
 HqVoQCY/90vhpvQcG0hSzMj0EyW5nMYz2s+jQKPs22YnZli5zGExXbYnAUZvHb+OKEtS0X16Laz
 C7bSb6dbmgQjCba61bTnhNkiIFNhEoTuAt4KH+9cGISrBt0e2G7WcCWNbKFmi5GyQIFpH/Qkgor
 XQnPhq+eK8nf85Q==
X-Developer-Key: i=christian@heusel.eu; a=openpgp;
 fpr=6F779ADE247A6B8A0F72CC13C047D4F328B52585
X-Provags-ID: V03:K1:8m5gqzHmb8w/7qAya6krWjEb94H5jQZUUaEuDTdlJugTx5FSnDf
 vNyMgYADKegCEh3K76sgbqezR5VHAA7Sjbbq60fiy9B/iS0KmBlQ3j3+Q/g278M70y/pNrg
 FcqD7F0i90vrLV16//nVbLynn7zZv9NfVu6IKQ4sdT55GaOCj2S36Xex866byvv9ZORWggS
 v8GyC2i7FdluZBQ/Fq0ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:36TsXbwSJXw=;xmDtvzDO4PqqmMpo7yFIQUWFmSa
 6p87oVTMLhjmCS7KbFKgAT7BsWomWma0b7l7bP1MWh2spVa4dC+67Dn0n57CARrlyFz0cbatG
 2Hv0TFVFvs+lrEl8V06O2XzMSc8fNG9cVz220iCE4apyBwdsYe+WIO+tZC/NzUyktDRqz3Itx
 9+hzHmyRKdWBycZKHM9pOkUO5d7ZfmuW9eKhC4yyBvhnU6DxYM/XxkKv+8acNyS7vs0soiVA8
 lWAR4h5Om/sBXCAu26AziGB1EBxPG7x80nJObHe7M2uEmrYChtA/MOy1YEIYj1WjR1uXSgaqA
 4NhNpgUIbQDyfMsGW2M6PLu4lzhAET6MWIikXuE62aAhKpUF3+XfungWhCcmQr4iF1Q5FZFXo
 BaI8lRVjc9fW4tWyImLDNU+Cb/PojXCsqqGzkq62dD1ZqigP80mI0Hw76Pb0n3niFunZeDHeA
 nqZCEvffvrhFhKY1sIhh/YS7GxHhMRFc74detyMWrCPjzWQ8IvfFzTPIW9/cUequ2NOSxUtqy
 JE45neqJG/bBQ38fqHWuCJ1isseHH3bc2ROGoI/rPVfJoKtM/PQbYFAfORD20tGsR/+uDbDzz
 EMDJ/kXdzz9jI15fQL4Y3UDuCntyU3xScOn02aYt4OkT8FX3xKOlWSd+VftaxXHp04vl7QDel
 WoUKbQAVIRc0YTkLDgx3iRz/zGFWA/yJbxoCM7OpyPw+bA/JtC28HJfOcJ3x4GS+6pLFMc492
 9nyK0ce5Qbvxz8LRbfZpGrILV6+U7neeA==

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
=2D--
Changes in v2:
- fix the double initialization warning reported by the kernel test
  robot, which accidentially overwrote another quirk
- Link to v1: https://lore.kernel.org/r/20241016-lg-gram-pro-keyboard-v1-1=
-34306123102f@heusel.eu
=2D--
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 129bceb1f4a27df93439bcefdb27fd9c91258028..7fe842dae1ec05ce6726af2ae4=
fcc8eff3698dcb 100644
=2D-- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_skip=
_override[] =3D {
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
 		},
 	},
+	{
+		/* LG Electronics 16T90SP */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "16T90SP"),
+		},
+	},
 	{ }
 };


=2D--
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241016-lg-gram-pro-keyboard-9a9d8b9aa647

Best regards,
=2D-
Christian Heusel <christian@heusel.eu>


