Return-Path: <linux-acpi+bounces-6275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A190115E
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jun 2024 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7981F219DC
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Jun 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F21386C6;
	Sat,  8 Jun 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6GINMJk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F508DF4D;
	Sat,  8 Jun 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717847928; cv=none; b=Hc1DR2Wakm7tWe+qq7G+FWbZx9gmyOsCNzZkzHXopoO80y/Dbm3ebvuLTb3diw/hsCvYbLotvwJAvf42RgtDN38NT8nb2hPV8b46HMljNW/W9CohexPKiSpNPG5bLw+k17RSX+/1koFzYvpcyG6z8wvrmttMDCuBx1cqKm1ED6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717847928; c=relaxed/simple;
	bh=DzZItR/XD7N9LswW4+TMkpca7KLSfzsgxdoa43ZNfDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8R8CfxNuy6pXnLqByigE7NXTCkhj3wEgSwmQnRpnPggGz3i/kUuoMdWSY0+KTuAveU7yPKXny7t9L9CO5pe7ZeUW7vONX62Op7ntkmMgqb5q9HHsoBOQyGsUlwQCpDIekfik6HfcEMvvpGdUmkW9/NOijXWH4uWUKrmMfy/UiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6GINMJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BDEC4AF09;
	Sat,  8 Jun 2024 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717847928;
	bh=DzZItR/XD7N9LswW4+TMkpca7KLSfzsgxdoa43ZNfDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U6GINMJkSlCE41KfeaZzFXTUrtZxDWSXH4JVhX9PcTRg4CT1avrA0pw1g0YxTg+fF
	 5Lw2IPNc2TvxHCn+i8eJQ1TOt3YG0aFTLFFOIKVFqp0VA2d9XBPYKboK/U2ris6OLJ
	 VxRnzshbIdkdGrSHwAkXMBmENZDuiPnK8np3YjX532syJvdkUznNMAUhCMVbmX6AES
	 35YDLDksqui+QvpJqmnVTv6Hj9gwpxaIjXWc55Y6Zi3tbDvy4GUpAYQTnVx5rgTwLU
	 2rNhqpUkDBpUX82vypdGoTqT7YYRweE5D5YagB39ysDYJRdVKazSaXEmNfFq12Fbsu
	 femu34yk9gODA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b97f09cde3so382245eaf.0;
        Sat, 08 Jun 2024 04:58:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQjrwNBUOfZDZ13o4LEitUBWW72G0G/owKEiOdZ9Jf/zDJloNXm6K3KNb/eGTz9VovtMwLKWShni0h/68/X5hcjZqvJ0PkYKcMmKOsuRlwFEfUuDw4DvdDg7/JoIi6vD85dmmVG985k28Pl3QuD8p42OvVxCA+Hi7GCLd4XtVPW9087fbt
X-Gm-Message-State: AOJu0YxcQX9QopOmhaCISZqxaU/y/Fa+tRdBa9PkZZMZGU0OpdHuzcbd
	WgOffJHsDYQpZgwpH8S0smwdP2PGG9zOGMDIc3KZvgHpRxoDiEhUfjhx3BKHhRAs9dl1QVuZFym
	8Li9XKRIiJoo0MPtE0FYFENrcQIA=
X-Google-Smtp-Source: AGHT+IHOgfE8EAt38vVrthEz/6qkdGWnaA9HHRM1PPC9eDL1nE44LwGfWGO+Utqm9g98PDm86I2O3dR5lHLvECcfzt4=
X-Received: by 2002:a05:6820:d13:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5baca86a2a3mr2925804eaf.0.1717847927247; Sat, 08 Jun 2024
 04:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
 <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com> <998d53cf-c22b-4706-93af-ab38802dc531@linux.intel.com>
In-Reply-To: <998d53cf-c22b-4706-93af-ab38802dc531@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Jun 2024 13:58:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVpLNLiQ3uHEA9+MWWHv91Yov5hC8uhTg5+z3mK08Yuw@mail.gmail.com>
Message-ID: <CAJZ5v0jVpLNLiQ3uHEA9+MWWHv91Yov5hC8uhTg5+z3mK08Yuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: utils: introduce acpi_get_local_u64_address()
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-sound@vger.kernel.org, 
	alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, 
	vkoul@kernel.org, andriy.shevchenko@linux.intel.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 10:33=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 6/7/24 20:51, Rafael J. Wysocki wrote:
> > On Tue, May 28, 2024 at 9:29=E2=80=AFPM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> The ACPI _ADR is a 64-bit value. We changed the definitions in commit
> >> ca6f998cf9a2 ("ACPI: bus: change _ADR representation to 64 bits") but
> >> some helpers still assume the value is a 32-bit value.
> >>
> >> This patch adds a new helper to extract the full 64-bits. The existing
> >> 32-bit helper is kept for backwards-compatibility and cases where the
> >> _ADR is known to fit in a 32-bit value.
> >>
> >> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.=
com>
> >> Reviewed-by: P=C3=A9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
> >> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >
> > Do you want me to apply this or do you want me to route it along with
> > the rest of the series?
> >
> > In the latter case feel free to add
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks Rafael. I think it's easier if Mark Brown takes the series in
> ASoC, I have additional ASoC patches that use the u64 helper.
>
> Mark?
>
>
> >>
> >> +int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
> >> +{
> >> +       acpi_status status;
> >> +
> >> +       status =3D acpi_evaluate_integer(handle, METHOD_NAME__ADR, NUL=
L, addr);
> >> +       if (ACPI_FAILURE(status))
> >> +               return -ENODATA;
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL(acpi_get_local_u64_address);
> >
> > I'd prefer EXPORT_SYMBOL_GPL() here unless you absolutely cannot live w=
ith it.
>
> I don't mind, but the existing helper was using EXPORT_SYMBOL so I just
> copied. It'd be odd to have two helpers that only differ by the argument
> size use a different EXPORT_ macro, no? Not to mention that the
> get_local address uses EXPORT_SYMBOL but would become a wrapper for an
> EXPORT_SYMBOL_GPL. That gives me a headache...

OK, fair enough.

