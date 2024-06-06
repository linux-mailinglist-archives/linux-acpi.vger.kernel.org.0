Return-Path: <linux-acpi+bounces-6220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2D8FE812
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E71B2246D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F9196429;
	Thu,  6 Jun 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIc05CTM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978BA195FFE;
	Thu,  6 Jun 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681391; cv=none; b=Q1EKqOkU4mANxF6/2hdTS7jtdL27t8LxcNzV6MBt73P1PPWTsVXWiZBn19+eL88LDjVbrIctx6DQBmB1NCusZc6t0fRV8EzvR6G+pCsmrI2xoY7zBQonbE0lqsAarVgsaywVeSaAsIiZZP4Q6LXYAugzG+gyQLFj5Tf2xVnWbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681391; c=relaxed/simple;
	bh=kX1+TUdz8cNcUskmb6NdxdcNtxJMTV95e7OlXyGW47I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZyi6m9F4HR6xcfgXp0PTcCksCEJTSiwmFjTI+/oD1MKQDhaXCpp5kwycneSya3GLyYe4c1kgcoL4A7qQoxlhAKAExUdE1B9l/fdvJVaiQyumxfQp36RGKGRE9kwDEGCHU1260QeLtnig02aBIqYAP9dpXEuZCZsvMgtJ4oEoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIc05CTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C596C4AF07;
	Thu,  6 Jun 2024 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681391;
	bh=kX1+TUdz8cNcUskmb6NdxdcNtxJMTV95e7OlXyGW47I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIc05CTM9DM8Wlx6/Rn1BWhHD5ovl2CQXMXEBFXrZ89KOhwXp1cXAACCF1B+GvLzj
	 hI2O3ErLmx2uhcXKCEW03IL0y9+7d6WCZpnXCG501cj/7jQFvsHHsP5BPs8XPa/kWq
	 WxLsoeCaIdk2QQGg2Hr02gNwG3Y35gkkbx2dnRmcaWiLk49Z0EH6egckjyHC6pVlky
	 fbCA7SB/KtDF54JrakHBiF2xCSOCHfZh6m4bDOBhyC5eWCbccMmHX5oRakieRCIkl5
	 0g767rw59SGKOSHObRdiGHDqCqeowAOxTPGg3a1VuswLlvMEGEG6UI24EEIA3S/VDh
	 rzuZiToF+B9ZQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b335681e82so139871eaf.2;
        Thu, 06 Jun 2024 06:43:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb/qiuHsyCR55cQtvwXAGppqbjruaPWSGPA0VdCjznq21AJzl8R6cESM4lxL8u0b41X9bEj4qE5a6qilEFpFmiYRcoVm3HMKuHp9gwao5KZKGm915yt2j49GF9ka5kd4MCM4vmEEGUnApr04RfVxCE1QxtUyssioaqMTj4XyXphMCL
X-Gm-Message-State: AOJu0Yw2gSw1I3Pg7IKvCMsyXBx/9zprKkVxz0nwV+ZRNObaZHBrBmBL
	o6BasYHgHkBJBzzMXLCpuL+IflQlz9biDGxav3Alu2nKuVqBICeXbCz3JxM6n3gdEWxwoIt2W0H
	BvZ8+nsfsEDTx9kh8bD0kn4/ZQ1g=
X-Google-Smtp-Source: AGHT+IGH1/PBSYTdAuOFfLPnVUByi6WZQhVobPYV9sXwjcCyOryn71Pt2/ePacaenZivpYC63hY1sNj+df3fcdywwHk=
X-Received: by 2002:a05:6820:2b02:b0:5b2:7e47:e914 with SMTP id
 006d021491bc7-5ba78d3bb71mr334007eaf.0.1717681390197; Thu, 06 Jun 2024
 06:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4569763.LvFx2qVVIh@kreacher> <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
In-Reply-To: <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 15:42:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
Message-ID: <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:07=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 05/06/2024 21:17, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
> > device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> > to fail probing on some systems which turns out to be due to the _FST
> > control method returning an invalid value until _FSL is first evaluated
> > for the given fan.  If this happens, the .get_cur_state() cooling devic=
e
> > callback returns an error and __thermal_cooling_device_register() fails
> > as uses that callback after commit 31a0fa0019b0.
> >
> > Arguably, _FST should not return an inavlid value even if it is
> > evaluated before _FSL, so this may be regarded as a platform firmware
> > issue, but at the same time it is not a good enough reason for failing
> > the cooling device registration where the initial cooling device state
> > is only needed to initialize a thermal debug facility.
> >
> > Accordingly, modify __thermal_cooling_device_register() to pass a
> > negative state value to thermal_debug_cdev_add() instead of failing
> > if the initial .get_cur_state() callback invocation fails and adjust
> > the thermal debug code to ignore negative cooling device state values.
> >
> > Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to the=
rmal_debug_cdev_add()")
> > Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laur=
a.nao@collabora.com
> > Reported-by: Laura Nao <laura.nao@collabora.com>
> > Tested-by: Laura Nao <laura.nao@collabora.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> As it is a driver issue, it should be fixed in the driver, not in the
> core code. The resulting code logic in the core is trying to deal with
> bad driver behavior, it does not really seem appropriate.
>
> The core code has been clean up from the high friction it had with the
> legacy ACPI code. It would be nice to continue it this direction.

Essentially, you are saying that .get_cur_state() should not return an
error even if it gets an utterly invalid value from the platform
firmware.

What value should it return then?

