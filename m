Return-Path: <linux-acpi+bounces-19588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EDCBE6DA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6232530012ED
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA8347BDD;
	Mon, 15 Dec 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw5yic3m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA52347BD1
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810003; cv=none; b=pGkPL+UGKsA7vIbCfYImIlkUJkRes2aztiLN4P/0o6hRAy7BUhAHzwZtzGt4uYS/tXQTUlQC+YHPopgimDEJdZpa/68sxkKyOHt9RgZK3dJWOa8Wj+M6lFCLiD3V2ff9zNEqXsrXPhLLJebURWRhgj4XPxh+AqdyrFZO64CUlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810003; c=relaxed/simple;
	bh=twWhoUbJKPR/8jVZTfxHVigTMhKmw6JiszbW5iJiawE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj5tiv84I8lLlp2YOPi2YSRpMzfrNE/Xnman+YnXV9dEGxTxP/g9FX4fDkgSUQoM52PmWNSggKhqJNdrRim6KPB6kQ7avt8dHIG2JNOIaSIF+oPlJnH8BFuBpQHA5gQuqMpk4N8L3Gh/YZR4od76arKdILhxI4jTVgHFBhDildY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw5yic3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A79C19423
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810003;
	bh=twWhoUbJKPR/8jVZTfxHVigTMhKmw6JiszbW5iJiawE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uw5yic3m7ycP1ZdHW63H5RjHppNQeqtrcbTLGlO1dJJkHUYX9TH5YKaALNqdhWVWO
	 iCFTX76JFmMo+8aLA7/19yZYRZE6101LZguK7tgwXMJuU377UZtRmNtj9//UmzbKlb
	 4yljpsn2iJfa+wCLblZZ1sAOzwJwUDnWbYndI3mnEtAl0BAqKVCJxc954zesBESKzq
	 SCTlyjTSbcyN8hJBZ3teVlWHUt7vENE6odNV1xi8JMltrMYgymwqy+lAbxxscFyh7x
	 yP3GCdJVOBreF0YCQ1W2X7kgsBcxGyQyd1ON1IIGdwZIw8Vl9i5idFIrVEt54vB9+o
	 pWnTyOV8KdiBg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65749fe614bso1170401eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 06:46:43 -0800 (PST)
X-Gm-Message-State: AOJu0YxD/R0v37ckoUpDFemvTvsSqq2aSansBu/fDIh0bY8xjZlQSeS6
	7jEkdmiAjONRl5DIT32EbgEWUTmlYxFA1WKhPchoxJDTDGesAMSJmrmi/mMY5EFfhDqhIXAYdG/
	/bvZXiERggeKRIYSntPVXkR7Ocvp3jZI=
X-Google-Smtp-Source: AGHT+IExAZVKeKHHhGzainu6YEOfQfX04W9eWTU0VrAgmVhc0oxLZYiptzPIMkdPYDLOrSgfpGyYd0PmNj4UfPBwwaU=
X-Received: by 2002:a05:6820:1ca9:b0:659:9a49:8e43 with SMTP id
 006d021491bc7-65b451af82cmr4794298eaf.19.1765810002683; Mon, 15 Dec 2025
 06:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 15:46:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iYCVW09z0P2UUS6bGiYV6R5ajPaxVfDZeBKwF4Q+Fhkw@mail.gmail.com>
X-Gm-Features: AQt7F2pgh5clWqf0HzR_BfIvoqyimoEoW88PxeX7k8RqwBex2QB63V3XrFRxlgA
Message-ID: <CAJZ5v0iYCVW09z0P2UUS6bGiYV6R5ajPaxVfDZeBKwF4Q+Fhkw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ACPI: Convert button and battery drivers to
 platform ones
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:04=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This is a v2 of
>
> https://lore.kernel.org/linux-acpi/2339822.iZASKD2KPV@rafael.j.wysocki/
>
> with the majority of patches unchanged and some of them updated, mostly
> for cleanliness.
>
> The following intro still applies.
>
> While binding drivers directly to struct acpi_device objects allows
> basic functionality to be provided, at least in the majority of cases,
> there are some problems with it, related to general consistency, sysfs
> layout, power management operation ordering, and code cleanliness.
>
> First of all, struct acpi_device objects represent firmware entities
> rather than hardware and in many cases they provide auxiliary information
> on devices enumerated independently (like PCI devices or CPUs).  It is
> therefore generally questionable to assign resources to them or create
> class devices and similar under them because they don't provide
> functionality associated with those entities by themselves (for example,
> they don't generate wakeup or input events).
>
> As a general rule, a struct acpi_device can only be a parent of another
> struct acpi_device.  If that's not the case, the location of the child
> device in the device hierarchy is at least confusing and it may not be
> straightforward to identify the piece of hardware corresponding to that
> device.
>
> Using system suspend and resume callbacks directly with struct acpi_devic=
e
> objects is questionable either because it may cause ordering problems to
> happen.  Namely, struct acpi_device objects are registered before any
> devices corresponded to by them and they land on the PM list before all
> of those devices.  Consequently, the execution ordering of their PM
> callbacks may be different from what is generally expected.  Moreover,
> dependencies returned by _DEP objects don't generally affect struct
> acpi_device objects themselves, only the "physical" device objects
> associated with them, which potentially is one more source of inconsisten=
cy.
>
> All of the above means that binding drivers to struct acpi_device "device=
s"
> should generally be avoided and so this series converts three generic ACP=
I
> device drivers, the button driver, the tiny power button driver, and the
> battery driver, to platform drivers.
>
> Patches [01-03/10] are preliminary for the button driver conversions.  Pa=
tch
> [01/10] causes platform devices to be registered for "fixed event device"
> buttons, patch [02/10] cleans up the "fixed event device" registration co=
de,
> and patch [03/10] rearranges the notification handling code in the button
> driver to use internal "button" structures for passing data instead of
> struct acpi_device objects.
>
> Patches [04-05/10] convert the two button drivers to platform ones and
> patches [06-07/10] do some cleanups on top of them.
>
> Patches [08-09/10] are preliminary for the battery driver conversion whic=
h
> is carried out in patch [10/10].

This series is now present in the acpi-queue branch in my tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
acpi-queue

along with some other material (mostly related to driver conversions)
posted recently.

Thanks!

