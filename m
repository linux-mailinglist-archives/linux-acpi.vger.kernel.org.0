Return-Path: <linux-acpi+bounces-6229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5687F8FF078
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3AF1C2627A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473B197A6A;
	Thu,  6 Jun 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epnHCtfh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E3197511;
	Thu,  6 Jun 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686938; cv=none; b=M2jQnZdMC11UJO1RhtouP341T4INQIva9UOtmwJ2CaK6Lfww310ssmPH4vixo2rUkDKMCBpG584hm1W1IhYkbWk3wdlzQf3DQZCcTghO5MIfa4yvjRZaJjh/N7UgqR2N8sR4kP+mCpXu0oSRTV2YjEc7ovMe1CkobHKYWjQ+Bdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686938; c=relaxed/simple;
	bh=gAwxQG7OmSYm4sHXqHR0ZDCMjm7rFtydV9pugblE7mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3mPWJ5/1B2SXVO5oVgMmFfKjIpst3amx0/c+4HLDJDHDD6/826LK3PgsoEbGYDp2okmz0ht1aDATojDU1BhM6XpaNrfaavFXvzgT9JsQFFCbjS1Pk/9cFESBN9Ya+8OwV3GPxDO4myxgDLuSfGKWyTw6S9y5n9+LUPSfsJXep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epnHCtfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736F6C4AF09;
	Thu,  6 Jun 2024 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717686937;
	bh=gAwxQG7OmSYm4sHXqHR0ZDCMjm7rFtydV9pugblE7mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=epnHCtfhHrQIRBXhKVqepyOxjMh21zZvcTkQFrvl/NeoyNvS9jul3/e0PzfB/BiaM
	 a0knR0DN9eHyaeFp3OIYSHhrEMTynxBiqEOCJ5tLnoXzIpfA2O1RewEwr8YPFwkmsn
	 qmrTYLOpU2yxYfrETXheKD846F/YQE4HC+YVe4NX8Ypt1djPycvzd2bhdTgFo5juQQ
	 6mFvJOynAYeEwurL7aIY42NZpGLV3c55p/Pi+6DAeFc3VNU0MTjF5c2hVrnxHiTqA+
	 jTvFp4grnCmppyxVhlxkKcv8V0WBXrG+7Bp+k0F5AbvcBfIin+SVwrwd5XhG5tPfXG
	 DwWv9f5vlQGXA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ba8e1b9018so43660eaf.0;
        Thu, 06 Jun 2024 08:15:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2v57jDAkva0E68GjOoiQ7Es5j7OX2g6BufeH5e2npL/+ag3U2P2pEC+R4YTDbT+c9XkehNqWV9u0Cg57rOpkTWTd93rKHH5St4OKhJJSqovWToOfsUmmjXbcODGXwNiSIZpwrLuTYzWQ4Fcu1JTMFyNC5Bj8gxStsjDxKyvSRFFg0
X-Gm-Message-State: AOJu0Ywq31DVa0wR0L2zqowz6MtcRkQFfKpZ54xCYDNHTr5VDKWSbsJr
	86HC5AXjbP+IjkikKAq6xaFFu3WnZnBRYoDvzisqtWbbOgFFjWYH0tmZSZ/SpiRSkRAfsFVgJGI
	24uMcMaw0fAIJWonj8wgyO2OS37g=
X-Google-Smtp-Source: AGHT+IHnw2q18iqXGsnSopwvjzmRaI2tzRl0ofq8J44KMLcEhaKJfxrNE96Cn7BUKf2cpdch+dhBHMAYqODIamzojWo=
X-Received: by 2002:a4a:a7c9:0:b0:5ba:6669:ba6e with SMTP id
 006d021491bc7-5ba78ff8903mr6108746eaf.1.1717686936669; Thu, 06 Jun 2024
 08:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4569763.LvFx2qVVIh@kreacher> <5f93f034-f781-47e0-b8ce-3c8407a709f7@linaro.org>
 <CAJZ5v0hkOvYL66D+tCRJxbp=XqV59yeZ0dA1Kxoczkcpe5X9sA@mail.gmail.com>
 <CAJZ5v0joTyOcRU0FyaHEEYEbiPbbNSFzW3P7eJJ4MM5QdhQR2w@mail.gmail.com> <90a9df3e-153f-4972-8086-13c21a574763@linaro.org>
