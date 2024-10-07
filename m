Return-Path: <linux-acpi+bounces-8589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC4993524
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0952D1C2349E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1C1DD9AF;
	Mon,  7 Oct 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHSWpsmW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410E1DD9A8;
	Mon,  7 Oct 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322634; cv=none; b=lq6SN+CSfQrcEBWEevbzMS8DscEl9uGyp43kdUdqyO+qAJS8nYDD0cqgen1NE7Xc3fPYD3PsKNPQPrK48zdhZVb+sBaqlZCqOGLcsPXP/AyK29+h3lF4bNU8rQ8+XvyRrzhM5EggGjdmVgj+1BLT8g9CT+1aO9kNR9ecEaPYFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322634; c=relaxed/simple;
	bh=AlK4P1UlbmMivBa60mCYivg9HM3F7snG3/v9gyigkbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG92MSUyhCqPlialk/o6tSPg2xkLXugEARIAcbRgPWvvxVKFpl2n0p0U8B5r8U+mYQKtKQCkMCU7Um7JSVRdqg4cj4AZwns0dPZhv44wy3oz1u4TcZkb6Cn0JGr9LzCkZNopGyRd56kCkoaTxlaf9giWarnNJ9fmuU7nQ86VDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHSWpsmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA084C4CEC7;
	Mon,  7 Oct 2024 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728322633;
	bh=AlK4P1UlbmMivBa60mCYivg9HM3F7snG3/v9gyigkbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aHSWpsmWmRt+vx11Tj+agbL+mc5Z14msyWD3a8uuHTdYqzxx+XDjMQ1ANkCxS9AoH
	 fDDhOx/q262IJwVDE6vRVjvhzFH0q1fUQ3M40BSlGdrwslLqBAR+KTy9XBDIxdYEm3
	 0nbj/sefSACrB8DTYipL1rOION/daIY1jy74oRiNAX9NmNbX+aGoodnABpMvxoZCd3
	 IHTKCMFzTwjT31Dq2Z3H7M0SEIXT/Jou6ODmXumsOqOxtI3IQLWueRprjUrnkCxw88
	 V5otfvlL0CXSlf+VELthAQTf7ka69+v8Ncw0ZR4OWg07Uw5oxjW4vZuuvVl8gdwHk2
	 wmy+CZiBL2wlQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e3b79b4858so2655921b6e.2;
        Mon, 07 Oct 2024 10:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiGioWI/UgxmO9B0TTF4MNYXLKn7vPuOjpMAVdsFGV7ei6XN3IS4XICIULUS+37bQcNlAWUG874S1i@vger.kernel.org, AJvYcCXXorONrXc2ntND7wtvoB/4qQ/q3LIAq3NKKUM/0dRAoM//AtQSKPrY37WRsTT0qsAsJqIHRQ263/vBqEq3Eyn6O75Cqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUueSIEm0hmEBItVomx2flUc2VHi1ZNCaaFQCxwvzGea2Fj7rl
	NyMjZeOSypdX9QJ58q+nsNB5sexLS6ma0GsUfjA7ArNDMb0KO/TYpcJLkM05uOF1TRbsfT9rwWW
	l27JrkE2OUk10kHy2wZQKXk41uVQ=
X-Google-Smtp-Source: AGHT+IH7fINeVOserZn4p9MaX+Qa/NlZSjq4iaGm/7sDFZ/6pI0FMQhYRZkjd6HNAntaVex0FDYhD3ouDwsJ2oTTxGY=
X-Received: by 2002:a05:6808:654c:b0:3e3:a319:4488 with SMTP id
 5614622812f47-3e3c10a2cb2mr9378594b6e.0.1728322633140; Mon, 07 Oct 2024
 10:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005212819.354681-1-hdegoede@redhat.com> <CAJZ5v0iewd+hmF6ZrXSPTs5_aKov57taaRKEoBM5VaRefrdM1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iewd+hmF6ZrXSPTs5_aKov57taaRKEoBM5VaRefrdM1Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 19:37:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQ=dDL5OQ+6JHv+=8iawcQaCDwR59xYZHuzO6GcbtTbQ@mail.gmail.com>
Message-ID: <CAJZ5v0hQ=dDL5OQ+6JHv+=8iawcQaCDwR59xYZHuzO6GcbtTbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] ACPI: resource: Improve Asus skip IRQ override quirks
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Luke D . Jones" <luke@ljones.dev>, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi Hans,
>
> On Sat, Oct 5, 2024 at 11:28=E2=80=AFPM Hans de Goede <hdegoede@redhat.co=
m> wrote:
> >
> > Hi Rafael,
> >
> > After receiving yet another Asus skip IRQ override bug report / patch:
> > https://lore.kernel.org/platform-driver-x86/a983e6d5-c7ab-4758-be9b-7dc=
fc1b44ed3@gmail.com/
> >
> > I have taken a closer look at the existing Asus quirks to see if they c=
an
> > be simplied to cover more models.
> >
> > This patch series removes 8 quirks by making the quirks match more mode=
ls,
> > while extending coverage with 3 new models which also need a skip IRQ
> > override quirk for their keyboards to work (including the model from
> > the new report).
> >
> > Please send these to Linus as 6.12-rc# fixes, since this fixes
> > the keyboard not working on 3 more models.
>
> I will, thanks!

Now applied as 6.12-rc material, thanks!

