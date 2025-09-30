Return-Path: <linux-acpi+bounces-17446-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F23BAD56C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C84A1C93
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Sep 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08B303C9B;
	Tue, 30 Sep 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VrsUI5u2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948491FCCF8
	for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244080; cv=none; b=PQ9MIIL4K8oIUzPoAGaaG8yoRI6yTVfKcgtKHrKN5IyU5+W1mVZrD7fLJ1LuVhNDBoOj3tAtL0EU8FNxQ/iKgZibJ6GUEKCf7WnlrhJc3CK0C5R/ZZkWqAVz2gBQtaqOGiwNynwzUCk2NS8SIX7+Pu5BkYPfkcTouscHegFgi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244080; c=relaxed/simple;
	bh=ZaEVr4or5cOiiWh76vrIwiPcXn98KNEC6FATw2gVXH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j64jCo1i8YGcbPq9uRgr7QTuERWeBp7VXH0thkDiQL3DrHygZHf+2oV+EcL/uVjuDjd2vblQMocGdd48Waboh7f5CG2I3b/5jG1NsFRxl8bIqqak/KbE/kiVOj1uczO1eviunN+zkw756zbIyfGrYjgL9y8mos4NIMrgnEGYleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VrsUI5u2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e3117ea7a2so12076701cf.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Sep 2025 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759244067; x=1759848867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=VrsUI5u2aLDo8TiJlCvgmiP1oRPX5zQ1Rd/VgP2tVuuHFQO8Wgr9yAIlI6lPPe6Slp
         MM/AQixaX4DWa/YUyCbQZrGuBkeo6JwffJhcgMgEi4pbLU89NlGr7Kzsxq8NJBB1qzq9
         kR0Sm9oQpP0n/O2OJ+LuEZqy3cX2Md+PrufBcTNOtwMFBEKb4Ga1XgdbmvwVZzPNTtok
         jMJ9hcazzzs6/Ih21A9hq8OUchkTF6w0D4QZ5GwKl+FBnOeye/edSk1xT3/1ryERYDJX
         1ZpL1kmKxojsfcRlw/KuEvRRxyX4wO/bZZdMcbR33xYihrOjrQW76x5omqbnDhQy6UYf
         k7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244067; x=1759848867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=RoPfUlYPv4TwYONYvL6RYKyjuwvNCRxpWjs/KSXCDDmlpENhZ18VR5+GnygU4TbGAo
         cMtwq7PsnDokDSzYT/KUuaQIbWoBobLezCfisXMNDmCkt/zgeiptR8yFmiGQ0iU2MI1R
         M8W3KcUN6ZEsG0u/k31252dA9BS6VUpefMO/UfzaJ6hdH5dexqqkhoEEXRQIIpZFE7L5
         7UEiSQ3OcRtQPOa9PaPMz4WYjsCbXiGm/WE6QV8xw6wJr643qg9wR4pj1PeSoP+q0pSG
         Z4hqtnvJ7C9ZTl3zlPw2ji0Cx8hC8o0FGvPP1opq3vdTm7L/GmUAz5/w4WSzhczGlju/
         g37w==
X-Forwarded-Encrypted: i=1; AJvYcCWIlK8IP2aL0ikC3a2CoaaCG//N3p33Qn1cJYoUIgpBrC1EgcmMwww4l2TMVav3/dLH+kxq4QG437Rb@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFKTRitND9CQ3ABwIEvD+M41rlljTiKVxzyHQ3H9PqBjkDeXt
	Adk3DFo4LLZkuEw9bTxvwljwJhQCZOI3A6d8oWpjyNvwBkSaizuA6WjVA5qTLi7wd6Om+/I9dbQ
	fJF+Ds+0jtTOBJZ3Hc054gGcOaGzBVF3rif/1OunJvQ==
X-Gm-Gg: ASbGncv2IP8QEpYv7oO4ga0ekKD+hpfdxTSN7BAv4zx/jlsy52IR8IhNtblGqf1apAN
	wbP703O/z6/awffqCy26hDPGkNC8CxGjhaUj83gFKflhIx702AqsmS91Pe7jgIwtzLJm64ZHNCF
	h3bEWMJqywEroQlh7YV5f3EwcJZydKPFSjKulSJC2kYjnlKhl1UAUuzIW/tuEPneYpbczxDH//z
	LnfVRmlYGEMjMPNclO4W4sHJbc1fSm7kPO4/kA=
X-Google-Smtp-Source: AGHT+IFOfelJUk0OlrUf28WQ82S2leR2E6nLxLlUD+/+zPuAH+3piu1oethsTrwzU7V8ASeo0taITg+SlRBUebjqnyU=
X-Received: by 2002:a05:622a:2598:b0:4b3:65e:76ff with SMTP id
 d75a77b69052e-4da4782da69mr239644941cf.15.1759244067321; Tue, 30 Sep 2025
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <2025093030-shrewdly-defiant-1f3e@gregkh>
In-Reply-To: <2025093030-shrewdly-defiant-1f3e@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 10:53:50 -0400
X-Gm-Features: AS18NWDw8pvmBCS0-6-XLE_nnPEk2xIPcwJH7fRLekDAunX6m_kspIDqEfOyowQ
Message-ID: <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > > prepare callback.
> > > > >
> > > > > After kexec, use driver_set_override() to ensure the device is
> > > > > bound only to the saved driver.
> > > >
> > > > This doesn't seem like a great idea, driver name should not be made
> > > > ABI.
> > >
> > > Let's break it down with baby steps.
> > >
> > > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > > same driver after kexec?
> > > To me that is a firm yes. If the driver binds to another driver, we
> > > can't expect the other driver will understand the original driver's
> > > saved state.
> >
> > Hi Chris,
> >
> > Driver name does not have to be an ABI.
>
> A driver name can NEVER be an abi, please don't do that.
>
> > Drivers that support live
> > updates should provide a live update-specific ABI to detect
> > compatibility with the preserved data. We can use a preservation
> > schema GUID for this.
> >
> > > 2) Assume the 1) is yes from you. Are you just not happy that the
> > > kernel saves the driver name? You want user space to save it, is that
> > > it?
> > > How does it reference the driver after kexec otherwise?
> >
> > If we use GUID, drivers would advertise the GUIDs they support and we
> > would modify the core device-driver matching process to use this
> > information.
> >
> > Each driver that supports this mechanism would need to declare an
> > array of GUIDs it is compatible with. This would be a new field in its
> > struct pci_driver.
> >
> > static const guid_t my_driver_guids[] =3D {
> >     GUID_INIT(0x123e4567, ...), // Schema V1
> >     GUID_INIT(0x987a6543, ...), // Schema V2
> >     {},
> > };
>
> That's crazy, who is going to be adding all of that to all drivers?  And

Only to the drivers that support live updates, that would be just a few dri=
vers.

> knowing to bump this if the internal data representaion changes?  And it
> will change underneath it without the driver even knowing?  This feels
> really really wrong, unless I'm missing something.

A driver that preserves state across a reboot already has an implicit
contract with its future self about that data's format. The GUID
simply makes that contract explicit and machine-checkable. It does not
have to be GUID, but nevertheless there has to be a specific contract.

Pasha

