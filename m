Return-Path: <linux-acpi+bounces-20568-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEWGC+NqcmkGkwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20568-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:22:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928FA6C4E8
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA623009F98
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FE376497;
	Thu, 22 Jan 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="X29H1S4v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061062C158A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106108; cv=pass; b=jv6n909uTSIYP+PfkszDv6R3XBrA2IYJyOhYMiNGisqnm1zoDvKJxzYMvQ3CGAitC4AsURxJMr9LDN0b9XCKp84K14wCIxbWUALLXsWSqqGy7I5DVtUTKcdL6HTIKEyv0K5eG6H8kFOcD9BxoXKHeMYso9XbRyTh4qQh100zdP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106108; c=relaxed/simple;
	bh=VhooRDxRH7BCE6BJvUO/eqRRlhR9iYQiXGVIVK9NRIk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q8f9yCi5rwtbHQg3IBKdXVbxQugjC5vOKYZX2WbScpEZiz2oWVuq91FAuxGoMLac4iVuUkcYKSeSbeG3U8UlQAnPjlJKJ7KZAlrk7ID160P2CAoZedSczXXVl/DoTauyBeE82D32DCuEMoNFCsQVd85R+/Hi12gv2/cUV6i628w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=X29H1S4v; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6f85470b6so2623018eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 10:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106099; cv=none;
        d=google.com; s=arc-20240605;
        b=bWT7DB85Xh0MqnXNRqHEe/68S1OoDw21dVU1EAjyqXmtAE/FDM1TICxw7qefsg/G8N
         LeVVYFmXVI8cNm+rVsHqcDWAXkjAD5ffoqWPueaJlNkkSZu0lph32FiGo6SUDY/gAarf
         TlILjLKJVlAG1hZDm9zlgAOFYs/i2BD86m/Eo71mZ2dpQWyMjXd8tXsNsqEZ1XAa2kQb
         fS4eKcvQQGh7Hzro8UHi3CZswesZZL8SAHsRzfVFc0vvgP2Qwu3MkwaVmWWPjDj1Qqg9
         MQOndp1XKt5WWjLPv2GPdD8YZuFpqdATMcwZnavE57k3TUB+Mg/+mtT3mwYMUy2nQlWW
         ddtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0MzuJtp8q1PRl9d8Ezimoh0lMOyUjuJJE2l+zzr12ig=;
        fh=WHCe2qbtH+bYmL78e67lL6PU3GGimSRw3bx5h+B6ogc=;
        b=DV+jX5lasyPxbOxcAr4my9fWjcyTR7Q850DwEMxkZHcjiFPEsMNLRgnK1Mpsy7uNCC
         N0U+VLipqhqoUpfKXnBlm7vjwIPZDQVwT2UGDfI47zJAj9/YRS8O/KfqZqNxuYrO+YcV
         un8/RJqNGZzsIlR9f8+RX23m8RkPz5f9RP+WXQXMEXCiR7/JNZUid/iEvqzAyDgqFMrA
         bCeGjViEF7dZYMl8sfSVlXbfgDDsLkHQCGyqZy74lMJBFWTMFzQnlnO3GjGbPplhIWfF
         UralUcoQ89jhYxwkXl0wlh2E6PGFtlyYVaPKIL+q5OIRJ4V1sVgUauUBZxgXT73VX7lF
         vXUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1769106099; x=1769710899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MzuJtp8q1PRl9d8Ezimoh0lMOyUjuJJE2l+zzr12ig=;
        b=X29H1S4vp+zV5NPPWHrLySUdmMt+CEbZ2ifY+VPeIN8dFfdSZpdyT47GOrPTNxt8+s
         LmiX4oZMXICIN4S03GYzHf1lPAFEyDU7tTzRQ5L4guApUSGrCGtp746iHLh6Wt4oqYTL
         dsQ70SppdJJEEe9pq1G0b9rDtaWHom/MJ+nQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106099; x=1769710899;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MzuJtp8q1PRl9d8Ezimoh0lMOyUjuJJE2l+zzr12ig=;
        b=nN/NUGWYmcj4UvWt0QuCqt1lNl6lsD6U7fnOkoXknt39Ydmw4FVo3MEyqVdIgjsL7K
         Ofqy+VjTXIHGdRh4FiM4iGs10FyMuFn3XFF0gre820crKDc8S4GaQ7DN5uFrCvrzq4p9
         UidTMyRxVrUqHV5+znqcdcLrYcgoB8z2NgHzcMQa/hVMhXpgPifFT+vM/1L+bN4rLh43
         7mvZqs7lEGAidZQvTnUxxfXj1jvS7de8aZLjf2OxnPSC1rnmsvpd7ajHF94ejPoOJSqg
         kFLE8dIb4Y0bGsQVZjrWMkL0pm+gUn6MnX3zJqtEo+/NHAxYITnzk4A+sOpOdJR6A0PO
         CM6g==
