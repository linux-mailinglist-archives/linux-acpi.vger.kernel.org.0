Return-Path: <linux-acpi+bounces-20805-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R175L4uEf2mzsgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20805-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 17:51:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47FC68CA
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BA8A3006B2C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39AB26F47D;
	Sun,  1 Feb 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxcwkt/N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA326ED3E;
	Sun,  1 Feb 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964137; cv=none; b=CiLu8wYg9opmh+cJnCuKOuoCXi0H1xT3rWAXzPgDAyfbGMhPe2Pt9Ll4yNA6eIS/pgQOWRzryLFgrJ0vlnDKJw/wiDsxlKgownKN2YdxzHW3SbUSiWVBamRMR83IWzhiqHV8HWqF53sgK+DPACr+MRfQu4tSVfkXTS2ePqc46aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964137; c=relaxed/simple;
	bh=Xcg5dMcD3gfNoe5awtJkp8+RbxVdfVBZaTZPNqrYjsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixbLVBKzJoQfVMG5or+2jwp/dRLyDlnpMVy/AgpXEIf9Jf/Lxmvikwzb/qkjnDH352JHbSZG9Fh0V5/o8Obj4Tz8ys2TgopTHXxTXf0wJO7Uv2vcK79lfOIdYnyjP+BrmkpPZ2nvRMdY7V8rg+WnhF8eia4mnH05+VCJDDjSe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxcwkt/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB24C4CEF7;
	Sun,  1 Feb 2026 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769964137;
	bh=Xcg5dMcD3gfNoe5awtJkp8+RbxVdfVBZaTZPNqrYjsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mxcwkt/NJDeCumyF+iPJGRDfOF3UVmIcxHuGv004PbaOKxTzEL5UkW7GumCL3+MQr
	 ybGXH39WMcFOrskVirc1pFP7TCthYqwzVis2cs01ea0LyoKNo4OTAU08wUrYuq3NCG
	 XMZHtCMgMTBBmoeChxlsqlrK5/JZtWJvUYGgktcRq7YAHq8kEKdGoG9tijXzjZAeLw
	 ac1k8JaBEGEijEeSvUNipJT4oXqPMfVZsbwrdOvtxuSOrELHK6ol9r+wMeqe9zDetR
	 BuG+UMRquoetvBTT2jt63tRn6an4Fuxk4spFesgZfw0j/NHkVjA27tCkdn6c9EKxMc
	 T/90nh4ZXqImA==
From: Thomas Gleixner <tglx@kernel.org>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, spasswolf@web.de, Mario Limonciello
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 regressions@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Clemens Ladisch <clemens@ladisch.de>,
 Jinchao Wang <wangjinchao600@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Anna Schumaker <anna.schumaker@oracle.com>,
 Baoquan He <bhe@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave
 Young <dyoung@redhat.com>, Doug Anderson <dianders@chromium.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Joanthan
 Cameron <Jonathan.Cameron@huawei.com>, Joel Granados
 <joel.granados@kernel.org>, John Ogness <john.ogness@linutronix.de>, Kees
 Cook <kees@kernel.org>, Li Huafei <lihuafei1@huawei.com>, "Luck, Tony"
 <tony.luck@intel.com>, Luo Gengkun <luogengkun@huaweicloud.com>, Max
 Kellermann <max.kellermann@ionos.com>, Nam Cao <namcao@linutronix.de>,
 oushixiong <oushixiong@kylinos.cn>, Petr Mladek <pmladek@suse.com>,
 Qianqiang Liu <qianqiang.liu@163.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, Tejun Heo
 <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, Thorsten Blum
 <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>,
 Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, W_Armin@gmx.de
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
In-Reply-To: <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de>
 <87v7h5ia3d.ffs@tglx>
 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de>
 <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
 <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de>
Date: Sun, 01 Feb 2026 17:42:13 +0100
Message-ID: <87a4xs2z6i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[web.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20805-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,amd.com,linutronix.de,kernel.org,goodmis.org,lists.linux.dev,intel.com,google.com,ladisch.de,gmail.com,oracle.com,redhat.com,chromium.org,igalia.com,gmx.de,ziepe.ca,huawei.com,huaweicloud.com,ionos.com,kylinos.cn,suse.com,163.com,suse.de,linux.dev,linux.intel.com,bytedance.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B47FC68CA
X-Rspamd-Action: no action

On Sun, Feb 01 2026 at 01:36, Bert Karwatzki wrote:
> I found the error, the commit 
> ("drm/amd: Check if ASPM is enabled from PCIe subsystem")
> has been applied twice first as cba07cce39ac and a second time
> as 7294863a6f01 after it had been superseeded by commit
> 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device") 
> This effectively disables ASPM globally after the built-in GPU (which does not
> support ASPM) is probed. This is the reason for the crashes and loss of devices
> errors which on average occur after ~1000 resumes of the discrete GPU.

Wow. Nice detective work...

