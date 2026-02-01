Return-Path: <linux-acpi+bounces-20797-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFNTNCcpf2kMlAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20797-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 11:21:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4DC56C4
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 11:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA1DF30022F8
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ECE2E8B8B;
	Sun,  1 Feb 2026 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i7WiGSJD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE62701B1;
	Sun,  1 Feb 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941284; cv=none; b=JqAACEFLd6NnhI7HiIe3p/Ni5seJtcDIIXohud3Vu6IJ9pJrBZAzAKdDvpubtOgDKQ/CdFrotRTG5WbHfuqg87Dlki6EbmZ4pyzRI5RY89Jb0R2D0ZWdxXXvjztNszW3e+j4YbAyxY0gobscmwQkStC4T/LM1Bgxk3AWJjGo7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941284; c=relaxed/simple;
	bh=uTcjg7oWuXYWxhI5viZWpG4AjyZYMiFFCHK6hnZNmbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CubgFvL3u8ObK/5wC5bOxkKmZuF9fJ57XyC1+3zrcdP5ayxuTFgo4MaqxZTBRL+GxFp0O12S6RdbhZweKgVMsGYJI8rafFAzvn2Qfsu8+eHciQGE+1JyGeaLV7Tk+L3vSpNlgKNXA2UJPYwDZ0ImpqReBq798mOm19fTimUkmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i7WiGSJD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769941198; x=1770545998; i=w_armin@gmx.de;
	bh=9x7HpyWOhbUGkwEQIBNa7vexJVFMvQ6wdp3e0Aovy30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i7WiGSJDLPksZeJeN5ZeGfcXT7eTrn9bq5uASZzw91IbSbkTGvCX3bGW5ohJlN3C
	 wx84muhLR71ozgINowEpd1vThw+c2KFdRCmJzz7nQo0+4Q1umF2mN3GIHPhw1vIFp
	 OMaBUFWpB4g2E0lDD0z1zu5aadXmRG7V9gASh3cbHHVYRQUldlR+CWotRkVgbgXVl
	 RPNKWHTOrbl9Xkt6mYzFMMLgsKk2iwNKEay6CYdzqm3+n/u/ZnJMkfdBQyDTobGQK
	 ve21mPDQVdQgW/a34ehaW/wQKbq13nwr56riwW6xpGTr0oeAZh71ssKMDmvcDU1v1
	 69zzkepqCcmcJa99Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.66.134.249] ([164.15.244.57]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mulm5-1w3TTi22Jn-00t7V6; Sun, 01
 Feb 2026 11:19:58 +0100
Message-ID: <2a4e5667-ae24-403f-8fbd-cb37bd66f055@gmx.de>
Date: Sun, 1 Feb 2026 11:19:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
To: Bert Karwatzki <spasswolf@web.de>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev,
 Robert Moore <robert.moore@intel.com>, Saket Dumbre
 <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Clemens Ladisch <clemens@ladisch.de>, Jinchao Wang
 <wangjinchao600@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, Baoquan He <bhe@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Young <dyoung@redhat.com>,
 Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joanthan Cameron <Jonathan.Cameron@huawei.com>,
 Joel Granados <joel.granados@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>,
 Li Huafei <lihuafei1@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
 Luo Gengkun <luogengkun@huaweicloud.com>,
 Max Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo <tj@kernel.org>,
 Thomas Zimemrmann <tzimmermann@suse.de>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de> <87v7h5ia3d.ffs@tglx>
 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
 <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
 <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TYg08LGyCYWL0RjzI4ONXXWizRQBxv3kR0Vr5r4HV9kjJpvdgCk
 0/euWXpFGLD3gHCPcA7Nn4THoLVo8V1+lhIVEn1W7cOXNQTJObE8suIv4sTMUWnXfEsO+m4
 nbNJlDZrG0yHIOgLOST7YGB7Ei63IJwRrysLzSek8cIyf831VirJFVUZAhDI95fwV4TOtqH
 UUCCKBtgJtb4pRxIeMQlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AveMuN3d2N4=;Qo9YCR/IA9BExtuLwf39GJ6cxAA
 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
 G4SLRa/k=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20797-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[web.de,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,linutronix.de,kernel.org,goodmis.org,lists.linux.dev,intel.com,google.com,ladisch.de,gmail.com,oracle.com,redhat.com,chromium.org,igalia.com,gmx.de,ziepe.ca,huawei.com,huaweicloud.com,ionos.com,kylinos.cn,suse.com,163.com,suse.de,linux.dev,linux.intel.com,bytedance.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71B4DC56C4
X-Rspamd-Action: no action

Am 01.02.26 um 01:36 schrieb Bert Karwatzki:

> I found the error, the commit
> ("drm/amd: Check if ASPM is enabled from PCIe subsystem")
> has been applied twice first as cba07cce39ac and a second time
> as 7294863a6f01 after it had been superseeded by commit
> 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> This effectively disables ASPM globally after the built-in GPU (which does not
> support ASPM) is probed. This is the reason for the crashes and loss of devices
> errors which on average occur after ~1000 resumes of the discrete GPU.
>
> snippet from git log --oneline drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c in linux-next:
> 158a05a0b885 drm/amdgpu: Add use_xgmi_p2p module parameter
> 7294863a6f01 drm/amd: Check if ASPM is enabled from PCIe subsystem  <--- This does not belong here!
> b784f42cf78b drm/amdgpu: drop testing module parameter
> 0b1a63487b0f drm/amdgpu: drop benchmark module parameter
> cec2cc7b1c4a drm/amdgpu: Fix typo in *whether* in comment
> 0ab5d711ec74 drm/amd: Refactor `amdgpu_aspm` to be evaluated per device <--- This removes the code from the previous commit.
> cba07cce39ac drm/amd: Check if ASPM is enabled from PCIe subsystem  <--- The first time the commit was applied.
> dfcc3e8c24cc drm/amdgpu: make cyan skillfish support code more consistent
>
> The fix is simply to revert commit 7294863a6f01.
>
> I sent a patch for linux-next (unfortunately without CC'ing stable) and a seperate patch for
> v6.18.8, I hope this does not cause confusion ...
>
> Bert Karwatzki

Good work! Thank you for researching the faulty commit that lead to this strange behavior.

Thanks,
Armin Wolf


