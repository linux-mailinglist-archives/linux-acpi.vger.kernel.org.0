Return-Path: <linux-acpi+bounces-20572-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MV3IwGMcmlJmAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20572-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 21:43:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8816D7F9
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 21:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE033018BC1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04EE3A703F;
	Thu, 22 Jan 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHFXodMN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9836167F
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114546; cv=none; b=VVspukb8Qo03rpXP70lK+RFbIBtSJmcBZXaeE+qWIJxVjskY4O802OONZCmuO+uvKrlju4hAv2T2IsfSzOWH/a5ShXJwoAQNUlLxeUOeZnlGEwrlXQVMz88VbtfnWtUrFc8yDm2O4hDg8btPz3DqHKKsxWSXowd8Y6rvbQwpmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114546; c=relaxed/simple;
	bh=YdU8DNhP91LeCY4j9fHRAcnp4yzvo1q2We7MT/bawHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0eBtBZ8reAZeNC2m229HLXZrGD1J0WOtZn3nB8kxYOsFN+Hb+nOA4/cxYmSTmDUnzCzQKj0UUqCOAWhKg1HDXeYNwIUfy8/c92CJX2qlYIlFQsy5HQqK8QJhWuwIJVhx4Qn08QYt40/UMlnYhJbFqPOBom2woGWTwcvqwNPiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHFXodMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED68C2BC86
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114544;
	bh=YdU8DNhP91LeCY4j9fHRAcnp4yzvo1q2We7MT/bawHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHFXodMNVzAFcschIuYZJLZE+N8XUtEvgrEVPBRa2k0GqLVHF2l/6kvqwmymvytow
	 mCXVbYz0p5cgEpc2gizqQoFD8bahFtoxberDyq/ouVNW2qt0iyOWDAG91CmUVf4qT9
	 E6crQ3Q37Yfdm6YaKwtMUV8dIHBjJNO72m4nkQv6wYqn1VTgW1ZgDyJtigtoW4+o2M
	 AvTzOY1gSOJFdzLJ/GrvLML0/MJPgewro7PbvKM7IG74XMvFZBh57UmW+znMamYBnC
	 O4R387F6p4ibs7q/VrUJ0i0mzMUcavzYLqgv3Tjw01SDYNawOOfVJ77zFhREiksBc/
	 PNxT6k0pfIeqw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfcb5b1e2fso856104a34.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 12:42:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRm4Gmj/BpN+bHEx/Jh3aXo0oSix92RnH8YCbxudCz48/np3J2ztW8njHVeZuplWDBcY5eVsa17wBZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfb2JIXacsY6vYj6wU5q+4jgn2sRAfIBiOfQpMpbYfV/OlNPi6
	9fDA6hZELnsf/l1Cgvl25BSM+F1lX4gXszHEKe2HtZZYRrBcUvOCtxfu1wfXUXZaRLQtKxHIWiE
	6Lbs8400gEYcAgaie4mdNsPEOdnbDhFE=
X-Received: by 2002:a05:6820:2917:b0:65f:1ab0:cdca with SMTP id
 006d021491bc7-662caae62aemr595718eaf.1.1769114543636; Thu, 22 Jan 2026
 12:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com> <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
In-Reply-To: <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Jan 2026 21:42:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
X-Gm-Features: AZwV_Qg3yZuk_X0ssWawPlzuyryx_Z9geQPKaI5uf2RWtFcC456yy1UQin1ttaM
Message-ID: <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20572-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C8816D7F9
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 1/22/26 10:55, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> > <jaroslav.pulchart@gooddata.com> wrote:
> >>
> >> Hello,
> >>
> >> after upgrading from kernel 6.17.y to 6.18.y we started to observe a r=
egression
> >> in the ACPI power meter hwmon interface. Reading power*_average sysfs
> >> attributes blocks indefinitely and causes tasks to enter uninterruptib=
le
> >> sleep (D state).
> >
> > The most recent change in the acpi_power_meter driver was made in
> > 6.15, so this is not a regression in that driver.
> >
> > Also, nothing suspicious is done in power1_average_min_show() and
> > power1_average_min_store() AFAICS.
> >
>
> I suspect a circular locking problem between the hwmon lock and the
> resource lock. Unfortunately I don't immediately see it.
>
> Would it be possible to test this with a kernel which has lock debugging
> enabled ? I'd test it myself but I don't have a system available
> that supports the acpi power meter.

One problem I found in acpi_power_meter through code inspection is
calling hwmon_device_unregister() under resource->lock in
acpi_power_meter_notify(), which may be responsible for the observed
symptoms, but then I'm not sure why it started to be visible after
6.18.

