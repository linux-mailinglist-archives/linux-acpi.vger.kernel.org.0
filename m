Return-Path: <linux-acpi+bounces-19373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7CAC9A037
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 05:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E40573456E6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6002DCF74;
	Tue,  2 Dec 2025 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="JQTvkHGp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF51A23A6;
	Tue,  2 Dec 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650177; cv=pass; b=aZt1GeWlq4mGTWNFUPxnX2hlCmExb9cyc1LX6lPJ3tP2EHaRVTz9aOSdGRZurfDa0M353wiFgL3jOC16cftoFI/fcIwPevta8mQ0nRtfB2J+wbuExSVMaL1JGTNn4c2FUT7uoYjIeCuS1g6axVfBKfYnPNHjdkGx5/ZMH0nY4UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650177; c=relaxed/simple;
	bh=zberiFQ9fzE2wHsCxRxJP8uQeXw0joLdO/LlZbq+V+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxINuX7fkdbGf9az4SfkFYKd0iEyyl4/Tz0MrD0A1ybiEVO6ZVD+KyVqQQo+9NrW8pYvWyXKznVVec1zXB0C54Mze6HsVKltH9t1me4xBocHN9LGdNx8oTwG5co4IExvLwpOj+PqoDvMWEQEVYKE6huRNfqvP3MviTO/E/komVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=JQTvkHGp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764650144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q1J7NoIHHD4iUK+1oL0pXt0jhAIIMO8eNl/e8RdkukblZX3H+9wXK9cDCUs35BPhkhgJJO3pnRr6VuZCM56FRMTtt4pzAlxrAlOETjK4A5pCXKsJWnDG1yjhkVszi4HuqKLTN0g3G/Kfmgc06oVq8MW92sPGQAIzWZxMcvgO58A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764650144; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TPWPkwKyrUpHoNb+LjuE6gPDtbXFmFpkHgDbSUDooqw=; 
	b=f2yXuEf5npqcnLAP21nXYRfHie2oi86HiUM04u0GOD0Eh+qPxZVUOL5Yn/6tIo3hKj+IykNrdL1RuWa+fJBfwuvvSWjWUraj2654u4F0z9j0Q7l+8iJxxCussylYh3N5RmravTq3by9uOMrJGmsjAYPz/vRE9cCuNOxg/N/gcfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764650144;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TPWPkwKyrUpHoNb+LjuE6gPDtbXFmFpkHgDbSUDooqw=;
	b=JQTvkHGpROjyr1DuuT74aw3NSqL5OquQk6gwcV+Ne6DTiHKHhBGHHZExxAkmKCS6
	jMyofJVJQc0l+wMLtRCYgMZHm0mMrPbOUo39UUkMc3Mpo24iF55HWkTp0Z6V69YsXXH
	v25fdnP0x4Z0C/cvYF+6/kAP5GuY+N1GQWhnZYNQ=
Received: by mx.zohomail.com with SMTPS id 1764650142159431.31272850876826;
	Mon, 1 Dec 2025 20:35:42 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>
Cc: linux-acpi@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>,
	William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>,
	Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC PATCH v1 0/1] ACPI: s2idle: Add /sys/power/lps0_screen_off
Date: Tue,  2 Dec 2025 07:34:15 +0300
Message-ID: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Introduce the `/sys/power/lps0_screen_off` sysfs interface, enabling
userspace control over ACPI LPS0 Display Off/On notifications [1].

These notifications are a part of a Modern Standby [2]. The Display Off
notification signals the firmware when all displays (physical and remote)
are off, allowing it to enter lower power states that makes device pretend
it has been suspended while the system remains operational.

Future work will involve integrating this new sysfs control support into
userspace services like power-profiles-daemon, adding a new `idle_screen_off`
inhibitor type to logind and updating power managers with the new
functionality that may improve power savings for idling devices.

Display notifications will allow to support "resume to a dark mode"
feature where the device wakes briefly, performs actions, and then
re-enters into suspended state.

[1] https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
[2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications

Dmitry Osipenko (1):
  ACPI: PM: s2idle: Add lps0_screen_off sysfs interface

 Documentation/ABI/testing/sysfs-power |  13 +++
 drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
 2 files changed, 145 insertions(+), 17 deletions(-)

-- 
2.51.1


