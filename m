Return-Path: <linux-acpi+bounces-18022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6ABF57F7
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC635274A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777432AABC;
	Tue, 21 Oct 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="V4hWNgts"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835B30217D
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038862; cv=none; b=EAYKcSrfzpIHwsZm37kCgzrnzCSKXFpyGJvLER6EFb+zPquMPsGgtgb5l8HXvdxXDsuQV1DblStt7kPWE5/9dEzWAlFQzmDRWu2iP7Bxt529A/tRHS45qe4Yari9Yaw9TjNussFTYGJPFq4lD3TJnPLvrkZdeY+RXQm8ejnShcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038862; c=relaxed/simple;
	bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqrpiPlCgmJHhxia+lWkYJeveUgedtfooGD6u2NGoFSs5a/Y6NSCOETMzAWoWgLBhICrGgTCweW9BDkakVAgEcmPf9F2DIJopQ9tQVeqYvZ4hahPOjlj8VzOoQmYGM9jl5n03m3fXmcM+/y4TAkYfMWoe5/D2fqNWPnXr1hPf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=V4hWNgts; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-362acd22c78so45124311fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761038859; x=1761643659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
        b=V4hWNgtsX0nHo9y30R/HNtN9/pw0rP1dvKo53R3ZkLgztA3ZFZNjjDovB2FC0LZb1w
         Hmghorx8Bxgur7UZnh9duRWwpgabzGbpkt3QXpUJAs5Es765Aa6nxc0BbJIkmACCqs3n
         2p665rwgEo+z+D/AOCk7mbTHPUudelhc3cIhURZuG35gWVjVkrWPcS0Q0r858e4Z0esy
         TdIm85vXWGk90+65zICj4gT7wmHduAg1Qc8igkKbXaK+QZBt0guQy/uoFwtOyuyXGl5/
         DN7oi43gI1+BqK7QTOSt1iuA1jhf5WH2epmlxd9Yf0gbG9fvB6jcBg23XkLzeeiAtZ/m
         YStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038859; x=1761643659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7z2gScypkXsCTEfcWrJhYzB1SDqV1mmRGQM3Gk7S9E=;
        b=RMrdMNppeXv3mKnsiT59VaUC5ruJenfUiP9lRIA7EintInqhHqIU/snWv+XH/8Ah+8
         3E+Ln/ddi3yM4dREvu6JQNgwpKjsF1nAvYAA47eJ2Ttob9HBGvfSGr6ecIXCOdHjjhyi
         9WQjT4NSQpZCdcXYCfxNedeQ47tz2Q5YoQMgWVa+mt8CHiAxXEokM2t3f57QGCN5BRPo
         LLn4wXTrVzMwg4q83v4663YXth0eD92holTx84jnQOBqRhSZJHuUTGINlUbxyS6+5IZF
         Wa07V7r5fTUobx3J87+Z5AYTQrvCi3hqGqEYhthlf1K0hIi+lpMHZMQBKuLxN+UdZdfS
         EM4w==
X-Forwarded-Encrypted: i=1; AJvYcCWOjpkrh1CO0/CMFqmH+wTUGDWZ5xiKsB7PFGyr8DUekBYscAmqjz4ihSujyj5Vz1DSvY2/PqI1B34/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bbmL/BBQ4az/W7Dj7qpawkZnX3RWNl4ytLxCexp6bmz8w1B6
	MduvrHk52TVxa4QOt5NGflFoZA3GzONEMGmp3lGg2T8L4zfBfOkEageoHKIQ1iwGKCigkZkIwUA
	apX2cNQWPqGlydrUKf7SPco+6+NXqM57fz8pjBTWU6A==
X-Gm-Gg: ASbGncuNJYlAWBcwYOhWRJ2s0VTRugD29KVFSyphs97b/vuudk3VaDfSN8YyiDSce3D
	KIWNI86JOgIAHKfVl9QVAs5iEIhM48vCg3Jc9Jx8J1aEHecEgOvJd2SvKGm89EqNCarXSkbO+TI
	2qrFxQesixdfCa5fcW03UMHtsNsQc+dW4ZPIf37S/GEDPGXUelWhvdWZZmaWAmrAVqjy1M6Fnt6
	DmxbmVcfmH2pb2LDFn1rA1g1enONkB8aanOOsSuTo7MNE2ibRc3O8kZFJcwgpyMdKyufSbQ0hoy
	MaPiLj9d+XsXy6vgotXx/FS5sc4=
X-Google-Smtp-Source: AGHT+IGcqahLfKSaPq3awX9rBHq412FeWkuYZKlnUWbJU5x4mCNhy4NKrxE77gwoikcyWR8JVYkFw8yaJVdN+5pc3a4=
X-Received: by 2002:a05:651c:1ca:b0:36d:bcc:bfaa with SMTP id
 38308e7fff4ca-37797a5f17cmr50360261fa.40.1761038859288; Tue, 21 Oct 2025
 02:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com> <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
In-Reply-To: <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 11:27:27 +0200
X-Gm-Features: AS18NWAqzshJ751MyC_I5LHfM-95oy0012vlyyZ7HFzAJN8zex77zf83nZAiBoE
Message-ID: <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:17=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Mo, 2025-10-20 at 17:25 +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
> > > [...] could you take this
> > > opportunity to prepend a patch that splits the part under guard() int=
o
> > > a separate function?
> >
> > If I'm being honest, I'd just make everything else use __free() as
> > well. Except for IDA, it's possible.
> >
> > That being said: I have another thing in the works, namely converting
> > the OF code to fwnode in reset core. I may address this there as I'll
> > be moving stuff around. Does this make sense?
>
> Yes. There was already a previous attempt at fwnode support [1], but we
> abandoned that when there was no use case anymore.
>
> [1] https://lore.kernel.org/r/20220323095022.453708-3-clement.leger@bootl=
in.com
>

Ah, what was the exact reason for abandoning this? It's not clear from
the email thread.

To be clear: I think that we can convert the core reset code to fwnode
without necessarily converting all the drivers right away.

Bart