X-Gm-Message-State: AOJu0YxOxyVdRkfE01IEzoGsbJRrex9kxdRh8at1tVgziOdTmYZf7rWo
	JdGkO+ZQX9ePbp2kuk83lvyyZ4W3qqfcgcGT5OTqibERJPzoD3PgxJBz5viHpvgX+xxpcbSF1o7
	STWVMaa4+wATpSYJCa0vsdUvise0d+CLRUCLUvwL+eldo8MIL2oTIBg==
X-Gm-Gg: AZuq6aJUvpdp5FR4ItsX1vnKqvs2hYhAy7qC0Ftvi66NalXOi/28DQRJEf0RzvgwXqL
	KygcGkeSvRWDcFNUsVBxG/RYaSuPTTKaDufKfnEX3F0rKGzjx9JkCDzayIoaAhTTQvDYgRPhPns
	Rckp6fi5IWUuH17OZwMgVDymBLZmbgV5g4Qsg0XvpuBmzA2JU1uEVpGR43Rh9Ln657lGOpIpnJ/
	oupJ2PX+9v7CcHqej9pLmAP759JrAGYPKVrc0ZlQAhc1DGe4BV+dnHS0U4qtIrw3xssjRXN
X-Received: by 2002:a05:7300:a507:b0:2b1:7910:b102 with SMTP id
 5a478bee46e88-2b739bd5d0fmr155624eec.37.1769106098756; Thu, 22 Jan 2026
 10:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 22 Jan 2026 19:21:11 +0100
X-Gm-Features: AZwV_Qh_bOcLy7884GZpUPmlbyyvzCqiPSLKlOSY7iBGuh3BMOizgEkJIsajebE
Message-ID: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
Subject: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock in
 hwmon_attr_show since v6.18.y
To: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20568-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gooddata.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gooddata.com:dkim]
X-Rspamd-Queue-Id: 928FA6C4E8
X-Rspamd-Action: no action

Hello,

after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
in the ACPI power meter hwmon interface. Reading power*_average sysfs
attributes blocks indefinitely and causes tasks to enter uninterruptible
sleep (D state).

This affects both simple tools (e.g. cat) and monitoring agents scraping
hwmon (Prometheus via Grafana Alloy), eventually leading to hung task warnings
and stalled metric collection.

$ cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI000D:00/hwmon/hwmonX/power1_average
# blocks foreverJaroslav Pulchart

Blocked tasks show the following call chain:

