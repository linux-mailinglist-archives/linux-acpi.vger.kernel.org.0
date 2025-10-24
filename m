Return-Path: <linux-acpi+bounces-18192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1332AC06F72
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3375505CEB
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C6326D53;
	Fri, 24 Oct 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yCrc+9CP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E32DEA7B
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319647; cv=none; b=jrWV1jMrJF41VUbxLt5EJggm2ZLSYRthv7Z9UfBx9SUil3KMe5/ZPczweNSe7t5hhiVEV/cxcw03I3NMabTTL1T+IWdmR18v+LiHyoRgK27R1oFZ6//o+UbgYbhQGH9EfMEvkdFzveIo7em/nePwGoe7eu6FaX89bSC+Wh4TABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319647; c=relaxed/simple;
	bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfnJ5tck9n3pZScsV0n2dkrVLLAcYBOGLeXSISbrPj8t7IA2EGwIgOq9tq/2KxL9RqfCemGSQafddwBX8xCSUFPHLGynFccSXqMQjnqJzAHTAJ8pN9WOjeWDw59pYsceyZkD60Hj0PIV8KeWxtYt9TubIIpAjJajEEsE3wbKAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yCrc+9CP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29488933a91so14428675ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761319645; x=1761924445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
        b=yCrc+9CPuRj3S0VDiKd0dyZY1VMg0zxkUWkqw1mCRDAqCJekFepfvc6pmg70rLZFPY
         BrtVNavTpbrqza8uII7vb2FtTekv8ow24SiYIuMc4qN1Cb7rOwfnyvwsCOlWDsaONSOl
         B00tnCJTA3p/1OXS4/m8KCQzQKlkoRHbyQkN67ik2rSLedSarnB4PHqbOgwcuVXcXZ3U
         0hQLGZxLK7InjHaGAA3izbDwxgckmjVdJkP6Nj0pwbCeNXJjuyiX+XnyrWNLO58slFnn
         aXpk4LKiQZzP7m0NlkEnL0uur2eXvxFPmX/5WdHZ3XNSHahJLBC6IkMnpSvYFIHHBtiK
         yX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319645; x=1761924445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
        b=BVl+61rDX9h7HyjnNRZVSIJ5Cz9Yrx/9SYHVBueNdYzf0U57uTbM97NjvQ+jmjFAOa
         w3itEpyiLLmrpUGJPzVHO7wJc3Z+4fDdWclNCQNB053MyNc9wObCyYMb9yTqaASQ7YiT
         lViGFq4SlFodT6F+RaTDSOb17VKngygCePpyivfR/wsefQUmA6OjeYrIt2MJSrUH12Fh
         eagRLS7Uv5HbT0VN3p7XYEwo9p2BAOkif+qfwhUdd9COOSVOsMo0FH+pGCqyeMkr3KZ0
         Rszli14UfikaeeK+/Wy6bg0gGenLydtu4Ox80i9usXbx1mQH4uKfe4y4/a0y8plL/7Yj
         FBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWft1v40DpOUdQSUP0oxxmzm+SqNnL4YAnZhlExam18J/m66slUb7GhV52CcbxRxXJZjp27JrXjxzwl@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTbtfPcgqFze0hA6LnTSmpoz2K6bF6cv1AZTeSWTbS/ONsycD
	g16Hl+gRt6vPMkNq07kEDnT+7F3pn35YEPN5VatGDkhvY5G9PKJljf2IKehvS7o/cv6Y18glKRU
	X/xQYkNoyHulzL7bUronsKZXDdOVIJIU4TmocWRlWCw==
X-Gm-Gg: ASbGncstj+BXiSyRSfAeGsjq9DduF3p2j1wq1w7JEgDrAQI9prbV9KjrrHLGa4RIh0w
	EymwATRUvCcOoovv2bl4nqJV8zcbR1KC6oJefI6Xll/y74/bh1xPLCQXU3Y/FezoCXDr+xfD/m8
	INGQ9gBgdBp+aONRnr7mo2eodFS/0m4xH36aT0MvQz3D8M1SD+rkjSHiN8Llwrxqaq4U1lnDTsk
	d8nBKTUndkud6XA9hGmlHpYnLOHDCwyQ+i8zRBzkWmET/et0l47x/NkQgvpHgzFDwKNy8etNtN2
	K1XcGHa9XbIioBM=
X-Google-Smtp-Source: AGHT+IE3ievDsUOrEWWRlev3EL7B/5BDY1VDgl+stdkjFTeQQMz83r5xV0GQ4imramVbO2gEuzsY0GzOsNiz+9le5Qg=
X-Received: by 2002:a17:903:3bc4:b0:290:b131:31dd with SMTP id
 d9443c01a7336-290c99aa9a0mr353473585ad.0.1761319644954; Fri, 24 Oct 2025
 08:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-3-69088530291b@linaro.org> <aPuYg0ws8Q2sp7Wv@kekkonen.localdomain>
In-Reply-To: <aPuYg0ws8Q2sp7Wv@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 17:27:08 +0200
X-Gm-Features: AS18NWD66neXy4pA0EykICaxP-IPYvUIs5btM5R7nrvoWotj1uaZi7dUGJ0akYg
Message-ID: <CAMRc=MfgGSExksz6ZwGEhv3yiL+Kfg+YKX-p2Ox4m66nYor4hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] software node: allow referencing firmware nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:17=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Oct 22, 2025 at 03:41:02PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > At the moment software nodes can only reference other software nodes.
> > This is a limitation for devices created, for instance, on the auxiliar=
y
> > bus with a dynamic software node attached which cannot reference device=
s
> > the firmware node of which is "real" (as an OF node or otherwise).
>
> That's not entirely true: you can add a software node as a secondary to a=
n
> existing OF or ACPI fwnode. This has not been used widely and it's not ve=
ry
> convenient to set up.

First: set_secondary_fwnode() API seems to require a struct device,
what if we don't have one yet? Unless you're talking about a different
interface.

Second: are we even allowed to modify an existing fwnode from a random
place in the kernel? I mean: I'm module X and there's an fwnode Y, I
don't know what it is. Can I just arbitrarily add a secondary node to
it?

>
> Additional properties in ACPI or OF nodes will still need the secondary
> node, after these patches.
>

That's not the goal of this series. Being able to create software
nodes that reference real devices. In this particular case: a software
node for the reset-gpio device that will allow it to resolve the
reference to the physical GPIO provider.

Bart

