Return-Path: <linux-acpi+bounces-11087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B629A321C4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F192C3A5B2E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB15205ADA;
	Wed, 12 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rHoWqk9K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B8205AD1
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351341; cv=none; b=SN8zW56vEa5NQPbgRYjCclGByTt2fkRXt+E1dSXuIGqz2KEqlefk2Xt/UkoixMkiPEfJeDyuAA/NHYhdXvqGspYE7myPtDuKRYgFpRm2SbN1+1qdIn26o2PwtUuuH+ggsPBEPz6sQTPdD4t2ZiaBuu9jtEvP3FbLRqBwsG0pFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351341; c=relaxed/simple;
	bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZiHPMW9xInY8Bpk8Q4F+6EVS2X5t+Hs5fBFhwc3u7l23WQCyqnr+4TMBsokAPjMAQjtfT/n+x5T65yukZL5iyA0N164SvV/cxkUwwWC/xeM2YnLKeeqvEaCWD7ivUB0hNOTCePAg26nsFdvBNYsrMZ4vz1Z2FBjjeWPc2SkpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rHoWqk9K; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54505c79649so3545384e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739351337; x=1739956137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
        b=rHoWqk9KET0/UQ/ypo46bbvtDE7KVr2A0Su0zP99gIi13A5YypM+5rtXFlf9+Pi9XG
         S1p7zWrmM6Cpf4+oEjbBfjNNPAUn4RXEJWT2lB92AYtmk7OU1OOF53vNerZYnsRNcrit
         3WTY4zd57B3VAxztrC4hOGhKP1xPmbrur1pGgTi3NnrMX8uA0MC8gPyUn5Pe0t4WyMb/
         J8e6BstzphqbwUUjxcB3b+EjL91JKnWq/UhyrShnawCmKwugtdXjAYBhPMNPiKeV96ch
         LBzU8yDrM0bj2PSV/7FG5WlLQ7SPkcRxwobkU6MfLZcs8L1cfH9tfnrHAbbyKnSciCcq
         6ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351337; x=1739956137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
        b=ZU6FOqXLsLiaEYGKMUp+/IKYO80Bh/ughyQn7qe+aOABxtU0b/agKHR4mZf2YnQ1xV
         Z1CFYUSmC95jNKTPtgsW6GxF7pFs1k8JkGYDecBKwjdHoBDePUc0iZ3dFwtsxpToqxcQ
         ZgBku08Sb1/Q0YqRFb7lZQ9RJDc8wXjvmDynLvBoHKBvKuZQhV6Jw3URhCtXIin1HCLY
         8EI1GLwoAtCBTCKLnrnMZt//6LS9w4g2U2hi1W84jmsAQRwMWxxQnjPGAR1PWKZgDNkF
         dWdbjQLv//ALOB957FeJA6xUzL6T/F1MP05rVtC0uglejJhu8ZpMIJ9pPkFsSJ/8OXss
         AjTg==
X-Forwarded-Encrypted: i=1; AJvYcCWPxp6IH1Lc36uvUT0CkLNBJ2+sAXdfN99PwHhLeFkFArvq1tQWMw/sVIOcntiETbdK0shLyy8AWb/3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyon7m7HID9khyHNs47XGkQdJ92RG6K+vMlIriHuTgXJmJUkxBJ
	2A66F2PT2mtZTeSYYhQbfbuPn6YK+rGUaFsbjB0omoZIgqj/DuM5U1rtTduUZruPHcjw9RtFy+e
	D7oxOxnH3UYDmT4Bf0OBftsOnegp0W72BqdVAGQ==
X-Gm-Gg: ASbGncv4AO2iU0iduujUMfpwR5r2eYF1ovqYFyuywQYWtosbOnShhyKWehRucU3I6HY
	5ZBibk8Ig5HrQp9EbtbNto3cedZFSDavlgPCYzxR4zZPoFPDnuWcpc2BOENRRRVjp359fY6K6U3
	kx4FdxtuDtsqovFQnYitr2VCg6phWm
X-Google-Smtp-Source: AGHT+IHMVhNH1DsYiwDgLt8aoqLJRbGu0lSkpmAHQUbgHbclESRiO+lCCFE5NmUMNPANjy2YyCxX/m9IzHXzQl+nN4A=
X-Received: by 2002:a05:6512:6d6:b0:545:450:74b9 with SMTP id
 2adb3069b0e04-54517f7b432mr715928e87.0.1739351337360; Wed, 12 Feb 2025
 01:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211203222.761206-1-superm1@kernel.org>
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 10:08:45 +0100
X-Gm-Features: AWEUYZlOaG0fdFZcvnZdGV-_YBOc5ks7TZt7wQR5Pn3UZrMzduFNjTZra-BNIVw
Message-ID: <CAMRc=MfOjfHWYGWMx3jcqQpnn6Kn+TFHVLZ355P7zG27JkqFDQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org, 
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	stable@vger.kernel.org, Delgan <delgan.py@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 9:32=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO =
11 is
> specified as an edge triggered input and also a wake source but this pin =
is
> supposed to be an output pin for an LED, so it's effectively floating.
>
> Block the interrupt from getting set up for this GPIO on this device.
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Delgan <delgan.py@gmail.com>

Please refer to process/submitting-patches.rst - don't combine tags.

> Close: https://gitlab.freedesktop.org/drm/amd/-/issues/3954

This should be `Closes`, not `Close`.

I fixed the two above myself but please keep it in mind next time.

Bartosz

