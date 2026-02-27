Return-Path: <linux-acpi+bounces-21238-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D7PCcDloWmUwwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21238-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 19:43:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F181BC1E4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 19:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1CC307AA49
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767538F23B;
	Fri, 27 Feb 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKKxSjyJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5E37B3EB
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217788; cv=none; b=pYz4SfCim2bVAU5vxrhFw9k9gjyz3rODUsTUyIGsS0kU89i+Lr1iC5axPBMWAsY1fw/NlWqcdAA+u9lFgU74/cYZG3gWh66ovBgv5Bj5B9rRk5V1v/9/EzXCGd/HAjpGCJnehcXrm1myiGz4hqoVKXjznWkfeny//CpYebIxIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217788; c=relaxed/simple;
	bh=hLSes2z5x7GSIEnWExFpKROOwYV91+ZUA4ZJSV2ziQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhFchLOYBkXFaMQO9Js+UbXKlHZFtG6sDVNdx702ruxWVqVgYjC3nhmugpj4eChFs9rhoI6WzRahewWtrCwuA/L2rg8eQecwjkL8FsnphEfOAo0UGOCg+t56wf2MPFLJgm2e48nlIf9uDvnEkny4yam1z6qbrIqD5OShPt+qKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKKxSjyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B25C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772217788;
	bh=hLSes2z5x7GSIEnWExFpKROOwYV91+ZUA4ZJSV2ziQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pKKxSjyJuAcI1aIGp1VukgWscRj0aLBdJhYnVlJ7+IkPsYWZzm2VVx0Ylc9RnhhtA
	 OTuD4uJKuIhrtGtBL8wv7/FAUxfBvZNFcJNGu3UtsxwPF8Vm+T6rpMJWRvSAwrHhKC
	 +eDhvfiLQ0iNjW96E8Lb9maKg7YpndhlQTRju/pAoMwRGLFNPSuc73V2+RrwkOgRuz
	 J81Lhz9R3wZWvyruHqEpuCOJaDEkvgc0Fa95sb8VR4HOqqbjdZp3w1w6nMw1ih9xLn
	 R0rXkD28kzFrhowewfqyc5AsDzp6lu0AZuFlmqcr5tO7YR0b2Dh/1nGPatTkxakD/1
	 vIbw64v3vVlHw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6799774d0fcso1326696eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 10:43:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWj+iLRsVXMG8tAK4fpFXm6ycGAcxt5mbWGS+mAh2YLKtnFI6j5i6YOARcQSomhhYQJJOpj+/7XhpS6@vger.kernel.org
X-Gm-Message-State: AOJu0Yytz8+B5oVTQQyogPnDXGTkZW/ueCKfhTHPDgTUKnwKO3ASLNm7
	UGeWSYxqCgGwoCIvqsPDikKc3zNFM+jJhA2LqVReVM/I31oJRkuAKp5aEUixDyVEO9oWRQsxDa0
	8YCGnBwCh6yxSli0exUq3TOm1fNjC2I0=
X-Received: by 2002:a05:6820:3102:b0:679:e750:6c0e with SMTP id
 006d021491bc7-679fadbad18mr2384152eaf.8.1772217787262; Fri, 27 Feb 2026
 10:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <CAGwozwHE4DVCh79-523V5=a_fqR0gXnnkorGCPEsgHBDLYPtxA@mail.gmail.com>
In-Reply-To: <CAGwozwHE4DVCh79-523V5=a_fqR0gXnnkorGCPEsgHBDLYPtxA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Feb 2026 19:42:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8e4eKNiQi-cE+v6LXyfier85PCoramheAPMrwnnsQpA@mail.gmail.com>
X-Gm-Features: AaiRm53_H7esTsUQV4dSi9rPFLw9KyEbxYdsiIpV-4MaAuVJ_ZyfvKXNJjsCb7U
Message-ID: <CAJZ5v0i8e4eKNiQi-cE+v6LXyfier85PCoramheAPMrwnnsQpA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21238-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,hadess.net,haitsma.org,poettering.net,vger.kernel.org,jhu.edu,kernel.org,hughsie.com,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,antheas.dev:email]
X-Rspamd-Queue-Id: 73F181BC1E4
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:00=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Hi everyone,
> now that the kernel merge window is over, I will slowly get back to
> cleaning this series up
>
> I already have some feedback that I will address with V2.
>
> Specifically, we found out that the resume DSM needs to always be
> called and it merged with 7.0. So I will rebase on top of it, remove
> the patch that added it, and rework the logic to always call resume
> before sleep exit. I am not sure how I will tackle this or whether it
> will involve reshaping the FSM states.
>
> Then, there was a compilation warning reported by the kernel bot.
>
> Afterwards, I reviewed the feedback in the Phoronix article. People
> would like to have an option to turn this feature off, or perhaps
> force it off. We could add a Y/n Kconfig for the sysfs patch
> defaulting to Y that enables it, which will be the appropriate option
> for consumer kernels. Or a kernel command line parameter so that users
> do not need to produce their own kernel.
>
> Finally, there is the issue of the Ally devices, which will need a
> partial cleanup that needs to go through platform-x86 and hid core,
> which would make this series touch 3 subsystems. I would tend towards
> omitting it for V2 to keep a short(er) cc list, but I can produce it
> for testing as an addendum.
>
> I have my plate full for the next week, so if you would like for me to
> consider some feedback, next week would be a good time to review this
> series.

I have some feedback already, but I'm not sure when I can get to it
realistically.  I'm already starting to be oversubscribed for next
week, unfortunately.

