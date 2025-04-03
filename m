Return-Path: <linux-acpi+bounces-12680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196ADA7A23C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3803A5F61
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD124C07A;
	Thu,  3 Apr 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nXN35pJV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FC3597B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681456; cv=none; b=req8VATPZ4yHxMKrlSiZEltQmqd87n563Mf5Ldt5Oh8Zfobgkr36e7vlf6oVhIP5R/gFd7zj7WKoP7xhVGMG6AGHMrYJ19WXm6UJQrd9XR5Na06JoRk9YSJn24jtG70ih0Nv+1QOJCgWW57ESV/2izcJVyJPDSnDxJAB581hFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681456; c=relaxed/simple;
	bh=7RumA3X5eB7LdNlJXXDsoSjZ7aj/drzqeBxe1DW71xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8/q3msKW5JhX9l1Al16rWjfOORdrrYC7KIeN4k4ha70MlW4rbh+VcWue6FaeWepyyBCdHjgtfiJp9/1wA7/UaiMYOWXrzznPhc1iAEnY7W4aAbuCIjf+A83B56lW3iIn/tfP6ACT5K+J53O2SQyOHgpIKW3SDiBXzFDiBgwzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nXN35pJV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499d2134e8so990783e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2025 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743681453; x=1744286253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkOktHGlzjAkXagwjlA6YI1+PYwTvY9/fqcii/7p6HI=;
        b=nXN35pJV0C89hgcKghGD6dr09VFh51dAELeuUjSxYij76Sff1JpDDRgAuVzwzQM0E4
         GbU4EsrCIycxe5pS+j+ZRCfTjecOqTKfpZKENBNYg3N7HlDD4CH0ky9RDcBVaA7YFwm6
         oMgE0leusXNQl00mdUOXJxzhWK0WBot0jRjC4HBUFZSK2hb/Hp3oL3AqXzOMLYVfpL0b
         nbJTRyPNlqgFNO4R6OWkQDSh/N5PPkvjh9lRL8yY71b6+EN0VWgaCKbKDkfXpAJ4m6ch
         1EvO1+ne329l9bhy9+Ku9pbRyKUdjE+MoRK2IXvYDEuE9zWfY3Hv9p0G6g6jGBd7AZbt
         ctKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743681453; x=1744286253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkOktHGlzjAkXagwjlA6YI1+PYwTvY9/fqcii/7p6HI=;
        b=jj/oGCZJnUVe1hadqCd3s5vx2kTyH1IhEsazdzGWN+KUMpmAdSAP4iKOHmmXR71Xh9
         yfTT/MOGbmfSvaYWJtBrgmfdyOsfSkTZFWNGOnzsqRDM3QChFpHHQKFGoEdTErt1Xw4O
         mQVbYucJGgstOykbCvzoyh06MNcJAHwq++NAs/wBIAns5zHjPTIKVRSjJ3igNUBGISts
         jQJgzoxI7vNdgvcbsG0EPy1SHoLR/rbY+WwkZ/Dh7FnYpb10MIGe02akYIUO5pRZfqWT
         5uGehKHxAWyapfFM4b4HqLjTOTW4eZT4NtblzvsMUiap08jOYm15I0TPmmcx25RbXgVM
         Eejg==
X-Forwarded-Encrypted: i=1; AJvYcCXun2A44fpbMTNaixtiuANjFFf+9glPWD0xz6MJQmM82M/oVnA+3Awtp3opjsa0SZGSC64S92mmx40Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyOufQJFDEZE1tSSK+aEIret/gEtz0AkZ5LT28MGhuq0b43gq0Z
	aS7WruESEQl70Im2sh/j5pHbCL5hcKHpDVJLNHCGb9B90t+bjBPIrXG0Owpe6tOe1eRmq9dcQHd
	HYk4itCZDBXvb1GNU+a7+07fn2fJt9kACZycCUQ==
X-Gm-Gg: ASbGncvopFPLFfvLd7qmYe7vShFZb99wr1YgkoMisyRJbaa5O0yHd2C6tE4GSfVX7bl
	h1tPJLyQMf4dh5FDDN5E4jmo9iliCrbKFqEJtf8X+n+hUIrgNWsHSwXE6E9NxeSiNFlbVYz5lI5
	wVY9SiM23PwBRZqhzgOhXCu3lgBV7a2x8OR7xyFBWu/Wk8fd/5kuKeXe71
X-Google-Smtp-Source: AGHT+IEJOnKqMX5+dgmSPUxCOsMR6NccyLGkvgLJRbiRfJodYmSW6tCZcu76/+/XfCMur6jjpB+I1EXvHvccn5hkhG0=
X-Received: by 2002:a05:6512:3b25:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-54c19c5c517mr1842371e87.18.1743681453030; Thu, 03 Apr 2025
 04:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
 <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
 <20250403103506.GJ3152277@black.fi.intel.com> <Z-5rJDWaSJd58lTa@smile.fi.intel.com>
In-Reply-To: <Z-5rJDWaSJd58lTa@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 13:57:22 +0200
X-Gm-Features: AQ5f1JqR55KMuRFut8zPE2h0a1E_W5eZhlgdejLJXansH_I-MmaaezYhi6oZpYs
Message-ID: <CAMRc=Mc3YUsLm5dX0b3rFsuCErf0WmyyYtXZgDYBt0w+xwqkCQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in
 struct acpi_gpio_lookup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 03, 2025 at 01:35:06PM +0300, Mika Westerberg wrote:
> > On Wed, Apr 02, 2025 at 03:21:19PM +0300, Andy Shevchenko wrote:
> > > Some of the contents of struct acpi_gpio_lookup repeats what we have
> > > in the struct acpi_gpio_params. Reuse the latter in the former.
>
> > > +   struct acpi_gpio_params par;
> >
> > params is better name
>
> It's been already used elsewhere in the code. Do you want renaming there =
as
> well for consistency's sake?
>

+1 for using param or params here and elsewhere. It's much better than par.

Bart

