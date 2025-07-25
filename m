Return-Path: <linux-acpi+bounces-15317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA7DB121D0
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01FA3B9240
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241EF2EF291;
	Fri, 25 Jul 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RxjoTNGA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412A2E5B2B
	for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460188; cv=none; b=oXyJ5C1unQDkYTTFHXiP6YMplmnftIxg+UBFc9cxDTWmb8pErYjGppQc2j7C2ZniGNpx7zFb+t3SfN/C32qCdBS5Ve18cxu6dOX+EJEYR1EcH3yupFN1WTFd5ErT8BibLTZFay2Va41QyLIkqxtQ19f4CS90OoQ0/LTr+vU56Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460188; c=relaxed/simple;
	bh=G6cKxpFpNKWSetLJHJ3pQ6zg1bL/LOkHThhiObiZaiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5TS6viZwfDC7WsRQqlwGB4KK2/R9mBucGhARdKOHstdQh0djqioRj2iQqoesJR4pDqpI1AXkBqkaOYkMI6r4QqLplbLvln1qdKx/Hq1kXv/BHTVhRInQAIgFzsON2uHifQGXHcDDPkYXqLmVvx5O0/slU4+WuaVYPrW9dS9wZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RxjoTNGA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32e14cf205cso22264041fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2025 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753460184; x=1754064984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOo595UD81PW4Cz1UFmTlajy9wRb7dyhybVVNSTeWD4=;
        b=RxjoTNGADffczmoCgzq8vqRTkAAT2YiyseHpZvygnUhkFtdREp6OT0XRzRckbk1Qg2
         /PBKREDSYxOnmxXdkBwD4T0KBwiDnnipayFkuOA5jgFx+Xaka61ozxbiqbqpC6BtSEgi
         nwCi1Y7dy1Ve8EaF2shU716RzX14iJRZwzfQa+qpO/jZdFK0DONZyeilNNb28muOA0JY
         kQ9I2DUCvfFzdfLb7XR3kVLk3Fz2sN6qdc6aU3n8ddH+Y8BCprNR36wkI+Qlse17pp3r
         3cci7ZtSHSiPN5+s/nqwKlHlc4zmK1sLdFxsiln0DBO3+XcBGACtTW+QrK8RXnlRTJfZ
         O9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460184; x=1754064984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOo595UD81PW4Cz1UFmTlajy9wRb7dyhybVVNSTeWD4=;
        b=EcPQ8gHlLVoIc6hYfsT96skbd0NTHofYhOOVOZOStvA9jlNrDdxvpVgqbfFs0Fs8Fu
         SnW57s7swGm6Y+qQVIW4JI+LSlPZxWkgHXhZzu9nXt6HgWM5ifKNme1iwjwgXSf4x3nA
         fRFyPhm9c2NWQzTmzq3BWvnCU095OKJkbVvXgkyGlxr4cRLpvFi7JFmf16IPTc2cJrxt
         ufpnOZCRrVTYRrc4fX2MNQ9eALs7+6G07c7oJYDZ9iZZjqNG+kIsp1hIUFBgCxXeIUoO
         D6PenKXatxnN7snbspgJ+rzfKoetpoUeYfh1uU8ZqG7Y99QuG2nb5tbb4a2jxcXCasyQ
         TJWA==
X-Forwarded-Encrypted: i=1; AJvYcCXmNGGy0p8A0qEE2UF5t0XXfkXgTurBDhGUcn46FwOliV66Lfyv095qs21o5b1H3Yis56Fx6iV3CJsi@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjLyiHq5elz+kMc8Q1JXqCcjTGE9+Kii3NnP9zUEsKFs+vIXy
	X4Xlu6y5opfUzUHFDx50dMWdNRyErOzW2Mhr4RePXRGrCW7sH0hTHZszcN/2GkPekppmsa8ZKvV
	bH2Ah1XrfxvMcye1h5ZfuXK0ByBiCB/YKE7rAiHzR/g==
X-Gm-Gg: ASbGncv8GzkWJxlxmYDaDYmHBE/Tpfjtxu4hoAn1uRtKE2oJsPImRBDFmnboGTxLPYF
	PQtIPy34lEaCt9EAlS1ZBr0otJMcVsPT265hMUM1r+tk4hd2Zx3lB7/FV5rChDCI0qyoLGwwGjr
	gwpOf4p/5bU+wqrnQIK+hwVulRyWooJf3LxXK0GH6J/cUspWJSaxzvHDaPGYENMFIC52ZRKAJKj
	T3JO54=
X-Google-Smtp-Source: AGHT+IFIuUIEQS0zyr6rBam/nD3H+hqGiiProGvcAqPkV/NrJ9CSjPmlKsQWWtSCr8nBHng2+tmatocM0hZ4PbG8CJs=
X-Received: by 2002:a05:651c:1503:b0:32b:5672:41fb with SMTP id
 38308e7fff4ca-331ee74cc42mr12092821fa.19.1753460184460; Fri, 25 Jul 2025
 09:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
 <20250704070356.1683992-9-apatel@ventanamicro.com> <175341132347.3513.7184287611040628050@lazor>
In-Reply-To: <175341132347.3513.7184287611040628050@lazor>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 25 Jul 2025 21:46:12 +0530
X-Gm-Features: Ac12FXyJjR2ZAcC8iSDmp338bf2ZOm1s9QD7gpAd84fmChTRX_UPxaRyR5VVtyQ
Message-ID: <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service
 message proxy bindings
To: Stephen Boyd <sboyd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 8:12=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Anup Patel (2025-07-04 00:03:40)
> > Add device tree bindings for the RPMI clock service group based
> > message proxy implemented by the SBI implementation (machine mode
> > firmware or hypervisor).
> >
> > The RPMI clock service group is defined by the RISC-V platform
> > management interface (RPMI) specification.
> >
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> [...]
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clock-controller {
>
> Maybe the name should be 'clock-service' then? I don't understand SBI so
> not sure why this is in DT to begin with. Is something consuming this
> node? Or a driver is binding to it?

SBI is a syscall style interface between SBI implementation (aka
M-mode firmware or hypervisor) and supervisor software (aka
Linux kernel).

We have DT based drivers in OpenSBI (M-mode firmware). This
binding allows Clock message proxy driver to be probed on the
OpenSBI side. The clock message proxy driver allows Linux
RPMI clock driver to send RPMI messages via OpenSBI as
proxy thereby sharing the RPMI transport between OpenSBI
and Linux kernel.

Regards,
Anup

