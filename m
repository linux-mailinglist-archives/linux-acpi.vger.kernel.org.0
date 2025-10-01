Return-Path: <linux-acpi+bounces-17488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508DBB1BE8
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 23:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0895D4C3EC4
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B343101C5;
	Wed,  1 Oct 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i0Zb6ZN0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108130FC16
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352640; cv=none; b=ot3W7da79g5uQ5zTKSKNgRd71m/dDekXlUbXfgwqY3cu6Mbb0Hnj05ZXmKYGWslXsKDWfijvBuow08rxI8I7gbYtY/K0+hVF+VMYC5TcN2kCeRiAqsqmuMvfkVt7w1/wVPCPI0jFOX3HzsB2llki5TSDSTl0/DD18UHPL/EHreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352640; c=relaxed/simple;
	bh=4105Z/5hGdN1tVTRN0xK8sG6WEId1RBapbjPdK8pf2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaynfPswdaF5My3rsyCnhpZ5WQ1bSwpQVhu56Fa4Bi6XULpJYwDKzwa4Nj4miZ/igs5j5Ze6a0nIfqyofxSnQaBH1j06+Zma5Dlq0NS9VmjwygMYHYNTZM0wgNN07uaAf1iNXJg7rYnV1Istkv97wLOlrEPnz6LqOKQA4ulMe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i0Zb6ZN0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso2180001cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2025 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759352637; x=1759957437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8R4ckxlGGkZLYacM+hUbGwqr1ufUw/TwOnVgoT0mKE=;
        b=i0Zb6ZN0f4+0hfEOhumLvgMXrurfvrSLqLDyiUYRJsh/eGZTjivfVr+fSg6X5l6k5z
         Ah5ET9XvAoOwUNAZ8SzSDke9lkma397b9ytpkmfTSgoKjAWiMfw8iU3dAMSHUk3LiDOe
         975s+ITiZZkHFpvnFyFR2aTIjxPI++YMKSHP1rlLrJ5rE8svRrf4pj4glgYcL8KzJjab
         /m6SZgQaDQcTWj/cvNDpm23pXZTwGXW5ZB9/EjpM/tdqQCMZdQhok+XMhnkljnmbDfW2
         FBpGwk5RdA7mEIRm6NQbzxdDDQN8SCw2SqPlupOfIoF1pLIdbuMYBjwb3Ex3qHm1//8D
         w9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352637; x=1759957437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8R4ckxlGGkZLYacM+hUbGwqr1ufUw/TwOnVgoT0mKE=;
        b=jJESQVgu9JeyrOMNTYGoeA8uYXkkn9g9h/S4zFQXhIwztMpPDIJKl5nc5bxIox6Qj9
         p5cjxpQ1y6qQV+EfVRuNuFhBULWqTnt37pKRPiHtb+L6uZNR7Rpw//kxWa6JAApgftAW
         t/hlIKC+mKN1QduNdBTHEmppgLKirNa9LTAcKYqIBeqFJZfV7OQJDYle547eNO7JBysO
         zdOIIBy3W+F1B7yDmUK7P5+s9BdT2bd0CodGuy2revb/dOwHniizj41CzVS0DmCVE9mE
         Cu9+zTpjwkVqzxgTkjqtPg14sdl/4VnxYLSJvsPdksprj1Uxw0g1XSJ5D4m2MmGeyqE1
         +MsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7yKCbb+0Jl+0fsmE5XkAVLxF4KX90qKo5S1h8iUKDuCnb5vE2RTGkcGjdiaiEw2oY4NHE5/nl7DDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/prpaWrsj1CrUvPdPwJ5bo4X44fUGcEgtVZK/X7VSVzCbxaIE
	HYnEIl9k3IN9KRPva9y8WfmnqBd2mv/WIFFktbBAaw8r9PF8YPYnLL1JGWYI7aKe2hgACbABFbO
	jvsPgqvli4oZDMbU6moTXiwTPWgaHeSmf4JJrp8rotw==
X-Gm-Gg: ASbGnctrKBsoUPT6GWpSb7cpzJ/peZs46mJIW1MAlMmkeNuVAxOT7S0+L6rWEX9bFdj
	R9os9D8M93CWX/9DuI4OtFl0/oGnYeR8P/if87Y/fDrwJBFWCzb0TkryDQR7aZQEm4Ikky0npA8
	7WeFCjXjjCk8J1YQZoR9zzlKkMlbtEbm6MAU2A7g6igulF53vTLs2g2QosAvJFLssEydFcFJ4kh
	ozsUoXIZKi2sVpFN3CbVRYLZe8l
X-Google-Smtp-Source: AGHT+IHaT8f3IGH0wGTAIKWNGc+wQvt8RfNaa66LDPUvvqcvMX2b9yoXuqRxIA4IpTokJk4759Ot+dBCeq72YxFQH1A=
X-Received: by 2002:a05:622a:8c:b0:4d9:5ce:374a with SMTP id
 d75a77b69052e-4e41de71c93mr65042911cf.53.1759352636890; Wed, 01 Oct 2025
 14:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh> <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh> <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
 <2025100147-scrubbed-untold-fc55@gregkh>
