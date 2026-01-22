Return-Path: <linux-acpi+bounces-20570-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBscHK6AcmlElgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20570-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:55:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9D6D4A0
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 20:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5A5E30071FF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F95388861;
	Thu, 22 Jan 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWqiCKiD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0E37647F
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111475; cv=none; b=OwekfkMdSMccqNOAYZG1j5If1sinRiYE87bdZ0fIgyuHkTmkfckShycxkJj4aP42XNgSv/GoWF/7ScG1BuwqFJJhgWhuAw8F8aU1FpN28KyhIJBSsGqhIHXhpn7AqpdtH5Ox4ZVqKwB+mtCSFZB31Ez+JUgKk4aGDK0XKb1DCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111475; c=relaxed/simple;
	bh=mLaH61TfNeZi5HsgN3gmj+TISyGn9FbYdWJz/w6hGPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSpOn69iXUG187A4wVxXJTrZkwbqZpSTOOuUez9xIvF+0xR6qsb4ieeG6kz+RcvaVunP07F/qrPQ4VbH23B8Jhvwyg3XDNfOnuPN0D5DiDUSYimWNl5JmVrFfU9ztL6nfDt8t4bDlxS9ZjvLTgi/607Sg008Aln951jYhDS84pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWqiCKiD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso875284b3a.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769111466; x=1769716266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyo0M+NXsguzAXuJOHqQymLg3pEHabDo9I+gpN9fO3Q=;
        b=FWqiCKiDPK/Chkr1an3IwajXDM0cx+4DdldaTzbC+dV/5YV2dtJ9J+/eHEjDV4sNZ2
         /A9xV7faDI2PP+Rx6yWlnd/4HXdMly/Oj+xF4Q3bXNL3QOaHkcC3Siv+q+1fATVBr1om
         0TA9n/1w8Cw/aybuFxVjdagzNZztKYPlbNJM7irqmY9Zc2wxBhq53+UfsTtiW7SDAE28
         zqB2tR6xgXDC+tn7b0LUe3+g6RewoSHvxwzQhW2jiuxcIJvkkd8BhYmOGd2Q5h9I+66C
         GRxaSvn+MhlDv1GbDqGDh6bl5qoVQwYxObHZSOTFmLS59yAVPKqnudsZ2a+QH5V3CGCJ
         yZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111466; x=1769716266;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wyo0M+NXsguzAXuJOHqQymLg3pEHabDo9I+gpN9fO3Q=;
        b=Iu2BN3bKg1pmQ8F8/YH4YKc02WH57lfFq4/NfXBMy4sCHxJR04LYqhoDwDpXNP7IQe
         zgzcwbO1fAFr3dM0XVUmiO/Oj9TQRgtI4bGVysDL+B+rsFf0qLGb4PyphltP9CNZ5HJ4
         CSAd45F1Utp60WWwy9opc33JFA3/y+CfDuSroVz6VVWxFZHS+qdg16iFoj4fHsPcDwjJ
         jG2hMnAHrqbbpjPOAgLaGKopg1gn0SGUx/mkj7MVTxKeIuPdGuAgxPiK+mEsghqn4eMz
         4C+nG7AymapX7bwJycZkSEobt9PBXJn00uB1KZRhoc5Uf6eGDpnoe7Bs8zrtpVLjJBB1
         wMew==
X-Gm-Message-State: AOJu0Yw/neMTwRBiuLvIRmBn67CsmxOmsfFY/a1JigUraMncC6b94fde
	DTYqasL/PkRX0kI7x+V2sgpGEeASSY1Ks4Rmek2WfUaYL3gAIg65A0VaRd6CI0Eu
