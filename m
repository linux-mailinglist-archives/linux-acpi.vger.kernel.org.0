Return-Path: <linux-acpi+bounces-17535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD6BB623B
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 09:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4851F3A9E7A
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192022AE5D;
	Fri,  3 Oct 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw1vqdPY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF41224AF7
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475367; cv=none; b=JqKgkNC0UloxXWLLdMcekKDydobtQR8P9cMPghPg/d3ikg4jmtd1ppKljHDWgEIyvV1jWZhtw55YDp3SfpMwaLQWbSEJH3YxZs+C+K2bnXNxU6xdnbz3FYWiIhT+LgsV34114dsVAc4RPxDE7mZr7OQe+NRwcm02oVHopMnjuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475367; c=relaxed/simple;
	bh=zx2owurHFfkAoHhzYNDDvjYONBg7XXGf7hyYmx9Idvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnWptGQXzGqreGetESxmmKJosA89IV5jM3U1EI31URtipJhCcv87CuLSWXkmkjy9gwFsDZh5h0ph1lf9PT2pMGgu3tPmJmB+GABf56xTUcNhQ1ifz3XqQQhq0E9qvI5I080uAoEsR7j2KoQp38o0un0OQBx+If0WwLzI4UkUtbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw1vqdPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB6C16AAE
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759475366;
	bh=zx2owurHFfkAoHhzYNDDvjYONBg7XXGf7hyYmx9Idvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jw1vqdPYfbBqcJ3OLjd2j5FrI96x4fjWKWTLMeQ2vgkCxWs662iR8TIFDDMeR35SL
	 Rbtf0HfETOJRyS5V1zRObhawAFuSvb0owXUV+l/BzvAK3l7wd04qPcjR5iyKDvgUb9
	 yJPUIGAjQXcGI1MIBCwKJxA4PlXbVk18KcqgP/bDb+Tx69GnVS2dYwCaOZURHi8+C/
	 fyCoze5UemfnzlscU4NxIaS4tZDsnVJXV7AMvQpUEU+T3CTZA78doodM4COOfY/FvQ
	 P6yzUf8ui8+skIZCfgXcxG0u4XrDlEMTCiOF2LIvqO+fMd5/qbcE+ybZPLXIOjf5Dz
	 oxSO2S/wEqbJA==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63470a6f339so1985164d50.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 00:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfeSAimaxRt6egGTD32SOoKCgb2R3o2FvRfAeHEYINu0l4u5TS5/x3KloQuYG5Yc40V5hTHo4Iq8jM@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGeJeb2IQSEr7R44jVsbcwa3hXRoL9bkRiiNxgEMer7m3wozO
	9fh3svd4kfIlVhqBa44DY8WHQIACZisJCdIojBPnCPQo5TneIMuJV99EV+EBoUMYETxjvIth99H
	qcITXLWNSZxED5y63KmCDaqfbcltIqBmE9b3+B0SQ2A==
X-Google-Smtp-Source: AGHT+IFEA0NhirwPGgcphjG0fmApdQNf9P4ICBae69kfL2JodwSZCLWlp251XiujpsESiyOGRzhhBlkoU1i9wi0ONVg=
X-Received: by 2002:a05:690e:2513:20b0:632:3cc7:c8cd with SMTP id
 956f58d0204a3-63b9a073829mr1721525d50.23.1759475366088; Fri, 03 Oct 2025
 00:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
 <CAF8kJuN2-Y7YZkY5PrerK=AdTUfsaX0140-yJJSTnNORucYfqQ@mail.gmail.com> <20250930164705.GR2695987@ziepe.ca>
In-Reply-To: <20250930164705.GR2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 00:09:15 -0700
X-Gmail-Original-Message-ID: <CACePvbXSc=k-ivLE-ukuXaKO73mDm=tZBA82c6W+6-i3NnJriw@mail.gmail.com>
X-Gm-Features: AS18NWAqOUXihtz1zjCgVeWOSSOOP1uiZ1AkbQp8d_YOzMx9hgHpSXuyfXEL7Bo
Message-ID: <CACePvbXSc=k-ivLE-ukuXaKO73mDm=tZBA82c6W+6-i3NnJriw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Sep 29, 2025 at 07:13:51PM -0700, Chris Li wrote:
> > Can you elaborate? This is not preserving everything, for repserveding
> > bus master, only the device and the parent PCI bridge are added to the
> > requested_devies list. That is done in the
> > build_liveupdate_devices(), the device is added to the listhead pass
> > into the function. So it matches the "their related hierarchy" part.
> > Can you explain what unnecessary device was preserved in this?
>
> I expected an exported function to request a pci device be preserved
> and to populate a tracking list linked to a luo session when that
> function is called.

The current PCI subsystem is designed outside of memfd.

As for the request PCI device function and that function populated a
liveupdate device list. It has been considered and the current
approach is simpler.  The reason is that, if you want to populate the
device list, you will have to know about all device dependent rules,
devices depend on parent bridge, the VF depends on PF. Because the
request can be canceled as well before reaching the live update
prepare(). Those derived dependent flags need to be tracked and
reference counted. Even worse, it needs to be reference counted by
each liveupdate feature. e.g. LU_BUSMASTER vs LU_SRIOV vs LU_DMA each
need to have a reference counter, so it can remove that dependent flag
when its refcount drops to zero.

> This flags and then search over all the buses seems, IDK, strange and
> should probably be justified.

The current approach is much simpler when request and unrequest a PCI
device. Don't need a recursive walk parent or the PF relationship.
In prepare() it only walks the PCI root bus tree top down one pass.
That is the only place to deal with dependent relationships. It is
simpler and doesn't need to maintain per live update dependent feature
refcount.

That is my justification.

Chris