In-Reply-To: <2025100147-scrubbed-untold-fc55@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 1 Oct 2025 17:03:19 -0400
X-Gm-Features: AS18NWCXBo3N9-wt7szYuAOizDJQam1vtml22whdpVU-nHHawPcXDZeIceT_zwo
Message-ID: <CA+CK2bA0acjg-CEKufERu_ov4up3E4XTkJ6kbEDCny0iASrFVQ@mail.gmail.com>
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

Hi Greg,

On Wed, Oct 1, 2025 at 1:06=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 30, 2025 at 11:56:58AM -0400, Pasha Tatashin wrote:
> > > > A driver that preserves state across a reboot already has an implic=
it
> > > > contract with its future self about that data's format. The GUID
> > > > simply makes that contract explicit and machine-checkable. It does =
not
> > > > have to be GUID, but nevertheless there has to be a specific contra=
ct.
> > >
> > > So how are you going to "version" these GUID?  I see you use "schema =
Vx"
> >
> > Driver developer who changes a driver to support live-update.
>
> I do not understand this response, sorry.

Sorry for the confusion, I misunderstood your question. I thought you
were asking who would add a new field to a driver. My answer was that
it would be the developer who is adding support for the Live Update
feature to that specific driver.
I now realize you were asking about how the GUID would be versioned.
Using a GUID was just one of several ideas. My main point is that we
need some form of versioned compatibility identifier, whether it's a
string or a number. This would allow the system to verify that the new
driver can understand the preserved data for this device from the
previous kernel before it binds to the device.

> > > above, but how is that really going to work in the end?  Lots of data
> > > structures change underneath the base driver that it knows nothing
> > > about, not to mention basic things like compiler flags and the like
> > > (think about how we have changed things for spectre issues over the
> > > years...)
> >
> > We are working on versioning protocol, the GUID I am suggesting is not
> > to protect "struct" coherency, but just to identify which driver to
> > bind to which device compatability.
>
> So you have a new way of matching drivers to devices?  That's odd.

Correct. For a device that persists across a live update, the driver
matching logic in the new kernel would need to be altered

Unless, the device can stay unbound into initramfs, as Jason suggested
earlier in the thread. But, still probing would need to be altered to
keep the device unbound.

> > > And when can you delete an old "schema"?  This feels like you are
> > > forcing future developers to maintain things "for forever"...
> >
> > This won't be an issue because of how live update support is planned.
> > The support model will be phased and limited:
> >
> > Initially, and for a while there will be no stability guarantees
> > between different kernel versions.
> > Eventually, we will support specific, narrow upgrade paths (e.g.,
> > minor-to-minor, or stable-A to stable-A+1).
> > Downgrades and arbitrary version jumps ("any-to-any") will not be
> > supported upstream. Since we only ever need to handle a well-defined
> > forward path, the code for old, irrelevant schemas can always be
> > removed. There is no "forever".
>
> This is kernel code, it is always "forever", sorry.

I'm sorry, but I don't quite understand what you mean. There is no
stable internal kernel API; the upstream tree is constantly evolving
with features being added, improved, and removed.

> If you want "minor to minor" update, how is that going to work given
> that you do not add changes only to "minor" releases (that being the
> 6.12.y the "y" number).

You are correct. Initially, our plan is to allow live updates to break
between any kernel version. However, it is my hope that we will
eventually stabilize this process and only allow breakages between,
for example, versions 6.n and 6.n+2, and eventually from one stable
release to stable+2. This would create a well-defined window for
safely removing deprecated data formats and the code that handles them
from the kernel.

> Remember, Linux does not use "semantic versioning" as its release
> numbering is older than that scheme.  It just does "this version is
> newer than that version" and that's it.  You can't really take anything
> else from the number.

Understood. If that's the case, we could use stable releases as the
basis for defining when a live update can break. It would take longer
to achieve, but it is a possibility. These are the kinds of questions
that will be discussed at the LPC Liveupdate MC. If you are attending
LPC, I encourage you to join the discussion, as your thoughts on how
we can frame long-term live update support would be very valuable.

> And if this isn't for "upstream" at all, then why have it?  We can't add
> new features and support it if we can't actually use it and it's only
> for out-of-tree vendor kernels.

Our goal is to have full support in the upstream kernel. Downstream
users will then need to adapt live updates to their specific needs.
For example, if a live update from version A to version C is broken, a
downstream user would either have to update incrementally from A to B
and then to C, or they would have to internally fix whatever is
causing the breakage before performing the live update.

> And how will you document properly a "well defined forward path"?  That
> should be done first, before you have any code here that we are
> reviewing.

Currently, and for the near future, live updates will only be
supported within the same kernel version.

> Please do that, get people to agree on the idea and how it will work
> before asking us to review code.

This is an industry-wide effort. We have engineers from Amazon,
Google, Microsoft, Nvidia, and other companies meeting bi-weekly to
discuss Live Update support, and sending and landing patches upstream.
We are also organizing an LPC Live Update Micro Conference where the
versioning strategy will be a topic.

For now, we have agreed that the live update can break between and
kernel versions or with any commit while the feature is under active
development. This approach allows us the flexibility to build the core
functionality while we collaboratively define the long-term versioning
and stability model.

Thank you,
Pasha

