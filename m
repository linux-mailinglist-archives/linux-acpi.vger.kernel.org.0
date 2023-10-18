Return-Path: <linux-acpi+bounces-754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94EE7CE923
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3571C209B8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E889CA55
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnZgJ0+9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B53FE49
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 19:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360EAC433C9;
	Wed, 18 Oct 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697657858;
	bh=Pm68nGKZCBKSAtYtKm9YziV8SShEc1H1nFdeoAO94gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hnZgJ0+9fvLqsNUG+OCTRIzD9CeR0NFZd2lwTyyB9xAS2TA21NgBqW7jyK68xv0Sq
	 w4giLGKcfCjJAuS9zxYkq9nAaydQ2ewSTtxuiuubla7tFrt7c84FWjmJbAGHvqa9oW
	 y2f172IJir3MkQoB6usVMqdrNzoemRgU/KPymFuV9E/IUIuLy/XWY/qXSQHveyTrXg
	 F+/jvB2ToriKXXWbYeX4xjDh0+GjC5wMmrhD5Fii0pATuWO+IpgVxi8kHWiZrFiQyG
	 QdpdoqAznJGjwjW5ZmmGmMW8JB0Ceuh9qJcnTd2d/SEL0Hd1rnRDNMv7uguEuLr6c/
	 IziemYhBULpHQ==
Date: Wed, 18 Oct 2023 20:37:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, Gwendal Grignou <gwendal@chromium.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <20231018203755.06cb1118@jic23-huawei>
In-Reply-To: <ZS7jyHkKJcubVxws@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
	<20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
	<20230809185944.1ae78e34@jic23-huawei>
	<ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
	<20230828190101.50f70921@jic23-huawei>
	<CAJZ5v0gOXsX98jQTRSwoYmfYBfva1RHTsDaLL++m7c+kLjStVA@mail.gmail.com>
	<ZS7jyHkKJcubVxws@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Oct 2023 22:43:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Oct 17, 2023 at 09:19:30PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 28, 2023 at 8:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
>=20
> ...
>=20
> > Sorry for the delay, I've lost track of this. =20
>=20
> NP!
>=20
> > Honestly, I have no strong opinion, but I think that this is going to
> > reduce some code duplication which is a valid purpose, so please feel
> > free to add
> >=20
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >=20
> > to this patch. =20
>=20
> Thank you!
>=20
> Jonathan, are we all set for applying this series?
>=20
Applied, but it might end up as 6.8 material depending on exactly how
timing turns out.  I have one pull request sent and I'm not sure I'll get
another one in this cycle. Given I just applied some big drivers I'd like t=
o, but
not sure yet...


Jonathan



