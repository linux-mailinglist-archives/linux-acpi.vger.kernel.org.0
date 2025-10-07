Return-Path: <linux-acpi+bounces-17650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D904BC2F89
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A674E3840
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A925A2A2;
	Tue,  7 Oct 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XK2TCWx5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7A189B80;
	Tue,  7 Oct 2025 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880521; cv=none; b=nkk1CTwiEPIEaf45A4K/FarK9LHQZySkFI8YmI+4y39GCirGtGtmfOPer5yixDL0QwXBB+ssYRb24pHsZiUzSfBj1XXFZYh7B2RCjgsjXP5+vB1r6lvwdYS4k+dnqgaQPV0AZSw6huLne6YhxSMIVl/07CxpI17jBzjXjCLag8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880521; c=relaxed/simple;
	bh=qHe/ybm8eOSN8pdCnXvghde6o5cfP+zFF6gwiwuEGzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiXdawzvU/bz0e3hdJb9sgFdD9cEX83cQDt0hmn+7eRoIgkPGOslgWG7s1hUDbp8SyHsWq9bwcTuY3ymTOBl8a5IanWMLoeveBCCj3WM+xl9oJA2+1pEO+FDzHS9TksgEmZi1oEgG7DBbJXkiwFJTiZBU6nhkQ+Naf0DWesRygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XK2TCWx5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880516; x=1760485316; i=w_armin@gmx.de;
	bh=KsiNFzuS5joNiJf9B6Ji3rZJuEOjSGwAfMiaRgnWbGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XK2TCWx5UovTmYXSv9o3RTUJJ29UuilFxR/KGAsN0KtHLeud5mo7176ldiZdCirn
	 VZG+SocFTXyfqDrVfCPilOkGnLWD3PNafJMCS7xmjePjnbNjAxKZb73GBBPc+dAMe
	 ZRM9aPBEksnONK9XImtZ112GMGTgZzjZ7/+V1yiciDOxb2OnPh1LjYkq3sS8rQ6c/
	 J5XoxInn4ufKSb2GIw69iK63Ng51q8QqhnszfXQ94yUTVcuGyfwfWWOENAGxWorm0
	 43h5nqtd74wWIxSd1LAcEjFkkqmfM1Z36M/oBg4Qxyq7y/zIxmp7BEwCZa0PDx8hQ
	 3GAISRIkE30UCnvriw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGQjH-1v2gpN2JX3-00CJKQ; Wed, 08 Oct 2025 01:41:56 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] ACPI fan _DSM support
Date: Wed,  8 Oct 2025 01:41:43 +0200
Message-Id: <20251007234149.2769-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B6sF6lVUB3DVzPV0pt/TSjjiw7mRD6qxzlkalgni3/bMBqhdTfX
 QoRaEfAU3cqD1KrTlfx/k6b0G8OuFKqpbxD3nhyLZyyNzJnvc0EIR2JDWOr8pN18VuA14vH
 mfeR0NaFbAyFmUHxdqu+KscNEi4SwUX0JHvILIYtoao+ZoBlT5U7esQYvePl2g/ZbLKiubq
 Mgj9Jb2BbeUkD5qxDQMeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XEp4FTFZvzc=;MUSyYtxcFvnIKVO8NRgdBj2rd00
 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

Microsoft has designed a _DSM interface for the ACPI fan device [1]
that allows the OS to set fan speed trip points. The ACPI firmware
will notify the ACPI fan device when said trip points are triggered.

Unfortunately some device manufacturers (like HP) blindly assume that
the OS will use this _DSM interface and thus only update the fan speed
value returned by the _FST control method when sending a notification
to the ACPI fan device. This results in stale fan speed values being
reported by the ACPI fan driver [2].

The first patch performs a simple cleanup in order to reduce the usage
of the acpi_device struct. The second patch fixes an issue with some
64-bit ACPI implementations where an invalid value was reported
instead of the standard ACPI placeholder value (0xFFFFFFFF). The third
patch fixes an unrelated issue inside the hwmon support code while the
next two patches add support for the ACPI fan notifications as
specified in ACPI 11.2.3. The last patch finally adds support for the
Microsoft _DSM interface.

All patches where tested with a custom SSDT [3] and the acpi_call [4]
kernel module and appear to work just fine.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/device-exper=
iences/design-guide
[2] https://github.com/lm-sensors/lm-sensors/issues/506
[3] https://github.com/Wer-Wolf/acpi-fan-ssdt/blob/master/ssdt-dsm.asl
[4] https://github.com/nix-community/acpi_call

Changes since v1:
- use acpi_evaluate_dsm_typed() during _DSM initialization
- send ACPI netlink event when after handling a ACPI notification

Armin Wolf (6):
  ACPI: fan: Use ACPI handle when retrieving _FST
  ACPI: fan: Workaround for 64-bit firmware bug
  ACPI: fan: Use platform device for devres-related actions
  ACPI: fan: Add basic notification support
  ACPI: fan: Add hwmon notification support
  ACPI: fan: Add support for Microsoft fan extensions

 drivers/acpi/fan.h       |  47 +++++++-
 drivers/acpi/fan_attr.c  |   2 +-
 drivers/acpi/fan_core.c  | 254 ++++++++++++++++++++++++++++++++++++---
 drivers/acpi/fan_hwmon.c |  32 ++---
 4 files changed, 302 insertions(+), 33 deletions(-)

=2D-=20
2.39.5


