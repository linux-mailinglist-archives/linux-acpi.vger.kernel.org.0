Return-Path: <linux-acpi+bounces-18450-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C2C2B2CC
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37BFC4E2E17
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3C2FBDF9;
	Mon,  3 Nov 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GEjDmM21"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A43002DA
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167376; cv=none; b=Ym+WY0sSlesD98dk3FvdbsyER0dNbMqU1OKI0iWJW7HExRopij9byZF7dDbstthhZqOU27g6qInpfO123CeorgXs2HQYmVBGuQwvHJq0JqyNOfI6KLUxSTOCFUTAQLWGFIgzQwwwOlD+3XsE00iP5upgNKMbr1Zx3Y1VFf/1R5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167376; c=relaxed/simple;
	bh=qXd1oKO85msYoAVXXFRKg+REL5mVmucUjgWVubyCwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejII+4mdJe1tT+epCw4N2PmazlcGm+UvD8IbbzhsJqokMFIlRvMTuBvUAWUch+GOEZw8X/snJpn3cF5vKwUhlmQulFio4qbJN4sc4oTes0j9ilApjDYLXz66ol4KbY7YZ0BMGoUYOohQHkRKeeCdR28HGNbO2q8ITA77TCi0lFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GEjDmM21; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378e8d10494so43315871fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762167372; x=1762772172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok14Sy5kuYnk485Ftwy7kJP5xIgoR392fDNYbBDnVsc=;
        b=GEjDmM21brD60IDPvOLK4mVw/J58f58NnHnBLBc3eSK7EDPtCPIkrx1lzVOL7ny4NG
         ueMQCmyBb5ySLVGqqeUWmQ6L+5KrSRYSEyaviljmmxcJZWx53bQ6HbtE32r0UuxpR1aE
         HYyGQ+qHThCkNtxLsMjMaL2NgRwjCPS1did9aII8lIDDa1hf1h2Dqe1qyWBAjQvc/jZw
         MuW94y+xfITOAk18nnHwb9my9xpckl53mBGhu6X192TRqlKiCNvkAMIWX5otU+3v76Gw
         YW5wKCMv4shQxT4W9Zbnkyr+gWF9AdHjIT5sTJXd9Mt8unMvoJCl68CBV6VOnLGzFm0K
         X+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167372; x=1762772172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok14Sy5kuYnk485Ftwy7kJP5xIgoR392fDNYbBDnVsc=;
        b=VkhDulMlidZaiO24p/seoGvtvCrkUxyq16SsLKWkX1/rVS6X3lC1hsWOc/S6j3TVFJ
         kGhVO2ddTmxHS+GGgkOwdAg2j3bOjrDOwv0tRVlsF9nO2PFQFa7atQxBYqTZ3n0JyT+F
         JLdsuB7R1L6YWyBZjirswIViE14s5klfdI5qSEvk/R5lA2ubsdJLwtnuhpUaXaMoj7ML
         koKogYSxJrkabGgalp29PyquRSDMlp/gynM/xhhmIFKaxtj9+WIgwEghquUy+arysrvK
         jGjPBEZxYG3EqMG4GcrAKbwpFqR/WHjiYHFd07/Qno211w+Oin2eBtIilChnYErz15j7
         BDqw==
X-Forwarded-Encrypted: i=1; AJvYcCWph2HZ6JTChNZU4O4HrydriAi4oDlCzpooWcwlIdPtLIybx3bCAoWRr2RCtBk8ruEz/RSP5iTkww8e@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUj6XJf4R/mNvsGBX8mLGw5tBQORDQwQtYyENlwcOmdOf5GL3
	AQ5hbk1ct0VOvngdbDnHxeqFMmksobZ9bKyeHY7DuBGDHIYZzycWLcrerOImbVKLQoUpLEiWeiG
	hYzsDMa97ayD21/SXIKiHmFBN8oE5VmufREjgQSoTcw==
X-Gm-Gg: ASbGncvh2V1GYD2l4YwetABniF71tQnVDTeoE03UXM4xPV8JTEVlotMPaE40kUBtYNT
	55WCpFBUdAsQ68EbrQ9eTsWjPEfLM+5F8Vx1rq9kMlfttn7mvdXXIB/ZM57k8o8Dd6fLQjPRYfY
	iJ21g8dE5G+nBjSHmfCrCAHUtJQ1nSZszb86KfAlLnHt/WkGBbO8rcnP4nDqtCTij7n7333vaeC
	vcZLDfe2MLM31lMHKVDZFzcZM4+pmm5rJtQO6NWEsUTpx89NEZifXzclrOAuS/ii1v0eEE9pB32
	ngSdK/ODNz8eZk1R
X-Google-Smtp-Source: AGHT+IGCNFyrRkoy6fXh6ZFQgn7Nyap9sPAn3749NMDYc+KPJNXNFZcWuq9hVUt8f+/CoqxAouRL21Fy6SGUSNRsLi4=
X-Received: by 2002:a2e:9284:0:b0:372:9c25:7a94 with SMTP id
 38308e7fff4ca-37a18e2d703mr27723701fa.41.1762167372364; Mon, 03 Nov 2025
 02:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-3-6461800b6775@linaro.org>
 <aQh6n2XuI0oayg2g@smile.fi.intel.com> <CAMRc=Md=r7GaO3A_7de+EqzboyA2cqNSTZx7+64VSMvRBb9gpw@mail.gmail.com>
 <aQiJgRDm0lZYqSmj@kekkonen.localdomain>
In-Reply-To: <aQiJgRDm0lZYqSmj@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:56:00 +0100
X-Gm-Features: AWmQ_bk3gj7buQnHcMQ8QrYYR-_txSOE_pOOdJ6cMSRz8o8pL2AgO4lkThKstzw
Message-ID: <CAMRc=MfQ6n0S4RCPMhvE8kx5w4pc47=M3pwMH6c_CCo1-uZMKA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] software node: allow referencing firmware nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 11:52=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz, Andy,
>
> On Mon, Nov 03, 2025 at 11:36:36AM +0100, Bartosz Golaszewski wrote:
> > On Mon, Nov 3, 2025 at 10:49=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > > +#define SOFTWARE_NODE_REF_SWNODE(_ref, ...)                  \
> > > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > > +
> > > > +#define SOFTWARE_NODE_REF_FWNODE(_ref, ...)                  \
> > > > +     __SOFTWARE_NODE_REF(_ref, __VA_ARGS__)
> > > > +
> > > > +/* DEPRECATED, use SOFTWARE_NODE_REF_SWNODE() instead. */
> > > > +#define SOFTWARE_NODE_REFERENCE(_ref, ...)                   \
> > > > +     SOFTWARE_NODE_REF_SWNODE(_ref, __VA_ARGS__)
> > >
> > > Now, useless.
> > >
> >
> > No, why? With these changes, SOFTWARE_NODE_REFERENCE()'s name is a bit
> > misleading or incomplete, so I'm proposing to start replacing it with
> > SOFTWARE_NODE_REF_SWNODE() which is compatible with the former but has
> > a better name.
>
> Given we're already using _Generic() to determine the argument type, coul=
d
> we simply use e.g. SOFTWARE_NODE_REF() in both cases?
>

It may be possible, yes. I'll look into it.

Bart

