Return-Path: <linux-acpi+bounces-18339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2DCC1B3FA
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 15:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11501623430
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F233F398;
	Wed, 29 Oct 2025 13:16:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96333EAEF
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743785; cv=none; b=uK9BSJOnFxEJNJfS5BLdKbgjapIDOfYNekJkkD0Fe1rLdcVVBWu2sDtxwH+Qef3UJRBuZDaurrjmoxqGv/gAldqqnFRDkClN1LtXzu/iPOUw6pRkqNCzJSUWNx1+0yNFvLIfT+P08LPzFtRkUWzLp7qPaEhl3gP0cq4l9om0ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743785; c=relaxed/simple;
	bh=OjzbgQ/qKYVclJQZ9IIosBdCIVoeWZudPZmxJnF2eyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKcy7C6z8PxOSQ7mYs6uY/1IbNOCclB4wh5s5zny7Rs6Xg8mNeMX9mMPAdubZMp9uIVMh2NckCUO1XU2fefvogdDAcqHJzRi0qYU9b7eEX5OGboI/8/5vsqRaCxO1UKC8BGgKXQERaQMfHto/HN4O+k9uzKa/kk6GmfVGCl6j4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE621-0001h2-J9; Wed, 29 Oct 2025 14:16:05 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE620-0062zq-2q;
	Wed, 29 Oct 2025 14:16:04 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE620-000000008eD-3JO8;
	Wed, 29 Oct 2025 14:16:04 +0100
Message-ID: <072411812faa1a9744eda9628afc7c7677f485b6.camel@pengutronix.de>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
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
Date: Wed, 29 Oct 2025 14:16:04 +0100
In-Reply-To: <CAMRc=McmA9M6gMzpJ1pgQG2+6gGQ5GgTV6mB_X95WxGCgv861w@mail.gmail.com>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
	 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
	 <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
	 <CAMRc=McmA9M6gMzpJ1pgQG2+6gGQ5GgTV6mB_X95WxGCgv861w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Mi, 2025-10-29 at 13:55 +0100, Bartosz Golaszewski wrote:
> On Wed, Oct 29, 2025 at 1:51=E2=80=AFPM Philipp Zabel <p.zabel@pengutroni=
x.de> wrote:
> >=20
> > > @@ -535,7 +535,13 @@ software_node_get_reference_args(const struct fw=
node_handle *fwnode,
> > >       ref_array =3D prop->pointer;
> > >       ref =3D &ref_array[index];
> > >=20
> > > -     refnode =3D software_node_fwnode(ref->node);
> > > +     if (ref->swnode)
> > > +             refnode =3D software_node_fwnode(ref->swnode);
> >=20
> > software_node_fwnode(ref->swnode) never returns NULL if given a non-
> > NULL parameter.
> >=20
>=20
> That's not true, it *will* return NULL if the software node in
> question has not yet been registered with the fwnode framework.

I completely missed the list lookup in software_node_to_swnode().
Thank you for the quick correction and additional context.

regards
Philipp

