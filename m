Return-Path: <linux-acpi+bounces-6765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1049275C2
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BD1F2387A
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAB1A0AEA;
	Thu,  4 Jul 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9uDYZNz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F015A11D;
	Thu,  4 Jul 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095390; cv=none; b=f3O2JLWfqMa3GZJBiWAnC2/0fahkUqQfvrC4h0EhbhJEMsfnLevFrsx1Y9e22YZhW/b+b0n3/kBnDu4eF9qvTuzP9/vrhvyENHfRPwJrKe07XdGh56dMGDS+kj4yJOGXCmBJ6qmMekxf2v9rVzdI13AKJ82D9JN2CY6hQVg55+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095390; c=relaxed/simple;
	bh=W31QLCmsBH+N23WsVFp6vLfxTlySqxr6oI2EDkb0Bxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF23Ljg7/D+2L3f82ZUuuErYqTLgTZ5U8yGCGkpP2DL9FD5enMq/2Mc+O1u/vZeoxX2dcpUVhVtWIICz6OpnaEV0APWI5ADTUZ75Quq4qvo7n/b2afJUkbCMqRQSLkne8G9gPhlF8Q6cFVTR2nXZPGreyAnhj9/eiDPriU/bG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9uDYZNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D25FC4AF0A;
	Thu,  4 Jul 2024 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720095390;
	bh=W31QLCmsBH+N23WsVFp6vLfxTlySqxr6oI2EDkb0Bxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O9uDYZNzfjbL20BPce0SBXAc/6RLb5luVbNL9iCTQkFLPB99LpWgM5nctRQ/1XVji
	 nshJkaGwdzZDbyDUMoQHt/xAifrlNytJgUgH6VnItp/6hHsVmsGSLvWiDX9FRgYiWJ
	 pjXcA7iVvKNESo3x4n19MGOsweMqlzElVf8p8SpN/ndYxkPx6CNZyT5m2ejHEsMNDq
	 MJMpk2qp981GKj6XP19yo4c7GEZjxVCQmGhtXwTjsllc4b+11ALcxgMT/6Qvtxbrty
	 ogK2aquxqjOS0h2jxDo1XXCmGHd4yeZDgS6s+QAvgeok/s4MCOIPUh5rq3q/uM+rzT
	 qyQVilGGdzmvA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25989f87e20so86127fac.1;
        Thu, 04 Jul 2024 05:16:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFlMKkWyhXBGzcp8xsFWTbCpvO6FDEgdQHbUVFlY2hBKuI6/fckHSB8fYTKPpimPWAyJx7R0LAyQwMDKcGywlRp4tvKnLRn6uHKtKsWFSz2QxwYOeixDF3xS7vAm4utocSOwiDjv8IvCHnsqc/X4y4fDqnPpWoqfP+4cLKTS4FEw==
X-Gm-Message-State: AOJu0Yzj7jIcyr7B0PlmQSOWbgyBsvteSe6HL7ddYYIkr+JRoHuUcMKk
	AXYW2z/H9yzrw/Hbb3iKSvYv9eQbDH8HICeXTKGUZOMTbyj/a7ji5NUrYurxftEd3sbF1hKgyYZ
	qvUl9zTJ3sAG+3zcyHNImmg90CIA=
X-Google-Smtp-Source: AGHT+IFtXfqhDha8ognSJPCS7ZjL1umAb0rhhN7ePNkKKBtyEecApBtNtccw9KOd6T0xU7AAFVDa0ziWjPibVSlRSUc=
X-Received: by 2002:a05:6820:2c07:b0:5c4:5cbc:b1b4 with SMTP id
 006d021491bc7-5c646a91827mr1360390eaf.0.1720095389853; Thu, 04 Jul 2024
 05:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613211011.413120-1-surajjs@amazon.com> <CAJZ5v0iLtYOWc0w202kq8Tb-n=8ToQj2xHQ2_socwqqTyXufSw@mail.gmail.com>
 <703fd8504ca9541898ec920e15c05d673233218f.camel@amazon.com>
