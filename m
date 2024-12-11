Return-Path: <linux-acpi+bounces-10091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D870D9EC7AA
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1932850F4
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABC1E9B34;
	Wed, 11 Dec 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9pOlSVm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EA1E9B2A;
	Wed, 11 Dec 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906940; cv=none; b=lFTdiGTV89IEeTQn/LTUfXNIZsrt6+Ro2MG5hKyF43iQSvDgF80/AC5pR08jH8mY8OlRsULJFzVRxe0YliGGSug2EB+ybEsc4Pl9PS1n2ohWles32VYtHNFLNUhiQfK1fAszokOOa1Qj3Fw85GkTW3Ml96nCJpb2RJ3SnHsTQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906940; c=relaxed/simple;
	bh=1G/Mmxl2g5MMf0pdtQ+gE9HvBYR2X/4145Gh60vMkLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K00U7BGHW46SlbGTHQ18ThjaBcAxLWltjifgEAY4t0VZI8NRn9mEUnTdZ8uXiQ9M5tLFGxpsPcOcNoFFzJnZJ/WY4IfXMpRIwJlVXezO//5Vgwq6aKRPFrmkrdIP943FnBoCmcrPh8+u63RcFfYLA6KPyZXn+Euuytl1YHqEfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9pOlSVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA25BC4CEE0;
	Wed, 11 Dec 2024 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733906940;
	bh=1G/Mmxl2g5MMf0pdtQ+gE9HvBYR2X/4145Gh60vMkLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9pOlSVmAgpW67G/yoyHqQWcwFUry0nInVTvj+lh7ds0VLMFXGXlqDzXDk80P4brV
	 kdURSuTZRii6DWSNpLgbA3zHWryQ9Zb/Yio3OiJPSb9C6goN1w/T+fsjrE4Lb0yFTr
	 ufjW16TfTnPmGMA4xhno4xDua4vLq62HsS7eVcZgzfXZ4jAY2doqxpm7MjQtJk8fSv
	 vIQ9hdA+hSJDLPX3ZlEF0zl6B+ytewflMMglcuwPoYB6WB4Emjt7GQPejExICzAwlN
	 gjNxBFFNy+4dntyNp7BGBIQJNcETTJhWYny3MKKLUz5BuBsyWZg1ja6sVLrDLjwGym
	 pyQuXKlMCGTcQ==
Date: Wed, 11 Dec 2024 09:48:54 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <20241211094854.407ddd54@foz.lan>
In-Reply-To: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
	<20241211091954.42a5c778@foz.lan>
	<Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
	<CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Dec 2024 09:37:07 +0100
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> On Wed, 11 Dec 2024 at 09:32, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Mauro,
> >
> > On Wed, Dec 11, 2024 at 09:19:54AM +0100, Mauro Carvalho Chehab wrote:  
> > > > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> > > >     unsigned int i;
> > > >
> > > >     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > > -#if IS_ENABLED(CONFIG_ACPI)
> > > >             const struct ipu_sensor_config *cfg =
> > > >                     &ipu_supported_sensors[i];
> > > >
> > > >             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > > -#else
> > > > -           while (false) {
> > > > -                   sensor_adev = NULL;
> > > > -#endif
> > > >                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > > >                             continue;
> > > >
> > > >  
> > >
> > > Considering that you drop patch 1, and keep the ACPI dependencies
> > > at the header, as proposed by patches 2-6:
> > >
> > > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>  
> >
> > The 1st patch fixes a compilation warning when CONFIG_ACPI is disabled.
> > Merging that patch as a temporary solution is simply easier than making
> > arragements for merging the ACPI patches to the Media tree so the last
> > patch may be merged, too.

If this is breaking compilation with W=0, then this is a different
matter: this one shall be submitted in separate, against fixes branch,
and the patch title shall be something like:

	media: ipu6: fix compilation when ACPI is disabled

And have cc stable ad fixes.

Once merged upstream, a separate patch series (without patch 1)
should be placed against the -rc kernel where the fix land.

Yet, based on the title, enforced by its description:

	> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
	> throws the following smatch warning:
	> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

I don't think it makes sense to c/c stable, as this is just a smatch
warning, for a configuration that will never be used in production.


> > Besides, the fix should also be backported.
> >
> > Ricardo: how about adding Cc: stable for that one?  
> 
> Adding:
>     Cc: stable@kernel.org
>     Fixes: 8810e055b575 ("media: intel/ipu6: Fix build with !ACPI")
> to v4

Thanks,
Mauro

