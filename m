Return-Path: <linux-acpi+bounces-11558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C992FA48314
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 16:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9404E7A3B16
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AB26B2C5;
	Thu, 27 Feb 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="2n352TG0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103902222BA;
	Thu, 27 Feb 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670572; cv=none; b=CJ3JdPMBf/6eDUokwOoNQ4KuiZtzCV/BH4jvxsKmj1gs3OOYfOrxalGLOkGuVDlvfd6ThbiuilHqP1Ll1nM7V2ep7mm1IaKA1k/isG18Zi9x9Afx/nhIUUnJ42K1WxG3Z4Seb4ddtqb4V+oYckhQsNGUnoeNZrjpWYsk9P4f6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670572; c=relaxed/simple;
	bh=T7wvOszu/unZkBQdoGyUu95ygsw6g2gM1ljmXZ2ze90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMWXAPLySaFBYahtvkU6DfvdPh3RrZ6haF21NDCRde3BnwqKAHRL3z+aWzJnAb0/DJZjCyVbuGe6tiaY0p681FKP7wIE3dZN3+rwqrY43QhZ60uc9EZcehPEV2mLhqU6dGQyvopi8++8Cd6Un1EimTBkneFjNGWdvRqvLEguCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=2n352TG0; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 86A332E08EB1;
	Thu, 27 Feb 2025 17:36:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740670566;
	bh=eWpEwZhNxv2521cAw63u3P9hTVlN8O5YjZboZLx1fXw=; h=From:To:Subject;
	b=2n352TG0UQI3JVZLkNIQYHWY0Ja8beT2nDRuRq1F8aZaSQ5SRjBRdx/iYqJxs+ACq
	 sXmWlzCgSELCOJUnvqhWYktLyCvoZrrEANZh2TMx7c+e+LsvKsAk9r+qqUBaZ+T3EW
	 fQNDNLviWf9sA+BhX96kQYyOhzAioellQwqbwpds=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca
Cc: ilpo.jarvinen@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	hdegoede@redhat.com,
	me@kylegospodneti.ch,
	luke@ljones.dev,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 0/2] ACPI: platform_profile: fix legacy sysfs with multiple
 handlers
Date: Thu, 27 Feb 2025 16:36:01 +0100
Message-ID: <20250227153603.131046-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174067056588.31591.3695283512802745173@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On the Asus Z13 (2025), a device that would need the amd-pmf quirk that
was removed on the platform_profile refactor, we see the following output
from the sysfs platform profile:

$ cat /sys/firmware/acpi/platform_profile_choices
balanced performance

I.e., the quiet profile is missing. Which is a major regression in terms of
power efficiency and affects both tuned, and ppd (it also affected my
software but I fixed that on Saturday). This would affect any laptop that
loads both amd-pmf and asus-wmi (around 15 models give or take?) and only
get worse in 2025, as more laptops start to integrate amd-pmf.

The problem stems from the fact that wmi handlers use different
profiles than amd-pmf, which can load alongside them, and block their
choices. This patch series is a mitigation of this issue, by making pmf
accept all profiles through the legacy sysfs, and by making it a secondary
handler.

While we can argue about whether the secondary handler concept is
necessary, alternatives such as renaming profiles in current drivers will
break existing scripts that are tested for a particular manufacturer, and
allowing amd-pmf override options may cause unforseen regressions in
other wmi drivers.

+CC Luke

Changelog since V1:
    - merge patches 1 and 3 as per Rafael
    - simplify secondary comment about secondary and make it last

Behavior with this patch applied and asus-wmi, amd-pmf
(maintains interop with 6.13):

$ cat /sys/firmware/acpi/platform_profile_choices
quiet balanced performance

And writing quiet to it results in the profile being applied to both
platform profile handlers.

$ echo low-power > /sys/firmware/acpi/platform_profile
bash: echo: write error: Operation not supported
$ echo quiet > /sys/firmware/acpi/platform_profile
$ cat /sys/class/platform-profile/platform-profile-*/{name,profile}
asus-wmi
amd-pmf
quiet
quiet

Agreed ABI still works:
$ echo quiet > /sys/class/platform-profile/platform-profile-0/profile
$ echo quiet > /sys/class/platform-profile/platform-profile-1/profile
bash: echo: write error: Operation not supported
$ echo low-power > /sys/class/platform-profile/platform-profile-0/profile
bash: echo: write error: Operation not supported
$ echo low-power > /sys/class/platform-profile/platform-profile-1/profile

Antheas Kapenekakis (2):
  ACPI: platform_profile: Add handlers that do not occlude power options
  ACPI: platform_profile: make amd-pmf a secondary handler

 drivers/acpi/platform_profile.c    | 57 +++++++++++++++++++++++++-----
 drivers/platform/x86/amd/pmf/spc.c |  3 ++
 drivers/platform/x86/amd/pmf/sps.c |  8 +++++
 include/linux/platform_profile.h   |  5 +++
 4 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.48.1