In-Reply-To: <703fd8504ca9541898ec920e15c05d673233218f.camel@amazon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 14:16:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXADyd57jAujYSb5gXWoPJpEAyUPXi_mcJdpORcpg7KQ@mail.gmail.com>
Message-ID: <CAJZ5v0hXADyd57jAujYSb5gXWoPJpEAyUPXi_mcJdpORcpg7KQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: Support CONFIG_ACPI without CONFIG_PCI
To: "Jitindar Singh, Suraj" <surajjs@amazon.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "okaya@kernel.org" <okaya@kernel.org>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:01=E2=80=AFAM Jitindar Singh, Suraj <surajjs@amazo=
n.com> wrote:
>
> On Fri, 2024-06-14 at 13:08 +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 13, 2024 at 11:10=E2=80=AFPM Suraj Jitindar Singh
> > <surajjs@amazon.com> wrote:
> > >
> > > Make is possible to use ACPI without having CONFIG_PCI set.
> > >
> > > When initialising ACPI the following call chain occurs:
> > >
> > >   acpi_init() ->
> > >     acpi_bus_init() ->
> > >       acpi_load_tables() ->
> > >         acpi_ev_install_region_handlers() ->
> > >
> > > acpi_ev_install_region_handlers() calls
> > > acpi_ev_install_space_handler() on
> > > each of the default address spaces defined as:
> > >
> > >   u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
> > >           ACPI_ADR_SPACE_SYSTEM_MEMORY,
> > >           ACPI_ADR_SPACE_SYSTEM_IO,
> > >           ACPI_ADR_SPACE_PCI_CONFIG,
> > >           ACPI_ADR_SPACE_DATA_TABLE
> > >   };
> > >
> > > However in acpi_ev_install_space_handler() the case statement for
> > > ACPI_ADR_SPACE_PCI_CONFIG is ifdef'd as:
> > >
> > >   #ifdef ACPI_PCI_CONFIGURED
> > >                   case ACPI_ADR_SPACE_PCI_CONFIG:
> > >
> > >                           handler =3D
> > > acpi_ex_pci_config_space_handler;
> > >                           setup =3D acpi_ev_pci_config_region_setup;
> > >                           break;
> > >   #endif
> > >
> > > ACPI_PCI_CONFIGURED is not defined if CONFIG_PCI is not enabled,
> > > thus the
> > > attempt to install the handler fails.
> > >
> > > Fix this by ifdef'ing ACPI_ADR_SPACE_PCI_CONFIG in the list of
> > > default
> > > address spaces.
> >
> > What if there are PCI operation regions in the AML on the platform?
> > How are they going to be handled?
>
> Hi,
>
> Appreciate the response.
>
> I think the short answer is that if there are PCI operation regions in
> the AML on the platform then the kernel will need to be built with PCI
> support (CONFIG_PCI) and if it isn't then there won't be a handler
> installed and the operation will error.

A problem with this approach is that AML has no good way of handling
such errors.  It accesses a location in an address space of some sort
and expects the access to be successful.

The interpreter can catch them, but then the only thing it can do is
to abort the AML which then may lead to all sorts of unexpected
behavior of the platform.

> Correct me if I'm wrong but it seems the intention of the patch series:
>
> 36ad7d2b9e9b ACPI: Move PCI reset to a separate function
> 86689776878f ACPI: Allow CONFIG_PCI to be unset for reboot
> bd23fac3eaaa ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is
> unset
> 5d32a66541c4 PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
>
> was to decouple the dependency between CONFIG_PCI and CONFIG_ACPI.

Yes, and as per the above, it was a mistake.

> bd23fac3eaaa ("ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is
> unset") added an ifdef around the code to install the handler for the
> PCI CONFIG region making it dependent on ACPI_PCI_CONFIGURED (and thus
> CONFIG_PCI). Thus it is not possible to install the default handler for
> the PCI CONFIG region unless CONFIG_PCI is set meaning it makes no
> sense to have it in the list of default address spaces.
>
> I can gather that this leads to 2 possibilities:
>
> 1. If there are PCI operation regions in the AML on the platform then
> these will error on a kernel not compiled with CONFIG_PCI.

But as I said, there is no good way of handling such errors.
Basically, the kernel should panic() in those cases.

> or,
>
> 2. The code to install the handler for the PCI CONFIG region should not
> be ifdef'ed and should be executed irrespective of if the kernel is
> compiled with CONFIG_PCI to allow for PCI CONFIG regions in the AML.

That doesn't work either because the PCI config address space may not
be really accessible without CONFIG_PCI.

IOW, I don't see how this can be made work.

Can you please remind me what the use case for ACPI without PCI is?

