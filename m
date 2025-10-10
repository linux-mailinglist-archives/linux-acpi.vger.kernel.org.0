Return-Path: <linux-acpi+bounces-17710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4DBCBA1F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 06:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213CC4052D2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA91FF5F9;
	Fri, 10 Oct 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQTDoKiq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C131FE455
	for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069978; cv=none; b=niA81w0oHJMOhJmCmmZ9p2CsCV7AcfIcziMUR3o1HKCwwTUi0EnpSy137NoyTeRDEZVGW5/PcB9tqrmJam9pb1he3Ju2Vm3+9vaM3A3mT9//+qjaobIqKC0HueRDI9SKNITkRVBWO/cw6Uy89+ALzlsuBYwUzwHF2qG7PlNDMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069978; c=relaxed/simple;
	bh=bJV3A2ztZGaLQ6mgfvyHfdT7NOP/K+k71R0Kusejlnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gazv0W2Nh1iliM1GFk3O//aoaLOl/1iMGghXdKxz75g4sRQWitpO37RdfJ7n74SYaCelm8zxufzUETFJGulRIlYnWMvP9k1EpKc8f02I/Lkz/zh+zJIzgy7jZVvQwHFnA4+kwIwQBVuWKR+yNO/OJUFVaAG0MA5cmW6A+x+vK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQTDoKiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5403DC4CEF1
	for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2025 04:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760069978;
	bh=bJV3A2ztZGaLQ6mgfvyHfdT7NOP/K+k71R0Kusejlnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQTDoKiqaGFunGsyhh1cbd7kdKT7FDFjTs7auCjOhXVFIujP32wm8NR5H1D0qoO9X
	 560grcEWL+xo7zPe9VtRzFChsZVCoL1+awasIcTBhFIA1XVXT9RWP8+V8UsT3xPYy3
	 elf9PI+UPsydclMFBaaOjqgKdMDumtaiG70vJFxJNSTChwgdrzYQbd63b+EAkXU0vd
	 zugWmoSv7FfkAaPwlDrNWONUSEKezzTneq1TLFPdiVhj/CzytW0xUF4m3/caiaoLo3
	 rhszQMNCBU/Rsh5xshKWDmEcURG90gtzXSRdaxVLPDYt01bKwl41KEWCabfYYj+79M
	 gzAcR8tsVnEKg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-749399349ddso20168397b3.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2025 21:19:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPfpll/cKAfeUjXQBGLtnZzfl2T6RDHP4lP1mh5yglEzkAXXoi6SfmE1v3oaqRM5fFrICmsNrpIaFb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5eN1ZfAFpGP8aqPPDW8wud8/QavrfX13xYwroSCJn3Tcq2jP
	gyIAhIw22C8z5OTG0ujQANz/v17W3QPMTIERGUoYqJzIjFmmub2a+rGX4VpQa6iIPOfWJtIAFgM
	ysEAJJdsmaRemtcco7IP2aig3dhIZDyskTf87bFgTIg==
X-Google-Smtp-Source: AGHT+IHLY3NQ877f+Hb/NGw3OlMwCbxviANquhSk208SkinMsbXRBhob17ACKUqhB6hbnqihTyuVE3CPYH0yMCZrPxs=
X-Received: by 2002:a53:ea91:0:b0:636:fd5:ed02 with SMTP id
 956f58d0204a3-63ccb8ee9f6mr8057747d50.45.1760069977672; Thu, 09 Oct 2025
 21:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com> <mafs0a51zmzjp.fsf@kernel.org>
In-Reply-To: <mafs0a51zmzjp.fsf@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 9 Oct 2025 21:19:25 -0700
X-Gmail-Original-Message-ID: <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
X-Gm-Features: AS18NWCu3_vyHjoCV8Rj_bpQLVkf37Xx7I24e2eNWuCPz2Dl_PLLF000jx8A6IY
Message-ID: <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Tue, Oct 07 2025, Chris Li wrote:
>
> [...]
> > That will keep me busy for a while waiting for the VFIO series.
>
> I recall we talked in one of the biweekly meetings about some sanity
> checking of folios right before reboot (make sure they are right order,
> etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
> on your hands, would be cool to see some patches for that as well :-)

Sure, I will add that to my "nice to have" list. No promised I got
time to get to it with the PCI. It belong to the KHO series not PCI
though.

Chris