In-Reply-To: <90a9df3e-153f-4972-8086-13c21a574763@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 17:15:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jurx=TfT2GHCeMt7xhTFRQwpS_H6-fDss=bt+HodvBoQ@mail.gmail.com>
Message-ID: <CAJZ5v0jurx=TfT2GHCeMt7xhTFRQwpS_H6-fDss=bt+HodvBoQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:50=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 06/06/2024 16:18, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2024 at 3:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> On Thu, Jun 6, 2024 at 3:07=E2=80=AFPM Daniel Lezcano <daniel.lezcano@=
linaro.org> wrote:
> >>>
> >>> On 05/06/2024 21:17, Rafael J. Wysocki wrote:
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cool=
ing
> >>>> device state to thermal_debug_cdev_add()") causes the ACPI fan drive=
r
> >>>> to fail probing on some systems which turns out to be due to the _FS=
T
> >>>> control method returning an invalid value until _FSL is first evalua=
ted
> >>>> for the given fan.  If this happens, the .get_cur_state() cooling de=
vice
> >>>> callback returns an error and __thermal_cooling_device_register() fa=
ils
> >>>> as uses that callback after commit 31a0fa0019b0.
> >>>>
> >>>> Arguably, _FST should not return an inavlid value even if it is
> >>>> evaluated before _FSL, so this may be regarded as a platform firmwar=
e
> >>>> issue, but at the same time it is not a good enough reason for faili=
ng
> >>>> the cooling device registration where the initial cooling device sta=
te
> >>>> is only needed to initialize a thermal debug facility.
> >>>>
> >>>> Accordingly, modify __thermal_cooling_device_register() to pass a
> >>>> negative state value to thermal_debug_cdev_add() instead of failing
> >>>> if the initial .get_cur_state() callback invocation fails and adjust
> >>>> the thermal debug code to ignore negative cooling device state value=
s.
> >>>>
> >>>> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to =
thermal_debug_cdev_add()")
> >>>> Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-l=
aura.nao@collabora.com
> >>>> Reported-by: Laura Nao <laura.nao@collabora.com>
> >>>> Tested-by: Laura Nao <laura.nao@collabora.com>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> As it is a driver issue, it should be fixed in the driver, not in the
> >>> core code. The resulting code logic in the core is trying to deal wit=
h
> >>> bad driver behavior, it does not really seem appropriate.
> >
> > Besides, I don't quite agree with dismissing it as a driver issue.  If
> > a driver cannot determine the cooling device state, it should not be
> > required to make it up.
> >
> > Because .get_cur_state() is specifically designed to be able to return
> > an error, the core should be prepared to deal with errors returned by
> > it and propagating the error is not always the best choice, like in
> > this particular case.
> >
> >>> The core code has been clean up from the high friction it had with th=
e
> >>> legacy ACPI code. It would be nice to continue it this direction.
> >
> > This isn't really ACPI specific.  Any driver can return an error from
> > .get_cur_state() if it has a good enough reason.
>
> We are talking about registration time, right? If the driver is
> registering too soon, eg. the firmware is not ready, should it fix the
> moment it is registering the cooling device when it is sure the firmware
> completed its initialization ?

OK, so arguably the driver could set the initial state of the cooling
device to 0.  That may or may not be the right thing to do depending
on the thermal state of the system at the moment.  Then it would need
to wait for the governor to pick up a more suitable state for it or
leave it at 0.  This could address the particular case at hand.

However, should the core fail the cooling device registration if it
gets an error from .get_cur_state() to start with?  It didn't do that
before.  Indeed, it didn't even call .get_cur_state() then in the
first place.  Moreover, the current state of the cooling device is not
even needed to register it except for the initialization of the debug
code for that cooling device, so why fail the registration of it?

