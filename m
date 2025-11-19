Return-Path: <linux-acpi+bounces-19068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A06C6D7D1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 09:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01AFB382DA7
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5832ED22;
	Wed, 19 Nov 2025 08:42:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155A32C327
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541725; cv=none; b=gQzKgi2jFK2PKAcJr6QouyCn51ryxbCMgnQGzv0dig9rN6bl113GjO1Mb24tWNlaTaH3+VeJDwKwObOLs3+nY/pJty6jBB7QWFxyPUuKUjYwtafSM0aTcSUmE4GfUsTT3SwZIa3k4yo9giqsZ32xEMnpbqaPWySrTI7vTIqrjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541725; c=relaxed/simple;
	bh=eWFikmnhpKxmZjUEopAhykBWamuhA8gNbQHLFDY6lAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTIsChfkks/xhHOyougJHHUfpeeZm+m+bhfmSc6159fxfFZu0mMCVGkghUF+4qY89InqnNvhT+AR1tT/STfpNeiogGvZ8QRFVpIpV0ayfh6RTt4PFzMqK999+z+JPhHLHAm4VyTh6W2x4YFTRJfrOxlLVimMMPvBrIpDn3JGTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLdkg-0002XY-J9; Wed, 19 Nov 2025 09:41:22 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLdkg-001DYn-0L;
	Wed, 19 Nov 2025 09:41:22 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLdkg-00000000283-06U3;
	Wed, 19 Nov 2025 09:41:22 +0100
Message-ID: <66f0428f889e9d8d35e3215936da9bcc53afe1c3.camel@pengutronix.de>
Subject: Re: [PATCH v6 8/8] reset: gpio: use software nodes to setup the
 GPIO lookup
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich	 <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 19 Nov 2025 09:41:21 +0100
In-Reply-To: <CAMRc=MfsyZ3wqMSQ9jcTFHp2RUrZ=Ge1xdPY44VAGqJ9_XD7QA@mail.gmail.com>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
		 <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
		 <0d251a35a438ebf3e14c6762df7ece079ee1d164.camel@pengutronix.de>
		 <CAMRc=MfAw-HyofSL52PY0H57rBJZAo215gryxWyS8x-d+wcjRg@mail.gmail.com>
	 <c8aea0bd3907957a6f40078e1198959cd8c0d613.camel@pengutronix.de>
	 <CAMRc=MfsyZ3wqMSQ9jcTFHp2RUrZ=Ge1xdPY44VAGqJ9_XD7QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

On Mi, 2025-11-19 at 00:28 -0800, Bartosz Golaszewski wrote:
> On Wed, 19 Nov 2025 09:19:30 +0100, Philipp Zabel <p.zabel@pengutronix.de=
> said:
> > On Di, 2025-11-18 at 18:08 +0100, Bartosz Golaszewski wrote:
> > > On Tue, Nov 18, 2025 at 5:44=E2=80=AFPM Philipp Zabel <p.zabel@pengut=
ronix.de> wrote:
> > > >=20
> > > > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >=20
> > > > > GPIO machine lookup is a nice mechanism for associating GPIOs wit=
h
> > > > > consumers if we don't know what kind of device the GPIO provider =
is or
> > > > > when it will become available. However in the case of the reset-g=
pio, we
> > > > > are already holding a reference to the device and so can referenc=
e its
> > > > > firmware node. Let's setup a software node that references the re=
levant
> > > > > GPIO and attach it to the auxiliary device we're creating.
> > > > >=20
> > > > > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.or=
g>
> > > > > ---
> > > >=20
> > > > I'll apply this with the following patch squashed in:
> >=20
> > Strike that, I'll have to wait for the SPI issue to be resolved.
> >=20
> > > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > > index 3edf04ae8a95..8a7b112a9a77 100644
> > > > --- a/drivers/reset/core.c
> > > > +++ b/drivers/reset/core.c
> > > > @@ -945,7 +945,7 @@ static int __reset_add_reset_gpio_device(const =
struct of_phandle_args *args)
> > > >         of_node_get(rgpio_dev->of_args.np);
> > > >=20
> > > >         rgpio_dev->swnode =3D fwnode_create_software_node(propertie=
s, NULL);
> > > > -       ret =3D PTR_ERR(rgpio_dev->swnode);
> > > > +       ret =3D PTR_ERR_OR_ZERO(rgpio_dev->swnode);
> > > >         if (ret)
> > > >                 goto err_put_of_node;
> > >=20
> > > Huh? Why?
> >=20
> > PTR_ERR(ptr) is just (long)ptr, so a valid swnode pointer makes ret
> > non-zero and takes us into the error path. PTR_ERR_OR_ZERO() includes
> > the IS_ERR() check and returns 0 for non-error pointers.
> >=20
> > And there is a (false-positive) sparse warning:
> >=20
> >  drivers/reset/core.c:978 __reset_add_reset_gpio_device() warn: passing=
 zero to 'PTR_ERR'
> >=20
> > I think it would be better to return to the explicit IS_ERR() check
> > from v5.
> >=20
>=20
> Yes, it was like this in my initial submission and seems like it's more
> readable and doesn't cause this confusion. I will go back to it. Though
> I'm not sure if the SPI issue will require a v5

v7 :)

If there are no other changes required, I can fix it up:

  https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D8e72a48fc1df

>  - I'm looking into fixing it in the affected driver.

Great, can we make sure the fix is applied first, to avoid breaking git
bisect?

regards
Philipp

