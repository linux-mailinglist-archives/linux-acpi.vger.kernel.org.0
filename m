Return-Path: <linux-acpi+bounces-8030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0067967445
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695482829B7
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AA24B29;
	Sun,  1 Sep 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QxWwmqpR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36429A5;
	Sun,  1 Sep 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160311; cv=none; b=eY0uNFigIHmJztLPsSq+xLXezU2fhCWmwpllQOVwWJSqpOkHpkIwWPx5HPfujYvUlNc4+m74ta2ijFCrytgnp3H4VdSV/GBu1GckErx16dMgU15vkjXpsrR/SGAXLZulJbS9u0audHlAB/iNUHN0Sb+6TK39+UlGlAPPpBh6W8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160311; c=relaxed/simple;
	bh=Gn3ZeVq3s2dJ2JDVX0zGK1/0ntK9iJVduGOXDYUA86k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ERQj62M3DyRG2iXEl8GG6WJk5ZeJ+PSpOF9cmn/5hRzkN0EBuaN9MjTEEjEkV5z44Cgft7z8yvjVWBEwd2fyXPw9kDsRPLrRy+C4n9E0Xfo7mXyAGOeKuXhmLZjO+DzqU5OhQ93FeQ+ozGwww+85/fB+jhNzDM5UHhzeM6Ra3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QxWwmqpR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160275; x=1725765075; i=w_armin@gmx.de;
	bh=61iovUbYzxeFk07bQVInsGZWHQS/VYBUxCJlz8xdIac=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QxWwmqpR/3JHaQaH/66lZRFRzyvchiFN0Zq75WMEbFsz54rJc8dAK4sGRjC/2B0V
	 5CMJmhWKvPoJbB0lsgIg7wZiYUWQknZaGn8gj9LpkVOVUAk8fMqlc1K+pfuZFvRdj
	 atgEo2eVRd+qTOsEVuNFfa8XXdO27x731xE45Gn6PiU3PI4tFw0DwEtUXmzxJrMXY
	 n/ismuFant5rr9s1pAU6r9ecTtLaKCV7TWvhMVHlv8j9JiXH19puCnVTFlrfWnCqB
	 dLkJgCQji6MyjMBg902YnQQUNQ9wL0P7UF0q81xl7xrrZXUV/IZiCYlaJgkxJ5Oii
	 e1E5Cm2J4wKBc5mIhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1OXT-1s3n3I1dHv-015tVz; Sun, 01 Sep 2024 05:11:15 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux@roeck-us.net,
	jdelvare@suse.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] platform/x86: wmi: Pass event data directly to legacy notify handlers
Date: Sun,  1 Sep 2024 05:10:50 +0200
Message-Id: <20240901031055.3030-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4u3UKfkDSEUWuZoiSkM7PtXoWy76rIvZ2VcU48CiI7eEcJEO5r
 hnvReU9imYCvaRBsbOCnGQohxmm6kFYlg8hsfJHA5kyaNk/HO8oKsdsi0xylGoLaAiqF74h
 a6OZY/uGZ6IYg9zusX2t2W7jNJGTlAGLOwoiLd5To2mhaHp4Y5ve7XEVKvdf3cF67I+uNLK
 9snwFUEnKaOj/0GcPOAEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T6dhtErzGBg=;/T1T6/xYWinrkcrJReMWvJ1eTSi
 fs1v3uhXNNlgIMTRiC2V/CQNtcVOOsGlyIHz3DIa1534awQoyxIU/70RqeakeSnF9YBY4yCrr
 eweYXE6+VEfH+QUFqIyMO4Do3avivR1ehUq5NzUdMT+n1nm6twixMkw++5kk2GPe/dpGS1XfD
 Rcwo+U85qQYWlWRhXIL2orXVcxBJSu1Vb32Td/YUfEx56rHWB+zPG0Kw3PbiW4/SzyWvPudyg
 OBAtSbELDPh8bZVl4gWZZbPRN9RCZX5ZDpC71onGSpe5LcO9awzVkErR8FEoIfyQ1ruLYm9HJ
 IsjGq47xZj4V6DBbRQ9H74vIdrmBMz4vE0jvMBIaNbHyG7dp/f/KRcGrg0xIk5e4/AFRmcHJO
 XPufnBD3C4puPV8f9noqNF2x6FnZOckeUUNTenYwnmgwqr88sxnT5DLayeHaXbhv0gd0F3ueH
 WjE2hOO1H9oesWbQBZX8iSb9WiCcEgOi1RwzGBYu6kkIm3zHcYWd2XVAe4EFqDKjtfHrChbiv
 J6WYtAVvQ5QDbGqA0R18QCb7Pg0ImIjyqbz6UL+hkBC2zO14aDMqhyxILafVfCfSjcVHiK34m
 4LDXn7dwkeTna01Tm4drG3kH+cDNll+vuBaFfTNapht2EgF2sJIX6hRXVD9AT28EtyhFZNDT+
 9JPK+ij9p0TXflIk06XMeqik8mezI9Y+SblA9xEnfBvKw6Czo/9zdiec7FLeN9itU4oR+EtgG
 qtPGjIuz9SnEMMlmIIQJoHw3CkvdpvLB/maR1Pcj3Y44Twmn+rywMu0yX1Ud6pz71SzNqQW85
 kELaOEJJ5IgHIJlG2XToSZ7Q==

The current legacy WMI handlers are susceptible to picking up wrong
WMI event data on systems where different WMI devices share some
notification IDs.

Prevent this by letting the WMI driver core taking care of retrieving
the event data. This also simplifies the legacy WMI handlers and their
implementation inside the WMI driver core.

The fisr patch fixes a minor issue discovered inside the hp-wmi-sensors
driver.
The second patch converts all legacy WMI notify handlers to stop using
wmi_get_event_data() and instead use the new event data provided by
the WMI driver core.
The remaining patches finally perform some cleanups.

The patch series was tested on a Dell Inspiron 3505 and a Acer Aspire
E1-731 and appears to work.

Changes since v1:
- Rework the hp-wmi-sensors patch
- add Reviewed-by tags

Armin Wolf (5):
  hwmon: (hp-wmi-sensors) Check if WMI event data exists
  platform/x86: wmi: Pass event data directly to legacy notify handlers
  platform/x86: wmi: Remove wmi_get_event_data()
  platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
  platform/x86: wmi: Call both legacy and WMI driver notify handlers

 drivers/hwmon/hp-wmi-sensors.c           |  20 +---
 drivers/platform/x86/acer-wmi.c          |  16 +--
 drivers/platform/x86/asus-wmi.c          |  19 +--
 drivers/platform/x86/dell/dell-wmi-aio.c |  13 +--
 drivers/platform/x86/hp/hp-wmi.c         |  16 +--
 drivers/platform/x86/huawei-wmi.c        |  14 +--
 drivers/platform/x86/lg-laptop.c         |  13 +--
 drivers/platform/x86/msi-wmi.c           |  20 +---
 drivers/platform/x86/toshiba-wmi.c       |  15 +--
 drivers/platform/x86/wmi.c               | 143 ++++++-----------------
 include/linux/acpi.h                     |   3 +-
 11 files changed, 53 insertions(+), 239 deletions(-)

=2D-
2.39.2


