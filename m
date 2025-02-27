Return-Path: <linux-acpi+bounces-11579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A7A489F3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 21:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E532D1653E3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270E4222576;
	Thu, 27 Feb 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rx0mWpSS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031419DF52
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688503; cv=none; b=uC2AnFdkAjeoavn2XIgUbCohfoNW+DNEvDWeZQHXuX3UMsIeRKBQrvvNZnV8kvfDY9zYVos2QVEeXy0ws/f5prIWQ9CJjTcP5+77ccxadxepqBhemj0OawKpnjz/Wu/vrixmvuSiSe5gXe80i2VQHjESOo5f5WL23sLkfT6/PPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688503; c=relaxed/simple;
	bh=bXxSEzAG/4iUWducMgDBSPmkjWssMBKyphle7BJUApI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2gHusfaxFLUUter+f/DSGGjdL/cd73iOBuUytII73OXLq8QEVliuySLNHuBOV93n3jmC6X/MUzmoITNLkkQkp1gL1QeSOTj2O2TSf+0YfxSbYtsElIaHUZtLpxcWdp1n0veGUW3bGJaLcp+80hcvLOeFxJuN1w4Lx+k02gKgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rx0mWpSS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461a485a72so1324814e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740688499; x=1741293299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeuqxAmt1Qh978bgMpTPOmbEBFg9vrDCcgbGN4kik24=;
        b=rx0mWpSSCn/tf7BxgezhV8pgrg8Pku6GYqtxYofVYIP7CshX6/2xNv8k8aYL3rYKTW
         4DKmZA6PWCfd63arNbuBtE4Upqfo2pBIfYo75IKdK7PW85bM2P3z84UxvCBiKfS2Sjlz
         P/af4i12bBgctLOtcm0XXTHLTDgeoDANLhPKFqChhvlp/yVBtKEnoZ4pNLnbJ6XtgPy7
         KDqxPVXtnjizLdAUxaZqVWAUw5B/dvSiFgtJ5YKCinJfIfmICrntgNUIQmr8XAMpKPet
         hCmwO1WFbm9+N8PlSro6WbmVLsRdzSW+vb5w30HfmpXAutvrhqfRbJvtmzxyvf9w0fHS
         KePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688499; x=1741293299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeuqxAmt1Qh978bgMpTPOmbEBFg9vrDCcgbGN4kik24=;
        b=kc7WqyEzqS+hMeT/a3HqFX74R67mmb3hDiCX46UvKA5SJ9EnuNEtR0zTcM+zX6upFS
         AxURUTLeTJ+JOSfN5auLEOFZYKFrU18K9R++eXAELh/1+afn7BjmozATEenktr5gGfUS
         fXXbDq/uMRBTaqH5Y6WcX3DFF88xpJaSYeoAiC0+jFY7Wg7YpTokt6piHjHHYQz7giWH
         QNOS0Q7/xnN8yCrQkvdd80ZpMDH+LNPRQ89Fiz18I/vAwueOw2BTWlOoi2kPs4vgJ0WZ
         5FU6iShLTqoBE+HYMCKUOPZH2xyz/JiSno2EpzDLufbzUhhaiBLLy+HSFYUfWIOvb1gj
         6ieA==
X-Forwarded-Encrypted: i=1; AJvYcCVrTyTwwK8F8+WW+TxsjwA/6tzIjcxNZqiy2OEWsoraZ6cgIup7D3JSWHGTP5C9oqgR9Lr6ug4EO91g@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkv+GossbV2KyeCdDGYveW2/ohw+jhGxVpn5AhGafVDhfVBWOK
	C/FLgBBxwwIxHdaqF4K79uaVkFrYOP4sbJNQQqvzs4iMkuv36xVxLPtV0sKMITULZqyh/ydLz07
	2TGTHYzroKZzKsLBwMNOBzhxU+JUeEcxzl1Bd7w==
X-Gm-Gg: ASbGnctDB/gFdLLXbGP0IRuvZjXCLi4174GPEnh9zLEicm0M+r0JHhHB2vl+V3+zrpJ
	eBIAYMpjcP+4iOBtCysXlHSy1V1njtnK7kj5ja2QLCCwUpgOBK9Y4lJ0cSwHu6rX26y86ORciAz
	jqJE8t6nY=
X-Google-Smtp-Source: AGHT+IGg4EqvzrAvnzj94K+52AOp6peQCUTUyjS5GdcexzC1jX0ldvgPrkj7A9gohmBANYoaKcLYCMjFpUrRRlAREJQ=
X-Received: by 2002:a05:6512:1089:b0:545:27af:f2e4 with SMTP id
 2adb3069b0e04-5494c3207e0mr295413e87.18.1740688499410; Thu, 27 Feb 2025
 12:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219145338.3306745-1-superm1@kernel.org> <20250219145338.3306745-3-superm1@kernel.org>
In-Reply-To: <20250219145338.3306745-3-superm1@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Feb 2025 21:34:48 +0100
X-Gm-Features: AQ5f1JqqOtUfQcK4ttKKJLnwL4MmovtUXV3akSvWi09-svI3CFHM7hoXCk9DBy4
Message-ID: <CACRpkdaCUx5EW-CzHgNiKgQF6FxKbFP0_pHC3LnfgEKpksTJtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: amd: Add an LPS0 check() callback
To: Mario Limonciello <superm1@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: mario.limonciello@amd.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

thanks for your patch!

On Wed, Feb 19, 2025 at 3:54=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> During suspend the pinctrl_amd driver disables the interrupts for
> any GPIOs that are not marked as wake sources.
>
> This however does not prevent them from changing the wake status
> bit during suspend, it just stops the system from waking.
>
> If the system wakes from hardware sleep for another reason (such
> as plugging in the AC adapter) this wake bits might be active.
>
> This could potentially cause problems with going back to hardware
> sleep.  Add an extra debugging message when PM debugging is enabled
> to help identify if this is happening.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I don't understand the ACPI part of this patch, and I think I was
not even CC:ed on 1/2 so I haven't seen it.

Anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

if you want to apply it in the ACPI tree.

Yours,
Linus Walleij

