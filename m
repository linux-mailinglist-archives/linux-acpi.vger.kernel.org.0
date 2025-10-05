Return-Path: <linux-acpi+bounces-17591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA0BBCD57
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB88E1893339
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705E22068B;
	Sun,  5 Oct 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RNctxaB6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D628E9;
	Sun,  5 Oct 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703128; cv=none; b=lvTB7UvxgMfsb7Vy3GXiBNiKX6nX1BvSiaZ7M1uGOcrMThjOUdw/la4h/wEYXIHm4dfL6GoFsafTHf8FxjhSwSV+/dhpQwyxfeoLLe0hmCB9clO2/K3sXa+9TV1cGi+9obS1VftnoCBJ84vXWYb3+eOzm3pE7QVoR8C86+/5j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703128; c=relaxed/simple;
	bh=T5nsXl0tOn/rX6M5N+j9ItxCDv98/Kcqvys//y17sko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NPBoLgCFeSpZWHhFF5gOws7sd5XY5aS5tg6qFn5w0smYLCu+S5ch16mHSaU1MAvo6s4LBQ2xUUuFud4DTZiXzwODntutmHpm6USpfp6f2OT8NtSGd9M47nLXS1vOi+AlwmUD1kEJ+JDKuycNNAnUnaQqjUyfqK48+d9L7+uj/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RNctxaB6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703124; x=1760307924; i=w_armin@gmx.de;
	bh=AXFTHd2wHRp4SX+AYSwWdrtQKHjpsxVBPt86e8V2gJw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RNctxaB61/dCqlZQ+xd3nCBORISGV9L5Dowt4Th7RN/4InSFHJ3hH/VhqD4n6nAr
	 gER7YtY6BmzUGM9Hk7NTfEkgzE4K1wEe4iRkOjagwt4TiIr7RylDFU/DdXWnFwG2k
	 j07eHrCmx3q0KSqof/NTpHnfDPbEw0ZYoc6GqiRSXaRblRupZc6c5zZDxMxR0s0VC
	 Un8/pxx9K3Ji0Kl0lh/655zDA8VhZw9V6SSY7cYX5CqkKyG3I4sXVBSn+RZtmATL3
	 4/07l4NZyVNR8Soq8PZXiPUEBOxWz3Mc1JmYVhH58y1ReujpoKfnRLaU4hp0BdZ/G
	 TTcvZAQLY0gX3HDw0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MNt0C-1uuSOi0d32-00OqXw; Mon, 06 Oct 2025 00:25:24 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ACPI fan _DSM support
Date: Mon,  6 Oct 2025 00:25:07 +0200
Message-Id: <20251005222513.7794-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SlREDYBgZiSy01VguaksXaPg1wpWgGY/XgXrkW35w9W06KL6FhU
 lGCUViYwxDhT9yUtUsCUl5EPTnGjlvC5uCMF1nzLffawZVOyg0M7nKhVNsVGStBDrhAv6R7
 qihlKz3oGTJp+ZoT1aYCrlo0HJ8J+u4OEK3Y53qmgaSE7MqRP6svkEsf904Oej4vntYzh3S
 CiYoSr7Ilpa4sJsTI6uOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:evMOVsMzfVk=;hktxoKXSp175kNFTJCHd4G7eeYm
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

Armin Wolf (6):
  ACPI: fan: Use ACPI handle when retrieving _FST
  ACPI: fan: Workaround for 64-bit firmware bug
  ACPI: fan: Use platform device for devres-related actions
  ACPI: fan: Add basic notification support
  ACPI: fan: Add hwmon notification support
  ACPI: fan: Add support for Microsoft fan extensions

 drivers/acpi/fan.h       |  47 ++++++-
 drivers/acpi/fan_attr.c  |   2 +-
 drivers/acpi/fan_core.c  | 260 ++++++++++++++++++++++++++++++++++++---
 drivers/acpi/fan_hwmon.c |  32 ++---
 4 files changed, 308 insertions(+), 33 deletions(-)

=2D-=20
2.39.5


