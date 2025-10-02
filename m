Return-Path: <linux-acpi+bounces-17517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37227BB57F3
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 23:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8482AE3
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9F223336;
	Thu,  2 Oct 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ8+OoDf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678573BB44
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441178; cv=none; b=eayvIP2dIIzVduxwSeDs6UnJ2jQlx/P31AJ79Is29Nc9+JRAl6/RZbdssEKBwEDNaWEsb0vhetthG5Cj2p5zTEi1rQgBUbW07Ph2vX4tUhkNRav9JHgZfsyPIALAqsysruAPl8yusq346AyNLfFCG8WWFP9WiAS2Y3rIRZvoLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441178; c=relaxed/simple;
	bh=ex6PQc0wXWx6TMj8K3rK3IDyeD8F4H6+MT/6qRBubA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFfzZDRHbfEOq+wvTvUpbBgRf3BBZ+lPVd2XsCjrz4ZiS53y9K7IgGBIu/GuXsriq5JIMeZ3459wIAp8E/HZwxkC64pk+mUIdFExwgjgeHVPCzEN7yqUyhmaNf6U5B4jQ34puKZsCcTuSddRxi3r1N7NfaWvIUQdIQlSMVcbEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ8+OoDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ED4C4CEFE
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2025 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759441178;
	bh=ex6PQc0wXWx6TMj8K3rK3IDyeD8F4H6+MT/6qRBubA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LZ8+OoDfBZ5BtJMSVd9ex9TUlD6EoZLybFgbNjDjE2hqLGgHoUoZJCC6YrBUCc1DD
	 +PV22oYifPll7ytAwtPdSK1XtLchmW2s2U9vKrURR2I4mO4f9KvU6ZlgZYEfaC8Ne8
	 OGTOM9x6RbqemaLXT/DNsi5woSTaF4IQ9/YC/x0YOVKzEXgSO+DAFc9YnYYqvxvJ0y
	 xkA4gu6v/yttMJAJwmd/514X8eHTmoqzlbuwVGoPHZ48I4DQvML5wP05PzO9ezMtNU
	 4C92xW0Kpe3wzqEt+UhlToDDBN+2d/+KG/wM9Br+oOWLb+vczQOgM9vFw23przXZLD
	 OhFIk0xxfETGw==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6089a139396so2052910d50.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2fDYlHQ3TEUFfkLGkfFn6cCyDjsi0OxTtonxFKhvR4Qs/Pq4rYKxgxJexAfqq3GprvxY0AqashH4X@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1mDv7U/vJyJPDHGwoLI1XPq81ZWF9uJNUfo4vfyGvsDB3NQe
	kWpzK55Su+/m4etnfGLHGGaEIvRGdxvn1564dSuOgquRrvjp2NtENbtLzJdmP1njMbwBZ1FxSB5
	4ISCc21FCf5/wgX5+9ljobCpdKw8SZpzaG0OjHb7BRw==
X-Google-Smtp-Source: AGHT+IFqDarmQ9v4gLTtiLEN2s/MNB4zEb8TW4W8dJe+jN6E+wAqgXHnZfKnxjm153JlNRgMa66a/yo7cRXL6vFx6Wg=
X-Received: by 2002:a53:d8d1:0:b0:635:4ed0:571f with SMTP id
 956f58d0204a3-63b9965c422mr809130d50.23.1759441176979; Thu, 02 Oct 2025
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <20250930163732.GP2695987@ziepe.ca>
In-Reply-To: <20250930163732.GP2695987@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 14:39:26 -0700
X-Gmail-Original-Message-ID: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
X-Gm-Features: AS18NWC4hZkC-DuL7JkglZ9HG1Kuo8rh0wtcRWye7eZGtmkdwbiQhcM2W2Wo-oE
Message-ID: <CACePvbVXZ-rPmBi30eAO-2oF5K5hzQqQPo17M6hV7Pn4Dxrg9g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:37=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> As I said, I would punt all of this to the initrd and let the initrd
> explicitly bind drivers.

You still need a mechanism to prevent after the PCI bridge scan,
create the pci_devices, not auto probe the drivers. If it is not
driver_override, it will be some new PCI API and liveupdate is the
first user of it.

I was afraid to add a new liveupdate specific PCI API for this
purpose. However, if that is what upstream wants, I can certainly do
it in the next version.

> The only behavior we need from the kernel is to not autobind some
> drivers so userspace can control it, and in a LUO type environment
> userspace should well know what drivers go where - or can get it from
> a preceeding kernel from a memfd.

There are two slightly different things here:
1) modprobe the driver. That is typically control by udev.
2) auto probing the drive after the driver has been loaded or PCI
device scanned.

In your envisioning, the initrd autobind controls both of the above
two spec of things, right?

Chris

