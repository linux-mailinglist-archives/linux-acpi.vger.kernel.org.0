Return-Path: <linux-acpi+bounces-17749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C0BDB4CB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 22:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D30B4E120B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D232C3274;
	Tue, 14 Oct 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYoNL9S2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415211EDA02
	for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474690; cv=none; b=trDBx76ZcdiPHbPpqWGwfmiBQUUCukeKZV6euaC05wRNX8RA2NePEhZ2vH3M6DlLkvB2jKzNgVnCq+wA1feV48KxSeLLVYMkSKJA7on6rEC3bjMxAXEnnu/lVZYwRigu+A/OlY2mS1HSUWRzXoPEP3Z/l7TbPpCAET7o88i3DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474690; c=relaxed/simple;
	bh=sk3w75RtyWNWUZvXt6JftS1Ei1J9D/GDQ/pCitVq9j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmRUFfPiWoZAStmd6jk401PbtVIwM2zflU55VKq58tZqEfidDv9oV5yzizJQZPkq1XaL8jpw/s3B9ieUn4Hcqu1258BjtuMNfsKBCV/m4zM2lJC4pgkxQnEVFrFF6xEXSM+NnCTJeYkeUUQpYloeMgz4al1C3swVdUwlsjqFZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYoNL9S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACE4C4CEF9
	for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2025 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474689;
	bh=sk3w75RtyWNWUZvXt6JftS1Ei1J9D/GDQ/pCitVq9j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IYoNL9S2e1A4E/u7UXKL7LbX+LrqNMgH7a0xnThaZco2HQYIyQ3Y/IlvAXGC8zQXf
	 +Vs/MiD9nYVGFQGohEfiPuzrCJVmHdE/Q6fI4xet1CRY0/0lcEgtOxa+xAoxsiZSex
	 3uJ60LKwTUlXBCyCv8fnaA03PsqvbKMhbpgZjVTvA59uCXH9FT87vJsD+wishRVkqE
	 z1b0h2fmupBNDItA+tc1nn7opABG13H8BaDBP6d4RGVgD+Bl7s3Gkbf+U32EnX7HGL
	 vcXVMDCdLExWut0dgTyaOpmUrFobCgRGRwGUnNXSdt4qLDF3yDHqxrZgjvMRx4bsj2
	 wBA9EZMGQYiqQ==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6361a421b67so6108248d50.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2025 13:44:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhgqcin1qgLcc0YhzKR4/t8rF2pmEQD3elDGCPSdxgRJXGxL94buBW/ICZWWH8LPMMf14IBWkV+hp3@vger.kernel.org
X-Gm-Message-State: AOJu0YwrViweKvte34GcJaP/d7oJcegxJyVk0ZouT4VOdT+B5GMT8iAE
	QTi3VQTfquCHjquiJmxOpY8bgb/42a2hnsAg/eIPfRpRYDSoYZFbiP2wpqt5Ke+zD9QLI6vuxI8
	E74MQPo1bybtlXFGqG9X3HxUTx2nRmSMgb1/kLfa9qg==
X-Google-Smtp-Source: AGHT+IFJE1plANafJtInJCscm+heLOGPK8H3e3UnKYtheN5mGgUTBn2x78JByU4wjUGojfILO7wb17BQyddrhRF9+MA=
X-Received: by 2002:a53:b4c4:0:b0:63c:f5a7:408 with SMTP id
 956f58d0204a3-63cf5a709c9mr8433411d50.60.1760474689167; Tue, 14 Oct 2025
 13:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
 <mafs0a51zmzjp.fsf@kernel.org> <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
 <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com> <mafs01pn6nbse.fsf@kernel.org>
In-Reply-To: <mafs01pn6nbse.fsf@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 14 Oct 2025 13:44:37 -0700
X-Gmail-Original-Message-ID: <CACePvbWw9zWE7drUnaxfGk971Hv3o8WhLyYF74d4hDundhQ4jw@mail.gmail.com>
X-Gm-Features: AS18NWCZdqV7l4n0ncE9tVNVDPwqC_rRLuITbh1FV52A2zBupxn8n08DI-DoFKE
Message-ID: <CACePvbWw9zWE7drUnaxfGk971Hv3o8WhLyYF74d4hDundhQ4jw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:58=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Fri, Oct 10 2025, Jason Miu wrote:
>
> > On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> >>
> >> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> >> >
> >> > On Tue, Oct 07 2025, Chris Li wrote:
> >> >
> >> > [...]
> >> > > That will keep me busy for a while waiting for the VFIO series.
> >> >
> >> > I recall we talked in one of the biweekly meetings about some sanity
> >> > checking of folios right before reboot (make sure they are right ord=
er,
> >> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare ti=
me
> >> > on your hands, would be cool to see some patches for that as well :-=
)
> >>
> >> Sure, I will add that to my "nice to have" list. No promised I got
> >> time to get to it with the PCI. It belong to the KHO series not PCI
> >> though.
> >>
>
> Right. It is only a "nice to have", and not a requirement. And certainly
> not for the PCI series.

Ack.


> >
> > For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
> > that up. Would you tell me what we like to check before reboot, I may
> > have missed some context. Thanks!
>
> The idea is to sanity-check the preserved folios in the kexec-reboot
> flow somewhere. The main check discussed was to make sure the folios are
> of the same order as they were preserved with. This will help catch bugs
> where folios might split after being preserved.

Yes, the idea is that, for all folio that has been preserved, remember
the folio order at the time of pserver_folio. Right before kexec
reboot, maybe after the freeze() call, the KHO can go though the
internal list of the preserved folio and verify the folio starting at
that physical address still has the same order compare to the
preservation time. In other words, the folio order hasn't change since
the between preserve_folio() and kexec reboot, for the folio that has
been preserved.

> Maybe we can add some more checks too? Like making sure the folios
> aren't freed after they were preserved. But that condition is a bit
> trickier to catch. But at least the former should be simple enough to
> do as a start.

Agree, we can have more check there. We can also add those additional
check as follow up patches in the same series or later series. They
don't have to be done in one go.

Chris

