Return-Path: <linux-acpi+bounces-20334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F0D2025E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8311B3014D0A
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E13A35CD;
	Wed, 14 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0np8qO/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530043A35C1
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407488; cv=none; b=YZyp6yevDFvbj/G8DpVBECVuiTKkoGnN74rVdSPh86ijVVJdgGTuwlF5y1NSehUcxIf/93Hvhz24kiIadyF2yZ+963pwDtkVGiGfRHXWyb5SFmwbnpIF+pCQXNq0aYCbSMdvHpeJkgaZXCA43HpQrML3ch/Mp4BpXPSwA7naVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407488; c=relaxed/simple;
	bh=ZeyTuvEG6SItYZ+PthGqNFBLMgVQeKz3xPTTzCsMehU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJZZ9YtcZFlM7QTuMGQ5BCdIQ23PBKU/WUoQeCc2T27QwgcuYI9DEfS9Q6jVH/5v4+MyxYionwKHQ/4l4as3T0NYqQkdoiF8RIAO9HzGCzlJW9oHklXB0muI1ERfNQJH+AF2qj0eepef/Hk0WnzRksVWTJtvJrGOdeGZf6kuLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0np8qO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE325C19425
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407488;
	bh=ZeyTuvEG6SItYZ+PthGqNFBLMgVQeKz3xPTTzCsMehU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I0np8qO/g390D626bXc2gCH8h+KEEd0TK3ou0uSAbYsvWp8Vbrz7juzQHarIt3Zmr
	 oq4rwMRUfsOZV+h+C9gyq6DZlcVrWAodmlt4rvgaGARbtAXle5rengzRKQh6Hg3diZ
	 YjvTvsJfNFomGoYUc9HYpsGAQWru130eYxmJRCoRF08JaLTZ5OB7t4dSPdtc9VEyt+
	 +KGR4h55B1dLkwMOWnZ/S12AXV8gz3+t5incIgIrtQ+PKu12N3UfOF/LnyASHiksSK
	 n0vsBimmxNVwYjKzgy0rLQv11Hq5+1Mw/DHEstWBSLLsRDgBpyaDrSewzzm2tN7kpR
	 54A2PVv0EVWHA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40421de595fso201888fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 08:18:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUM57Z358A/rSfN9Ud1GJqHbAJuRDCOjQEI6G9XzbZ6SSmqRUrcLtPqg8mHG0Kot3rrfIBfq3yVlJ8I@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqO7Mt+vD9Fm6W9K80T8XBZ0MIpVGHUOOTHUKMvP/2VU0pvTq
	g2p/qQQXf0q8d1VVeJHFWG0+o91X5CqO/8z0CW2Zs8X+ks0YtNTMNguzCdQ/D32vIKD39aFTw6w
	uvKwONuhyZUTWNoOFTpk8rmsGhL7pquE=
X-Received: by 2002:a05:6820:f036:b0:660:ffd3:32b with SMTP id
 006d021491bc7-661006ccdbamr2424231eaf.44.1768407487064; Wed, 14 Jan 2026
 08:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114082306.48119-1-kkartik@nvidia.com> <aWdecdvZZbai0qrv@kekkonen.localdomain>
In-Reply-To: <aWdecdvZZbai0qrv@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 17:17:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jbAp0ANtJ9XE1ot4g6UHoYGSY9djq4_MvkYvM34+t4mw@mail.gmail.com>
X-Gm-Features: AZwV_QhedFYQhtDWR2jzFtu6cwsw3SZ5IPLsPain7mKOR29j3DBaV-zLOVZPxXE
Message-ID: <CAJZ5v0jbAp0ANtJ9XE1ot4g6UHoYGSY9djq4_MvkYvM34+t4mw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: bus: Align acpi_device_get_match_data() with
 driver match order
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Kartik Rajput <kkartik@nvidia.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:14=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Kartik,
>
> On Wed, Jan 14, 2026 at 01:53:06PM +0530, Kartik Rajput wrote:
> > During pre-production development, drivers may provide both ACPI and OF
> > match tables while a formal ACPI HID for the device is not yet
> > allocated. Such devices are enumerated via PRP0001. In this case,
> > acpi_device_get_match_data() consults only the driver=E2=80=99s ACPI ma=
tch table
> > and returns NULL, even though the device was successfully matched via
> > PRP0001.
> >
> > This behavior also risks breaking existing PRP0001 setups if a driver
> > later gains an ACPI HID, as the presence of an ACPI match table changes
> > the match-data lookup path.
> >
> > Make acpi_device_get_match_data() use the same precedence as driver
> > matching by using __acpi_match_device(). Return match data from the
> > acpi_id or of_id that was actually matched.
> >
> > Remove now-unused acpi_of_device_get_match_data().
> >
> > Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>
> Thank you for the update, this looks really nice now.
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 6.20 material, thanks!