> >> This affects both simple tools (e.g. cat) and monitoring agents scrapi=
ng
> >> hwmon (Prometheus via Grafana Alloy), eventually leading to hung task =
warnings
> >> and stalled metric collection.
> >>
> >> $ cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI000D:00/hwmon/hwmonX/po=
wer1_average
> >> # blocks foreverJaroslav Pulchart
> >>
> >> Blocked tasks show the following call chain:
> >>
> >> [  528.108418] u[  617.816097]  __mutex_lock.constprop.0+0x3c9/0xa00
> >> [  617.823094]  hwmon_attr_show+0x36/0x130
> >> [  617.828889]  dev_attr_show+0x19/0x60
> >> [  617.834095]  sysfs_kf_seq_show+0xbf/0x140
> >> [  617.841102]  seq_read_iter+0x112/0x510
> >> [  617.847099]  ? security_file_permission+0x8e/0xa0
> >> [  617.854101]  vfs_read+0x215/0x340
> >> [  617.860095]  ksys_read+0x61/0xe0
> >> [  617.866096]  do_syscall_64+0x5d/0xa70
> >> [  617.872097]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  617.880076] RIP: 0033:0x408d8e
> >> [  617.885204] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  617.896098] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 000000=
0000408d8e
> >> [  617.905398] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000=
000000001e
> >> [  617.915098] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  617.925099] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  617.935103] R13: 0000000000000040 R14: 000000c003e03880 R15: 000000=
0000000054
> >> [  617.944105]  </TASK>
> >> [  620.891393] usb 3-1.2: USB disconnect, device number 15
> >> [  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds=
.
> >> [  740.292941]       Tainted: G            E       6.18.6-1.gdc.el9.x8=
6_64 #1
> >> [  740.299938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [  740.313368] task:alloy           state:D stack:0     pid:5901
> >> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
> >> [  740.326290] Call Trace:
> >> [  740.331572]  <TASK>
> >> [  740.336311]  __schedule+0x2b5/0x690
> >> [  740.341312]  schedule+0x23/0x80
> >> [  740.347316]  schedule_preempt_disabled+0x11/0x20
> >> [  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
> >> [  740.360318]  hwmon_attr_show+0x36/0x130
> >> [  740.366315]  dev_attr_show+0x19/0x60
> >> [  740.372315]  sysfs_kf_seq_show+0xbf/0x140
> >> [  740.378315]  seq_read_iter+0x112/0x510
> >> [  740.384312]  ? security_file_permission+0x8e/0xa0
> >> [  740.391316]  vfs_read+0x215/0x340
> >> [  740.397336]  ksys_read+0x61/0xe0
> >> [  740.403310]  do_syscall_64+0x5d/0xa70
> >> [  740.409321]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  740.417340] RIP: 0033:0x408d8e
> >> [  740.422111] RSP: 002b:000000c003401498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  740.431439] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 000000=
0000408d8e
> >> [  740.441336] RDX: 0000000000000080 RSI: 000000c00479d800 RDI: 000000=
000000001c
> >> [  740.451326] RBP: 000000c0034014d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  740.461320] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  740.471322] R13: 0000000000000040 R14: 000000c004d4d6c0 R15: ffffff=
ffffffffff
> >> [  740.480548]  </TASK>
> >> [  740.485315] INFO: task alloy:5903 blocked for more than 123 seconds=
.
> >> [  740.494310]       Tainted: G            E       6.18.6-1.gdc.el9.x8=
6_64 #1
> >> [  740.503355] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [  740.513305] task:alloy           state:D stack:0     pid:5903
> >> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
> >> [  740.526807] Call Trace:
> >> [  740.532010]  <TASK>
> >> [  740.536313]  __schedule+0x2b5/0x690
> >> [  740.542319]  schedule+0x23/0x80
> >> [  740.547444]  schedule_preempt_disabled+0x11/0x20
> >> [  740.555324]  __mutex_lock.constprop.0+0x3c9/0xa00
> >> [  740.561576]  hwmon_attr_show+0x36/0x130
> >> [  740.567326]  dev_attr_show+0x19/0x60
> >> [  740.572315]  sysfs_kf_seq_show+0xbf/0x140
> >> [  740.578311]  seq_read_iter+0x112/0x510
> >> [  740.584311]  ? security_file_permission+0x8e/0xa0
> >> [  740.591316]  vfs_read+0x215/0x340
> >> [  740.596477]  ksys_read+0x61/0xe0
> >> [  740.601312]  do_syscall_64+0x5d/0xa70
> >> [  740.606333]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  740.614312] RIP: 0033:0x408d8e
> >> [  740.618667] RSP: 002b:000000c002217498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  740.628317] RAX: ffffffffffffffda RBX: 0000000000000027 RCX: 000000=
0000408d8e
> >> [  740.638353] RDX: 0000000000000080 RSI: 000000c006f78e80 RDI: 000000=
0000000027
> >> [  740.648314] RBP: 000000c0022174d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  740.657348] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  740.667288] R13: 0000000000000040 R14: 000000c0047276c0 R15: ffffff=
ffffffffff
> >> [  740.676348]  </TASK>
> >> [  740.680440] INFO: task alloy:5921 blocked for more than 123 seconds=
.
> >> [  740.689314]       Tainted: G            E       6.18.6-1.gdc.el9.x8=
6_64 #1
> >> [  740.698323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [  740.708314] task:alloy           state:D stack:0     pid:5921
> >> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
> >> [  740.721209] Call Trace:[  741.467334]  power_meter_read+0x1ea/0x2c0
> >> [acpi_power_meter]
> >> [  741.475320]  hwmon_attr_show+0x5e/0x130
> >> [  741.481343]  dev_attr_show+0x19/0x60
> >> [  741.487325]  sysfs_kf_seq_show+0xbf/0x140
> >> [  741.494315]  seq_read_iter+0x112/0x510
> >> [  741.498537]  ? security_file_permission+0x8e/0xa0
> >> [  741.503544]  vfs_read+0x215/0x340
> >> [  741.507125]  ksys_read+0x61/0xe0
> >> [  741.510650]  do_syscall_64+0x5d/0xa70
> >> [  741.514578]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  741.519954] RIP: 0033:0x408d8e
> >> [  741.523283] RSP: 002b:000000c007a8b498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  741.531260] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 000000=
0000408d8e
> >> [  741.538718] RDX: 0000000000000080 RSI: 000000c0060a3000 RDI: 000000=
000000001f
> >> [  741.546256] RBP: 000000c007a8b4d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  741.553731] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  741.561265] R13: 0000000000000040 R14: 000000c006dbae00 R15: ffffff=
ffffffffff
> >> [  741.568728]  </TASK>
> >> [  741.571167] INFO: task alloy:6139 blocked for more than 123 seconds=
.
> >> [  741.577893]       Tainted: G            E       6.18.6-1.gdc.el9.x8=
6_64 #1
> >> [  741.585112] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [  741.593345] task:alloy           state:D stack:0     pid:6139
> >> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
> >> [  741.604775] Call Trace:
> >> [  741.607508]  <TASK>
> >> [  741.609883]  __schedule+0x2b5/0x690
> >> [  741.613629]  schedule+0x23/0x80
> >> [  741.617023]  schedule_preempt_disabled+0x11/0x20
> >> [  741.621921]  __mutex_lock.constprop.0+0x3c9/0xa00
> >> [  741.626946]  hwmon_attr_show+0x36/0x130
> >> [  741.631052]  dev_attr_show+0x19/0x60
> >> [  741.634903]  sysfs_kf_seq_show+0xbf/0x140
> >> [  741.639231]  seq_read_iter+0x112/0x510
> >> [  741.643261]  ? security_file_permission+0x8e/0xa0
> >> [  741.648236]  vfs_read+0x215/0x340
> >> [  741.651800]  ksys_read+0x61/0xe0
> >> [  741.655302]  do_syscall_64+0x5d/0xa70
> >> [  741.659221]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  741.664566] RIP: 0033:0x408d8e
> >> [  741.667876] RSP: 002b:000000c003805498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  741.675821] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 000000=
0000408d8e
> >> [  741.683331] RDX: 0000000000000080 RSI: 000000c00731d000 RDI: 000000=
0000000023
> >> [  741.690831] RBP: 000000c0038054d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  741.698340] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  741.705812] R13: 0000000000000040 R14: 000000c00552e380 R15: ffffff=
ffffffffff
> >> [  741.713298]  </TASK>
> >> [  741.715755] INFO: task alloy:6146 blocked for more than 247 seconds=
.
> >> [  741.722459]       Tainted: G            E       6.18.6-1.gdc.el9.x8=
6_64 #1
> >> [  741.729641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [  741.737842] task:alloy           state:D stack:0     pid:6146
> >> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
> >> [  741.749353] Call Trace:
> >> [  741.752118]  <TASK>
> >> [  741.754483]  __schedule+0x2b5/0x690
> >> [  741.758268]  schedule+0x23/0x80
> >> [  741.761738]  schedule_preempt_disabled+0x11/0x20
> >> [  741.766704]  __mutex_lock.constprop.0+0x3c9/0xa00
> >> [  741.771723]  hwmon_attr_show+0x36/0x130
> >> [  741.775911]  dev_attr_show+0x19/0x60
> >> [  741.779802]  sysfs_kf_seq_show+0xbf/0x140
> >> [  741.784140]  seq_read_iter+0x112/0x510
> >> [  741.788171]  ? security_file_permission+0x8e/0xa0
> >> [  741.793223]  vfs_read+0x215/0x340
> >> [  741.796834]  ksys_read+0x61/0xe0
> >> [  741.800372]  do_syscall_64+0x5d/0xa70
> >> [  741.804312]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [  741.809713] RIP: 0033:0x408d8e
> >> [  741.813030] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
> >> 0000000000000000
> >> [  741.820985] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 000000=
0000408d8e
> >> [  741.828512] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000=
000000001e
> >> [  741.836025] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 000000=
0000000000
> >> [  741.843517] R10: 0000000000000000 R11: 0000000000000206 R12: 000000=
0000000000
> >> [  741.850996] R13: 0000000000000040 R14: 000000c003e03880 R15: 000000=
0000000054
> >> [  741.858511]  </TASK>
> >>
> >> Any help or guidance on how to fix this issue would be greatly appreci=
ated.
> >
> > To my eyes, all of the tasks above are blocking in hwmon_attr_show()
> > and I'm not sure how reading power*_average may lead to that.
> >
> > Anyway, I suspend some unexpected interaction between acpi_power_meter
> > and commit 3ad2a7b9b15d ("hwmon: Serialize accesses in hwmon core").
>

