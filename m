Return-Path: <linux-acpi+bounces-19860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3992CDE976
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C3B3006A70
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32327702D;
	Fri, 26 Dec 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YhvyPOMa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C98479;
	Fri, 26 Dec 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766745179; cv=none; b=MF7RwbD9wHmfadbAUS+glS2fYnXVBif8x48ai0+3xebrgoLpkGEfI6wQkiOCqCmxC1WuULCobmQwglRksl2+BFcmOxGXtJ0KuBeO2tv24zGodMiinqLm3/csIxDWTFj2x99t1BscV8cUd/XGOayzaG9JBaChIkzPhCigOlAH6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766745179; c=relaxed/simple;
	bh=jJkEt+JI0dTrED/qRcrATo3hSLn6bJyVRHyp+n3DZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eR7Pr01RAMfq9axgHG1r+QqRISHT3xFx+cTNImRNf/9coiLhA2ChyyV8IvvKLyHfGfXz2uT/IjhIGzBPCs0q0ANzaGJcKnLegRY1UtBco9XIAgC4qe/5yR0Vjku3GPBt1yiEF11LhvwIQXWJ6vnSTiNFJLC7eO0CmM1uki+O1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YhvyPOMa; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 1AAB8BDA4B;
	Fri, 26 Dec 2025 12:27:40 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 3E3B2BD9DB;
	Fri, 26 Dec 2025 12:27:39 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 417381FEEA0;
	Fri, 26 Dec 2025 12:27:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744858;
	bh=JJSnIibN6K9IQDpOOY/Ta4c0i8T0M1hkQKidrwA0gvA=; h=From:To:Subject;
	b=YhvyPOMaywUtsEBFyjOr0z7B6aE77O+yAI0EcSW/cANC/xtr+0I9i8Bhiu0h3t6CN
	 KVEVY7iGAW59Idx6nE3nOdsPOCeyYGl2ENxFySkVgQim3sAA5t73+jw2K7PrnoqCar
	 e2fxKEfurXOGK8Xp/RNuotlliUKnl2td8p3urJuwybipU1AqdUpMOpM0yfoqcgGP2j
	 wiYFBi69KFB9BdIqb4Tqah1lxchECqTGg/Ux0JqeknT91H2OptrV4+bC8iUu1+TZ9H
	 HGIDKdjsrnRPasp/WNLzKmdirNeFDw19u31te+3bCMh4q2EXX+YBjrQ0v9YtRnfLLS
	 ZhKlzmqolb4ig==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
Date: Fri, 26 Dec 2025 12:26:38 +0200
Message-ID: <20251226102656.6296-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176674485873.2608178.5862922189409135880@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

This series introduces a new runtime standby ABI to allow firing Modern
Standby firmware notifications that modify hardware appearance from userspace
without suspending the kernel. This allows userspace to set the inactivity
state of the device so that it looks like it is asleep (e.g., flashing the
power button) while still being able to perform basic computations.

It is a more fleshed out implementation of [1] and a rewritten version of [2]

The first part of this series implements the plumbing that moves the existing
DSMs from being called at the end of the suspend sequence to the beginning,
where they are called through a transition function. Then, the last patch
exposes this transition function through /sys/power/standby to allow userspace
to interact with it.

In this way, the core series can be tested while not exposing the new ABI
to userspace until ensured to be stable.

For more information, see the first patch in this series with documentation.

Because this series is a major rewrite, I have not tested it much and there
might be minor logic issues. In addition, due to confusion with the
"screen off" terminology, I opted to rename the "screen off" state to
"inactive". This way, it is applicable to devices that do not have screens.

To test this series, it is recommended to enable logs with:

sudo bash -c "cat > /sys/kernel/debug/dynamic_debug/control" << EOF
file drivers/acpi/x86/s2idle.c +p
file kernel/power/suspend.c +p
EOF
echo 1 | sudo tee /sys/power/pm_debug_messages

Here are some commands afterwards:

echo "active" | sudo tee /sys/power/standby; cat /sys/power/standby
echo "inactive" | sudo tee /sys/power/standby; cat /sys/power/standby
echo "sleep" | sudo tee /sys/power/standby; cat /sys/power/standby

Merry Christmas

PS. this series is made on v6.19-rc2, but you should probably test it on 6.18.
My Wifi does not work, and neither does booting with a dock connected. Do not
test it on an ROG Ally, let's get the basics first right :) The shims in
asus-wmi/hid-asus should be removed once this series is merged otherwise they
will conflict.

[1] https://lore.kernel.org/lkml/20251202043416.2310677-1-dmitry.osipenko@collabora.com/
[2] https://lore.kernel.org/all/20241121172239.119590-1-lkml@antheas.dev/

Antheas Kapenekakis (8):
  Documentation: PM: Add documentation for Runtime Standby States
  acpi/x86: s2idle: Rename LPS0 constants so they mirror their function
  acpi/x86: s2idle: add runtime standby transition function
  acpi/x86: s2idle: add support for querying runtime standby state
    support
  acpi/x86: s2idle: move DSM notifications to do_notification callback
  acpi/x86: s2idle: implement turn on display DSM as resume notification
  PM: hibernate: Enter s2idle sleep state before hibernation
  PM: standby: Add sysfs attribute for runtime standby transitions

 Documentation/ABI/testing/sysfs-power         |  20 ++
 .../admin-guide/pm/standby-states.rst         | 100 ++++++++++
 Documentation/admin-guide/pm/system-wide.rst  |   1 +
 drivers/acpi/x86/s2idle.c                     | 176 ++++++++++++------
 include/linux/suspend.h                       |  26 +++
 kernel/power/hibernate.c                      |  29 ++-
 kernel/power/main.c                           |  84 +++++++++
 kernel/power/power.h                          |   1 +
 kernel/power/suspend.c                        | 153 +++++++++++++++
 9 files changed, 532 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/standby-states.rst


base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
-- 
2.52.0



