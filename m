Return-Path: <linux-acpi+bounces-17532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90ABB5F1B
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 07:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA44A19C416F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 05:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E41E5B71;
	Fri,  3 Oct 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frsgF6PU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5811A5BA2
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469612; cv=none; b=j8W65OD9WV1UVQ8gb7W20b21AFVdpm2PH6WyjLNrKJBCnYYe8oh4FcJNPN+8/fXP/o4omJXs6iJlqChkeqE7Bbt6aTZQfuLbURdT/2bMXQXdhBr5I2XtCjDL68X7suQIc6rGUZLYfaqv1wetLqfwpFqPGjaqmkyf86nLdTDJ5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469612; c=relaxed/simple;
	bh=aymF+kHt0bRkt4NYpGtGvod39hk7LcUqVXZL4lImRts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDRVFK1nQ8fMtKISPmLtVWk1zthHjOrpOmqok9fpGxJSEVQEWoVT2te978QdjAFKDFVeoki8MW60u8EP/9WLPbjSaVbErwDZnDFlqNhQILxqlJW20kw57sMrbowNohRGbxbYN2mJUciHHVJD9u4J/68tRmCbrObizsK2/UpG+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frsgF6PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB4BC19422
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759469612;
	bh=aymF+kHt0bRkt4NYpGtGvod39hk7LcUqVXZL4lImRts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=frsgF6PUFcJvPaZPknZZFKBTvjLGNh3P30VSZrBKs99it8qv6bsTMa9qZhXxkTvfy
	 Xf7m4KNemSP44Xhm4nYVCJMj/H/TrCp79kdeG+/xCK7FKEQh85nPFzr6w1KFKEhRFh
	 JKHMWtCylzC/ct6pEjh0ey2qblLO8MLZtoCcfwW1k8Pe5kGZdD9ZiHQRlBH/2HIHoW
	 YkIO55g3rn+/PtmDnM90c0GcDqOZHdiDXfJRi7/aHdwjSgKb/fNs0YVFCUpSK/jVko
	 UpKytK3uODWMYj6ibp/wlDiYJI86ntfPTUH0MXrUayl5WZKMNKly8n1zErpjdpFRi0
	 sAvtupIq6mwWQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504788so19472607b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 22:33:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJBOQ9KHUAucjeiKSebQVYS7RYE952IP141dMfdTeHCEf1WtdnF47sD3+GTa8F0TN96A4TdpzSnrOq@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgrWZSVgoHFQDTSfd/K960Oy56bG1598vtzzS5PBKPg4nWoe3
	BEZUHk37xO+JGBDmANNmFdMV9rjbImnGYZrKWeQ+6rn2CEIfTAq5OA1LR/Tvaj4a2XLJ5i6JLj7
	MVlecqAst3RD6AKJoedxRl4jaiiVeHPNNZ7ZBZX5WZA==
X-Google-Smtp-Source: AGHT+IFGRCKmW2gE00AaIAEW4tjWtvQLfhUOLXg0iLrBky3mVLLN656OY7gISxl/CyqUSzfY6NkU+hVENUugvUALFbk=
X-Received: by 2002:a53:d24b:0:b0:624:628f:2979 with SMTP id
 956f58d0204a3-63b9a05e883mr1333318d50.17.1759469611325; Thu, 02 Oct 2025
 22:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
In-Reply-To: <20250929174627.GI2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 22:33:20 -0700
X-Gmail-Original-Message-ID: <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>
X-Gm-Features: AS18NWCakhaCBnTAUMjvVRzoBIQQPbxeCW482Ovmcc260U2djC6oIjpaGAP8i34
Message-ID: <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com>
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

On Mon, Sep 29, 2025 at 10:46=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
> >  static int pci_liveupdate_prepare(void *arg, u64 *data)
> >  {
> > +     LIST_HEAD(requested_devices);
> > +
> >       pr_info("prepare data[%llx]\n", *data);
> > +
> > +     pci_lock_rescan_remove();
> > +     down_write(&pci_bus_sem);
> > +
> > +     build_liveupdate_devices(&requested_devices);
> > +     cleanup_liveupdate_devices(&requested_devices);
> > +
> > +     up_write(&pci_bus_sem);
> > +     pci_unlock_rescan_remove();
> >       return 0;
> >  }
>
> This doesn't seem conceptually right, PCI should not be preserving
> everything. Only devices and their related hierarchy that are opted
> into live update by iommufd should be preserved.

The consideration is that some non vfio device like IDPF is preserved
as well. Does the iommufd encapsulate all the PCI device hierarchy? I
was thinking the PCI layer knows about the PCI device hierarchy,
therefore using pci_dev->dev.lu.flags to indicate the participation of
the PCI liveupdate. Not sure how to drive that from iommufd. Can you
explain a bit more?

Chris

