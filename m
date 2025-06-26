Return-Path: <linux-acpi+bounces-14682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5085AE9B18
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186467B396B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCB8221FC3;
	Thu, 26 Jun 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0Ry1Z2r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8921D018
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933268; cv=none; b=i3bh3xvls6C72RaDxbuDmS6YYuvSWspiGgETYka6D2C5qRIks6HuxQJP1MdyZ6wNNSALmXXRvaH0jq6lA/CMJVxnHDJ2sWyIgJh/+9D4I0nnMnC86K6jx6wVDyle5RqhHs117XSxhOwQN0Z5DETkrrKeKsJrlq35Iy+2GieyYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933268; c=relaxed/simple;
	bh=c08UXPYZtjpEMhL4kGvfOaWGJO+poU22yY2ilFqSmcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjB2Ht5+yaILX4bPGMPmpMErdWT6zO1tlqjXZUYqgLdxnLVnnK/BLqJVEaHjIeR8RyIN6tWdyHSZ9wJWpNCEApEh2jxdSqGOO0Asq7m7b9qvvpicu3WQnY0rORMfkGJkXeovY6A0pttW7HjiK4OUbJrutiHlDKUvA8yxwCOMUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0Ry1Z2r; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e81749142b3so579035276.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jun 2025 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933265; x=1751538065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=j0Ry1Z2rbrHJ+ZMvicemzIgGcSDadTcbHP3hHnFupm7bwKB+1XyO2EgBX32uMDgBOG
         2mbz9ms0z3BUkx6d2Dt4mfp60k9dTQyO5Ft4WV6ZOioSbXFbLittcGKI83+08NqhM9gp
         +pyBuETk9YzhYzlEEyqRB5Lok9YIoMMN8a9t0OoEf6HsS5pIBqvTJGF3ZHaBFNaNIggW
         cH/eoY85HSVulwaAjccdTn+0il4MRKcNKKHNbQssidnyJM/kcNjpHwvIje+dhdTwXZ5e
         sF1Pnasi/hgGsqMMyrvct6YbCM14/wGAfbULuJPQJabimZjQzyz7yfWtxy6M1aysRcTf
         HGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933265; x=1751538065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgWe1yEUe01r1E8Tw1sTfxB+GfHH0ZziUvZh1CX89D4=;
        b=vEKgWzHEO1HpOdrjbW2NvWw0tXn6CNNipPZ2EuSoLmEgUosqkyLjF+j8MpWIXKymLx
         i7uXyUUynrY9UIp398bRGcrxG6vS0she4ygxteNwssDKdCpwgWm30sdcBepVlJINKsXk
         09DIT2cLQXFuU0n92UrKkcLnIa6csya5ri18bLZaWSTyl5bro8fnCbYNoC78HyAcs6Vg
         XBJjqi4RgMlzVuJ6mq0ZipAhWpvSTTSS1BIAA1heLgZ8TrWD9RTZRc9w8v0fQ3h943wd
         OCUHViai7SYiRwcRoAN1T2aLJhnNJSryf96Zue7keckDn+1z4uReS1iGAA/lIg7Q3Aqf
         Z0bg==
X-Forwarded-Encrypted: i=1; AJvYcCWtS8TLoJNSfAtyXz9DNoQUV9WRStqFNe4X+a8w8cBTB3ok57mvJuEpYUqCMw7C//D9T70BomvZfFO8@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5UNPfFyqvtNEFG149fwYcH7GsLA3teBMPw2qIJpUnrqyRfqw
	Klob1+syeZA+SC0BdDruJxTedqRP56GPV+a4ByV82owY8v87xdK5dDVpxxE5zf5mUYLm8HA+2z/
	aBRjqo1yReS8kAsv96XXkqgtGzeNWnsfrZDL42vKO+LngAwoatfTY40E=
X-Gm-Gg: ASbGncsgbn/iPGa1FizQhUjStt9+p3yQDT8r7eolZaq13oVVfOEjFjynLBNM2VzGKc4
	gsXgxpI2a/p/uJ0uC6P1vJ6dHRnUOh4NvriZ/bEqUXeudsgJidP1DFOkWTeAKxZrVScWNJ6C/yi
	hwfrkmOsXTCRLDJSUCcfmzUQgNMrF//Cr7NE1heqpKKgGT
X-Google-Smtp-Source: AGHT+IEyk3mms1+5t/8MuCL0xllpmb6YLFcWeRD/hQ0f5nW0B1ALuSQjWxbP5EYpCLmojQnL9hQoN2Or3EhNmCkqm78=
X-Received: by 2002:a05:6902:2b90:b0:e84:2adb:2548 with SMTP id
 3f1490d57ef6-e86017a744amr8247814276.24.1750933265396; Thu, 26 Jun 2025
 03:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
 <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
 <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com>
 <CAPDyKFoW5ag69LBnxvP5oGH1VAErBn17CAOzh=MX2toxAHwLxA@mail.gmail.com> <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:20:29 +0200
X-Gm-Features: Ac12FXxpBZ3tZsz4pEVg98bpJK1QwSul4p2Gdnai6PYvcQNw3Uyzytb7ot0tbss
Message-ID: <CAPDyKFpnvg3w9B_R7F-xrhXU+upFSJv5c=buVR5FyFnqoach_g@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 at 12:13, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Thu, 26 Jun 2025 at 11:41, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Thu, Jun 26, 2025 at 11:38=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > >
> > > > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_r=
esume()
> > > > > are only used during system-wide PM transitions, there is no reas=
on to
> > > > > compile them in if CONFIG_PM_SLEEP is unset.
> > > > >
> > > > > Accordingly, move them all under CONFIG_PM_SLEEP and make the sta=
tic
> > > > > inline stubs for pm_runtime_force_suspend/resume() return an erro=
r
> > > > > to indicate that they should not be used outside CONFIG_PM_SLEEP.
> > > > >
> > > >
> > > > Just realized that there seems to be some drivers that actually mak=
e
> > > > use of pm_runtime_force_suspend() from their ->remove() callbacks.
> > > >
> > > > To not break them, we probably need to leave this code to stay unde=
r CONFIG_PM.
> > >
> > > OK, pm_runtime_force_suspend() need not be under CONFIG_PM_SLEEP.
> > > That's not the case for the other two functions though AFAICS.
> >
> > Right, but maybe better to keep them to avoid confusion?
>
> There really is no point holding pm_runtime_need_not_resume() outside
> CONFIG_PM_SLEEP and pm_runtime_force_resume() really should not be
> used anywhere outside system resume flows.

Right, I am fine moving it if you insist.

>
> > At least the corresponding flag is needed.
>
> What flag do you mean?  If pm_runtime_force_suspend() does not go
> under CONFIG_PM_SLEEP, needs_force_resume will not go under it either
> (so I'll drop the next patch altogether).

Yes, that's my point. needs_force_resume needs to stay within CONFIG_PM.

Kind regards
Uffe

