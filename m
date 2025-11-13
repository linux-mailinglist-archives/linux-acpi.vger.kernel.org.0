Return-Path: <linux-acpi+bounces-18855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8371C56DDE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 928B535366E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6C33120B;
	Thu, 13 Nov 2025 10:31:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34D28F50F
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029865; cv=none; b=TtaR2TV1wgJ+59Gco1HWw3ITBa0EZhOk/SBD6Ey9MoEptZ1aSt7Sl/h64v+D1Z3uE5EgL0nlmSD3HX6AOfbsBdnQg04UsZLqwGckIKJSsTE+3xq7o3Z5QFCZRhlk7L9PKjbOCAjnAoPcB6+7v1xDS/CTfTpPPb8S3GDbcn7+U5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029865; c=relaxed/simple;
	bh=9LnyBIpJdksuLIeVZtDZ7QNoRgyfvq4I9oDD8N4QfjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swW3fjjfIcQ7KNqZBPsjUbEfg+cXLzsEA53F2jlWxgAabsIyHE2eojKuePQaueDU8/8qgBwO6csvmfR6vaqTGl6qRwJzNgmM/L6zOn48DzZ2wir+bcjTpWzy0NCbpdtknV1Gi8hlanKde5cOfn5My8MLlp0gKwZ/3LuGMG812rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUbA-0005Yo-N5; Thu, 13 Nov 2025 11:30:40 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUb9-000EtK-2a;
	Thu, 13 Nov 2025 11:30:39 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vJUb9-000000005CK-31lN;
	Thu, 13 Nov 2025 11:30:39 +0100
Message-ID: <7aa5a0ce599f86cc29e5075aa4e35155dfcd013e.camel@pengutronix.de>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
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
Date: Thu, 13 Nov 2025 11:30:39 +0100
In-Reply-To: <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
	 <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
	 <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com>
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

On Mo, 2025-11-10 at 17:57 +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 10, 2025 at 10:02=E2=80=AFAM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
> >=20
> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> > > NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use th=
e
> > > swnode's name as the key for GPIO lookup") into my fixes branch and w=
ill
> > > send it upstream by the end of this week. It will be part of v6.18-rc=
5
> > > which tag will need to be the base for the future immutable branch
> > > created by Philipp.
> > >=20
> > > Software node maintainers: if this versions is good to go, can you le=
ave
> > > your Acks under patches 1-3 and allow Philipp to take it through the
> > > reset tree, provided he creates an immutable branch you can pull from
> > > for v6.19?
> >=20
> > Now that -rc5 is out, could I get an Ack to create an immutable branch
> > with this series on top of v6.18-rc5 (and merge it into reset/next)?
> >=20
>=20
> Hi Philipp,
>=20
> I assume the Reviewed-by tags by Andy and Sakari under patches 1-3
> make them good enough to go in?

I assumed I also need an Acked-by by Greg or Rafael.

regards
Philipp

