Return-Path: <linux-acpi+bounces-6216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216F8FE35B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F021F261A0
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317B178CE4;
	Thu,  6 Jun 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgww0fpg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C0178CC0;
	Thu,  6 Jun 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667278; cv=none; b=WCSwKGvFy7yKo9kz66Me58dyaL7+TtBAfAiZ2p9lQ36Huscm51Ibph/Y3vhp2VpLr61Zsp/8QFiT6gWV0HrVc4WP90oQ734FyWdLK7NSyjJaWkemREEHZkDcY5z8icG9UFLwdOxsWLBcmFlBXrmdBLUNy7tdedw/AE1jeIobVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667278; c=relaxed/simple;
	bh=HG6f0PYnCjpQM59ffIKq4KBMG1zved47nRM+LV2Sbbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxZ19bNeZ79kf74yBhTxzO+aI3bvL/IX6bl+yrWnLOCcWm+X5eO50+pBYfkdSlREz9hX1QhOtD8nfmpkkNQ/kTxDybQ3kpZ/oOdX3ax/bFQecsdQDXjX55CJm7VsLgSq1rZkPa8lMKNEzPpENBWbdMz1uFd2yKvYHtCkFRGseo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgww0fpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841A6C2BD10;
	Thu,  6 Jun 2024 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667277;
	bh=HG6f0PYnCjpQM59ffIKq4KBMG1zved47nRM+LV2Sbbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rgww0fpgGECJekwWDoHdUUpmvN6lJGmX80NKiBeY83wabYa719rzIjUwpfxCxIzZS
	 4Eu1fmanC4u7EKqcAt0rMswJ6IwVGse08BScmV5BV7sJn3aAkIvUOtgJ40X0XVisL8
	 MEYpLdXOCVaf4bVgLpAU32iP8LrS/K+uREI20zO4PAUhpDwJVSeEod9Q2Y5x8dMJEE
	 g10/kobPmHosT2cxUlkXm32dvtiEgQ5wjBFSVXipNe8gYg+9hwY5vRDwrzHjApl59L
	 Dv5/ahMpPpn5TL9qVSAS9rBlpeU9XgtKiQQ7eD/rIPDM3E659lMsf0WI4r/nvFQ7wi
	 PMt7A51x66X5A==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba84b73b6aso51986eaf.2;
        Thu, 06 Jun 2024 02:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSj4LAAEfXTftXrfLUgFDQFT+jqWwWOT3pJlNfyzblC3ZwKdnA4sk5OOhM9L5CD+bmUndQepZyGZ2LABFY3Tr/MjFOIghdl+er/yqJ0ydXk7PUTLOxETIYAqFngEVeXatKNK8Nr658u6nGqz7hwxTF1frlS29tXbf66AEnbPULV2Mj
X-Gm-Message-State: AOJu0Yxz9AbC3YzWVPLPQFfW19YUCO0q+KrowIFOaomXRyGaT148MumD
	P1hPXaDdQDwX3XsBkdwoBRP4g6ZOmLMzBoNK0me6MUT85MPDLI1cbW7BsCyf/2pU1MwnE8WMMhx
	NCMi3ZWjebbu2DobZxEr9rwHBMiM=
X-Google-Smtp-Source: AGHT+IEdvATOlntPTH8NHx0qIYfmywtahNQAT524ZRvHq2aR5YQZoqxyQ2x257hi9j6vTnfYExRDylZyhFXVUXnwHDI=
X-Received: by 2002:a4a:dfd8:0:b0:5af:be60:ccdc with SMTP id
 006d021491bc7-5ba78d49b7fmr5255602eaf.0.1717667276800; Thu, 06 Jun 2024
 02:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4569763.LvFx2qVVIh@kreacher> <cf24f2193c16ed070e5ec3b2f601650eb5b867ed.camel@linux.intel.com>
In-Reply-To: <cf24f2193c16ed070e5ec3b2f601650eb5b867ed.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 11:47:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUu=i-xXnv3ECP6hdW1JFf-4-hwWVokRAHCQS958GDww@mail.gmail.com>
Message-ID: <CAJZ5v0jUu=i-xXnv3ECP6hdW1JFf-4-hwWVokRAHCQS958GDww@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Laura Nao <laura.nao@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:41=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2024-06-05 at 21:17 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass
> > cooling
> > device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> > to fail probing on some systems which turns out to be due to the _FST
> > control method returning an invalid value until _FSL is first
> > evaluated
> > for the given fan.  If this happens, the .get_cur_state() cooling
> > device
> > callback returns an error and __thermal_cooling_device_register()
> > fails
> > as uses that callback after commit 31a0fa0019b0.
> >
> > Arguably, _FST should not return an inavlid
> s/inavlid/invalid

Thanks, I'll fix it up when applying the patch.

