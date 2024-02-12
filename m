Return-Path: <linux-acpi+bounces-3395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829D850FA6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 10:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542BF283C61
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CF1097D;
	Mon, 12 Feb 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XJ/dvrFp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86679C0
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729606; cv=none; b=Fn34OJfwg0D0rTsmTsLJCCaw0NMC95WwJG1RnPuD8Vzx0npY78qfBCXkzKd7/eCS/luSfVQBRziTw5Y2XFQMBeTXliCXwj7ZR2TThLrqmyCASQ3jvHmxf+NIr5/niHwOLV62G2suOG1NQrJRK6lEh4AUvVGSf7NP+BQB+AXmb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729606; c=relaxed/simple;
	bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYG9tXAyGxntSRRsdZx15CY0Wmz5rmL6Rt99xnISPHElghcuDYJcB0RaSZgdK5l+ly1vkEkqgUzKRQWXXBvuZxe1Mltf02OyKfwGsvUDblRmTxNwvOOdNT7zeIci3t0Ejso5pjStSCnGBmzPqtbm0FtXCoXfy7yg5sxmM0c8bzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XJ/dvrFp; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-46d2ef81f32so240078137.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707729602; x=1708334402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
        b=XJ/dvrFpttiQ0eQAWsv6BNf28mhumKXDBJL1kRyE5XvscwtHjwCHH5e9Df4dR8sVRj
         1xvcCsY6MKuj3VtfNahIH9UiG79XntdW0IVzEvXbrXcz2j34pvgrMH3VwgkD6d+V9Xq3
         RsvIDHJVyKEHSJc/DHvqExwb6Rlq4EVaCyDZ4ypUhFKrD2DTngy8/IepEPyPPh+NkvR4
         MXAghX71DJOFEyYpgf0+gdloMuPaAxhKWh1OTdlRiVNENRGrxPh1YP1uswd1ZeDYBDtE
         /Nnw7lfkTLudfiS1x5SUby3xr5hhIPF67gi/2pvq3BCqiLxEpOZPGe+kSvAEnGCt/0mT
         IxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707729602; x=1708334402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
        b=CrSxTX7JEnDr5JgRzkkorA7rT7cnbDFlZGd2JHK8EXSDXyG3fQEiksu3Xk81RhBj1e
         PwxifR3vutCpB2v6t/ScaG8m6ECwUDNzv6rX0b8baWvHGfUyg2mpNTQ1DhGrcg81NaUq
         Q+gAC5d4VO5JxHaI7ksUut3Ns6RJXRcenURznrwz2auL0u5BDT+NTXaUivMHnQUERsJ9
         XlupGND1dzycBYGFYj44s1DOZ0R+COUDaA0D5UqiSj/mEmWQ8pnZuFj+u2y5ufPOHQ/c
         iFi4N/moUVWRGk6CKcV1tseUIowyYcrSqnvYzHON10ARTxiJi3JBRE+thDUbOi9Tlbh5
         qPYA==
X-Gm-Message-State: AOJu0YwzqG/CfnbfpB8eWuyG/m2m2apjiKn4DTbqgmWDLgvU85CK4ORu
	uoGQFktmGBrtfiOVUcCSwuRwvMRE8Fp3AwtgnziLaHNPdJOKnAhGx+9QnPsodfQuOcqp2eA+UP6
	MxfiHVn6sni9t1kmODkW7Y4d+opgaGj9rYW+XeQ==
X-Google-Smtp-Source: AGHT+IHSNotxSJ3ltewKqxnRlk/iLnxwhZoi5Ou1X3qQ81yggKFAcv995ilite4ToFQmhx0SV+6LFcU5SayNI88fb6M=
X-Received: by 2002:a05:6102:495:b0:46d:2336:fcc0 with SMTP id
 n21-20020a056102049500b0046d2336fcc0mr3136855vsa.25.1707729601851; Mon, 12
 Feb 2024 01:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 10:19:50 +0100
Message-ID: <CAMRc=Mfezg_tt7Fd8AiJmL2ryQRp9pjozdOnM9Ak7mFdNVw34Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find() match function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks!

Bart

