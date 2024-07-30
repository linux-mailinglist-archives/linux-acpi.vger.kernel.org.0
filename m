Return-Path: <linux-acpi+bounces-7153-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCC9420BD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651171C22ECF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADE18CBF3;
	Tue, 30 Jul 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci+tJr19"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E79E573;
	Tue, 30 Jul 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368333; cv=none; b=FGgVtkEueIag4ZtKcAVMcX/WBH1NVn4PJq4OV7yRvHmf/iuMEZPXOYlDl4lQqJ0X4bZkSE9hSKJ1TaEEuqsObhYngVqZxvPOHPFQAAOpN26kAb7h61viP7yQRaLRyrg1KMpLCrqHTyiKPvNb38KE2/vIB2yqB9LZLaX4UYBFdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368333; c=relaxed/simple;
	bh=S1GPOgfG/eTOGcrRWUd+VDiuTDR1p8fuZXxeZ4ogaVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4kVThYlz/gWaMYO/QG2k50GT3DsJzF1J5Jfiebd9sO51iqOMsRBoRN8wzVqd9wwlReCBqfZjq8xtY0K8kh1TDOdcRPYyL6ctMbp8rU0A8ZTzYKOXAaBzi9w35ZOQukjKl1idfB4hU8BcWZtc2RuIbtH3nnK20BAhs+xZQz2/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci+tJr19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DA8C4AF0E;
	Tue, 30 Jul 2024 19:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368332;
	bh=S1GPOgfG/eTOGcrRWUd+VDiuTDR1p8fuZXxeZ4ogaVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ci+tJr194qT+QgXwU3gy4fYoVvljceE4xgSi5ILpIvvXiSRXhS8c6l8ni4/YhGHNW
	 lHicp5AfssUClH7hfHukpc7BcXJkL+MFxLnPGHfpPckH1gj69tzxhRs2xotiPIpdCS
	 MOnpBj/mSxSbNTN+KZBOVCgr9wQ4+cR+8mBFBUpRkxYisQTenLIgLWl/pp4n5kYZ+X
	 6F4gxW4t2pkczbbEJU00jIEdXr7QOXpHT8j8/KJJxJHCgMXr8pScBGwfe30cL5NOAG
	 0icxZNvZ+oO9ZsHnp2zf/SU93M/+mcbdm7PI+it7t2/4O/jxerl/Ponf25xK+MEDrP
	 5Od7z5HXHDxhQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db192667f5so549083b6e.2;
        Tue, 30 Jul 2024 12:38:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2qXFr41fhSxfMEtRnsEaeJCRN99zlxclvwQEv25mHlS7HfaEIpSfXDIIWrf+nwAffCe/oFMKydo3f2m4cY0KbHgSYSXy7AmHqIr83tz5YqRwj8Y/h13//qFInSpp/IK+UtmQ+N7Fi4w==
X-Gm-Message-State: AOJu0Yw35YU92G4OTe211kmmjI97i0XArXkFemR54q06mdKhU1RZLKsL
	gZObKocyhrNOi8MkchXVEkzVx0Yp5NbmKF01fQhOtijTXu5CCArG9EobuYA4bwAUD5DdNL27HRh
	zJuoXfRQv3kQkUv/q3/XRqccsnDg=
X-Google-Smtp-Source: AGHT+IEs8v2vHlL5ftoah5h3Zbd9pBpdugOrEKu0N/FItKrXImlqbQc3nhL13Wp4szqsfPo6V2ZlqOHqAai1iendqYA=
X-Received: by 2002:a05:6808:2218:b0:3d9:2751:a219 with SMTP id
 5614622812f47-3db1236c927mr12467190b6e.3.1722368331856; Tue, 30 Jul 2024
 12:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5038376.0VBMTVartN@rjwysocki.net>
In-Reply-To: <5038376.0VBMTVartN@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 21:38:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=NiEqigqxzBcsw@mail.gmail.com>
Message-ID: <CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=NiEqigqxzBcsw@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] thermal: Rework binding cooling devices to trip points
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:18=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> The code for binding cooling devices to trip points (and unbinding them f=
rom
> trip point) is one of the murkiest pieces of the thermal subsystem.  It i=
s
> convoluted, bloated with unnecessary code doing questionable things, and =
it
> works backwards.
>
> The idea is to bind cooling devices to trip points in accordance with som=
e
> information known to the thermal zone owner (thermal driver).  This infor=
mation
> is not known to the thermal core when the thermal zone is registered, so =
the
> driver needs to be involved, but instead of just asking the driver whethe=
r
> or not the given cooling device should be bound to a given trip point, th=
e
> thermal core expects the driver to carry out all of the binding process
> including calling functions specifically provided by the core for this
> purpose which is cumbersome and counter-intuitive.
>
> Because the driver has no information regarding the representation of the=
 trip
> points at the core level, it is forced to walk them (and it has to avoid =
some
> locking traps while doing this), or it needs to make questionable assumpt=
ions
> regarding the ordering of the trips in the core.  There are drivers doing=
 both
> these things.
>
> But there's more.  The size of the binding/unbinding code can be reduced =
by
> simply moving some parts of it around.  Some checks in it are overkill or
> redundant.  White space is used inconsistently in it.  Its locking can be
> made more straightforward.
>
> Moreover, overhead can be reduced, especially in governors, if the lists =
of
> thermal instances representing the bindings between cooling devices and t=
rip
> points are moved from thermal zone objects to trip descriptors.
>
> The first 7 patches in the series deal with the minor issues listed above=
 in
> preparation for a more substantial change which is the introduction of a =
new
> thermal operation, called .should_bind(), that will allow the core to do
> exactly what it needs: as the driver whether or not the given cooling dev=
ice
> should be bound to a given trip, in patch [08/17].
>
> Patch [09/17] makes the ACPI thermal driver use .should_bind() instead of
> the .bind() and .unbind() operations which is a substantial simplificatio=
n.
>
> Patch [10/17] unexports two core functions previously used by the ACPI dr=
iver
> that can be static now.
>
> Patches [11-14/17] modify the remaining drivers implementing .bind() and
> .undind() to use .should_bind() instead of them which results in signific=
ant
> simplifications of the code.
>
> The remaining 3 patches carry out cleanups that can be done after all of =
the
> previous changes, resulting if further code size reductions.
>
> Thanks!

This is a cover letter for the series at

https://lore.kernel.org/linux-pm/3134863.CbtlEUcBR6@rjwysocki.net/T/#t

but I had made a technical mistake while sending it and it was sent
with an incorrect message ID.  Sorry about that.

Fortunately, Patchwork gets the patch ordering in this series right,
so if you go to

https://patchwork.kernel.org/project/linux-pm/patch/14034461.RDIVbhacDa@rjw=
ysocki.net/

and click on "Series", it will create a mailbox containing all of the
patches in the right order.

Apart from that, I have put this series on the thermal-core-testing
branch in linux-pm.git:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dthermal-core-testing

along with the two (unrelated) series posted yesterday:

https://lore.kernel.org/linux-pm/2211925.irdbgypaU6@rjwysocki.net/
https://lore.kernel.org/linux-pm/46571375.fMDQidcC6G@rjwysocki.net/

Thanks!

