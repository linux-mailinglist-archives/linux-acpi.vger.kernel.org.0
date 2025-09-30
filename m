Return-Path: <linux-acpi+bounces-17436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3BBAAF3C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 04:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFB317E165
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009D1FE471;
	Tue, 30 Sep 2025 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr64HeHP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21D1F4CBB
	for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198255; cv=none; b=XLLBhDh/7Pn5ooBqhlsn8TzRRapQyETL9OrqNqJMt9p70qaoVWrUb2PIBFbBSd32NOLeOQnWXEDgljAmzd8yO8ZjsBnRgO658rnfrabNQeTZn8WUTz0yrOEVjFuuPhUY1HA7aHOKbhXL7G/saOjDOD/rwRoBgZhhIMddeCR2bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198255; c=relaxed/simple;
	bh=pgFQsTF0go03+MO1TNumSWtUMq2/R2Z0cHsYWuoyf8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOXR151ZX9C7i2kehvbSOlpCJEwIf82Z7PdN+77N+kG6LLiIKCDRC4+ZoPkbPiKLIlIe1ESXgvYl7W7DwJj86qC5leGhrYf1GhZ/7A/83tfLcf/ISYB7FSwzUHe5SS1zCTQGyg6CjyhcMN5Erz1u199xlJKdy4a4Q5fAuuwjpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr64HeHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881EBC2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759198254;
	bh=pgFQsTF0go03+MO1TNumSWtUMq2/R2Z0cHsYWuoyf8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qr64HeHPoM8jqsaSheaNhPCCPeQ1elbZXo9bp0t5cTex4Ann6+1eSt2AGG5Kj2yde
	 Pt8iqZPbv+Klxp1/Hh87iFjpuGkgaijgr0fX/GsoYQYM3TRIuhtem2zYoHA3Srcvj7
	 opZp9+pRu8nb/D3hnJ/QFEi4D0NgC4dLb5RWai6fGyQwHopmDAZu6s2g2CkSKw0+Z/
	 pafokvJjCgWPsKgPHvKIlCw7koxmCPfSfgX6OLRKHhxl+uu+JhPrXXTL5dDUiX98Vi
	 S6C4BZaW4I6CfrScXfLhRvHYkRsZlT+PmMAaWi4m+/lhjIrHIYnHk1fO+5XE3LRAiW
	 NFf0GIE49VJ3w==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso34545e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 19:10:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFrdEYF9coW16sdawT51s5oTsEwZnuVBZZ//8pu86/dC5RbYtsI2N/tr+5PVflrldnVMFv/nukmmKM@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzgbxCN3Tp81zT5Z4ElQw3wT5TSvYrkCMQJ9hjlhoM00yTBAz
	uKJ5u3jC1WZ/jowpixA1blKXeTR4FP0IFu9uBfYkDxtlynZ56ymPzwf09lKR0j2ar9VRG4HJyJM
	30eATAS6+LJ1OTlsiO3VNbe2eNDy+lm6/3dXeQpCT
X-Google-Smtp-Source: AGHT+IHAG3V5R9Lhg6msr+BcJHqtcjU3Z5BD2NkoFasZmfnaXmoRgIHQcea02VkehcGY/2PxhI1EHOE36OtShOfb0Q8=
X-Received: by 2002:a05:600d:3:b0:46e:1aac:1646 with SMTP id
 5b1f17b1804b1-46e59c09785mr856195e9.0.1759198253081; Mon, 29 Sep 2025
 19:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
In-Reply-To: <20250929175704.GK2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Sep 2025 19:10:41 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
X-Gm-Features: AS18NWC-vaCgpketj6DWsFpbQIRfi173ydEcEh5SUDIiZOfbAHSC8Mr6R50ydIs
Message-ID: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
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

On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > prepare callback.
> >
> > After kexec, use driver_set_override() to ensure the device is
> > bound only to the saved driver.
>
> This doesn't seem like a great idea, driver name should not be made
> ABI.

Let's break it down with baby steps.

1) Do you agree the liveupdated PCI device needs to bind to the exact
same driver after kexec?
To me that is a firm yes. If the driver binds to another driver, we
can't expect the other driver will understand the original driver's
saved state.

2) Assume the 1) is yes from you. Are you just not happy that the
kernel saves the driver name? You want user space to save it, is that
it?
How does it reference the driver after kexec otherwise? If the driver
has a UUID, I am happy to use that driver UUID. But it doesn't. Using
the driver name can match to the kernel PCI driver_override framework.
If we are not using driver_override API, we need some other API to
prevent it from binding to other drivers.

Do you just want the kernel not to save it and the user space(initrd)
to save the driver name? Some one needs to bind that driver_override
when the PCI device is enumerated. Specify in the initrd before the
PCI enumerate would be too early. It hasn't found the PCI saved device
state. After the PCI enumeration would be too late.

> I would drop this patch and punt to the initrd. We need a more
> flexible way to manage driver auto binding for CC under initrd control
> anyhow, the same should be reused for hypervisors to shift driver
> binding policy to userspace.

What is CC stand for?

Once in the liveupdate, the livedupdated device and the binding driver
is fixed. It seems (to me) more complicated to let the initrd fetch
the livedupate saved state and then do stuff with it. The initrd is
not part of the kernel, more like user space programing. It is not
able to get the LUO API to get the list of preserved PCI devices etc.
We can add an API route to the user space accessing preserve data in
the kernel.  But that seems to be extra complexity stuff.

Once it is in the liveupdate, there is no flexible driver binding
policy for the device currently liveupdate, the device needs to bind
to its original driver.

I feel that I am missing something, please help me understand.

Chris

