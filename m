Return-Path: <linux-acpi+bounces-20632-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ4jNuq5d2lGkgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20632-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 20:00:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634A8C48D
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 20:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E70530338B7
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6BD268690;
	Mon, 26 Jan 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTj73llc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6325485A
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454037; cv=none; b=NRO+yNKcACevi5MpfxBJcy53SeqlPmkN/1ohlnOsCufJ8Vqo7es29swpGI1D7qM+65UI3NEYt8zBRlYpxkwgfL7S+axyYvDauf3SVzHFjNUdBuW+f5IviRVejqGpkLb5ZeyxVdXWxRLitBC81wmcpiCkU0S0apPcpX1HzhpUd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454037; c=relaxed/simple;
	bh=eVrGntdQNf5cOiJFbbSP5ccGU/KDAvP/EXDag5Ww/og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trzwlHhvAirBARu+PkIxzvP2vBA57NVLZz1ut78UiZp3CcCh33EbPpFVN4lcKQTi68qR0D2kEtSO6Emi3Wr3qdhlQUP6wlGD76ChF+rIwlYzsGpsWkGTW4AqA4qGmOR79S/uAfTZ5oVoA5cVHh0NKJdZ/B1HyD1MoO7K4gU7iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTj73llc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72921C2BCAF
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454037;
	bh=eVrGntdQNf5cOiJFbbSP5ccGU/KDAvP/EXDag5Ww/og=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uTj73llcDkSxG5yIHGF5hUZ5N3eu5XbvvhFhSfK7J08tzlACGYxIn8LxQP8H/lHDq
	 C+616LxyYC6syeG1fRtYEf3D0BLpVhtO//fAynlPHNxI47G9QieNJN66MboVxlS5RJ
	 h1dJ/vUFh5P76vLlouqpj+/NxUuz4pvEPK78aDnHO02lLqXnmGxeuCBMF+RZaj6U8Y
	 EPHK883QNw446TtPmcjBk8kCmtIeWrAbfrKNwuuvTPzJCeEqY12F/sOeavw5YcRyKX
	 d+h957vJZup/HEML6y6SWGzohYGtlTEUcWmguSK/un8tc8/Ppdx1J+Yu943ud8/wTo
	 sgH40EOLFqTxg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65e943048afso1259720eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 11:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGCOhYCaHk6SbU16OA1DqZ8hbzOVia1Vr4SFYzZrckYD/qpMFX6Cog3EBC/Ynv58T7gbve2V3LRRv6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pf65z29x6C9md8UVtOfZl+tB3fmlMIgvkX1jR8L8stU5RomJ
	F5iY/6VL/aQRDlEv607lpwA44j/V+7f172NVedKbnjhS/jR0zze13F5VhDzQH2xjtAvSF3IAnwj
	LXnqQriZr4tG4E0pZYY8VOVXyF3V0zZE=
X-Received: by 2002:a05:6820:4cc5:b0:662:c5c5:4fab with SMTP id
 006d021491bc7-662e02de890mr2309055eaf.10.1769454036382; Mon, 26 Jan 2026
 11:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3026924.e9J7NaK4W3@rafael.j.wysocki> <176943940108.16098.4666901319744494904.b4-ty@linux.intel.com>
In-Reply-To: <176943940108.16098.4666901319744494904.b4-ty@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Jan 2026 20:00:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gY9O0A-UNtsA7YJ7Za85sDA3qFpe-phjhE_4cZ4HP4YQ@mail.gmail.com>
X-Gm-Features: AZwV_QjTijcbNPYCQeYmXILd6sVwBzum7dfo1vgBxHC21ddBqe0sXTJvMfVf0qI
Message-ID: <CAJZ5v0gY9O0A-UNtsA7YJ7Za85sDA3qFpe-phjhE_4cZ4HP4YQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] platform/x86: Fixes for leaks in panasonic-laptop
 and toshiba-haps drivers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org, 
	Azael Avalos <coproscefalo@gmail.com>, Matthew Garrett <matthew.garrett@nebula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,nebula.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20632-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5634A8C48D
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 3:56=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 20 Jan 2026 16:42:41 +0100, Rafael J. Wysocki wrote:
>
> > These are two fixes for leaks in the panasonic-laptop and toshiba-haps =
drivers,
> > in the "probe error" and "remove" paths.
> >
> > Thanks!
> >
>
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-fixes branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> local branch there, which might take a while.
>
> The list of commits applied:
> [1/2] platform/x86: panasonic-laptop: Fix sysfs group leak in error path
>       commit: 43b0b7eff4b3fb684f257d5a24376782e9663465
> [2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove routines
>       commit: 128497456756e1b952bd5a912cd073836465109d

Thanks!

Just to confirm, I sent a v2 of the second patch in the meantime:

https://lore.kernel.org/linux-acpi/12823935.O9o76ZdvQC@rafael.j.wysocki/

I gather that this is what you have applied.  In any case, it is a
replacement for the v1.

