Return-Path: <linux-acpi+bounces-17585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BBBB82AA
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E284A73B9
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D025A33A;
	Fri,  3 Oct 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBfKBp9r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87825785B
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525598; cv=none; b=P47Bi3VWMfb2xOKEwsMuLbbOd/pIifm3TmtJlF80UbFCugVuMCqk7QIUkQpGzGrjWiesviYKeRD/kfrr1G+RZ9q1crer0sXsxlXgsly+2+l/WkUgs5UO5tG9H4ZrDpFws4a48l+dsBDGL1DgmSVm95hTWTdsoc+jzyyLUjhXYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525598; c=relaxed/simple;
	bh=smHvUO6y6+rxNgqQB01yRAJUFj9igvIQ+EulDbNNivE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe1IstmL3KjM5AxIS+rOIsQc758Ne9nbyh/3FwYX3wmHdb77xo1jblsscvuNr2oMWj07DizX/MxMtfohKsc3qb/Ch3cYWuqxkk9nps0MY3y+4oqnl1TJzozN9bJO47AYPXnblH9RUjAg9zY+vcQx89UCRTWIkEezjzvyyKbaMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBfKBp9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD3C4CEFC
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525597;
	bh=smHvUO6y6+rxNgqQB01yRAJUFj9igvIQ+EulDbNNivE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pBfKBp9r4EBReETef1rwkhrDMbh3/3oZsjGE0Qv/cJ0qWUceuyvbuTpjazQT42Gsf
	 7XLsaOm/CY3DDt7UIODMThUf/VR67GVwz+ujPODvpqkRXtf8jacfahVFKhbZCcVaJx
	 AwuLT378x269/shlKaGps45u+9jZs6LEPOIpQjhhMZjXw6b5zF1jNpKOZNzQRu6/pO
	 yGWAF0sf+egSI5GLUr6/YboOQhOT1uPjz+VJGAjTIMNlgu5EEmaZNzLdiHcQXSNfkF
	 MZKTNnGeP3Hq2guWbW/+0No+4J3FloLBBXyCNntDmU+MhBKZtWZ7U+9++oh2k+QPNE
	 hv9aC8yR01How==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcac45so30325197b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 14:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgT7i50qaxH+61ntuzv1+fWB+Kjm9GiqdTuS2C4HS7IrIUyOk/anpkBsZplDJdpF0T6dq9iyQiU2/1@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNSe4HHCKD79wDHKGjiTz+V8Tmg2CbVEdoZJkbP0LanWo6FhS
	M059Eb+YhkTVTbB2u+5wYLI4YpEnp4qrGRiIP3ucY0hejQ1sMBDZcR0kTwsSeDGXJx7os9D7qG2
	WgDLlXe9IRHjNvvh+iMQ/QiX3FxaWzowLZHl3xJ3+yw==
X-Google-Smtp-Source: AGHT+IEwSPJ/yX5ZIhTiBfwNm0ItirHXcGbfQ0YU34j4BhQbTqiFL8oSKiBFAybUN0p/s6f72fePqzhe2TQ94F/S9ZA=
X-Received: by 2002:a05:690e:585:b0:636:18cc:fefb with SMTP id
 956f58d0204a3-63b9a064375mr2849137d50.5.1759525597099; Fri, 03 Oct 2025
 14:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
 <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com> <20251003140457.GO3195829@ziepe.ca>
In-Reply-To: <20251003140457.GO3195829@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 14:06:26 -0700
X-Gmail-Original-Message-ID: <CACePvbVqSWnj_iBBNH6bZ+HJC_40coQhvCrFvKaHmYDspnRP5w@mail.gmail.com>
X-Gm-Features: AS18NWBk8FZfS9kE7tc1gSuNGpUXJqvl96bjWvHjlLAXWT0QpjpjfPViNEQhQXA
Message-ID: <CACePvbVqSWnj_iBBNH6bZ+HJC_40coQhvCrFvKaHmYDspnRP5w@mail.gmail.com>
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

On Fri, Oct 3, 2025 at 7:05=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:33:20PM -0700, Chris Li wrote:
> > The consideration is that some non vfio device like IDPF is preserved
> > as well. Does the iommufd encapsulate all the PCI device hierarchy? I
> > was thinking the PCI layer knows about the PCI device hierarchy,
> > therefore using pci_dev->dev.lu.flags to indicate the participation of
> > the PCI liveupdate. Not sure how to drive that from iommufd. Can you
> > explain a bit more?
>
> I think you need to start from here and explain what is minimally
> needed and identify what gets put in the luo session and what has to
> be luo global.

That means it is a bigger conversion that PCI alone, this will need to
change the LUO subsystem design. I can start from the vfio/iommufd
point of view, if the liveupdate device is driven from the
vfio/iommufd side, what is the PCI layer needed to do collaborate. It
will likely end up changing the LUO subsystem and callback design. I
will make that my starting point for the next step.

Thank you.

Chris

