Return-Path: <linux-acpi+bounces-16217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EABDB3CF2A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CF202A77
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA002DF3CC;
	Sat, 30 Aug 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sKyQ16DW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108282DECC5
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583493; cv=none; b=S9JsXbp82ZxqJMcS+Ec4mwWH1gCXHuG1I5gCdwDWVYS6XfHFG5+ZRGa/cIgUvYYkYjn9nWdiIZ4IsRsAC6pGsrghgKM0s0/lMeG+qHe8rFL+owxKq+asuX8qUg5Dv95Y9Rh2APetRXIeYLRRy67E887W/mwYv7Gsgn9PPpYaNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583493; c=relaxed/simple;
	bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqyDPx8YppH5BjF/bGyo4o7g3wDKqVbBlTBgntv3obHvZpl6+kljFdKfneQa+NUOEs8Z7xJYPYZq/GzHDNvzL/tJzUz2TPINA2iCq8AgcghnQlxNYePlPOoOxhlNPjPrxVbHXHvLRApfRzwRvn+860rtgo4DOpt/xyMCV2LDTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sKyQ16DW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f469ad067so3243042e87.0
        for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756583490; x=1757188290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
        b=sKyQ16DWB/y/48kZvGMZW2Gj44Z7EnX9PqvUA+oImf0AXAcZbv5zbQQVDDFkdM4FAU
         rXWVisKElwY6yv6rRe23FDgxfKn0NkvA+BZOQg15LdT4H0XsxpNg2+kIFBu/TVkXAJ1P
         1+YlHWUGDxSdyzGZUQuXWRIdDxKiDD7BQW8zla6CUvG62/pr2YhPLI/EMtVDgZOQ85BJ
         idIIClCdh1Q7cbO4MtADc1h3DCghNpqnvY6Pz6mCI5DkF/82de15vcD/WUfvWQ84nwvS
         ytM8KzLxwIfv1qBF+dfH0BLn/4iRNsd22Z8cJLGWErrP62RmYxBSOA5LPFGr+ATWoTEk
         wrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583490; x=1757188290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv5YaPzqC3Q4Eg1Pl/dZPS9JfeNag02J+mjC/0Xdx+8=;
        b=LcunPhvN1i+AribTP5zQavQNFMezoPntA9mJlaqOZSoHZ50oXLh7pFvuvT1yJxhqZQ
         uPCSh2K6I8dv6CyvpWbPFyVFaMPXitdtZx9Z5t4xA7Rgw5Zq8sx4drW8hy2zdRSuQ/Nn
         fB6zLfT2BKbam9ofkXlGHGtZFZNxnWiF/vMnVg/gE0eNO8d/11qomhzx5JFXBDuDvt0C
         4BGJy01lHtKgcmS0odzR7/VT502FGCSVGmcp3FCKNRKAGZrRz8ayTuuY62QIEFv/wZP+
         xmQyjdjqWMHxKczkcMHPTMS1b07XStxWvkgKUnj3V5LaJ/LHwMdr9a2rlEZNRndmqgxx
         odHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlOUI3t45DNwcXWV8ifUgTniDoSt2/HYpbEgvyun/MUFHyFJCcjhhHjdpXA1l0S9zFVao6u+5Lm+1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxDs+JVkO9CM0hkyzjn8ZywYyxICDJrcePm43SP3sFELRxdXOYC
	/iEaRaqtmw1EAGZLrZtroOYiZA3tz5qlzDD6jBN0pQdwsmnCXOf3MjjHiS9j7lLrX5j+U244knn
	xnGEtZPKOxrvbja7z6lkd4Pk2mp93AHwoQCvrT1HNEQ==
X-Gm-Gg: ASbGncsAqRuAn0oMMVeZXCMy0mLYGoI34A89/6sd8zoZzr38cKsxGTlCloJIT0sX3Ye
	lphXeO4emX8rq2F1E4fPl+TLasCZxgaxiIIjQ858CLi9z7xNGmzbkR6samVEAw5YXbh8GXdfIXq
	ENUOuQT4ZEdu0+KggL9qMBp1si4AyoQHbI3890qbzUHIn8SaT1TWgHWCqRVIZpndpM/c6zhNc7S
	3poP7Z0f3CM9V8HaTHlCvpLFDpdG4+EuynkNletu9XjNbDGzg==
X-Google-Smtp-Source: AGHT+IHQUwwu34vgeZphW9VRaLBgPvPzIFcJJeErIWV2xc9g4g/MPBPhfaGbLPPRq/dIAxP0j9S4AWNKXDRSvv6YX2g=
X-Received: by 2002:a05:6512:6812:b0:55f:563e:f16f with SMTP id
 2adb3069b0e04-55f709b52a5mr577475e87.21.1756583490203; Sat, 30 Aug 2025
 12:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827175842.3697418-1-lkml@antheas.dev>
In-Reply-To: <20250827175842.3697418-1-lkml@antheas.dev>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 30 Aug 2025 21:51:19 +0200
X-Gm-Features: Ac12FXy0Nl4CmsqKiiwHV9VDpEUWs4Srsi2V0nq4DWPNXB6KMNEBW8bxC3QMlqg
Message-ID: <CAMRc=MdQY4mmfAPA2SorkjCdjpx7DSwF5rRUvnRPb9G1o5aaLw@mail.gmail.com>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:00=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---

Andy, should I take it directly through the GPIO tree?

Bart

