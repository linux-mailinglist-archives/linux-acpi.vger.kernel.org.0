Return-Path: <linux-acpi+bounces-4448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA988A81B
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Mar 2024 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B188340178
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Mar 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0AB4EB5F;
	Mon, 25 Mar 2024 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WY/AsTSe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB43DAC18
	for <linux-acpi@vger.kernel.org>; Mon, 25 Mar 2024 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373519; cv=none; b=kx/5JyNVhsp/xXwXFtRQrNLxEmKQI9YqE4TmkEqVG2Wa+UNDEmfej1xnjNTBPcsCj60IQPZ5Qn8TlKb9ax70uXsodDSCp3jDseOYKwJs0yhdJCQ4XlputkIK9JEcAnu/W5mWEQyy+dese0KxVcmSCu1cCDuYwnbUVurXEtaXHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373519; c=relaxed/simple;
	bh=Noq9HJ+sO7FD5O4+z0BIm08ek7Wa19Uq39LkX/oIuTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdm1f4JZbx11nuCTFqPUVrn1ySRm8arFYF5LIbzZI6yVGW7dp8nwF+RNAKa7mOWCqX4tvXJ02g7fQ0WqgMl+tM24WHcZO1X0cNF4sWUD/zULKmjRtqS92WwcRxoBf5Gd+AWBsjNe+C8WQlP1ejn7n+5aDKMv2LrpZ5K/w/xXrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WY/AsTSe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd161eb03afso3621820276.0
        for <linux-acpi@vger.kernel.org>; Mon, 25 Mar 2024 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711373516; x=1711978316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjrucB3wBbhQAMSDiYU110V4Jry+ELeXdh9amzt/biA=;
        b=WY/AsTSeQv4Fmk7STSmBBvYrNa4tiyMrMwMaDjk6316K0lJgcITZWk0udGfkPaFy/Y
         bER5v541q6lDkrXFASVu8MmgqKKC8RUEmsLVvV7Eip5QgvJjOI7r9JGwliXH37UgGdM3
         u0pn+2MKXPTzwqfxo0MHTDcbLmMZ8esKqFk1HE/Kj07zkgZkb9jeWLGlV8HxcfO8JgA+
         QAWwNCgn0N07CVhS2qvBdMfixiuouFLI59sEVOZ60sh1ukYR1qlP6LeIhWwTv5GRT55p
         wE1PtKFrP73TLEwOj1HJhS/AOVWkhfr75NsGqmvCO+POb9kcwt7jDC0ITxHPPfSxDMMG
         2Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373516; x=1711978316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjrucB3wBbhQAMSDiYU110V4Jry+ELeXdh9amzt/biA=;
        b=FxfH4cCEMEk1aQsGqdvhOXQP6SHI3CWqaBzgdzQ7RRZCgfPGz+B8YatsN8PQ7w8r6t
         bF4LxHqHzTQjy/dk4YEFqmMOcZQuM8ZJ09fPARmhYYpgdFFcSlkj/1frUwdbtx+KaBl1
         VeB22ceO4oPqcfFXQPQjecd0N5fTooQvfNkHZTC3HK4/jzTu9hnK3jFiWR3Si9XATOWG
         RLBNzI/gmFXYwoHVR04OFmxyE4nPZCi1VXhFSu1ujVMHCqfdx8bIoSbVL4N8odchpK+i
         icHFfh7Yq/BbhMtSiA18Y9RSQZI0H9EfZixb/Ju5lbacr6NKsX0ujr+Ee0cTsr3Oj3b2
         ciyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYa3TZ0niuxjiqC/Y/YHPnOC/XwRz8kizIQCZkOrYPmlcPQ5j7xKn3pNhdB2a7byO/a3/PZfenQ4n+xOnmZN0mixxU5n9ZeTbX6w==
