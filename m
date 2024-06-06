Return-Path: <linux-acpi+bounces-6224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C38FEDD1
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A1D1F21C8E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1E1BD51B;
	Thu,  6 Jun 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF7kITSp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21A1BD515;
	Thu,  6 Jun 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683529; cv=none; b=CE4H9Diw48VxjKmnT/XvTMpLKA/oilg0dML+VJWYyElflynTWIYajCuIPP/0wRVRHYy9RwBmQ8N91oyQqvIR9x7fN/U+aci4S1ZtL2z1X2W+2vFDwGHVhTyzjijpFFdGuEo/lOyoqumhpcF+osVUXQUhc83D+yb1dxD3nDB8ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683529; c=relaxed/simple;
	bh=YYYTroV05/ffOg/2MOMOK0Q5DM2WQSttah0HBo7odRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOry2x2Z5lACgNISTWQqV5mEtHfL0gy4xJBru44Dn9jr8xeP6/JVXB/9VJljA5BEjaxt4KYPson2Y31C01UuDDCM74AZwoZRkzThW4pdCFYQlmHfxtZ6bF/zemMqCvv3FW/GFpQ3i1m6+VFA8m0Jp817dcydoAq+aNBIFk4BxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF7kITSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7247AC4AF07;
	Thu,  6 Jun 2024 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717683528;
	bh=YYYTroV05/ffOg/2MOMOK0Q5DM2WQSttah0HBo7odRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VF7kITSpIgY4KyL8V/XPxYu/IHtOPcdTwdWxZP2r5ILxJxElcMkknv5n3mvF93KOO
	 ijiTMwphiy4NYiId6FlPGGZ+L10ztLFctBtLUvMFABVYnlBQVC7PQ4ZJ/qri38egdH
	 Ati0bxx0t9CkBNXst0FYgn0BARCknxK0b98t1y+nvAsNkEXqsTtkYZF91JPn8Nm8eY
	 nqsVVxrWeCcubzNUCXv9pZMiv7AXijdt+6n1EmBbA8QdHvYiY5bz++zNmfVosMkxmi
	 ErabVl3pDXRUrIj0gUkmUQOY5GXXTYQyAYH0Zopgr9pGn6eqjr40W9hlJPRNSSLp6E
	 2/SnFxRpOyNKQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b3364995b4so147269eaf.0;
        Thu, 06 Jun 2024 07:18:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWE9gmlsPhixLihakg/zgPv4kzNJlVICb0ygsTtQlXUK/rwNX6kwGe6kENBWFaJ8hMYBq08JMadRQjtdZRY8gFmAoCLcxusDyunuFTAnrSJFK4BH0Tp4a9ZPpNAoemeMrxCUwiZBJkHmZsx6oUEFFp7BNfhV1DTxQMPlMtAaLgRzXYO
X-Gm-Message-State: AOJu0YwmzjHbDQYU2XjCvFq651WaZz7bwpM7tihqqcnVaOsxtPnub7FB
	TKMchCsLzBJnJGG0yF74vKizsCgZ3rLGil+xZjJU+HRkanP+bjA69rfzRCQw9+tcZazfKjNPqjT
	6dVUeOwDLued27wRFrO2njUm49k0=
X-Google-Smtp-Source: AGHT+IEEqwqBmCZCeoe/yLOk2KEOkJIrsXRc8sijomiJ3iojMq0et9jelM+hJiW+6Z50VoXmGC2Msr9e8Srp5+thjZ8=
X-Received: by 2002:a05:6820:2b02:b0:5b2:7e47:e914 with SMTP id
 006d021491bc7-5ba78d3bb71mr442464eaf.0.1717683527592; Thu, 06 Jun 2024
 07:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4569763.LvFx2qVVIh@kreacher> <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
 <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 16:18:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
Message-ID: <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com>
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

On Thu, Jun 6, 2024 at 3:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Jun 6, 2024 at 3:07=E2=80=AFPM Daniel Lezcano <daniel.lezcano@lin=
aro.org> wrote:
> >
> > On 05/06/2024 21:17, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooli=
ng
> > > device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> > > to fail probing on some systems which turns out to be due to the _FST
> > > control method returning an invalid value until _FSL is first evaluat=
ed
> > > for the given fan.  If this happens, the .get_cur_state() cooling dev=
ice
> > > callback returns an error and __thermal_cooling_device_register() fai=
ls
> > > as uses that callback after commit 31a0fa0019b0.
> > >
> > > Arguably, _FST should not return an inavlid value even if it is
> > > evaluated before _FSL, so this may be regarded as a platform firmware
> > > issue, but at the same time it is not a good enough reason for failin=
g
> > > the cooling device registration where the initial cooling device stat=
e
> > > is only needed to initialize a thermal debug facility.
> > >
> > > Accordingly, modify __thermal_cooling_device_register() to pass a
> > > negative state value to thermal_debug_cdev_add() instead of failing
> > > if the initial .get_cur_state() callback invocation fails and adjust
> > > the thermal debug code to ignore negative cooling device state values=
.
> > >
> > > Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to t=
hermal_debug_cdev_add()")
> > > Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-la=
ura.nao@collabora.com
> > > Reported-by: Laura Nao <laura.nao@collabora.com>
> > > Tested-by: Laura Nao <laura.nao@collabora.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > As it is a driver issue, it should be fixed in the driver, not in the
> > core code. The resulting code logic in the core is trying to deal with
> > bad driver behavior, it does not really seem appropriate.

Besides, I don't quite agree with dismissing it as a driver issue.  If
a driver cannot determine the cooling device state, it should not be
required to make it up.

Because .get_cur_state() is specifically designed to be able to return
an error, the core should be prepared to deal with errors returned by
it and propagating the error is not always the best choice, like in
this particular case.

> > The core code has been clean up from the high friction it had with the
> > legacy ACPI code. It would be nice to continue it this direction.

This isn't really ACPI specific.  Any driver can return an error from
.get_cur_state() if it has a good enough reason.

> Essentially, you are saying that .get_cur_state() should not return an
> error even if it gets an utterly invalid value from the platform
> firmware.
>
> What value should it return then?