X-Gm-Gg: AZuq6aL3mGFXgJz6j0r+43T4dMayX40yvFwDhyNKV9/U7mrDTWfcOSw/e1cbDWWykyQ
	0WCuOIz/n7E3u31km0qccQdGgMhr8xFci8N4cxpuumObj2gAPg+sqVxY9jj/418Aa9Pw2FTWSRd
	nPHDiuT/dmx8l4oOb+jVdMYFZKC4mykRtDrz3vUco+A14tiExIU06DYM7917Bly1GRUQ0nN2inb
	MakMZDuIqphEJLnUk1HnxHWVkWRYiQgdA97TchoNjBKzllhJ0iKIEz2O9ebCo/jwFUds6XmohI1
	mvJH6R4GE5+zmte4vfMRGndFkcDWsHeDqy112R6nSPELWzFXNdJiUU0f0Bwbux6wKT5NOQWBAJi
	HSpLRDxK6gbfcMJqErD5eiQocD31NJDCJPePR0xk/QEQ5rOG982QDstEQJdot4k5oAleDH9LNI4
	jUFPo+u29AbD5jLRHXPzDWc6w0r+3lNZYJqO5AobnIzEGyTQaqEkNR87okFTl1
X-Received: by 2002:a05:6a00:4394:b0:81f:852b:a932 with SMTP id d2e1a72fcca58-82317d1d8e1mr344723b3a.25.1769111466004;
        Thu, 22 Jan 2026 11:51:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871ccc2sm172858b3a.36.2026.01.22.11.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:51:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
Date: Thu, 22 Jan 2026 11:51:03 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20570-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: C3D9D6D4A0
X-Rspamd-Action: no action

On 1/22/26 10:55, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
> <jaroslav.pulchart@gooddata.com> wrote:
>>
>> Hello,
>>
>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>> sleep (D state).
> 
> The most recent change in the acpi_power_meter driver was made in
> 6.15, so this is not a regression in that driver.
> 
> Also, nothing suspicious is done in power1_average_min_show() and
> power1_average_min_store() AFAICS.
> 

I suspect a circular locking problem between the hwmon lock and the
resource lock. Unfortunately I don't immediately see it.

Would it be possible to test this with a kernel which has lock debugging
enabled ? I'd test it myself but I don't have a system available
that supports the acpi power meter.

Thanks,
Guenter

