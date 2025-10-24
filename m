Return-Path: <linux-acpi+bounces-18210-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C325C07C90
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A607E34359C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E4534B693;
	Fri, 24 Oct 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Nkt7u74n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB134AAF2;
	Fri, 24 Oct 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331123; cv=none; b=FyBVLz5RVnf/k2H98CIeCY3PK6moJ2Cvm+T9XwuKy9nOyp2CuT5/5Sc/Zx1JbpaYoXzajwJyMG4K9gdK656tynySCZ11UV3TkA37tMpKz7FXHT6SFVqby3USrn/3NMKOgpmrZBw1+j9FL7kMhylfGCF1Q/vnDNRtpTNwmkGZHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331123; c=relaxed/simple;
	bh=WRf9IaXMzh9B/NBHpqw8ys+Klikm9oSunSxLA5Ywa4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FEOPcoeJNg6wtY0OrlCkqJgaUgdMW4+tQTC1Jn/Vbqhe97oU9qDp3OHS85LRoy7MOWh/0/RmJFvzoRZyQm5Qo+mYVIlXzW90qS8mvdNd/b/gr1vioIMqI9ZaqBhM9IiHKaAsi1eCimeteqQNuwniTCiESvNmHLH4wLqOih9HQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Nkt7u74n; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761331114; x=1761935914; i=w_armin@gmx.de;
	bh=psk2uCruRI7GJiVRlYoHrmShQQXO61rViK8tujqWmng=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nkt7u74n+3U6ux2uKrwuul86+8UloNj3B1rxQD41f94pyMCFP18FfVgNUyOI6p8E
	 9sn3S9LexY5S2ub87IaXYm/+Fy7+u8veBGTO8pji9hWa1isDiikOUoBXirASw+h0w
	 e94z4qLtHobuvkq4tXv0pCnPWLLN029lA+563ckGhP6db698JcBUcRboVhvly1i71
	 +W1j1dBMJBYq5ML7KuyctQuVAeph8boaxmqYMvHoZrz/CDm7IUsP0nabz/zLCZYFu
	 H6F/maZTg+qjKwUgbFd4TFOCNwjyIp439d+/ZxyPzeyrCfPsh43AEePJFcoA4MNz3
	 nkhodStdkwdgqB7MZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MHGCu-1uzDWk1QWG-00Ehpi; Fri, 24 Oct 2025 20:38:34 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] ACPI fan _DSM support
Date: Fri, 24 Oct 2025 20:38:21 +0200
Message-Id: <20251024183824.5656-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5tBYZ22jZDoegAUPG/0oC/pGvmqh/ia0GXNLgei9ghBZObxi+U
 9LCTqa6ETlZeFKnJrLonMDtBwOdtzvBI9vHY+EH/NM+f1zQLrrxCIEAtdVX604V8lrs8Vay
 iIGJd9yNu5EjC6rIe36pQ6fE2LOkVz+62oU/v5cMnuXSFdFECvHU52vKiI78CIA9OroQzZS
 uRsa5lDMJDWgX/hMmgZbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u7GHzjbtYK8=;6/jCLxSobzvJtuAMY6TJaEHdNWP
 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

Microsoft has designed a _DSM interface for the ACPI fan device [1]
that allows the OS to set fan speed trip points. The ACPI firmware
will notify the ACPI fan device when said trip points are triggered.

Unfortunately some device manufacturers (like HP) blindly assume that
the OS will use this _DSM interface and thus only update the fan speed
value returned by the _FST control method when sending a notification
to the ACPI fan device. This results in stale fan speed values being
reported by the ACPI fan driver [2].

The first two patches add support for the ACPI fan notifications as
specified in ACPI 11.2.3. The last patch finally adds support for the
Microsoft _DSM interface.

All patches where tested with a custom SSDT [3] and the acpi_call [4]
kernel module and appear to work just fine.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/device-exper=
iences/design-guide
[2] https://github.com/lm-sensors/lm-sensors/issues/506
[3] https://github.com/Wer-Wolf/acpi-fan-ssdt/blob/master/ssdt-dsm.asl
[4] https://github.com/nix-community/acpi_call

Changes since v2:
- drop already merged patches
- add links to the MSFT documentation in patch 3

Changes since v1:
- use acpi_evaluate_dsm_typed() during _DSM initialization
- send ACPI netlink event when after handling a ACPI notification

Armin Wolf (3):
  ACPI: fan: Add basic notification support
  ACPI: fan: Add hwmon notification support
  ACPI: fan: Add support for Microsoft fan extensions

 drivers/acpi/fan.h       |   7 ++
 drivers/acpi/fan_core.c  | 222 ++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/fan_hwmon.c |  15 ++-
 3 files changed, 239 insertions(+), 5 deletions(-)

=2D-=20
2.39.5


