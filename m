Return-Path: <linux-acpi+bounces-18397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE43C24030
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63783BCFF3
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A632D0C8;
	Fri, 31 Oct 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="J1/RKiGy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10A328B63
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901442; cv=none; b=ZECgWSJvN8EKMqRBEgIgxocP4QQ7Wur2qg/RWiLm+SuUO1JGT+4Ye0YOAKMvTE3G3eTETQRPQu2QTtiHlBJeDr6gjXsZY7781/GDQ5aDgwVpHW4uWu8gnp2BZ5EzfUF3YVCkyqqdQu2YW7d02OWO23VUaO5clhst9kpQuK5WKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901442; c=relaxed/simple;
	bh=JmwRJW0gNIcYacOJginCbtVk4EY21hnsJ56SOMEXrLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkO+IxzwRV53MLVEGZEpAebdTBA6Wg1BWygB1+ro7TGGjVJgV1uiCl9+iBRl/qRSZklLT15RdpSjpL8CLP7aAm+al/esXmc9uggGYoveH2/LwTd13sBrgtBgckZ0Wag9gsOPNKPPTrD6GAcbnFuistsdtjMDg1X3uCkQBNIZVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=J1/RKiGy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592ee9a16adso3261397e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761901439; x=1762506239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyZkpPnlGmsDa9oHnjzalUScaxn5FyZOHbjL33XRSaE=;
        b=J1/RKiGyUeJFQmhpQlYKiL/MyfrOhq6dyrVEn5MLXdJ9421EQkdF320DlUYSEz83JV
         kBsGQ79pWXLf0zrjeZNPCtc7t9yyFMsiqcooHuLJKqYCuJ/92Y+D23fqhsHftyKcoV8e
         o0Z+3v3KnvyoK17PvjGD2BRlpUimrlslxJ/uMaYldt3e3BCy7Xw9QucxX2jFmrhpE851
         YZ5ZK3z0M82kHNphaqTa9TqKBcsCw3JL+uMnGquSK6LfH7b/2aZxKHUipbWdbNG4vJRs
         pWG/ujLt7gTuvcRuCGn41gytwpTqRxogey78JfgSVDAtto1e/gqei2Xsm6eA8aTU8D5i
         Ynsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901439; x=1762506239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyZkpPnlGmsDa9oHnjzalUScaxn5FyZOHbjL33XRSaE=;
        b=PqX3470OxHCGnC/42ebrvH+YiGtDeVwG2UuECVMG8oeG99YbvijRBWWZgqjVXlusxA
         bJoHCSnn65+nKKxNW/EXCGCFpoL32QpREv+0D9Gnee5XySkkJeLpmomNr79/8KfgqR8V
         JzUbwkJDV8AdyTLCXU03HVe8ki5rmGgNVa00nkhmlmYhFB5DIJt5SWgwCfxqa2GjsQeP
         aGb2jTGsvHsNRrucehjiyAtKblyKWrryh+009FxCZZg5HpPrddQDFaGCZjL045+ByKHs
         FwJX19qLsYiL4uOcPBlSkxqjO8ewckDrqbSAOw4yr5fo8mmUOCi84MrZpouDHKTjwABg
         3aWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMYAhy/osUHB1jIKSa56CZq5GB+UZfFJzq9FPDZGVblYKmootfxF9jG1dCp2Jr5tYaWTaODPB/9kS7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68vIVcxhkjkVGHsh6kLz7xJlTqaDtmYgqdqXvFeiJoAlYO3d8
	sNRReIBAoRev8TBgKd6mt7VWwxWUuj7X/wkmRD5dh+6TXrGNpDSLoxVepKzrJhBlte2FZ3ofySh
	Loagm8dNuUBSFwAb7XH1DGyh7pyuk0ZJno2uOtMbduQ==
X-Gm-Gg: ASbGncvfPQWkGsUmECZm1Qd4HWrqn7NG7jD4gCokU+4Muw3lJhJseEaW23NjqP6Dnwx
	ANP8cINk6Y1TlLG4Ba2b3yvOCH2bfAwS+bDQ0qS2b/z6kwGC6/hfNtBQzfVnX8zV90q3l7zgqJF
	iGzsbseW+IHzkOaYAtfl9+9rIxLsgBRZHMvtVVrhoGA3nTV1v/bSFU10kfkqVzo7uwrjzQ6kwgL
	gaU7svjaczxReEnzPZdkt1ioBh5IQppGJAXIMLoqLjxuFugHsjtUhtyL9qKhIqdK/Rs7v/jVoZk
	a7gL7Dyw81B0rooeYvuKFGd9rt8=
X-Google-Smtp-Source: AGHT+IFfI9eyrhi23j8G72j/eiNvjJuhW6MkfmYo4FhTpD1BLwzZZcpAU2luApM87JyhG9zxJTnSnB8n9suQdUPj0KI=
X-Received: by 2002:a05:6512:3091:b0:592:f71d:965a with SMTP id
 2adb3069b0e04-5941d533768mr1223674e87.33.1761901438614; Fri, 31 Oct 2025
 02:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
 <aQMxNgC9SWQp-yUy@smile.fi.intel.com> <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
 <aQRztwrOFCWk8IG8@smile.fi.intel.com>
In-Reply-To: <aQRztwrOFCWk8IG8@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 31 Oct 2025 10:03:47 +0100
X-Gm-Features: AWmQ_bmv8Qxd8nCHziy118YXDf7vt-9TVORFE1gVGmbEVeznxXtKW3L2NFycPdo
Message-ID: <CAMRc=MezQ7RC=ZjiKkMa0qiaKTRXePOKxOCDjjV=-qUYto2jqA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:30=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 30, 2025 at 03:33:02AM -0700, Bartosz Golaszewski wrote:
> > On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Wed, Oct 29, 2025 at 01:28:36PM +0100, Bartosz Golaszewski wrote:
> > >>
> > >> Once we allow software nodes to reference other kinds of firmware no=
des,
> > >> the node in args will no longer necessarily be a software node so bu=
mp
> > >> its reference count using its fwnode interface.
> > >
> > > Same, a short comment (or an update of a kernel-doc if present, I don=
't
> > > remember).
> > >
> >
> > Andy: the resulting code after patch 3/10 looks like this:
> >
> > struct fwnode_handle *refnode;
> >
> > (...)
>
> Let's say something like below to be put here
>
> /*
>  * The reference in software node may refer to a node of a different type=
.
>  * Depending on the type we choose either to use software node directly, =
or
>  * delegate that to fwnode API.
>  */
>

But this is incorrect: we're not really doing that. We either use the
firmware node reference directly OR cast the software node to its
firmware node representation. We ALWAYS use the firmware node API
below.

This really *is* evident from the code but if it'll make you happy and
make you sign off on this, I'll add a corrected version.

IMO It's completely redundant.

Bartosz

