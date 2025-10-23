Return-Path: <linux-acpi+bounces-18161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A193C02731
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA7643443A7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709530BF64;
	Thu, 23 Oct 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvlkFrke"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860873064A7
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237020; cv=none; b=JUGMREE9qA0b8XgHxhJlnmUz9AJRF5am+GdTT23Nb5lhnNtSKGWUiCq4LmY40hlv6+4HB/n6cMNB/5ZSnSdf+NNaQIp3FWJaEb3tHaFU2Wh118V0b5XCoABpn8brchqvh9bfYt+B6V/POqdejLm7egsTGvYIxZyCoV6eufXbNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237020; c=relaxed/simple;
	bh=a3M7W3BWeRUGRfhK+snn/DeGWrSLsPNKDdfBeO+UoHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u96qaJvrLs2qr+S1RLaHJnyRNCgR96ywo8y1Pac2sh11XIVF8BQ7oGROGxYgzEzSZz037fY7AaB+eFiYHUPBOEiPiuDko9yaTy0e0WIFvYOwaFcjcMZ9nIkLmxVonxE/vXNa8f3oLWADGZu9AHpNcnOy9jyQY3f4iRU32uqMb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvlkFrke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D6EC4CEFF
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237020;
	bh=a3M7W3BWeRUGRfhK+snn/DeGWrSLsPNKDdfBeO+UoHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qvlkFrkeuyZbSOa0eJlFoW8mhuEYTiaMZH9yDPoiP4l42l3jFy8HwP+yXzSCXg1YW
	 BkK10VNt9Gv2UJIre5u0Yq+07wbILujdGj1zpuIOZI++3X/iLyS45I3HsS3HEfINj4
	 7XoCij7u/D3+V7GfL5RApPd4/dcNDhPSwVKhwF28rdriAs1GOyFmTignQq8HDIdvkA
	 vcry+txW8kDEHPBiABUMcyJ6Cvg5inb9rUIDkcaLplYqovTVAKSNUR5soWWoJcOlk8
	 V8/a6/CvbgI3xsAVANuIcPiG2yCCIXhynJXjoHYKheSzSKZ8eJYaY3yXqoi3wbooY7
	 dnnrYVBZVG09w==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c2883ffc77so758547a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 09:30:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPIpRil28xWL+LWhWgXgZr3QuIEoRq0JoonzznRVvqou1QLNuChW6eV/qBWwcYJ+Oel8b919Fk3CDz@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzKO9R4hHo+aWhYstqqq7pt3ZS/UDa3xXgYl2jYhAitpVvdED
	QgO/z4ozifzpFTgZRXXAIgh9IMpuaWwRw70KzhuZlPbAkIj9iEtxNVKXoIhxK9PwIDbR1ry6MvH
	VsMlw6Sr8MUhzy6LZqhFvFm6wjQFshik=
X-Google-Smtp-Source: AGHT+IHDq1EztUjEhZbcmsAypXJ2oBtJE39079rPcy57qhSiOK4J+4PcxlPfYPQJor2CNvKDZhuPPyoPZkpMwe3ojAk=
X-Received: by 2002:a05:6808:6f94:b0:43f:9caf:645e with SMTP id
 5614622812f47-443a2dd813emr11123727b6e.6.1761237019735; Thu, 23 Oct 2025
 09:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
 <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com>
 <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com> <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com>
In-Reply-To: <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 18:30:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJYOcTCACj6jKYL6juAYpUvJUf89kZ6ZxU3fMOpBjFzQ@mail.gmail.com>
X-Gm-Features: AS18NWCx-ccLUIcSua3zctE2K3sw3aOfu-2Tq4ZHKx5jLgRgn6u4OwXeYMA0b5c
Message-ID: <CAJZ5v0gJYOcTCACj6jKYL6juAYpUvJUf89kZ6ZxU3fMOpBjFzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:27=E2=80=AFPM S=C5=82awomir Rosek <srosek@google.=
com> wrote:
>
> On Thu, Oct 23, 2025 at 5:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@goo=
gle.com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@googl=
e.com> wrote:
> > > > >
> > > > > The ACPI INT340X device IDs are shared between the DPTF core
> > > > > and thermal drivers, thus they are moved to the common header.
> > > > >
> > > > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > > >
> > > > I've actually started to wonder if int340x_thermal_handler is neede=
d at all.
> > > >
> > > > It just creates a platform device if the given ACPI device ID is in
> > > > its list,
> > >
> > > That's true. It creates platform device for the given ACPI device ID,
> > > but only if CONFIG_INT340X_THERMAL is enabled.
> > >
> > > > but acpi_default_enumeration() would do that too with the
> > > > caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
> > >
> > > Not exactly. scan handler returns ret=3D1, so device is marked as enu=
merated
> > > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c=
#L2314
> > >
> > > > That should not be a problem though because if CONFIG_INT340X_THERM=
AL,
> > > > there are no drivers that will bind to those platform devices, so t=
he
> > > > net outcome should be the same.
> > >
> > > If CONFIG_INT340X_THERMAL is not set and there are no drivers to atta=
ch
> > > to platform devices and int340x_thermal_handler is removed then you a=
re
> > > right, acpi_default_enumeration() will enumerate ACPI bus anyway and
> > > create platform devices for all ACPI device IDs. However, for me it l=
ooks
> > > like it was intentional to prevent this behaviour unless INT340X driv=
ers
> > > are "present" in the system (were enabled for build so should be).
> > > I am not sure how DPTF works and what may happen if platform devices =
are
> > > visible in sysfs while drivers are not loaded.
> >
> > Such a dependency would be unexpected and confusing.
> >
> > Also, I'm not sure why it would be useful because the lack of drivers
> > means that the devices in question are not handled, so no
> > functionality related to them is provided by the kernel.
> >
> > > >
> > > > Thus I'm wondering if the way to go might be to drop
> > > > int340x_thermal_handler and simply keep the device IDs in the drive=
rs
> > > > that use them for device binding.
> > >
> > > Even better. If it's not required for DPTF to prevent enumeration
> > > on the platform bus I can simply remove the scan handler.
> >
> > I would at least try to do that.
>
> Makes sense, so I'll give it a try. Removing handler will result with
> only two patches, one to update dts_doc_thermal kconfig and second
> to remove the dptf scan handler, the rest won't be needed for a new
> patchset. Should I send it as v4?

Yes, please!

