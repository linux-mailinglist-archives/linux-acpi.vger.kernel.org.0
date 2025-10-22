Return-Path: <linux-acpi+bounces-18072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E864BFAAFF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 09:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB3E19C3898
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997342FD1B6;
	Wed, 22 Oct 2025 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yjWbfvaj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350D2FCBF5
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119520; cv=none; b=mpCkEthgsgfBD/NpLR/D7WsbSjWz31BJAPc2QtLXeCB6ZGe955vBpshRnbiz2qf5ElfjrcX9dCM0tdp1TEc+cSlCwSCeki/BWMNGY2Hhj7++O4WeNNuv2F6zVX+gEVMCOOO0HUfs0U7sYk+2y27XZGoPcCkoAC5hS85/CRnfzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119520; c=relaxed/simple;
	bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUUim55EXPUM1+NvVSMcMDA3UVlKdEZm4bZeURth6hBPf+bIJKC6sytyJ/NrnbqoiovBXq/MF0ua6ONy9H5dEfTmNCiE3Ls/uXXZ9r8aJVDSkXPmMwoalR2PThcsRttBpK0SAb6/ODTP52BFs3T1JgjIE/mclTwglaxBdIHgIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yjWbfvaj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so5633396a91.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761119518; x=1761724318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
        b=yjWbfvajw+hA9aow1wD23NpHUk5dI37pFdAvivig09R1y7pfB+HLCO49zxw4OjjGaQ
         Zv+sj8PjmDwLVLTWL9MDiytkaPIfCQc041Naa1iFf3wWLdC24yiyQGl9d8khyd4ir31M
         tHuZxlYxBJh8PXRAUv22IQMwlxwQW6jNIF00Dn0jsb/twHx07c8PLedazrTGmbrO4a/2
         arGmvTU8DQWJhrCpiMk8oAnwb9I48EcGdSakm8pWNg3DrPYqVFzb1hzu5dq9FtQJpVl2
         KbQ9feIE07+Gomw1oLQkBbVfKj8G+rygSgF7XZ+Tec59VwxKIl40D721DkUBpiLaARxU
         99fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119518; x=1761724318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
        b=vqL8aySwklZKEHzv4P/V7Iw0yQnrXzDpjk8hPpl3dx+aNG0LsK3GqdgvjA92u+GU8/
         eOfTnNaM4zsjIgvjLRO5KNy12llSC0dAlFLdRw65vKXaaQZE0rLzBS4o/M9hTt/iDnpW
         +GCDbsdk4LIWNx4nD8CF5I1F7uFOEF9z7dT7DuMmYH3vd27HWdQ+EsOj3VKvmMJQceI9
         Jguo4oBvXxSOG7qJ9cD3Mkz6glnWURykU0I8YWZGLyvx6imVyW55fLt6SJ+FZh1a4PIA
         stRG02tT18HbLnsUf9xH5105JEvTaxWh2nS1xGEhcIGZIAqTOk318sZY0E3nzH/jROh6
         FtMg==
X-Forwarded-Encrypted: i=1; AJvYcCWEo1alwbNwmkpFoM/iBM0lJlkQ9C+3YXfBV0HJwdR/To8EafyCC4/BTVSpdf28lAzfvhnn3yc11O4x@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3YMNqK8OBmBxbpfb7hcylZg0MWAQcGJpxee9Qfvit0X4ozCh
	FdHYgxO2jlEyJ8M433tSsVmgF/IVbUH9UkhdsXH+SiTViXnh68s8ytG3QUYdSH61b/T412xBBDA
	lWxMZesCoe96pt4OGuSgdRc87hDnosjDcmtVdyv/R5A==
X-Gm-Gg: ASbGnctRclF/5bXjZklNgYuEuFabnN+FfroOJjk6owSJY/I/UZI31cM3oAeO/bxC1Zb
	hc8OBqEadi2hSxU85Ui6kDz8aujs36SMaSfiIhmuO2U3VGKbLz6drkhidp8lqKv6s+V1QUWE5rw
	BPWF6W2y5LV8r9BKGtuto6bCY4kRFL46WAyAFUSXgaMpg7E4ifZWTp0UWzve9amA9/OqfQoV2ml
	bfxQ+bwWgqGvy+pMo3VA8W4UKPeE6cPIqNam+LtKlk+qr56+7vjB+si6WLqNNKFFk0aIbpmeFPn
	i4AQirQdLEkxD2Xc
X-Google-Smtp-Source: AGHT+IGg/bOFoiaG13MoDLh0wQPdpvQnjVjhF+kcamSsNZoWBjRpsyoZ2RCg+wNCw4VMdWeYvSdn0noK4cFimUz6as4=
X-Received: by 2002:a17:90b:2e04:b0:32b:94a2:b0d5 with SMTP id
 98e67ed59e1d1-33bcf923730mr24000792a91.37.1761119518374; Wed, 22 Oct 2025
 00:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org> <aO1bkraNrvHeTQxE@smile.fi.intel.com>
In-Reply-To: <aO1bkraNrvHeTQxE@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 09:51:44 +0200
X-Gm-Features: AS18NWAQSvR-Wj30Uglkmq34ZykFQDBTW9oa-LbZ-o-h0Yn2Kyd_r6Aqydksz8c
Message-ID: <CAMRc=Mc0E33JTettxsCEPf+K5FZ4-JOUX6tF1xq2QGr2gD0vLw@mail.gmail.com>
Subject: Re: [PATCH 1/9] software node: read the reference args via the fwnode API
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

On Sat, Oct 18, 2025 at 7:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Once we allow software nodes to reference all kinds of firmware nodes,
> > the refnode here will no longer necessarily be a software node so read
> > its proprties going through its fwnode implementation.
>
> This needs a comment in the code.
>

Honestly after a second glance, I disagree. Literally a few lines before we=
 do:

refnode =3D software_node_fwnode(ref->node);

We know very well what refnode is here and why we should use fwnode
API. If anything, the previous use of direct property routines was
unusual. A comment would be redundant as the code is self-describing,
what do you even want me to write there?

Bartosz

