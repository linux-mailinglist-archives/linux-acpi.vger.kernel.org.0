Return-Path: <linux-acpi+bounces-17537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48408BB6351
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 10:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035813C6292
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55125F994;
	Fri,  3 Oct 2025 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="anGi7FIe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAC2417FB
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478612; cv=none; b=ut91JgOammjtKOEQpGsqQT84+5kFMqT3AryttM5tL5ECyqx0c6ILqDvT8SrB9EofrQ6N+fQd+YB+zk6bj5mchCdTl/hZN7qe/I0zLrdXQSXU6SKqQhYbMS+WHkNyfOoNjXRMnzVJBzYsYVb76aJmmiDlLLPwX9lJQFCwWa2jas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478612; c=relaxed/simple;
	bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkVlgvIS0moes8T54dMDTgUUqAGbaPHRT8UZ9HgA4pvCkjtfe+L/TEiOBF1BCuPiFyDFA1bQbZ4XpCmIoNBUffTcTl0BJ3sduqq4Oe+UVwijpM4GMdqBmIogte07vFQOwoOdMGLzJX5pciDLcoXw55VdZieBIdobobFaO3iXo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=anGi7FIe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36a6a39752bso21235811fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759478609; x=1760083409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
        b=anGi7FIeHk3rhZ/71lHGwH6BHBNm2Mr9ymqRKp3iSsnzYKi+4Hx6524fKGjCtupHHr
         9v2+KbJge8rndvU4sT6zMcIgrqMevaGlA577wK++Siyb546laVFqq6xRd9OfWeslwAZq
         6expFd7kzFGzvBgnlfbu+eiT6QrQ1SuQ+HdNojiWHp3OZlkLPnYba8qG+K8ZBB71XOSE
         cUh1MYzD+uxwCJ4tZY/aI+IxylWDA/auEPGiqQqfQ+ybkLmY+aAcGkxweyMrClMF4Ohu
         YCB9WpPFzAmA6KHvYxYjeyOAGKgCtfjsI5Nn8Chi3zfCrYJyM4b8MTon1oNKBlhRhFBw
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759478609; x=1760083409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn6OdQEr8XVdAqEx3+HNvbieAPgE9iCGbOGXxcvqocc=;
        b=SAaGNb76My3EAYuZowAOmN5X/JR+w98ZkOVwtZUSNd4nei36TKav7qwrv/thNQQ38K
         zfi1Ebwj07+CVU7WvwhtEDviKhrWMZlLVc2zpYKytuBIkKwPER1anfzOahfbsWp+BW5w
         WWzCdBoFpIW6j2ySy5NAi3uVFwxpOdnKKMCtkzpQtIC/TP3hL1uQKqWY1cVCXenmVHVC
         uABli4rJHuzSADKjLLa4c+cRVHXjMi6u3Td++pL8J2yEyIKwasPAAEElkYq5CotmxVI7
         pTaMj7LY1EnC8K+KD9NWFzoXPLSz3f1Ig//GIrKTSyU2aqfKhy7fKzomJouE6nZuRqRo
         LWkA==
X-Forwarded-Encrypted: i=1; AJvYcCWgBBD2GizvVNv7ajq9TrF9HWYFQqQ7ksx0Ko/vUCJsfOy5EW6BTLIRMWDvdbo9llL3JStx7+wL2D9D@vger.kernel.org
X-Gm-Message-State: AOJu0YzppKW9WSzQ4JqbXjm3SDyZpGAQ1vy2yQRCV4pftdXqAh1XCUIv
	R/cMKBiT5P4Zziwg49eZ3YuR+5abQd4JhlPAYpWRjVYHFrFeMybkIn3eKPCPtEBidth+qHMEQTs
	MQut697/EKvj0sDt9aRf2u3rkBALzEBK0k/Mc+c0rAA==
X-Gm-Gg: ASbGncvIJrNCAWcWbXvGZLBPIB4vQfg4bD49PDNgvHOY3KyRMVny/LFqh7Q5cIysw/v
	5d0MCbWP9tOR6Ilek/tQhuoyt48CxyNchvC0hBTbIqSZnErHE5dpim3BfO51gwoaBLtecQU9kh8
	ZLwa2R7rJgb5JTGFE10kTPH+zphovjCx+o/Ai7etDeIpnNX00dMKkKf034rIkW0631cXuXe9iH9
	SSQRRu4fY6C+De7XxWksF2Ol+1lC+M0hLHqmDJBtYqD6jHIpOn4t1kPvBYAjiPS+ub5tnQM
X-Google-Smtp-Source: AGHT+IFyQ5SUlbaZKyC2n/giNpyOPrAzduQsXL67RzSc+/XD7ohW54+y3L1jWlwiS/5sdocrcIvEn67wqltom/d/bVU=
X-Received: by 2002:a2e:bc8c:0:b0:337:e5fc:d2d with SMTP id
 38308e7fff4ca-374c37eb3f8mr6316451fa.24.1759478608652; Fri, 03 Oct 2025
 01:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002215759.1836706-1-markus.probst@posteo.de>
In-Reply-To: <20251002215759.1836706-1-markus.probst@posteo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 10:03:16 +0200
X-Gm-Features: AS18NWAb_UicKSU3Hkbg1b38gS-dxjPWCSbdeYjPWZM22VcaOTqo95Y1mZFMQ6U
Message-ID: <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Markus Probst <markus.probst@posteo.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 11:58=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> sometimes it is necessary to use both acpi and device tree to declare

This is a rather controversial change so "sometimes" is not convincing
me. I would like to see a user of this added in upstream to consider
it.

> devices. Not every gpio device driver which has an acpi_match_table has
> an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device which

What is the use-case here because I'm unable to wrap my head around
it? Referencing devices described in ACPI from DT? How would the
associated DT source look like?

Bart

> can't be easily disabled in acpi and then redeclared in device tree, as
> it often gets used by other devices declared in acpi (e.g. via GpioInt or
> GpioIo). Thus a disable of acpi and migration to device tree is not alway=
s
> possible or very time consuming, while acpi by itself is very limited and
> not always sufficient. This won't affect most configurations, as most of
> the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---

