Return-Path: <linux-acpi+bounces-18075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96EBFAEFE
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A14B1A032E3
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBA30CD9F;
	Wed, 22 Oct 2025 08:39:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5306350A3F
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122378; cv=none; b=WLMoGCaN3D5f5mz8jXWTNF1oRN6nysc5j7WxgriADclpkt401JawTMVurmbxIw7P75E8pfeL8Jc6MjFB3MHYmVDWJk9dzwFaPkimm8qazbFAZesjE9SmfHY8f7JqXn3+C63vlKEYx76gpD4g4PdlMznzlDM0KzpHH0FLky5hjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122378; c=relaxed/simple;
	bh=ip9Mguraw/Sqbpw7MoyQiJGzEWgu6QV2OHUVhIabHW0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTcRARbBfVjgMU8N9KI9Ku4fQ71yMl1D0Fxh1ZRCuQEzlcnsYdZVBB4CoH7BxV7QSxGQ4rroPxO6YvZD0yrZJxFu0z1yTi+E0/fAumY75TEsLMdHP1DtcV9zT5l/c4IrFZM6Es6HsvnHznGFdiGCr9GInhq7PUoRHk/T5vLsE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBUNK-0000iU-E1; Wed, 22 Oct 2025 10:39:18 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBUNJ-004rVA-1I;
	Wed, 22 Oct 2025 10:39:17 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBUNJ-000000003kj-1Lpx;
	Wed, 22 Oct 2025 10:39:17 +0200
Message-ID: <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski
	 <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally	
 <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 22 Oct 2025 10:39:17 +0200
In-Reply-To: <aPerDcMFdbWecGEv@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
	 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
	 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
	 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
	 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
	 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
	 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
	 <aPeexuA1nu-7Asws@smile.fi.intel.com> <aPegyVyONkPWRgi9@smile.fi.intel.com>
	 <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
	 <aPerDcMFdbWecGEv@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Di, 2025-10-21 at 18:47 +0300, Andy Shevchenko wrote:
> On Tue, Oct 21, 2025 at 05:23:33PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 21, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote=
:
> > > > > On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel@p=
engutronix.de> wrote:
> > > > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
>=20
> [...]
>=20
> > > > > > No need to convert all existing drivers right away, but I'd lik=
e to see
> > > > > > a user that benefits from the conversion.
> > > > > >=20
> > > > >=20
> > > > > The first obvious user will be the reset-gpio driver which will s=
ee
> > > > > its core code simplified as we won't need to cast between OF and
> > > > > fwnodes.
> > > >=20
> > > > +1 to Bart's work. reset-gpio in current form is useless in all my =
cases
> > > > (it's OF-centric in 2025! We should not do that in a new code).
> > > >=20
> > > > More over, conversion to reset-gpio from open coded GPIO APIs is a =
clear
> > > > regression and I want to NAK all those changes (if any already done=
) for
> > > > the discrete components that may be used outside of certainly OF-on=
ly niche of
> > > > the platforms.
> > >=20
> > > To be clear, the conversion that's done while reset-gpio is kept OF-c=
entric.
> > > I'm in favour of using it, but we need to make it agnostic.
> >=20
> > As of now, the whole reset framework is completely OF-centric, I don't
> > know what good blocking any such conversions would bring? I intend to
> > convert the reset core but not individual drivers.
>=20
> Blocking making new regressions?
>=20
> Otherwise as long as reset framework and reset-gpio are agnostic, I'm pre=
tty
> much fine with the idea and conversion.

I think we might be talking about different "conversions" and different
"blocking" here?

1) Conversion of the reset core from of_node to fwnode.
2) Conversion of reset controller drivers from of_node to fwnode.
3) Conversion of consumer drivers from gpiod to reset_control API.

My understanding is:

Bartosz would like to convert the reset core to fwnode (1) but not
convert all the individual reset controller drivers (2). He doesn't
like blocking (1) - this statement was partially in reaction to me
bringing up a previous attempt that didn't go through.

Andy would like to block consumer driver conversions from gpiod to
reset_control API (3) while the reset-gpio driver only works on OF
platforms.

Please correct me if and where I misunderstood.

I think fwnode conversion of the reset controller framework core is a
good idea, I'd just like to see a use case accompanying the conversion.
It seems like enabling the reset-gpio driver to be used on non-OF
platforms could be that. Andy, do you have an actual case in mind?

Certainly dropping the gpiod reset handling from consumer drivers
should not be done while it introduces regressions.

regards
Philipp

