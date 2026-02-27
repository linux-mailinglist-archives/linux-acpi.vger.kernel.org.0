Return-Path: <linux-acpi+bounces-21233-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1tZVKFSzoWlOvwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21233-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 16:08:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614C1B970A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 698A530D11DF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5042B74F;
	Fri, 27 Feb 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Vlvdy1Tq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A342849E
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204404; cv=none; b=m3gMG1FwwAbHtJmRIx08dYFrHHIDDae37o78/rqkC1Z6YawxK1aZsgpmqSL4kB0A76HLHLXso7lbDQTnH8FrudPuuw/11pj39wMoDl+xr/1J2x8ktHGq4l5uf3+AM5se0iaq/AAIy5689QYpRn7PmHgmT7gGdWT5NYyrIqFSYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204404; c=relaxed/simple;
	bh=zmwNc3YwqC8Wzv/T/zFu2SNdLH8V29kOTIPTnIE/V0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfx8g+sPLUmxRn35bbgU5vn4jrwpxkq2MtwmmuoVMl3hGN2ve3lhLvuRxDo1kKHOm7v2mKE7dZeIjkYc+UFnfnl3jmuH2U1PmaoMBdFjacrDnahTJB++Jl6+vD5iPZdClTXBNucJHEyiZoNyNJgH0TeqQcZBs+b+QRPFh2Rzbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Vlvdy1Tq; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 1E714C4595
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 17:00:01 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id EC517C459D
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 16:59:59 +0200 (EET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5EF3B1FF3E2
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 16:59:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1772204399;
	bh=zmwNc3YwqC8Wzv/T/zFu2SNdLH8V29kOTIPTnIE/V0o=;
	h=Received:From:Subject:To;
	b=Vlvdy1TqZfY9qKejHDKqIGe8RhHLjwbGBToYWZoQyTM/w+dTV1SLuLm4WBEUW7pqV
	 0Y5jvsyk1WRvJJ8aqbOiackgMo7o/Y/v2zotJR4ybsft+BOkc1hw/tzsIiSytHh5yZ
	 qTNvVbx+3+qSodanLTXcSzxyWRvaMmKjU0W5BkqyP5cU3tIRXQfzr2jFWEwqeCl0XJ
	 UbwPovSDCBk9zBh1gSPwEfjk8e6C+lV/sjUsIhkllM3T4jiY6vhXp545fN3pLxCuS0
	 LJka+Mbob58sXqIqnEBmksNfEdwyFY9UorRe+CJj2Fl4A2wO15yn0Ab3FjUiw9pTBb
	 P7YAGdmOGt+2Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8273eb7798eso892775b3a.1
        for <linux-acpi@vger.kernel.org>;
 Fri, 27 Feb 2026 06:59:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBrouLffQFW2r781GGZsROVPVsJOlhJql9KSFBL7ZEtfPgp6ZJc8hegDNZ3pnDvo5W6Imo3sODQgq@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaxUn/E69LO4XBc954loZ1MRtRPUPHfclw27RxBjBvqwsdkv7
	wNSt1AwAm9YOJQTF6wG6RMYFXjn1RI5hLZZTknvv1kg90OhNJ51gCqgdqR1vz/4NL1DyVazQ89P
	yIniLbVj1Pjt2f6CoqX1tJITVOwMAVhE=
X-Received: by 2002:a05:6a20:729c:b0:394:5463:7330 with SMTP id
 adf61e73a8af0-395c3b0f605mr2880908637.51.1772204397873; Fri, 27 Feb 2026
 06:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 27 Feb 2026 15:59:46 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHE4DVCh79-523V5=a_fqR0gXnnkorGCPEsgHBDLYPtxA@mail.gmail.com>
X-Gm-Features: AaiRm51G5yWyUdirM3sEr4QYpNc1tra8MT1voDYeD3lcZ2Ehx8K2ob2rpKwoe40
Message-ID: 
 <CAGwozwHE4DVCh79-523V5=a_fqR0gXnnkorGCPEsgHBDLYPtxA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
	superm1@kernel.org, systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177220439961.2693842.1897470123756100241@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[antheas.dev:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,hadess.net,haitsma.org,poettering.net,vger.kernel.org,jhu.edu,kernel.org,hughsie.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-21233-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,antheas.dev:email,antheas.dev:dkim,mail.gmail.com:mid];
	DKIM_TRACE(0.00)[antheas.dev:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[antheas.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkml@antheas.dev,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0614C1B970A
X-Rspamd-Action: no action

Hi everyone,
now that the kernel merge window is over, I will slowly get back to
cleaning this series up

I already have some feedback that I will address with V2.

Specifically, we found out that the resume DSM needs to always be
called and it merged with 7.0. So I will rebase on top of it, remove
the patch that added it, and rework the logic to always call resume
before sleep exit. I am not sure how I will tackle this or whether it
will involve reshaping the FSM states.

Then, there was a compilation warning reported by the kernel bot.

Afterwards, I reviewed the feedback in the Phoronix article. People
would like to have an option to turn this feature off, or perhaps
force it off. We could add a Y/n Kconfig for the sysfs patch
defaulting to Y that enables it, which will be the appropriate option
for consumer kernels. Or a kernel command line parameter so that users
do not need to produce their own kernel.

Finally, there is the issue of the Ally devices, which will need a
partial cleanup that needs to go through platform-x86 and hid core,
which would make this series touch 3 subsystems. I would tend towards
omitting it for V2 to keep a short(er) cc list, but I can produce it
for testing as an addendum.

I have my plate full for the next week, so if you would like for me to
consider some feedback, next week would be a good time to review this
series.

Best,
Antheas

On Fri, 26 Dec 2025 at 11:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> <snip>
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> --
> 2.52.0
>
>


