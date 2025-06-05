Return-Path: <linux-acpi+bounces-14157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028ADACF2BC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60167A388C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D28274FCF;
	Thu,  5 Jun 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yAUwfp9f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0812749F0;
	Thu,  5 Jun 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136205; cv=none; b=ZcEMw8LgdhA4Oekf1RxhDCHc2R8yIjHz9b5tL1Mv3l0HUFz0nDCnB2glt03nxUmkTkJ2YTxSwvRJT4Dhs/i3SvPmEmeE+OKdssxWq1/WF/up6/b733WEB4TDo6NCZktTUcxsUrEV3GLfm6XmpApVIUsPIOHgzObtQsOgkpcz9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136205; c=relaxed/simple;
	bh=WsntjljouOPbHdbSquLJoJXrNH7kjo5Cyehy4uSQ4Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=THledoigrYJcUbMhBXd+rbUROpG4o/Ei/Hmv0oYKWEnd3Ob2/8GosNTm4h9NKb8DjlRyvIxgTx8OsElGVun/m/X/KPbkIRAeMNClpwDjcltAf6DqpoHerCxN98wWwEDrqTkVoLkQHTA+4f4i4CeXqOQ20uq+bGK3W7cAkSc2zS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yAUwfp9f; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1F2A966C044;
	Thu,  5 Jun 2025 17:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136189;
	bh=WsntjljouOPbHdbSquLJoJXrNH7kjo5Cyehy4uSQ4Uo=;
	h=From:Subject:Date;
	b=yAUwfp9f6+Yf3Fewx70/e6mr97+PWDZevnXvooQV8plIaTg3M2rfGuhgE2J77lvnX
	 cXwkfCWJhXaA06qOCNMMqAMR0rK4BCUU9rgUJS0QacqkFCPitzhG6UjKfdpifdfLeR
	 7m+OHbBGcAPYuLFwtopHYH0OtEcrTo1onq/op+qBmDdPVh21eJh68HKBGoYgtkIX+a
	 lp4XksNWMNRwXi3Yri7fxst6cQ73jtOdjA+FqabwOxBJpBPdi0UcNOlfmlMEJNeSYz
	 2nF0As3011AkOtnjrp47SOzF0U9X+DCCJNgJZUIsSJ/iehKq72En5ndTKkR0kTFHDb
	 ooiCdJVItfoMA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 0/5] x86/smp: Restore the elimination of
 mwait_play_dead_cpuid_hint()
Date: Thu, 05 Jun 2025 17:03:01 +0200
Message-ID: <2226957.irdbgypaU6@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTFgxoheEI+NWfLhkXW46nOJRwoQPjyhtjzK2PMeqp+IFBJDv0dbEecaOBBQv3ODI5hHoLvKO4qggjV7wMyUKH7rvpHM+2q0khd4cBskzjMXa5OVP6/fvVR4NX+IAE5MxbqJhaHV/vLI25++Oxhw0XvJ7Tw1sFvnxsCKjMaiNir/+zhHMbLDTXMAKwoMw0omSoSUQQcZvFJ3WoDQZACckhevk32yYB4ONnkF33LKMXdb51mmTA7HQ7cV8udNC0KF6dGNnLw14bB1fQ1KCQnmYPrUcnheafZ9YxO/DRArbD7H2nOxZzsT37izNVqDHA/Ekyf57/cQFQp8EyOMgRwfFYdCqY4sdDZ3bAYNLDffVlO7RVG9gvXiWPM4sr5/zc6m+y93dNVw/ZMAQ4micCAd0lhuTTl/FJdeD00HpzHXNaK6SUO9i/8mCO7qfOfojK/6TNe+EQEy2XQh/ErVRhx7lseeN4BNoMpGyb5M7au63GWlsF+FkMls3U8c+pOy9tFEUmjA2koqWVQpvzSEL+7Ry6ZFV5q06EH7Mm6LC9lB1JOXiWlxjHg8rGDuksaF0wGoZ7fbeFSzTC57fjeTVg53UmmsFHwz6KoZZ7aJnvrB7EYQVoHKKjUuSFd+9Vct5D+vsS9T9uyBeW4C0Thj/zoF2bXbvDzsXzYYYojt89IjKIl/mQ
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

Hi Everyone,

The purpose of this series is to reapply the code changes from commit
96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()") that
has been reverted because of an issue introduced by it.  This takes
place in the last patch ([5/5]) and the previous patches make
preparatory changes needed to avoid breaking systems in the field
once again.

The problem with commit 96040f7273e2 was that on SMT-capable systems
booting with "nosmt" in the kernel command line, the "dead" SMT siblings
were stuck in idle state C1 after initialization because they were
initialized before a proper cpuidle driver for the given platform got
ready.  That prevented the whole processor from entering deep package
C-states later on and pretty much ruined idle power (including power
in suspend-to-idle).

To prevent that from happening, patches [1-4/5] use the approach that
has been used for some time to address an analogous issue during resume
from hibernation, in which case the "dead" SMT siblings are also in C1
when the image kernel gets control back and they need to be put into
sufficiently deep C-states.  Namely, they are taken online and then
back offline immediately to make that happen.

The general idea is to take the "dead" SMT siblings online and then
back offline immediately when a proper cpuidle driver gets ready, but
some changes are made to avoid doing that twice in a row in vain.
For this purpose, the intel_idle driver initialization is pushed
to an earlier initialization phase (patch [1/5]) and the ACPI
processor driver only "rescans" the "dead" SMT siblings when
the ACPI idle driver is the current cpuidle driver.  It also
avoids doing this on architectures other than x86 (patch [4/5]).

Thanks!




