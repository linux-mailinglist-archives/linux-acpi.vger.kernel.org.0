Return-Path: <linux-acpi+bounces-20745-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEDSHAh2emmE6wEAu9opvQ
	(envelope-from <linux-acpi+bounces-20745-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:48:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17476A8CC8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E5ED302B8A2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580EB32AADF;
	Wed, 28 Jan 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMRtBe/W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9C30AAA9
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633208; cv=none; b=pH3MGaNsWKtuX82dAp1KjmUFK2acWRGRtY4jcwB10XU7XlcLa7zepjOddxtU4Vxzk6g09c826hvzNzbL34Z5ALeKFqD7oXAZWrGRbi6dmvGFmYQtkGygA4ZE47vViaFK+Xpbwiv9X1ug2bTNxr+gAw6RxLguwQD3d/Q+QVffHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633208; c=relaxed/simple;
	bh=b8OeO+k/KBoXIIpxZQPupwF2T1DGRXPpqx+TJiYFyrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj0pnhLtiqP6aG9Ltzd9HDVyTF9apWgM66KdbP234/81krDbQvVVt5KwlXRpXj6ep8q9cULB0y25JdAoHCn1iSU6g2UQmElJIwL0dgWIAN6KFs91vN7Y9TQqk+mkNkqqAqXicuXxUFCSMMOfUqrrBM9odKNtFApwKs+MdubRvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMRtBe/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA72C4AF09
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769633208;
	bh=b8OeO+k/KBoXIIpxZQPupwF2T1DGRXPpqx+TJiYFyrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YMRtBe/WYX5jTk5SD+58QsmmjC/JWi5/idzkhOQQNPMWIZtCeOa5rxg7G2W2ndPoj
	 GvDjf7BjcXxGVZNz4qeeWLo+rBasukK0E7b0xk15qoH/TVrC7gvZk1DMIbDupcirS4
	 akAX4PxyskPQDfqqwYSIlRe4ziDk9DegOsbRhP9lmichyMahUYJgOH1WR2B+/UsaY/
	 0lBUzFpZ7PLxCVP26sqOwBkCiIq+ujH7uWACeHbjwqIWUHe1Vae8GWWTQWTdpiXUT/
	 PPZ5jKmEcP6xZc/+2zQJb/Q/2eZ4tOR0Nr7q5MMM/rIUmjvIWLZOkdyFn83ECJDe85
	 t+N1g/68R4/9A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662feac8228so161917eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 12:46:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyS8q/CFIJmKSaAI1oEDv3pG+gl0jS1vifUFvlI09Fq53IOkULB
	foeA6xDUAFg+kjsXCY9mEqhKh2RYpXOidNTsJhpa6lHUEjMmvgcZsC2ZIt0aN3iNcCZJGnT8wdw
	ABXqppaj+r6jOh4c1jYkWgblrCwb6cQc=
X-Received: by 2002:a05:6820:839a:b0:662:f3f6:bf6b with SMTP id
 006d021491bc7-662f3f6bff2mr3258443eaf.80.1769633207035; Wed, 28 Jan 2026
 12:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127200121.1292216-1-riemenschneiderjakob@gmail.com> <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
In-Reply-To: <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 21:46:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1Uw9jOa-2WpDnYEKpD61D141aC5wb6aKv7ZeOFVB=fw@mail.gmail.com>
X-Gm-Features: AZwV_QgDQrZIKL7ugzwmN-LAZ10q4Q2Pl5b0vImPWTafWoorgUA9DAsPXhrtCb0
Message-ID: <CAJZ5v0i1Uw9jOa-2WpDnYEKpD61D141aC5wb6aKv7ZeOFVB=fw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9
 (Turn On Display)
To: Antheas Kapenekakis <lkml@antheas.dev>, 
	Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Antheas Kapenekakis <antheas@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20745-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[antheas.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,antheas.dev:email]
X-Rspamd-Queue-Id: 17476A8CC8
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 9:06=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> On Tue, 27 Jan 2026 at 21:01, Jakob Riemenschneider
> <riemenschneiderjakob@gmail.com> wrote:
> >
> > Windows 11, version 22H2 introduced a new function index (Function 9) t=
o
> > the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
> >
> > According to Microsoft documentation, this function signals to the syst=
em
> > firmware that the OS intends to turn on the display when exiting Modern
> > Standby. This allows the firmware to release Power Limits (PLx) earlier=
.
> >
> > Crucially, this patch fixes a functional issue observed on the Lenovo Y=
oga
> > Slim 7i Aura (15ILL9), where system fans and keyboard backlights fail t=
o
> > resume after suspend. Investigation linked shows the EC on this device
> > turns off these components during sleep but requires the Function 9
> > notification to wake them up again.
> >
> > This patch defines the new function index (ACPI_MS_TURN_ON_DISPLAY) and
> > invokes it in acpi_s2idle_restore_early_lps0(). The execution order is
> > updated to match the logic of an "intent" signal:
> >
> > 1. LPS0 Exit (Function 6)
> > 2. Turn On Display Intent (Function 9)
> > 3. Modern Standby Exit (Function 8)
> > 4. Screen On (Function 4)
> >
> > Invoking Function 9 before the Modern Standby Exit ensures the firmware
> > has time to restore power rails and functionality (like fans) before th=
e
> > software fully exits the sleep state.
> >
> > Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-=
experiences/modern-standby-firmware-notifications#turn-on-display-notificat=
ion-function-9
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220505
> > Suggested-by: Antheas Kapenekakis <antheas@antheas.dev>
>
> LGTM, no need for rby, sby covers it.
>
> Consider closes + reported by from bugzilla if there is a V3, I
> typically use lkml@antheas.dev but that is small.
>
> I will defer to Rafael now

Applied as 6.20 material (changed Link: to Closes: for the BZ link), thanks=
!

