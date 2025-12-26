Return-Path: <linux-acpi+bounces-19864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4ECDE98B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 566F6300B298
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990F3176FD;
	Fri, 26 Dec 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KUSqPMmx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46F15530C;
	Fri, 26 Dec 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766745406; cv=none; b=sEL9jjNvoSN18S+QV3jowIy5Fo+JMbXAadMnlxyitx3lzPdTPXvTZ5QFzzi65smLNQUWmeglTZ/XaedXu4dGqKEmhHadGqG/lQk/TYwC6sBx8+aFNDmoyLs3TRy3LTksqxIXqmL9Obu9W7YYJYSS7c5DZFp9Tt1RuVA2tJr22sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766745406; c=relaxed/simple;
	bh=fXN5mv8P1kI8mWWFE4AOg1cXqgCwS6BykBnWRCshjsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8UfiKMsT2JjX29JAdG0W0Q4l2G9IrhHD8uUX5CAmPcmDvrI/+9k5dJOQJ/PfAshkBrf5l91TTdEdzVJlypmyRpfNmGtP/vQIjQkoBWlSMeC3Y6EvwZzt2BpD99LNvq5/VWrNQY3JurFOdx+ep17Z832abyZPvHj9NYNIZ/ss9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KUSqPMmx; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id EE35E3F41F;
	Fri, 26 Dec 2025 12:27:41 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 13BA53F41A;
	Fri, 26 Dec 2025 12:27:41 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 20D18200D51;
	Fri, 26 Dec 2025 12:27:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744860;
	bh=uyXMiup/vHvKvja+QJq/TnejqQlHRb09JG6xpCU5VpU=; h=From:To:Subject;
	b=KUSqPMmxaMl0HwhxMoQ15FQxqftroZxch/oJ63Op6Y99Ar82qQmQMWMwsL5/OOGkZ
	 SY60+f2CUBbhsarhVU4mXPBc8CIJSl70o/n5/xnhqVrJ18WIyQ1hDJGchaw3L26mvO
	 cntTto1rTEn3frZuR8Ci41u/I2V3x0i6YTdnovuyqfELb6wHVfdmzGuufDpjBY7Fko
	 Yw18YMESIworvhpT1d57OoMB4HXBKkB7FKOvylIVr2jU85L4UkukijGdDfB41tbedZ
	 om+dFv1Cuz+loXqHLw9FW6WJrYRsGN4apVO1bNjOtH7P3/ubeMmJv2LKco+V/Etk5p
	 2I98bDp7r/QWw==
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
Subject: [RFC v1 1/8] Documentation: PM: Add documentation for Runtime Standby
 States
Date: Fri, 26 Dec 2025 12:26:39 +0200
Message-ID: <20251226102656.6296-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
References: <20251226102656.6296-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176674486055.2608234.5899126676132951757@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Introduce the runtime standby state ABI, which allows for firing the
Modern Standby firmware notifications found in Windows during runtime.
These notifications allow to make systems that support them look
suspended.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 Documentation/ABI/testing/sysfs-power         |  20 ++++
 .../admin-guide/pm/standby-states.rst         | 100 ++++++++++++++++++
 Documentation/admin-guide/pm/system-wide.rst  |   1 +
 3 files changed, 121 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/standby-states.rst

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..16378be2dc13 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -39,6 +39,26 @@ Description:
 		See Documentation/admin-guide/pm/sleep-states.rst for more
 		information.
 
+What:		/sys/power/standby
+Date:		February 2026
+Contact:	Antheas Kapenekakis <lkml@antheas.dev>
+Description:
+		The /sys/power/standby file allows userspace to inform the
+		kernel of the current runtime standby mode depending on user
+		activity. The options are "active", "inactive", "sleep",
+		and "resume". Only the ones supported by the platform will be
+		available. Depending on the mode, the appearance of the device
+		will change (e.g., keyboard backlight will turn off as part of
+		"inactive"), and its thermal envelope might be affected.
+
+		Reading from this file returns the available standby modes,
+		with the current one enclosed in square brackets. Writing one
+		of the above strings to this file causes the kernel to
+		transition to it.
+
+		See Documentation/admin-guide/pm/standby-states.rst for more
+		information.
+
 What:		/sys/power/disk
 Date:		September 2006
 Contact:	Rafael J. Wysocki <rafael@kernel.org>