[  528.108418] u[  617.816097]  __mutex_lock.constprop.0+0x3c9/0xa00
[  617.823094]  hwmon_attr_show+0x36/0x130
[  617.828889]  dev_attr_show+0x19/0x60
[  617.834095]  sysfs_kf_seq_show+0xbf/0x140
[  617.841102]  seq_read_iter+0x112/0x510
[  617.847099]  ? security_file_permission+0x8e/0xa0
[  617.854101]  vfs_read+0x215/0x340
[  617.860095]  ksys_read+0x61/0xe0
[  617.866096]  do_syscall_64+0x5d/0xa70
[  617.872097]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  617.880076] RIP: 0033:0x408d8e
[  617.885204] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  617.896098] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000408d8e
[  617.905398] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000000000001e
[  617.915098] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 0000000000000000
[  617.925099] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  617.935103] R13: 0000000000000040 R14: 000000c003e03880 R15: 0000000000000054
[  617.944105]  </TASK>
[  620.891393] usb 3-1.2: USB disconnect, device number 15
[  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds.
[  740.292941]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
[  740.299938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  740.313368] task:alloy           state:D stack:0     pid:5901
tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
[  740.326290] Call Trace:
[  740.331572]  <TASK>
[  740.336311]  __schedule+0x2b5/0x690
[  740.341312]  schedule+0x23/0x80
[  740.347316]  schedule_preempt_disabled+0x11/0x20
[  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
[  740.360318]  hwmon_attr_show+0x36/0x130
[  740.366315]  dev_attr_show+0x19/0x60
[  740.372315]  sysfs_kf_seq_show+0xbf/0x140
[  740.378315]  seq_read_iter+0x112/0x510
[  740.384312]  ? security_file_permission+0x8e/0xa0
[  740.391316]  vfs_read+0x215/0x340
[  740.397336]  ksys_read+0x61/0xe0
[  740.403310]  do_syscall_64+0x5d/0xa70
[  740.409321]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  740.417340] RIP: 0033:0x408d8e
[  740.422111] RSP: 002b:000000c003401498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  740.431439] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 0000000000408d8e
[  740.441336] RDX: 0000000000000080 RSI: 000000c00479d800 RDI: 000000000000001c
[  740.451326] RBP: 000000c0034014d8 R08: 0000000000000000 R09: 0000000000000000
[  740.461320] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  740.471322] R13: 0000000000000040 R14: 000000c004d4d6c0 R15: ffffffffffffffff
[  740.480548]  </TASK>
[  740.485315] INFO: task alloy:5903 blocked for more than 123 seconds.
[  740.494310]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
[  740.503355] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  740.513305] task:alloy           state:D stack:0     pid:5903
tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
[  740.526807] Call Trace:
[  740.532010]  <TASK>
[  740.536313]  __schedule+0x2b5/0x690
[  740.542319]  schedule+0x23/0x80
[  740.547444]  schedule_preempt_disabled+0x11/0x20
[  740.555324]  __mutex_lock.constprop.0+0x3c9/0xa00
[  740.561576]  hwmon_attr_show+0x36/0x130
[  740.567326]  dev_attr_show+0x19/0x60
[  740.572315]  sysfs_kf_seq_show+0xbf/0x140
[  740.578311]  seq_read_iter+0x112/0x510
[  740.584311]  ? security_file_permission+0x8e/0xa0
[  740.591316]  vfs_read+0x215/0x340
[  740.596477]  ksys_read+0x61/0xe0
[  740.601312]  do_syscall_64+0x5d/0xa70
[  740.606333]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  740.614312] RIP: 0033:0x408d8e
[  740.618667] RSP: 002b:000000c002217498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  740.628317] RAX: ffffffffffffffda RBX: 0000000000000027 RCX: 0000000000408d8e
[  740.638353] RDX: 0000000000000080 RSI: 000000c006f78e80 RDI: 0000000000000027
[  740.648314] RBP: 000000c0022174d8 R08: 0000000000000000 R09: 0000000000000000
[  740.657348] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  740.667288] R13: 0000000000000040 R14: 000000c0047276c0 R15: ffffffffffffffff
[  740.676348]  </TASK>
[  740.680440] INFO: task alloy:5921 blocked for more than 123 seconds.
[  740.689314]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
[  740.698323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  740.708314] task:alloy           state:D stack:0     pid:5921
tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
[  740.721209] Call Trace:[  741.467334]  power_meter_read+0x1ea/0x2c0
[acpi_power_meter]
[  741.475320]  hwmon_attr_show+0x5e/0x130
[  741.481343]  dev_attr_show+0x19/0x60
[  741.487325]  sysfs_kf_seq_show+0xbf/0x140
[  741.494315]  seq_read_iter+0x112/0x510
[  741.498537]  ? security_file_permission+0x8e/0xa0
[  741.503544]  vfs_read+0x215/0x340
[  741.507125]  ksys_read+0x61/0xe0
[  741.510650]  do_syscall_64+0x5d/0xa70
[  741.514578]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  741.519954] RIP: 0033:0x408d8e
[  741.523283] RSP: 002b:000000c007a8b498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  741.531260] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 0000000000408d8e
[  741.538718] RDX: 0000000000000080 RSI: 000000c0060a3000 RDI: 000000000000001f
[  741.546256] RBP: 000000c007a8b4d8 R08: 0000000000000000 R09: 0000000000000000
[  741.553731] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  741.561265] R13: 0000000000000040 R14: 000000c006dbae00 R15: ffffffffffffffff
[  741.568728]  </TASK>
[  741.571167] INFO: task alloy:6139 blocked for more than 123 seconds.
[  741.577893]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
[  741.585112] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  741.593345] task:alloy           state:D stack:0     pid:6139
tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
[  741.604775] Call Trace:
[  741.607508]  <TASK>
[  741.609883]  __schedule+0x2b5/0x690
[  741.613629]  schedule+0x23/0x80
[  741.617023]  schedule_preempt_disabled+0x11/0x20
[  741.621921]  __mutex_lock.constprop.0+0x3c9/0xa00
[  741.626946]  hwmon_attr_show+0x36/0x130
[  741.631052]  dev_attr_show+0x19/0x60
[  741.634903]  sysfs_kf_seq_show+0xbf/0x140
[  741.639231]  seq_read_iter+0x112/0x510
[  741.643261]  ? security_file_permission+0x8e/0xa0
[  741.648236]  vfs_read+0x215/0x340
[  741.651800]  ksys_read+0x61/0xe0
[  741.655302]  do_syscall_64+0x5d/0xa70
[  741.659221]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  741.664566] RIP: 0033:0x408d8e
[  741.667876] RSP: 002b:000000c003805498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  741.675821] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 0000000000408d8e
[  741.683331] RDX: 0000000000000080 RSI: 000000c00731d000 RDI: 0000000000000023
[  741.690831] RBP: 000000c0038054d8 R08: 0000000000000000 R09: 0000000000000000
[  741.698340] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  741.705812] R13: 0000000000000040 R14: 000000c00552e380 R15: ffffffffffffffff
[  741.713298]  </TASK>
[  741.715755] INFO: task alloy:6146 blocked for more than 247 seconds.
[  741.722459]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
[  741.729641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  741.737842] task:alloy           state:D stack:0     pid:6146
tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
[  741.749353] Call Trace:
[  741.752118]  <TASK>
[  741.754483]  __schedule+0x2b5/0x690
[  741.758268]  schedule+0x23/0x80
[  741.761738]  schedule_preempt_disabled+0x11/0x20
[  741.766704]  __mutex_lock.constprop.0+0x3c9/0xa00
[  741.771723]  hwmon_attr_show+0x36/0x130
[  741.775911]  dev_attr_show+0x19/0x60
[  741.779802]  sysfs_kf_seq_show+0xbf/0x140
[  741.784140]  seq_read_iter+0x112/0x510
[  741.788171]  ? security_file_permission+0x8e/0xa0
[  741.793223]  vfs_read+0x215/0x340
[  741.796834]  ksys_read+0x61/0xe0
[  741.800372]  do_syscall_64+0x5d/0xa70
[  741.804312]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  741.809713] RIP: 0033:0x408d8e
[  741.813030] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
0000000000000000
[  741.820985] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000408d8e
[  741.828512] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000000000001e
[  741.836025] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 0000000000000000
[  741.843517] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[  741.850996] R13: 0000000000000040 R14: 000000c003e03880 R15: 0000000000000054
[  741.858511]  </TASK>

Any help or guidance on how to fix this issue would be greatly appreciated.

Best,
Jaroslav Pulchart

