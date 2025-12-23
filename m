Return-Path: <linux-acpi+bounces-19800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A790CD87B3
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5E493044697
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336823313E;
	Tue, 23 Dec 2025 08:45:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244C2F6927
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479530; cv=none; b=U3TLgvYaCeu4jlLH33yBWWDWi+jGj1CpwAuQEgHMN8b74ACO/VjbgNhGwl8xdMqwMnxW9JRKIbhXMlYwIsjucM7WQWMM/gtmehwHL6NVqhw+j6a0t9K9R+tpGFfcQfs7nisN2DOObjterKw/RZ1TJC+EjZiMTrsSkparjEw4Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479530; c=relaxed/simple;
	bh=oFi2nxnCewGPylNCvxQMquEVKuQMCWP9UyrGraUnpL8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAfnVwDydbGbGj/ij8OdBeHud+nggMqxMrr2vsm+8wuOQ35zS5EN0ZZcMNXqaoqobO6Pgh/H9juPcu5XSEtEmNm2/EMMAmG0r9QUQgu/N4BesmUcY0ArJAtGfhDFxRL+5mXTGSeX7dLW52h8OqEwq5YCXdWe5/iDgw5cFyklkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1766479465t119t59354
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17626968613264636015
To: "'Bartosz Golaszewski'" <brgl@kernel.org>
Cc: "'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<dakr@kernel.org>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<dakr@kernel.org>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com> <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
In-Reply-To: <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
Subject: RE: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Tue, 23 Dec 2025 16:44:24 +0800
Message-ID: <030001dc73e8$56e38330$04aa8990$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzaRfJPMiwz9071uYI3gJ0t6u2qwFWX8iGtHZH4jA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ONv4FG6+I+02GhsPTdgiCWXf2TCAVC/ZqU5zi+gLmD9fFBFWXrj0Gfj7
	lYdJ6Lg0FFpa7+GaWFDF2MTWb/ZPi/CXwOamsbwNSprK+QGLEsNJCmpxSQcayFEPnyTrTqW
	wsFE7irP3CCZCzwxIH3QpKjzdn8OWRGMKrs0pAOQ/ulI43/kLt0MVAyIachGzaIirjf3e8G
	o0DARajPqU9ZIYAV9NEkm/K2cP1e1T7SsB0GEwT2RoDGWdTgd+9TbZUAVbGF41AUFoVLMxD
	ZY1ZAc2OJ8pqwQG556MQMrqOddMFdNVkFO837vTslU6gck32AFoNQdmeEh8pmY18XR/ORUc
	5yAqvJe6aZsEgG4+7whgRdocxNpyjFGs8MfNF4E+noKovqOYFHp3ZYYDxaRLMLCKj8Uq19I
	SePSVWOcJlvZsDgLPsk/cGang3/G5dSLiEMBsHIbaLF7bAViqm7cYk0C2yNciRzRwizXVNr
	w7T4WPlh2YWxRCgllBBldncZ+QLN5mtOSdszdJNC7T4fldba5E1wy2KEfma5/UgDEBzESAh
	n/YDp18yGO1QmVW49G8hT6yYOOfseVvk7bGl1oVfhC04HSkhdAoyFNwmiNvuBy6uF1bKKf9
	Y/xVaEClHcn8qo94mkxctdq2l7vI/r2tttEgEByHAaHrfpE7Rlk9Nn1qnQLrMjzeRo+6Mh8
	/m8xkdTfoWj9AMz07apT2GwgF+JIoHXPtLk1LZK2Ou2gw9XxmoAVq+6pad0M5sYnvk1gSI8
	BXBqvmyKEw81Q5MAIaM6jSmvk8CIabeA1RMc5S3o+SXq8E7Nf3VSe7VBCyH2JqOGRruN0iC
	OcLAZr5ZatS8lOj5PCfpk4DgDQMwAa0nPS6qNGHRcGatECat3hh1umrt+6u3iJ51TwTmzgG
	2hEOVjY9s5S0+oTaIUKnD2lai1zvpJ8JoG8C1kCYKm1FBqogn3nImaLA7/2SkDW+mYkKGkQ
	eyhHvsl49L/tU+kQhpm3fNrOp/m++wBWh56wSR6kkYi+IbS5Wwg1s9Vxn8VvA5oHXB+UJfT
	4gmDGmneyeVjO/8KBZ
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Tue, Dec 23, 2025 4:09 PM, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 8:39=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >
> > >
> > >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> > >  (const struct software_node_ref_args) {                           =
   \
> > > -     .node =3D _ref_,                                          \
> > > +     .swnode =3D _Generic(_ref_,                               \
> > > +                        const struct software_node *: _ref_, \
> > > +                        default: NULL),                      \
> > > +     .fwnode =3D _Generic(_ref_,                               \
> > > +                        struct fwnode_handle *: _ref_,       \
> > > +                        default: NULL),                      \
> > >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> > >       .args =3D { __VA_ARGS__ },                                \
> > >  }
> >
> > This change seems incompatible with my driver txgbe, since the =
software nodes
> > are registered in " struct software_node * " but not " const struct =
software_node * ".
> >
> > So when I pulled the net-next-6.19-rc1 that merged this patch, to =
probe my driver.
> > The error logs shows:
> >
> > [    5.243396] txgbe 0000:10:00.0 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > [    5.243399] txgbe 0000:10:00.0: failed to init phylink
> > [    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed =
with error -22
> > [    6.109548] txgbe 0000:10:00.1 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > [    6.109551] txgbe 0000:10:00.1: failed to init phylink
> > [    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed =
with error -22
> >
>=20
> This shouldn't have changed anything for existing software nodes - the
> pointer in struct software_node_ref_args has always been const. This
> would have failed at build-time if this was an issue. Have you
> bisected it to this very commit? What line is the -EINVAL assigned and
> for what reason?

The -EINVAL is assigned software_node_get_reference_args():

	if (ref->swnode)
		refnode =3D software_node_fwnode(ref->swnode);
	else if (ref->fwnode)
		refnode =3D ref->fwnode;
	else
		return -EINVAL;

I think the reason is that _Generic selection is restrictive, it only =
accept
exactly const struct software_node for software node references. So the
macro SOFTWARE_NODE_REFERENCE fall back to the default to set .swnode =
=3D  NULL.

And I temporarily added this line to fix it:

diff --git a/include/linux/property.h b/include/linux/property.h
index 272bfbdea7bf..e30ef23a9af3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -371,6 +371,7 @@ struct software_node_ref_args {
 (const struct software_node_ref_args) {                                =
\
        .swnode =3D _Generic(_ref_,                               \
                           const struct software_node *: _ref_, \
+                          struct software_node *: _ref_,       \
                           default: NULL),                      \
        .fwnode =3D _Generic(_ref_,                               \
                           struct fwnode_handle *: _ref_,       \


