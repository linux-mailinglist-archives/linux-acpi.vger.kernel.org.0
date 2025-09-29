Return-Path: <linux-acpi+bounces-17434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C565BAA430
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3838189373A
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E470227EA8;
	Mon, 29 Sep 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMZVNgY5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2321D5150
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169599; cv=none; b=eMiZQb8R6TGy/ZNPkPWcqrHB7hiqA1AM+/pipBKMdpWQAirA10a8W5OI2igDteR52S5nC6XfVfhT/u9CU8NgPzOkVFwLYJ1bZ1GQCg8SPERK1WiJ2O7uqnLyxFioSy97JbCmD/E+Jl+2oacZB+C7aO3zm8DoGITR9GySe5CXhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169599; c=relaxed/simple;
	bh=LbwCbJnwhsCtXCbxbZQZfXUROtJgENJZsEBiokVyt7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/YxuGTBHzm/jvdbvg3gNocgdabJ/YegcTNIm1qIvd7opGg42b4DFoW4SzD0kuZBvFmhEOObO4kw3S1Y/GhweJofdL/pIfd6Vn/yLF34RYv+aRabkOpL906Nrmt2z2kImwcr8l1x8L4RAaDWRyt0pPpm5tUyqWfZIyJtm6m31h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMZVNgY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A321C19424
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169599;
	bh=LbwCbJnwhsCtXCbxbZQZfXUROtJgENJZsEBiokVyt7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OMZVNgY59itidvz0btVDKFsvH1lJLh1matZIU6b1EIIIqUFFj+6rqX89jAPS9E0YO
	 dqr4FrmZIms+A5OX0deAsfOzqgIFSEgI+mC3OtX1UvvGhu6PmgVYavyQECkaKtoTyh
	 Hs98g5ulFr+zUNvntIAF7PoRn3SIhP/t/Fdv9zVtWMSlLX5PEmU8a7KPfG9tD1yhHZ
	 14IsrUInZhFH6CLnn5gIBm/OE17Tr4WQMlB3cmK8RxSPhh5HYfEa5cvnNtjThoxLGr
	 AKnQQhpEzw/3VwCGtQP9Dz5PrP9aBrld+hhoiruFExVXxZ8QlF1bAwqUzbL2tQyIew
	 mOGG3sdkU0GWA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d605c6501so50655937b3.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 11:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVymRxRgz7N2ZG5zwneqosdQpHWhTcBQjcYAh/VN7aV5bZ19+t/mK7q7iztoM6Ii8b5mmpkO+WwfEpE@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDx/TtAt2kw6lhIUg+M0Qak7ql4uqTbPIg4oT3Z96gf/jDGYw
	mtkmAS6gjfdMQ2kV5O2wjZplDHLunIUCBfkmbZdBPBpDX3TZVRxGjkqDpl25zk0HDa09gXd+yAq
	KHTQlpdfNM7Bqq997ENCkOEKj6lwKr4aUJ85SsFb4hQ==
X-Google-Smtp-Source: AGHT+IFg0OBCiBZqtizi3btuOfJ6EymPr85/ZCLZnPOFwkIJAPuGsn7pDtacbGVQYs+4GNGu2Du1Go3Fo+VIP+PYvcM=
X-Received: by 2002:a05:690e:2458:b0:635:4ece:240b with SMTP id
 956f58d0204a3-6361a88e946mr14562261d50.43.1759169597965; Mon, 29 Sep 2025
 11:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas>
In-Reply-To: <20250929150425.GA111624@bhelgaas>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 11:13:06 -0700
X-Gmail-Original-Message-ID: <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
X-Gm-Features: AS18NWBUaTdODdRMux0yKzkKlHMV32HuBLvBx3alg9CqrbonyaWXQPfEFzRGNtQ
Message-ID: <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sat, Sep 27, 2025 at 02:05:38PM -0400, Pasha Tatashin wrote:
> > Hi Bjorn,
> >
> > My latest submission is the following:
> > https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@sol=
een.com/
> >
> > And github repo is in cover letter:
> >
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> >
> > It applies cleanly against the mainline without the first three
> > patches, as they were already merged.
>
> Not sure what I'm missing.  I've tried various things but none apply
> cleanly:

Sorry about that. Let me do a refresh of the LUOPCI V3 patch and send
out the git repo link as well. The issue is that there are other
patches not in the mainline kernel which luopci is dependent on. Using
a git repo would be easier to get a working tree.

Working on it now, please stay tuned.

Chris

