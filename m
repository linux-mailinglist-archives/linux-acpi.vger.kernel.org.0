Return-Path: <linux-acpi+bounces-7785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163AE95BD6C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E941C21A39
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2441CEAD2;
	Thu, 22 Aug 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i04QWz6O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA8487AE;
	Thu, 22 Aug 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348338; cv=none; b=MIth27RuL/8l1jumTYWUdObS6ywwZjr08vf9Ya2/B0h/x9Gn0aTomdBDDnfM6GTRoLqftdl4Dkh5AsQq/DxRT9mt1t5HUxOWlsfDpoO2U79mj+sE0EMhzyaoSf2RoFymKEMI9oJg1CwiT/4YBvlQ6qfxc7AMieNOmyzwviWmX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348338; c=relaxed/simple;
	bh=Y6MHZHn0dItdfMB18uEbovy8LuIAhyoEd8b+ahGoCA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTlW4HqDtXKDsMsvlRznzo2m6JMnT2LvT9/bZMaTL76fKyCAbnazUz6FvU7wZgntkKG0hYOySdOWtSDph4t/P89E6eqJ+Ullwke8cBPAAeyXnDmGKzpt72Tpfz6oAAUPTIK3cDMePJ7tDH2WnEGoQlKQAykrqWFUbRXJRymQY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i04QWz6O; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348319; x=1724953119; i=w_armin@gmx.de;
	bh=ygCqjAHSRsl9Ms8YkRl85gypUcTZyKgxu8OJZt4JFVU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i04QWz6OIIo2qFTTgOKilEfoueHrifHMBXgWnt9YEWLgMkgImsZ7S76WbUa+Vn9B
	 FY4wbrXu5+y+RYqnNuZ6GJcuxkm9dyA00X9F3fjPT3OcuqQkDfIkmvo6/bEVdhi3Q
	 6uPUIB82teA5DWll5FMwg9b17ZcB83ujNWZBNbRH3GpuWWtHC3Nv650VNCZYFKk8n
	 zpZzIYN5jBJRJTorunxlVsa4rPOhBOIunvtbBfE/Kvnv7z490WYHkPA6GK9iUR/Hl
	 dXSUs6AadtJNji5pz3K8ixOIbkYnnVG2vhLJcf3BeTRa8/RvwUchu7xSgBt3IgVUG
	 ypkGjmPpyq/oHxoEGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N2mBQ-1s0KWZ0Qxw-010ij4; Thu, 22 Aug 2024 19:38:39 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: wmi: Pass event data directly to legacy notify handlers
Date: Thu, 22 Aug 2024 19:38:05 +0200
Message-Id: <20240822173810.11090-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bZeC1HcLadV+bg6yqYQueB1GjpaYGBy7IqicofIzKeK4h9bAoGW
 eDzZgYiElMARD+9hTTLwTcaMz//GCkVXXWfvCdegpS/HiBCZENtphIW6IO6Oi06aPGKlCkZ
 BjX5EEXJN/+8awHG1y05EedjKLxbFn1W16Ns+hw5dhy51VGvd59BHC7pVWQgrjAPhdd7TgO
 C1KNU9JFLFu4EochCY+6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mq5Vv18SZrA=;ntV1+pe2Xv0Dp8y7JS6S4MW3SFE
 o37wrXcePso/wmz8qO+rKqvcsGp30GdNGI6xoyrXierNMp/DA8aH+vAwjnEuqYrSzsP6x1+G3
 HwktzJqICJdob5KsNYHb0kiysfU688EoWBIfEzzVi+Vbl7g2a8FjvPGhNKGZhwPI7ONAp+BsK
 HwPSbFf8IPDtHqHk0wOP1dILPgkL8xgdmODIntwwjOz57ep6YD840J0RPXfmD1pYupUlyP3Sc
 k+MqtiphMbp2fw+lpIr9BFvgE3dNoq0dToKWdYC8u+1U/SnzKgjTM2F55fXaBT5DSVKPsLdM0
 9h7OSUtux/qQjy5seBRrHhuCrKrwvR1waciGsNkDRPCCobCxC8gv/h28GDmHV2L7rvZREq4RB
 /MbDelqM0iHe8mmzLRPzKCg7xL99ppV8n3iZub3V5XayCkpVRlrtAmi3XT5R381Bl5cSf2jPv
 8AY10VmyEX1X1QeBFL41Spv6p2ukhpMPFDXj2QVNEgdkrtyD0dw6VUWDk9yPUGqLvYzniD4Ep
 8bIXXvFyjlR4nWIw14LyHIve0bCMNPP0q9fjjv9OuK2RGMVRrtFw5HlaDXGzc3+6ygnZQgHPu
 kveGUPkDbtWvwOJDVI5eNU6Py3zT9GAUk7PZuLUxSNhaBgi9y8uj1S4W/sXKwViq9k2gpdFvz
 xxcUz0GVsrZve0lE7KGKxv511WL2Vc5KzDwlz9HaemlUanRN3ylAMjE3VvtwJm2O5wsKDpn4a
 dMFOw0xmMWFFSsEsY719pdCGtr4Y9elBMi2Cht1G8OR9S28/UgwUbrvJMMGyoHlmn/9wWttld
 sgOSQRy4DO82GH31H4kauHcw==

The current legacy WMI handlers are susceptible to picking up wrong
WMI event data on systems where different WMI devices share some
notification IDs.

Prevent this by letting the WMI driver core taking care of retrieving
the event data. This also simplifies the legacy WMI handlers and their
implementation inside the WMI driver core.

The first patch converts all legacy WMI notify handlers to stop using
wmi_get_event_data() and instead use the new event data provided by
the WMI driver core.
The second patch fixes a minor issue discovered inside the
hp-wmi-sensors driver, and the remaining patches perform some cleanups.

The patch series was tested on a Dell Inspiron 3505 and a Acer Aspire
E1-731 and appears to work.

Armin Wolf (5):
  platform/x86: wmi: Pass event data directly to legacy notify handlers
  hwmon: (hp-wmi-sensors) Check if WMI event data exists
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