X-Gm-Message-State: AOJu0YzbyPW+YvC64NIx6lJpM+SNQ7ji3yooiQNsSHfEYv3Dj4haOK6f
	TxtZ6VZv41fX7td2ihXR0yusd5R0Zj/yyjrkem5wuKRhKa5zRAuAvw6DxdljUF2YHkqOfmxFas3
	OUYAvtQD1WvoLYVWfXRxhYroKM50OhRs3hVNrVg==
X-Google-Smtp-Source: AGHT+IGj6hFj+6hUHwZFUxLS2kHoykDs/3o9qNXuHqkCWNbjVZC4rBcQ0W0UfjSVWc+jUK5Dl4JqkVCqyHnunibXQV0=
X-Received: by 2002:a25:c582:0:b0:d80:68d1:b826 with SMTP id
 v124-20020a25c582000000b00d8068d1b826mr4994709ybe.6.1711373515809; Mon, 25
 Mar 2024 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12417336.O9o76ZdvQC@kreacher>
In-Reply-To: <12417336.O9o76ZdvQC@kreacher>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 25 Mar 2024 14:31:45 +0100
Message-ID: <CACRpkdayWiVskunN-YeYzS7dd6ZGHmqiTbCyWQKvOG91S04Dzw@mail.gmail.com>
Subject: Re: [PATCH v1] irq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Francisco Ayala Le Brun <francisco@videowindow.eu>, Mario Limonciello <mario.limonciello@amd.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is a problem when a driver requests a shared IRQ line to run
> a threaded handler on it without IRQF_ONESHOT set if that flag has
> been set already for the IRQ in question by somebody else.  Namely,
> the request fails which usually leads to a probe failure even though
> the driver might have worked just fine with IRQF_ONESHOT, but it does
> not want to use it by default.  Currently, the only way to handle this
> is to try to request the IRQ without IRQF_ONESHOT, but with
> IRQF_PROBE_SHARED set and if this fails, try again with IRQF_ONESHOT
> set.  However, this is a bit cumbersome and not very clean.
>
> When commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler
> for SCI") switched over the ACPI subsystem to using a threaded interrupt
> handler for the SCI, it had to use IRQF_ONESHOT for it because that's
> required due to the way the SCI handler works (it needs to walk all of
> the enabled GPEs before IRQ line can be unmasked).  The SCI IRQ line is
> not shared with other users very often due to the SCI handling overhead,
> but on sone systems it is shared and when the other user of it attempts
> to install a threaded handler, a flags mismatch related to IRQF_ONESHOT
> may occur.  As it turned out, that happened to the pinctrl-amd driver
> and so commit 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the
> interrupt request") attempted to address the issue by adding
> IRQF_ONESHOT to the interrupt flags in that driver, but this is now
> causing an IRQF_ONESHOT-related mismatch to occur on another system
> which cannot boot as a result of it.
>
> Clearly, pinctrl-amd can work with IRQF_ONESHOT if need be, but it
> should not set that flag by default, so it needs a way to indicate that
> to the IRQ subsystem.
>
> To that end, introdcuce a new interrupt flag, IRQF_COND_ONESHOT, which
> will only have effect when the IRQ line is shared and IRQF_ONESHOT has
> been set for it already, in which case it will be promoted to the
> latter.
>
> This is sufficient for drivers sharing the IRQ line with the SCI as it
> is requested by the ACPI subsystem before any drivers are probed, so
> they will always see IRQF_ONESHOT set for the IRQ in question.
>
> Closes: https://lore.kernel.org/lkml/CAN-StX1HqWqi+YW=3Dt+V52-38Mfp5fAz7Y=
Hx4aH-CQjgyNiKx3g@mail.gmail.com/
> Fixes: 4451e8e8415e ("pinctrl: amd: Add IRQF_ONESHOT to the interrupt req=
uest")
> Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
> Reported-by: Francisco Ayala Le Brun <francisco@videowindow.eu>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> -#if !defined(CONFIG_GENERIC_IRQ_PROBE)
> +#if !defined(CONFIG_GENERIC_IRQ_PROBE)

Is that some whitespace fix? Not that it matters to me, so:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect that Thomas want to apply this one.

Yours,
Linus Walleij