diff --git a/Documentation/admin-guide/pm/standby-states.rst b/Documentation/admin-guide/pm/standby-states.rst
new file mode 100644
index 000000000000..af7f32721d1c
--- /dev/null
+++ b/Documentation/admin-guide/pm/standby-states.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=====================
+Runtime Standby States
+=====================
+
+:Copyright: |copy| 2026 Antheas Kapenekakis
+
+:Author: Antheas Kapenekakis <lkml@antheas.dev>
+
+This document describes the runtime standby states ABI available in the Linux
+kernel, which is designed as a generic superset of the s0ix/Modern Standby
+firmware notifications. Devices with these notifications support hardware states
+where they look like they are asleep, while still performing basic computation.
+Specifically, those are "Sleep", "Inactive", and "Active" states, with an
+additional state "Resume". Transitioning between these states follows the
+flowchart below.
+
+Runtime Standby States
+==================================
+The following runtime standby are supported::
+
+    <S2idle> ↔ <Sleep> ↔ <Inactive> ↔ <Active>
+        →       →  <Resume>  ↑
+
+.. _s2idle_drips:
+
+
+.. _s2idle_active:
+
+Active
+------
+
+The "Active" state is the default state of the system and the one it has when
+it is turned on. It is the state where the device is on, and the user is
+interacting with it.
+
+.. _s2idle_screen_off:
+
+Inactive
+----------
+
+The "Inactive" state is a state in which users have stopped interacting with
+the device, e.g., 5 seconds after the displays have turned off due to inactivity
+or due to the user pressing the power button. It is the responsibility of
+userspace to keep track of user interaction so it can inform the kernel to
+transition to this state. The response to this state for devices that support
+is to turn off their keyboard backlight, and some might pulse their power light.
+
+.. _s2idle_sleep:
+
+Sleep
+-----
+
+In the sleep state, certain devices will limit their thermal envelope so it is
+safe for them to be put into a bag and still perform basic computation such as
+fetching email. Then, some devices will pulse their power light. Userspace can
+use this state to perform basic tasks such as wake-up checks while maintaining
+the appearance the device is asleep.
+
+.. _s2idle_resume:
+
+Resume
+------
+
+The resume state is a transient state that may only be entered from the sleep
+state. It can be used to notify hardware that the device should boost its
+thermal envelope as preparation for the user interacting with it. As in, it
+undoes the thermal envelope effects of the "sleep" state while keeping its
+appearance.
+
+S2idle
+-----
+
+The "S2idle" state in the diagram corresponds to suspending normally by writing
+``mem`` to ``/sys/power/state``. Userspace is fully frozen, and the kernel parks
+the CPUs and turns off most devices. It is shown in the graph as a reference.
+If the runtime standby state is not "sleep" when entering s2idle, the kernel
+will first transition to "sleep" before entering s2idle.
+
+Basic ``sysfs`` Interface for runtime standby transitions
+=============================================================
+
+The file :file:`/sys/power/standby` can be used to transition the system between
+the different standby states. The file accepts the following values: ``active``,
+``inactive``, ``sleep``, and ``resume``. File writes will block until the
+transition completes. The system will cross all states shown in the flowchart
+above to reach the desired state. It will return ``-EINVAL`` when asking for an
+unsupported state or, e.g., requesting ``resume`` when not in the ``sleep``
+state. If there is an error during the transition, the transition will pause on
+the last error-free state and return an error.
+
+The file can be read to retrieve the current state (and potential ones) with the
+following format: ``[active] inactive sleep resume``. Only supported states
+will be shown.
+
+Userspace may transition between all supported states including s2idle
+arbitrarily, except for the ``resume`` state which may only be requested from
+the ``sleep`` state.
\ No newline at end of file
diff --git a/Documentation/admin-guide/pm/system-wide.rst b/Documentation/admin-guide/pm/system-wide.rst
index 1a1924d71006..411775fae4ac 100644
--- a/Documentation/admin-guide/pm/system-wide.rst
+++ b/Documentation/admin-guide/pm/system-wide.rst
@@ -8,4 +8,5 @@ System-Wide Power Management
    :maxdepth: 2
 
    sleep-states
+   standby-states
    suspend-flows
-- 
2.52.0