>> This affects both simple tools (e.g. cat) and monitoring agents scraping
>> hwmon (Prometheus via Grafana Alloy), eventually leading to hung task warnings
>> and stalled metric collection.
>>
>> $ cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI000D:00/hwmon/hwmonX/power1_average
>> # blocks foreverJaroslav Pulchart
>>
>> Blocked tasks show the following call chain:
>>
>> [  528.108418] u[  617.816097]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  617.823094]  hwmon_attr_show+0x36/0x130
>> [  617.828889]  dev_attr_show+0x19/0x60
>> [  617.834095]  sysfs_kf_seq_show+0xbf/0x140
>> [  617.841102]  seq_read_iter+0x112/0x510
>> [  617.847099]  ? security_file_permission+0x8e/0xa0
>> [  617.854101]  vfs_read+0x215/0x340
>> [  617.860095]  ksys_read+0x61/0xe0
>> [  617.866096]  do_syscall_64+0x5d/0xa70
>> [  617.872097]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  617.880076] RIP: 0033:0x408d8e
>> [  617.885204] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  617.896098] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000408d8e
>> [  617.905398] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000000000001e
>> [  617.915098] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 0000000000000000
>> [  617.925099] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  617.935103] R13: 0000000000000040 R14: 000000c003e03880 R15: 0000000000000054
>> [  617.944105]  </TASK>
>> [  620.891393] usb 3-1.2: USB disconnect, device number 15
>> [  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds.
>> [  740.292941]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
>> [  740.299938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.313368] task:alloy           state:D stack:0     pid:5901
>> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.326290] Call Trace:
>> [  740.331572]  <TASK>
>> [  740.336311]  __schedule+0x2b5/0x690
>> [  740.341312]  schedule+0x23/0x80
>> [  740.347316]  schedule_preempt_disabled+0x11/0x20
>> [  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  740.360318]  hwmon_attr_show+0x36/0x130
>> [  740.366315]  dev_attr_show+0x19/0x60
>> [  740.372315]  sysfs_kf_seq_show+0xbf/0x140
>> [  740.378315]  seq_read_iter+0x112/0x510
>> [  740.384312]  ? security_file_permission+0x8e/0xa0
>> [  740.391316]  vfs_read+0x215/0x340
>> [  740.397336]  ksys_read+0x61/0xe0
>> [  740.403310]  do_syscall_64+0x5d/0xa70
>> [  740.409321]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  740.417340] RIP: 0033:0x408d8e
>> [  740.422111] RSP: 002b:000000c003401498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  740.431439] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 0000000000408d8e
>> [  740.441336] RDX: 0000000000000080 RSI: 000000c00479d800 RDI: 000000000000001c
>> [  740.451326] RBP: 000000c0034014d8 R08: 0000000000000000 R09: 0000000000000000
>> [  740.461320] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  740.471322] R13: 0000000000000040 R14: 000000c004d4d6c0 R15: ffffffffffffffff
>> [  740.480548]  </TASK>
>> [  740.485315] INFO: task alloy:5903 blocked for more than 123 seconds.
>> [  740.494310]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
>> [  740.503355] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.513305] task:alloy           state:D stack:0     pid:5903
>> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.526807] Call Trace:
>> [  740.532010]  <TASK>
>> [  740.536313]  __schedule+0x2b5/0x690
>> [  740.542319]  schedule+0x23/0x80
>> [  740.547444]  schedule_preempt_disabled+0x11/0x20
>> [  740.555324]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  740.561576]  hwmon_attr_show+0x36/0x130
>> [  740.567326]  dev_attr_show+0x19/0x60
>> [  740.572315]  sysfs_kf_seq_show+0xbf/0x140
>> [  740.578311]  seq_read_iter+0x112/0x510
>> [  740.584311]  ? security_file_permission+0x8e/0xa0
>> [  740.591316]  vfs_read+0x215/0x340
>> [  740.596477]  ksys_read+0x61/0xe0
>> [  740.601312]  do_syscall_64+0x5d/0xa70
>> [  740.606333]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  740.614312] RIP: 0033:0x408d8e
>> [  740.618667] RSP: 002b:000000c002217498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  740.628317] RAX: ffffffffffffffda RBX: 0000000000000027 RCX: 0000000000408d8e
>> [  740.638353] RDX: 0000000000000080 RSI: 000000c006f78e80 RDI: 0000000000000027
>> [  740.648314] RBP: 000000c0022174d8 R08: 0000000000000000 R09: 0000000000000000
>> [  740.657348] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  740.667288] R13: 0000000000000040 R14: 000000c0047276c0 R15: ffffffffffffffff
>> [  740.676348]  </TASK>
>> [  740.680440] INFO: task alloy:5921 blocked for more than 123 seconds.
>> [  740.689314]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
>> [  740.698323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  740.708314] task:alloy           state:D stack:0     pid:5921
>> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  740.721209] Call Trace:[  741.467334]  power_meter_read+0x1ea/0x2c0
>> [acpi_power_meter]
>> [  741.475320]  hwmon_attr_show+0x5e/0x130
>> [  741.481343]  dev_attr_show+0x19/0x60
>> [  741.487325]  sysfs_kf_seq_show+0xbf/0x140
>> [  741.494315]  seq_read_iter+0x112/0x510
>> [  741.498537]  ? security_file_permission+0x8e/0xa0
>> [  741.503544]  vfs_read+0x215/0x340
>> [  741.507125]  ksys_read+0x61/0xe0
>> [  741.510650]  do_syscall_64+0x5d/0xa70
>> [  741.514578]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  741.519954] RIP: 0033:0x408d8e
>> [  741.523283] RSP: 002b:000000c007a8b498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  741.531260] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 0000000000408d8e
>> [  741.538718] RDX: 0000000000000080 RSI: 000000c0060a3000 RDI: 000000000000001f
>> [  741.546256] RBP: 000000c007a8b4d8 R08: 0000000000000000 R09: 0000000000000000
>> [  741.553731] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  741.561265] R13: 0000000000000040 R14: 000000c006dbae00 R15: ffffffffffffffff
>> [  741.568728]  </TASK>
>> [  741.571167] INFO: task alloy:6139 blocked for more than 123 seconds.
>> [  741.577893]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
>> [  741.585112] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  741.593345] task:alloy           state:D stack:0     pid:6139
>> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  741.604775] Call Trace:
>> [  741.607508]  <TASK>
>> [  741.609883]  __schedule+0x2b5/0x690
>> [  741.613629]  schedule+0x23/0x80
>> [  741.617023]  schedule_preempt_disabled+0x11/0x20
>> [  741.621921]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  741.626946]  hwmon_attr_show+0x36/0x130
>> [  741.631052]  dev_attr_show+0x19/0x60
>> [  741.634903]  sysfs_kf_seq_show+0xbf/0x140
>> [  741.639231]  seq_read_iter+0x112/0x510
>> [  741.643261]  ? security_file_permission+0x8e/0xa0
>> [  741.648236]  vfs_read+0x215/0x340
>> [  741.651800]  ksys_read+0x61/0xe0
>> [  741.655302]  do_syscall_64+0x5d/0xa70
>> [  741.659221]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  741.664566] RIP: 0033:0x408d8e
>> [  741.667876] RSP: 002b:000000c003805498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  741.675821] RAX: ffffffffffffffda RBX: 0000000000000023 RCX: 0000000000408d8e
>> [  741.683331] RDX: 0000000000000080 RSI: 000000c00731d000 RDI: 0000000000000023
>> [  741.690831] RBP: 000000c0038054d8 R08: 0000000000000000 R09: 0000000000000000
>> [  741.698340] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  741.705812] R13: 0000000000000040 R14: 000000c00552e380 R15: ffffffffffffffff
>> [  741.713298]  </TASK>
>> [  741.715755] INFO: task alloy:6146 blocked for more than 247 seconds.
>> [  741.722459]       Tainted: G            E       6.18.6-1.gdc.el9.x86_64 #1
>> [  741.729641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [  741.737842] task:alloy           state:D stack:0     pid:6146
>> tgid:5899  ppid:1      task_flags:0x400140 flags:0x00080001
>> [  741.749353] Call Trace:
>> [  741.752118]  <TASK>
>> [  741.754483]  __schedule+0x2b5/0x690
>> [  741.758268]  schedule+0x23/0x80
>> [  741.761738]  schedule_preempt_disabled+0x11/0x20
>> [  741.766704]  __mutex_lock.constprop.0+0x3c9/0xa00
>> [  741.771723]  hwmon_attr_show+0x36/0x130
>> [  741.775911]  dev_attr_show+0x19/0x60
>> [  741.779802]  sysfs_kf_seq_show+0xbf/0x140
>> [  741.784140]  seq_read_iter+0x112/0x510
>> [  741.788171]  ? security_file_permission+0x8e/0xa0
>> [  741.793223]  vfs_read+0x215/0x340
>> [  741.796834]  ksys_read+0x61/0xe0
>> [  741.800372]  do_syscall_64+0x5d/0xa70
>> [  741.804312]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  741.809713] RIP: 0033:0x408d8e
>> [  741.813030] RSP: 002b:000000c004fed498 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000000
>> [  741.820985] RAX: ffffffffffffffda RBX: 000000000000001e RCX: 0000000000408d8e
>> [  741.828512] RDX: 0000000000000080 RSI: 000000c004db7a80 RDI: 000000000000001e
>> [  741.836025] RBP: 000000c004fed4d8 R08: 0000000000000000 R09: 0000000000000000
>> [  741.843517] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>> [  741.850996] R13: 0000000000000040 R14: 000000c003e03880 R15: 0000000000000054
>> [  741.858511]  </TASK>
>>
>> Any help or guidance on how to fix this issue would be greatly appreciated.
> 
> To my eyes, all of the tasks above are blocking in hwmon_attr_show()
> and I'm not sure how reading power*_average may lead to that.
> 
> Anyway, I suspend some unexpected interaction between acpi_power_meter
> and commit 3ad2a7b9b15d ("hwmon: Serialize accesses in hwmon core").


