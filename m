Return-Path: <linux-acpi+bounces-20658-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNBOKVrAeGn6sgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20658-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:40:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B29502C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19B7A3046B9A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BA3587AA;
	Tue, 27 Jan 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o46PmiN/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAB357A51
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521019; cv=none; b=XBVoI7rNtWB9yBET06DSs07etP/oADT6Gper56OSV0a/EG7T53tMfHLViLHkkhL/xylN6OjXj3wrazYpzE1j6zpBsDptym6nOOGtibwRtLTe+0e0XsbFw31PvMcMXZn6CG+ocemVAQFn5KYG5Xwn8bNNn1b9QoJH/XdS7hxqpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521019; c=relaxed/simple;
	bh=4XZ7KNIkw8JzRrEKK6ttWf2qM91mPWMZpJ6azUz7vww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvs9ua1li0x+YCvNVd6i3egsYJW4X5fXfjnx9aCPvfXm2+tu4h2PUCXju7OMB0JDXYWVmeOALPO2slVD0xnIuPfEd40BvfkQ5qWPeyfstKt/V4JazySavnkLCZVHfwuxTOPN44kMzbfUnTiKSytu2e10UJPxV7mm+u8T82m4YGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o46PmiN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C5AC4AF0B
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521019;
	bh=4XZ7KNIkw8JzRrEKK6ttWf2qM91mPWMZpJ6azUz7vww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o46PmiN/sNS3KSkNVgFDqzPEiOXDT+D85eaJw7lWnXoz3hGrKJ1y3Ki9FI7FpJCtl
	 wMFOrpPJhbbcV3qOFscCEyhG5KmoPR6BFfBk92S1Stzjcm1lPtVZkUf9sOVEI5EkDA
	 INFzIhTySyMpChtSRLn61RZENUn/0CpkGZUkozU3qLzCaT93+4VBPxcwQVmyQLNpXX
	 aWbcLYcv7Xzyw5rRGsqvaIMoivR0A3xzF1jZnEhz8bwL6VeMiwRYiLYJUcDjpuXw8I
	 ESOhqtJq+HV1/kqfvua2mnLDAEb/qsUC1pRRYfwaa2wISnKFhFkjIDQC6nHzR8r2WW
	 PZF9AME/Jp/jw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d15b8feca3so2048059a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 05:36:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCGK/QOIgSqC1QPgsCTA6Gcrr/96ZdiFAP3nycinR1sFchg1zlZzjjCcV26UFLenDtemR8ofm/40Mr@vger.kernel.org
X-Gm-Message-State: AOJu0YwdF9QRMEdu1ZZkbH1tZzLCP/p2qSMPUi+7V5QPXvNvP8w42oK4
	tXtpthbUfiXcinHA9w/lUjbaauK0X/aDkYbKZCnXbgHHVHDlo2y48o4Be6gv8GK2jQAIGnlr65J
	iaA7KGXFI4S+kI652jrrrVj3WfzFJcl0=
X-Received: by 2002:a05:6830:2aa9:b0:7cf:d1ed:f9ff with SMTP id
 46e09a7af769-7d185116df1mr1142464a34.34.1769521018203; Tue, 27 Jan 2026
 05:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3026924.e9J7NaK4W3@rafael.j.wysocki> <176943940108.16098.4666901319744494904.b4-ty@linux.intel.com>
 <CAJZ5v0gY9O0A-UNtsA7YJ7Za85sDA3qFpe-phjhE_4cZ4HP4YQ@mail.gmail.com> <19b87b6d-2d9b-8662-8580-e883943aa264@linux.intel.com>
In-Reply-To: <19b87b6d-2d9b-8662-8580-e883943aa264@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 14:36:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZPB1fmWtnVzu-9+OUtr9R8xqHOD=vhH+x34T37M1MZg@mail.gmail.com>
X-Gm-Features: AZwV_Qj9mx-vm5VNlskH9xzip5gKmBrkLKsOgngC9tOvEITYoGgQSvXrV9OqnrY
Message-ID: <CAJZ5v0hZPB1fmWtnVzu-9+OUtr9R8xqHOD=vhH+x34T37M1MZg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] platform/x86: Fixes for leaks in panasonic-laptop
 and toshiba-haps drivers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
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
	TAGGED_FROM(0.00)[bounces-20658-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 098B29502C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:04=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 26 Jan 2026, Rafael J. Wysocki wrote:
> > On Mon, Jan 26, 2026 at 3:56=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 20 Jan 2026 16:42:41 +0100, Rafael J. Wysocki wrote:
> > >
> > > > These are two fixes for leaks in the panasonic-laptop and toshiba-h=
aps drivers,
> > > > in the "probe error" and "remove" paths.
> > > >
> > > > Thanks!
> > > >
> > >
> > >
> > > Thank you for your contribution, it has been applied to my local
> > > review-ilpo-fixes branch. Note it will show up in the public
> > > platform-drivers-x86/review-ilpo-fixes branch only once I've pushed m=
y
> > > local branch there, which might take a while.
> > >
> > > The list of commits applied:
> > > [1/2] platform/x86: panasonic-laptop: Fix sysfs group leak in error p=
ath
> > >       commit: 43b0b7eff4b3fb684f257d5a24376782e9663465
> > > [2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove rout=
ines
> > >       commit: 128497456756e1b952bd5a912cd073836465109d
> >
> > Thanks!
> >
> > Just to confirm, I sent a v2 of the second patch in the meantime:
> >
> > https://lore.kernel.org/linux-acpi/12823935.O9o76ZdvQC@rafael.j.wysocki=
/
> >
> > I gather that this is what you have applied.  In any case, it is a
> > replacement for the v1.
>
> Yes, I used the devm_ variant of patch 2 (v2). ...Had to jump through
> a few hoops though to get b4 to apply things correctly, and this is what
> you get as a confirmation/thankyou email if you don't refresh the whole
> series but just a single patch in it.

OK, thanks!

