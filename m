Return-Path: <linux-acpi+bounces-17539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F19BB641B
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABFF19E7F10
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2526FD86;
	Fri,  3 Oct 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QbTbxKwF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7926CE05
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481057; cv=none; b=D1qqyuBXpXlT8mms2iMCGpOzM1CUBrUIYdHbczU98umNZ6uUtfUW1acssp1e2jB4VJM5vS92Sk5rPaxSNOJM9nEgpWe44zpo8bpjK3ve6h9M2wk+Hoov8sEFCA/JwKGAd7SIJJRCMXsW44RHUvWJkmEcE1RbrM+Awaay9dLuF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481057; c=relaxed/simple;
	bh=gDmLNlBn7QFC1Dnl0Qfod3cP1ocPLcIYdIyxP3+GMW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXMdvq7V42fEH5IjFo8SuXM5hiPAOynaG6JUJPqvoMNwX4OvR4zST8s0ZQgwH1zxXC6Tj3ZCFim0lG6HSGTzDaq1VAURHGU2fbXIMkd0FNrFEcp1HComiK0TKXxqXAddlOWL9htdvQXcXNFtzYmkIsUCD+HuFEXoHiF8gld9E+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QbTbxKwF; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 03909240028
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 10:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759481053; bh=gDmLNlBn7QFC1Dnl0Qfod3cP1ocPLcIYdIyxP3+GMW4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Autocrypt:OpenPGP:From;
	b=QbTbxKwFQcvxLykltBBTykoPpcOVJqAbgG5wY9ohv/zCSB2xrJ4yUwP22oMYflwoY
	 qm3pAZQqN2raqbPTKG5EdGCGAewXFyKbbP7wW3AzsRjitQtv/XV6Fi/X0ER7PtHwSe
	 HGiytfpIz6T6ldoo7ea5TQ7X8vdaQc0x9voVFjkMzZ+KFvtreRDh3uoRUY+5C6ZKn5
	 n5AcJ4NaLY2TC9mw0DXMLXZUjV6x7FMPm0vf9OL5tJ4qMKf+ezij27vK2Et2rxZRp8
	 Qv/k6JbLkD4JPcbpFZAenheF797bSSHHevhPipYoQhYRp2G9DSHIV0iA20Al+3Td8C
	 GoYqAsfsyWBJQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cdMf40vQqz9rxR;
	Fri,  3 Oct 2025 10:44:11 +0200 (CEST)
Message-ID: <940aad63e18a1415983a9b8f5e206f26a84c0299.camel@posteo.de>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
From: Markus Probst <markus.probst@posteo.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	 <brgl@bgdev.pl>, Mika Westerberg <westeri@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Oct 2025 08:44:12 +0000
In-Reply-To: <20251003045431.GA2912318@black.igk.intel.com>
References: <20251002215759.1836706-1-markus.probst@posteo.de>
	 <20251003045431.GA2912318@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

On Fri, 2025-10-03 at 06:54 +0200, Mika Westerberg wrote:
> Hi,
>=20
> On Thu, Oct 02, 2025 at 09:58:05PM +0000, Markus Probst wrote:
> > sometimes it is necessary to use both acpi and device tree to
> > declare
> > devices. Not every gpio device driver which has an acpi_match_table
> > has
> > an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
> > which
> > can't be easily disabled in acpi and then redeclared in device
> > tree, as
> > it often gets used by other devices declared in acpi (e.g. via
> > GpioInt or
> > GpioIo). Thus a disable of acpi and migration to device tree is not
> > always
> > possible or very time consuming, while acpi by itself is very
> > limited and
> > not always sufficient. This won't affect most configurations, as
> > most of
> > the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
>=20
> Can you provide a real example where this kind of mixup can happen?
In my specific usecase for the Synology DS923+, there are gpios for
powering the usb vbus on (powered down by default), also for powering
on sata disks. (defining a fixed-regulator for the usb vbus for
example)
> The
> ACPI ID PRP0001 specifically was added to allow using DT bindings in
> ACPI
> based systems.
Hmm, would requiring patching of the acpi tables. Not sure if it would
work with the fixed-regulator though, as it uses dev->of_node instead
of dev->fwnode. I will try to see if I can make it work this way.

>=20
> Regarding the patch, please spell gpio -> GPIO, acpi ACPI and so on.
>=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> > =C2=A0drivers/gpio/gpiolib-of.c | 241 +++++++++++++++++++++++----------=
-
> > ----
> > =C2=A01 file changed, 145 insertions(+), 96 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 37ab78243fab..c472b86148b3 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -18,6 +18,7 @@
> > =C2=A0#include <linux/pinctrl/pinctrl.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0#include <linux/string.h>
> > +#include <linux/acpi.h>
>=20
> I'm not really sure if this is good idea to be honest.

