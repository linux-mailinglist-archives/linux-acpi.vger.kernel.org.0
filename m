Return-Path: <linux-acpi+bounces-19997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60717CFDAFD
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C7230409E2
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E131B825;
	Wed,  7 Jan 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjKSOqKs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FF3168F5
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788581; cv=none; b=otX8DTP/dhg82j6ty7uYJ1ZTwwAxYmjNKZ9xAfbg0dTQrfTOqXGOkI3vJFhHiS1V8DUjkHGUkzH31oy5PKS2CNLmwBOPPcyOVY3HprvvCsqLKGKNDP5k9+uivwPUF+q4W07rAYZySuhGCH4W+1sJzW78iIciihR1mdzzDy/6yCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788581; c=relaxed/simple;
	bh=YpQB8yKTPURU5YhIohBO9IAkqVY3GcDGFk7I5E/eYTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRGW/ODmshV3KLZ57c3pDTRiC80Q2RqhJdkDdZ0r1cfWtx80iAL8VqmQJm6zBl+Cj4V1647Kqq6ex1UQ26uxpUf23nzVeWMr+9oMz+surQAhUWygwBTHF0G7XRiZ8fgV5thi8Vrp1Rc7k5qOngFcgPKErApiq25zdB3xeG65PCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjKSOqKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C55DC2BCB0
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767788581;
	bh=YpQB8yKTPURU5YhIohBO9IAkqVY3GcDGFk7I5E/eYTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kjKSOqKs0k5t9qF4rHx9j6PjbRdiSQThfAMiN/D7Fyjssipb0h57m8GkFlV0kv9q7
	 3yF4VdYhqVMqsWntvt/UtI5+lfTtUAONZdigG2D241edN4iA81Es4e1A/Ex8zXlkUB
	 pANL1OeOjXVogZpvCuRJPrxnLUDg/F4zrGfoeGWzpeo/pjEjBni1+thKFmLpkHMact
	 zbFogIst1gb0oGngAFi2wjxSOxjEYCeigxqIaMCmCuWWpGAX4AJellV1zIT94JYcDd
	 dbWMehFqkAmnoDtgrVxLc4lJQk7boCtimJqjWl2AemYN1ElO26JzDi9aXMqTkv7eDa
	 YHqOIMG7vImSw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ce229972d9so1116425a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 04:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX47cDax1RspJO7Wv5VUgM2wDuWU45hXbKkJrYErz+Py0J1EwZegtciYh21pwk5I7ZV0kWL+kmnbeZS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ML+KQq0qdxUhJMZG12Fj63pvADsld8ai3WZ6rYsLGhpy1MtQ
	Yrxs7Av8eb67KHUP3EXxXr+DHEOLi7x6i0RP6se9L/VQ7kh0uSpCkcwH/pTW8HKTSsBi+2k2Wbq
	8NL0hoz+g3mBSFNRKF8k9yLmAIR1I6bM=
X-Google-Smtp-Source: AGHT+IFUwEObKoTW/cIOE4voT00iKEZTi9m5mdH+tsbeREadEq4geRZZgSq5wfvRgo8eYWQjSHXfMmSqwC4JSHt62LM=
X-Received: by 2002:a05:6820:2910:b0:659:9a49:8ec8 with SMTP id
 006d021491bc7-65f5508f8b2mr933270eaf.76.1767788580133; Wed, 07 Jan 2026
 04:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2396510.ElGaqSPkdT@rafael.j.wysocki> <65c7a296-7dc7-4368-9b2d-6fadd0dbf9c6@kernel.org>
In-Reply-To: <65c7a296-7dc7-4368-9b2d-6fadd0dbf9c6@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 13:22:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihuu_9G7N5UkHAGwRq=BN1spkXmdOuUTxRFwn3acdfbw@mail.gmail.com>
X-Gm-Features: AQt7F2rzfAea--kXwysJAUxQBxw2p5HJq4PYgiVyT8sW4xpYraMogD_OEeEV0as
Message-ID: <CAJZ5v0ihuu_9G7N5UkHAGwRq=BN1spkXmdOuUTxRFwn3acdfbw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hansg@kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Armin Wolf <w_armin@gmx.de>, Danilo Krummrich <dakr@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:47=E2=80=AFPM Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
>
>
> On 1/6/2026 6:27 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Sadly, there is quite a bit of technical debt related to the
> > kernel's ACPI support subsystem and one of the most significant
> > pieces of it is the existence and use of ACPI drivers represented
> > by struct acpi_driver objects.
> >
> > Those drivers are bound directly to struct acpi_device objects, also
> > referred to as "ACPI device nodes", representing device objects in the
> > ACPI namespace defined as:
> >
> >   A hierarchical tree structure in OS-controlled memory that contains
> >   named objects. These objects may be data objects, control method
> >   objects, bus/device package objects, and so on.
> >
> > according to the ACPI specification [1].
> >
> > The above definition implies, although rather indirectly, that the
> > objects in question don't really represent hardware.  They are just
> > "device package objects" containing some information on the devices
> > present in the given platform that is known to the platform firmware.
> >
> > Although the platform firmware can be the only source of information on
> > some devices, the information provided by it alone may be insufficient
> > for device enumeration in general.  If that is the case, binding a
> > driver directly to a given ACPI device node clearly doesn't make sense.
> > If the device in question is enumerated through a hardware interface, i=
t
> > will be represented by a device object matching that interface, like
> > a struct pci_dev, and the ACPI device node corresponding to it will be
> > treated as its "ACPI companions" whose role is to amend the "native"
> > enumeratiom mechanism.
> >
> > For the sake of consistency and confusion avoidance, it is better to
> > treat ACPI device nodes in general as ACPI companions of other device
> > objects representing hardware.  In some cases though it appeared easier
> > to take a shortcut and use an ACPI driver binding directly to an ACPI
> > device node.  Moreover, there were corner cases in which that was the
> > only choice, but they all have been addressed now.
> >
> > In all cases in which an ACPI driver might be used, the ACPI device
> > node it might bind to is an ACPI companion of another device object
> > representing a piece of hardware.  It is thus better to use a driver
> > binding to the latter than to use an ACPI driver and leave the other
> > device object alone, not just because doing so is more consistent and
> > less confusing, but also because using ACPI drivers may lead to
> > potential functional deficiencies, like possible ordering issues
> > related to power management.
> >
> > Unfortunately, there are quite a few ACPI drivers in use and, as a rule=
,
> > they bind to ACPI device nodes that are ACPI companions of platform
> > devices, so in fact they play the role of platform drivers although in
> > a kind of convoluted way.  An effort has been under way to replace them
> > with platform drivers, which is relatively straightforward in the vast
> > majority of cases, but it has not been pursued very aggressively so far=
,
> > mostly due to the existence of the corner cases mentioned above.
>
> This is the same as Danilo's comment; but could you leave a few examples
> of conversions that have been done successfully?  Commit hashes that can
> demonstrate what it actually takes to convert an acpi driver to a
> platform driver and might make it easier for people to reference when
> this comes up.

The purpose of this posting and the new document is to grow awareness
rather than to tell people how to convert drivers.

I'll start posting driver conversion patches at one point and the
motivation for all of them is basically the same, so I thought it
would be better to document it in on place and then refer to it
instead of repeating the same information every time a conversion
patch is posted.

