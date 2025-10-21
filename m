Return-Path: <linux-acpi+bounces-18024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D3BF5853
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FE7420F19
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F92E6CAB;
	Tue, 21 Oct 2025 09:31:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4F2DF6E3
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039113; cv=none; b=WdulLkyn/5lw5usLQqIdXblbpYHkqhOienpyqVrFevom+6PJXumU1YZJnQ3r0upsBiRS5IM5J7Uk8g0nUulBIKyk9AvmrxEGgan+7tam+NZ1MPuzVb7rUMbMuNJ0mrJGi9qMnqAuo897rRQOWP4Rsv1NbRNYSzu2oXbdx/Y7Kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039113; c=relaxed/simple;
	bh=r24GW0i1udPh6MxH0KHVOL1WuNqWbnMtEjp8otN7o5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCOowj1kd4yqxdk4jX5Zg4byrUj3kJ/suRT6qA9EWWwyUVQKeu9uF181MU6RRZsMivERwQ8H3Hjd1dCotflmRtZNkH53J0yRfKsnK8aIrvzSussnje3CUxKCHC3kEgCwEPdP1bGbldh0rt6/4PF3QDZKA8NPRCUGzr99jzFbm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vB8iR-0003nf-Dc; Tue, 21 Oct 2025 11:31:39 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vB8iQ-004hLI-1Z;
	Tue, 21 Oct 2025 11:31:38 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vB8iQ-000000004Fy-1ior;
	Tue, 21 Oct 2025 11:31:38 +0200
Message-ID: <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
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
Date: Tue, 21 Oct 2025 11:31:38 +0200
In-Reply-To: <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
	 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
	 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
	 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
	 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
	 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
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

On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
> On Tue, Oct 21, 2025 at 11:17=E2=80=AFAM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
> >=20
> > On Mo, 2025-10-20 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengutr=
onix.de> wrote:
> > > > [...] could you take this
> > > > opportunity to prepend a patch that splits the part under guard() i=
nto
> > > > a separate function?
> > >=20
> > > If I'm being honest, I'd just make everything else use __free() as
> > > well. Except for IDA, it's possible.
> > >=20
> > > That being said: I have another thing in the works, namely converting
> > > the OF code to fwnode in reset core. I may address this there as I'll
> > > be moving stuff around. Does this make sense?
> >=20
> > Yes. There was already a previous attempt at fwnode support [1], but we
> > abandoned that when there was no use case anymore.
> >=20
> > [1] https://lore.kernel.org/r/20220323095022.453708-3-clement.leger@boo=
tlin.com
> >=20
>=20
> Ah, what was the exact reason for abandoning this? It's not clear from
> the email thread.
>=20
> To be clear: I think that we can convert the core reset code to fwnode
> without necessarily converting all the drivers right away.

The use case vanished in patch review.

No need to convert all existing drivers right away, but I'd like to see
a user that benefits from the conversion.

regards
Philipp

