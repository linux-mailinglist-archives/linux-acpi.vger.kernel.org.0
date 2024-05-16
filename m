Return-Path: <linux-acpi+bounces-5866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAFA8C749F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 12:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03081C23E86
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978314389F;
	Thu, 16 May 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScYALdTv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12B14389C;
	Thu, 16 May 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855207; cv=none; b=l2byNp5jVoForROPlLFdnibreBCG+GRuEgJRoS4S2r5knXON8Eh0ICEaJE/WOY1cAjzkMEEdhsZRjsNY/luHklCZRvRbDbsp0mmwkwH7GnIhVtL4SufF1OqJnj2alifdf6VopEh7SuPv5YCIVV9p7nFU2IRSFGy6Slxp/45uIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855207; c=relaxed/simple;
	bh=aP4BKg6GnlWaJaGCLB8K2mhaB0kdRVmKegZq2DPZhV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx8V+UAZhI+2p7GSsLJxwRkwap2ecCXDBNO2YKJ1/9i0UQylJ2O+K2rOA8wImce5p6kspGWksLp43+BtOE8Fm6f4vKQ4tVcRpfeWQwiAa6k2N5+gyLtxzytNVSaSHaLZQLwM61GaQxV8IRIal0FzhevTxEtQBRkANnF/7QK3Ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScYALdTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCC5C32789;
	Thu, 16 May 2024 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715855206;
	bh=aP4BKg6GnlWaJaGCLB8K2mhaB0kdRVmKegZq2DPZhV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ScYALdTvjzmBicOJ0Rbdx7I654XNTrIZGeHPGFHZyb5G5loJmcuL5tOYgK+cIFbIu
	 Ix/Oro8u5j/deaWiaG7fmyOWhySrjjY4ycDHrFgWsGwJW8pHEZkOmPdyxK+E844a9a
	 cJiTnxTWOYr0bKABrLwklaKlN4UBCE0EEbJOUu+LQK7cIqGhmyu+EhjXz+LZBb2/Dn
	 Tb06IF12GHRJV9IwvJ8z1QZSUc1CFc6vvPbio9CQLIGph5ANb4n1CxtnefGRf8SfWg
	 uqauYXGiLtMleBvz0ivGLD40MRo0tX6Zww2AALRcIfLY/90QPc2Qt7pYHoDr3AfDAR
	 BHyZzuM7OyWjg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2f4090ac9so2781eaf.2;
        Thu, 16 May 2024 03:26:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi70bBnXSFI68qXQy9bpk14yypcdlzzhKaPoe2PkQAZxCm6WrtgVSCq210msuXvT28A2iH2r/6A3D8BpMV1AJkQokIJ7qxA6/qddQzsl0DL73CfiJNz/jLmv+fwftJ6pUyOQflKU1s3g==
X-Gm-Message-State: AOJu0YxU7z2xiYYkV/tAbeCkgMXZL8j8DIJS+NuQdPU6I2VKWyHFjp56
	63qOBZMn/fy/iosK66jea9eFjkEBdHqwIsO0fZj+pOtE06l4r8jbUN714cfVTsKlzkHYEuiOB+n
	5v0/WSyRAtHfpQJNb/VeMSrxfFFY=
X-Google-Smtp-Source: AGHT+IEA84Gdgt9lv8DZTUfEcZ9ettVVanMsJF5hG2e9SkWYmQ5gG1yYaAEC3Yvkr7rfUiiA6PmdZzPto608t85uN54=
X-Received: by 2002:a05:6870:9724:b0:23e:6d44:f97f with SMTP id
 586e51a60fabf-24172a3d677mr21010801fac.1.1715855205346; Thu, 16 May 2024
 03:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12437901.O9o76ZdvQC@kreacher> <6046110.lOV4Wx5bFT@kreacher> <ZkXea4fdJwgvu0Hm@smile.fi.intel.com>
In-Reply-To: <ZkXea4fdJwgvu0Hm@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 12:26:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxDDrN8DyKws1R-3GabjHcQ4eua2wyTQsueqnqa6Y4+Q@mail.gmail.com>
Message-ID: <CAJZ5v0hxDDrN8DyKws1R-3GabjHcQ4eua2wyTQsueqnqa6Y4+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 15, 2024 at 09:40:54PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> > IdeaPad Pro 5 due to a missing address space handler for the EC address
> > space:
> >
> >  ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedC=
ontrol] (20230628/evregion-130)
> >
> > This happens because if there is no ECDT, the EC driver only registers
> > the EC address space handler for operation regions defined in the EC
> > device scope of the ACPI namespace while the operation region being
> > accessed by the _DSM in question is located beyond that scope.
> >
> > To address this, modify the ACPI EC driver to install the EC address
> > space handler at the root of the ACPI namespace for the first EC that
> > can be found regardless of whether or not an ECDT is present.
> >
> > Note that this change is consistent with some examples in the ACPI
> > specification in which EC operation regions located outside the EC
> > device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> > so the current behavior of the EC driver is arguably questionable.
>
> ...
>
> > -             status =3D acpi_install_address_space_handler_no_reg(ec->=
handle,
> > +             status =3D acpi_install_address_space_handler_no_reg(scop=
e_handle,
> >                                                                  ACPI_A=
DR_SPACE_EC,
> >                                                                  &acpi_=
ec_space_handler,
> >                                                                  NULL, =
ec);
>
> Looking at this...
>
> >               if (ACPI_FAILURE(acpi_remove_address_space_handler(
> > +                                             scope_handle,
> > +                                             ACPI_ADR_SPACE_EC,
> > +                                             &acpi_ec_space_handler)))
>
> ...and this, I believe you can move scope_handle to the previous line and=
 align
> the rest for the sake of consistency and slightly better readability.

Well, I prefer to cut a separate cleanup patch to make this more consistent=
.

