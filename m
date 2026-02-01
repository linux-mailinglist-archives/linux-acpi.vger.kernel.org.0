Return-Path: <linux-acpi+bounces-20796-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOE7DE2gfml4bgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20796-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 01:37:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7EC4812
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 01:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79E433015D0C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 00:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB875809;
	Sun,  1 Feb 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="AEB0eUox"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62133D3B3;
	Sun,  1 Feb 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769906246; cv=none; b=fpkh3Q3GClxfKpRxYAJciM4pXOt/Yp5Y5eaSuF6hhIJOkEckCEkTaa3M1R++ey2FrcUe2JDHqFK26WGekZrwGTQY9xoMPwgF6rS/BBiIdEMGweyJ1n38fHDYYgjP5P35qhSEN/fghZDDGGZb4vGFFa9z9GiKD9+eyAGMTH/Bfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769906246; c=relaxed/simple;
	bh=M9f3xQcMKfs3bdFACBnKQPaShhwNpcUNN6CNNUiur7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Je+jRGjxeJ8AhE1WHv4EZElE5BPSqQAuZJsRILpyHhN3XO1RMJt09c/c53vbFmd6H7PQNi+pU29FiMNWSvxo28JOK1QNj3emSWRMfOCzxyI12IGzO9YDwzKKZUtG0V0hbdj5JKyYPnSJ1iRl/ZywH1cIVH1R1lQ7bKsu4cCFsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=AEB0eUox; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769906234; x=1770511034; i=spasswolf@web.de;
	bh=uV1KkRkswps/y1vskJMTVFJUBHlJRig50GzAfcy3NiU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AEB0eUox1bmxRX3KdqrdCQzc7IMb3ayTelSJVJGxfJlzR4/vI0Ii26UqENl6waLJ
	 kmjYfXzHPJCiJykx59MVdtbsBU7BN+hZTdkZ5Lbx2bqG4+1NHpv+heGjekzRj8xah
	 uT6oE3a5c7oZ0sR8l3Tl9k8QnysWXtBEkfN7egVOo9ityBnaUHcpOPksP1gblTFyV
	 YWLMTSx0ML+2kcGh/QuD941XHTI93SlfnOlFvstXa2uSLvs5VQQfxOHMwRhKPh36K
	 SYsyRCszXWFi7BVu2YVKe+Rq2AiOOwpwfF12Z0OtjCOqvp6uPPJn1BCS/H0vgisvp
	 I1QoYpKsBIJUS9yRuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqTE-1vI99Y1Vvi-00LtdD; Sun, 01
 Feb 2026 01:37:14 +0100
Message-ID: <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
From: Bert Karwatzki <spasswolf@web.de>
To: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello	
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore	
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang	 <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker	 <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong"	 <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson	 <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,  Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness	 <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei	 <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun	 <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek	 <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo	
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum	
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton	 <akpm@linux-foundation.org>, W_Armin@gmx.de
Date: Sun, 01 Feb 2026 01:36:59 +0100
In-Reply-To: <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
				 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
				 <87v7h5ia3d.ffs@tglx>
			 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
		 <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ldg1CeCCa6IXoP+cbbNUJlfqAbKLGP9lWuW1VHGnbikA2PH9fxH
 tf4RgYBTf5J8afA50l1gkRj+jjICujNwLQOedJqTyw1boPyUcVN3JUm0LwfA9Crsl5utYy4
 0hlfkQrT/JN3xuEHo+PCbzYW55VyxJSRHLIJDUDIe6E6Zgw7HNn0Ap+KXMuek8T/yyB6Obd
 4kLsS25u2ylVm3iX7GLVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7bvmpxHrgwI=;/MwO6G0jMF6J5q3ySvLB1ZndN0n
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20796-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,amd.com,linutronix.de,kernel.org,goodmis.org,lists.linux.dev,intel.com,google.com,ladisch.de,gmail.com,oracle.com,redhat.com,chromium.org,igalia.com,gmx.de,ziepe.ca,huawei.com,huaweicloud.com,ionos.com,kylinos.cn,suse.com,163.com,suse.de,linux.dev,linux.intel.com,bytedance.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC7EC4812
X-Rspamd-Action: no action

I found the error, the commit=20
("drm/amd: Check if ASPM is enabled from PCIe subsystem")
has been applied twice first as cba07cce39ac and a second time
as 7294863a6f01 after it had been superseeded by commit
0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device"=
)=20
This effectively disables ASPM globally after the built-in GPU (which does=
 not
support ASPM) is probed. This is the reason for the crashes and loss of de=
vices
errors which on average occur after ~1000 resumes of the discrete GPU.

snippet from git log --oneline drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c in =
linux-next:
158a05a0b885 drm/amdgpu: Add use_xgmi_p2p module parameter
7294863a6f01 drm/amd: Check if ASPM is enabled from PCIe subsystem  <--- T=
his does not belong here!
b784f42cf78b drm/amdgpu: drop testing module parameter
0b1a63487b0f drm/amdgpu: drop benchmark module parameter
cec2cc7b1c4a drm/amdgpu: Fix typo in *whether* in comment
0ab5d711ec74 drm/amd: Refactor `amdgpu_aspm` to be evaluated per device <-=
=2D- This removes the code from the previous commit.
cba07cce39ac drm/amd: Check if ASPM is enabled from PCIe subsystem  <--- T=
he first time the commit was applied.
dfcc3e8c24cc drm/amdgpu: make cyan skillfish support code more consistent

The fix is simply to revert commit 7294863a6f01.

I sent a patch for linux-next (unfortunately without CC'ing stable) and a =
seperate patch for
v6.18.8, I hope this does not cause confusion ...

Bert Karwatzki

