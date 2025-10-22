Return-Path: <linux-acpi+bounces-18099-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D444BBFC48F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B861A05502
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B2348454;
	Wed, 22 Oct 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHaW3NDe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A934845D
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140897; cv=none; b=Uif/crxLpDVR55iQEI55XGRzh1nxw1es9HPujbx0hWYhgolqF/gPSI44KTfEYLerffitCa0tIABVhGk04XQZ83B/9Uh37S90UkkAZuTSNPqMHak5sMliZU1aMM9kvoRfm9M9aP+Kxx2pqirARbcdAPRIjiPVjlT8Z8zYW6Y6XxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140897; c=relaxed/simple;
	bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goaQROeKmsnFBzgUwQCM6NI7aDHU7CNTKvy29VsHXmCEo0mdq59NZIwXhnPpZNqVNtODiv3Q/TURpwoAkMUq2rU2umrtYQtkNYMd8Znk0LDs3/eRSJTZUZUJwWi7fPdgfdiQG1m92aJiP+FWUi4buPXKLahjlHRIYanRAph4T7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHaW3NDe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2863569a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140892; x=1761745692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
        b=DHaW3NDev1RDSphTbDxQD251qxiDChfS61xdvO0IDpC1JxWRGuCTmbqFPp7bRlTEbH
         J0c92Q/jB1nKojacP1C/x0eyPH1ZyQaBKZUJmEJ9a7MEo2s5RWJVhw77mkAKrh5liwtV
         PJJ+pGcGVv5y1LXkUjTPCOl1fl3FWrdghLdrW80WSGYvUqaP6kcYoevWjNXw9dtraHER
         Z+Dmp5l+6/7jaS4xCLH9WfHPJgOQiyoIqPrzCeO5s0Ve3TBooRJBIVHS3y5kybHdA+7A
         8L4DWh25aYfB0aoQv5HR25kGnZFsw7uPlHHj9KRRtqfVEK1E10Xh7CcZRsZYKxQ9Tcbv
         tdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140892; x=1761745692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYT6Os1q2Rohj9KWPycuJw6XL0ogAAvatT1CGliGFF8=;
        b=RNZhS+gA8fgiP+Ahuf+B+c1v51/A33dtz7rJLYzOFxkw2xwWnh6ZvehxZBlTykBKKC
         1monAaYn3T2/zNn59BHDAPTaPqOEeJh30dNCGCzLTJIT52Sq1FBvGTi5YIpf96+vuyAR
         YUyU7dLjFszDoWq9pwjD9osnT1QDfQD0+MFfeiOo8VuaV9AwI7Hod0CJGMBTTZ8VrAn6
         QjFa/ClHu+AGDrDsPsKyPgn/X7uMmXw4s63FWK4lrIupv6wp5VK5JxIEEAL743p94rXv
         tiWo4OEgVKB1DR3+hoaJ693zK8GRoCPZac8DpOBCSDxjDM304grb6+98go/rifRdfLgK
         2Jiw==
X-Forwarded-Encrypted: i=1; AJvYcCVWspJCVNZ4rm9jFW0DqdsKeBD8EbxZcv0aSU6j+IsswnFemAc29dGwv8jEC6OmUFbB8mliRnRMnW6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yGkOAHNeCsSj/q9gKrjxUMGqCWX0JaiiMsXVuYAUXxpU/Ye9
	6QD1b+miMhDW/7fHqxQxFBJJdSXaJaqlaB8/uH1s+hJe5F/fY3XzgtnKtEepoHBe+/gL3/RwM3P
	q6WLnFg24+m1m+SH7aG9OIPMtbgT4wcs=
X-Gm-Gg: ASbGncsEbO5eP2+1BUy60PxjzNzhlSFqwFVZEGlsP5kNomJ5BB/5KKB4wbQxgokctE3
	vXTMwCN4F4k77YWs9D9TxeMdCXClgvcYOFHk9G7NISNKwbO0PfKwPCGiHtEzgdJnSR38Be4w35/
	BxsfnCDO7fXEMTxYK6Fcdpthl+Az+7wkZTlwBqsAnXDi5/QJ1KOdS/CP19/JQfGBX3qSgRZcvS1
	INQIUx801CP3tH9nOvgjNEHg1NBdvvXOByk7xccDRZoSqotWKGrPN6DO8Unkr2XhtWfyMP/
X-Google-Smtp-Source: AGHT+IEuV7ok09UjY4sSyg8xFKgHnnOuV/JfYn1sZVkbPUVR5FFRF22mq8r+kNUqlJQt2/5X3tjoeoegXNFBatkKhxo=
X-Received: by 2002:a17:907:72d3:b0:b3b:4e6:46e6 with SMTP id
 a640c23a62f3a-b6472c6191dmr2347267866b.1.1761140892136; Wed, 22 Oct 2025
 06:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022133715.331241-1-hansg@kernel.org> <20251022133715.331241-2-hansg@kernel.org>
In-Reply-To: <20251022133715.331241-2-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 16:47:34 +0300
X-Gm-Features: AS18NWBj2gBYFMQcocMtRK0flD8nTDu1ZgBmGY1rHhMmb1QfH--tXoq-ijJYeDk
Message-ID: <CAHp75VcDmafp4fiOH7LqhPqtTX5BEp1w0eA5UMk13U=2_tHsyA@mail.gmail.com>
Subject: Re: [REGRESSION FIX resend 1/1] gpiolib: acpi: Make set debounce
 errors non fatal
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:37=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Commit 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
> adds a gpio_set_debounce_timeout() call to acpi_find_gpio() and makes
> acpi_find_gpio() fail if this fails.
>
> But gpio_set_debounce_timeout() failing is a somewhat normal occurrence,
> since not all debounce values are supported on all GPIO/pinctrl chips.
>
> Making this an error for example break getting the card-detect GPIO for
> the micro-sd slot found on many Bay Trail tablets, breaking support for
> the micro-sd slot on these tablets.
>
> acpi_request_own_gpiod() already treats gpio_set_debounce_timeout()
> failures as non-fatal, just warning about them.
>
> Add a acpi_gpio_set_debounce_timeout() helper which wraps
> gpio_set_debounce_timeout() and warns on failures and replace both existi=
ng
> gpio_set_debounce_timeout() calls with the helper.
>
> Since the helper only warns on failures this fixes the card-detect issue.

Acked-by: Andy Shevchenko <andy@kernel.org>
if Bart wants to take this directly.

--=20
With Best Regards,
Andy Shevchenko

