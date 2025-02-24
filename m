Return-Path: <linux-acpi+bounces-11427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA93A42D05
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C953A5CE9
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39A1EA7E9;
	Mon, 24 Feb 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IJDkqEoo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1211A5B8B;
	Mon, 24 Feb 2025 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426674; cv=none; b=gTd20xvfetnvKK3V3azDiK11q4HfD7wLUcNT+FCJOmYXu5aC9ntb/2Tvw6o8n/85HpLDIjidkqgvMf5mtjrB77eewdVrS21y4F3YA6cp7Vgj8XXP2Xtxd+iCPJnZASZPo+ck8P2vrZfk5MU40pFs8v3MINQ5RxY6yIfflw65/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426674; c=relaxed/simple;
	bh=hcgJfw/7wOHsNOEBoUBiG14kJhwqkh4zp5hmxOiaJ5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjxnC5oXodltWqnahbyQQ6ZcAMEd7zcrAOaOEMoHF9ap6U5DE92hD3vbkkwFEWFRANwPXMXOXJHtUZviVQrq6ja3x11YYiaSr3bS1XocJFnBct7tGkTvVb8lk7NZkXC17w2qojcdDRcleuHBCNCKhZ4BQVJ1Xy/m6Pj3L7q7TR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IJDkqEoo; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3E7B92E092FE;
	Mon, 24 Feb 2025 21:51:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740426668;
	bh=nV6M1/9xoq45Ft8blytZcpP9OHrrGYYTleMHHH0uXsU=; h=From:To:Subject;
	b=IJDkqEooTtAATgziBepLyqCS6dKmwyVYUMRq6anzWCL7rqV+st3bao8OfD8Qxfzdd
	 W3GhAjeKcdHj9f179pyWj4XMKfbyNDhZNR3cMdwrbF/4Mx7e8f6O+kUeZZC8nQKjzh
	 +A7mjCIF1xz3OLFL8scFFbMZjHGiwAlJVqjwf/sU=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with multiple
 handlers
Date: Mon, 24 Feb 2025 20:50:56 +0100
Message-ID: <20250224195059.10185-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174042666777.337.18039573887564455104@linux1587.grserver.gr>
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
loads both amd-pmf and asus-wmi (around 15 models give or take?).

The problem stems from the fact that asus-wmi uses quiet, and amd-pmf uses
low-power. While it is not clear to me what the amd-pmf module is supposed
to do here, and perhaps some autodetection should be done and make it bail,
if we assume it should be kept, then there is a small refactor that is
needed to maintain the existing ABI interface.

This is the subject of this patch series.

Essentially, we introduce the concept of a "secondary" handler. Secondary
handlers work exactly the same, except for the fact they are able to
receive all profile names through the sysfs interface. The expectation
here would be that the handlers choose the closest appropriate profile
they have, and this is what I did for the amd-pmf handler.

In their own platform_profile namespace, these handlers still work normally
and only accept the profiles from their probe functions, with -ENOSUP for
the rest.

In the absence of a primary handler, the options of all secondary handlers
are unioned in the legacy sysfs, which prevents them from hiding each
other's options.

With this patch series applied, the sysfs interface will look like this:

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

Antheas Kapenekakis (3):
  ACPI: platform_profile: Add support for secondary handlers
  ACPI: platform_profile: add all options to amd-pmf as a secondary
    handler
  ACPI: platform_profile: Do not hide options missing in secondary
    handlers

 drivers/acpi/platform_profile.c    | 57 +++++++++++++++++++++++++-----
 drivers/platform/x86/amd/pmf/spc.c |  3 ++
 drivers/platform/x86/amd/pmf/sps.c |  8 +++++
 include/linux/platform_profile.h   |  7 ++++
 4 files changed, 67 insertions(+), 8 deletions(-)

-- 
2.48.1


