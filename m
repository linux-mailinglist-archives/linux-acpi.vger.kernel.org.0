Return-Path: <linux-acpi+bounces-10189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEE9F7A5A
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 12:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895EA7A14F4
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5B222D5D;
	Thu, 19 Dec 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0PM1Nb9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499D2594
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607535; cv=none; b=JhtY79kDgrKhlgB/IUW22oZOpCT0ihqeoEX672Td15yRBNfNQxN2uKr0rwqXXOYopmYZPsstjy9kurMz9+KNHN3O24aysWIPFL4Zl4xbPGSc5s1yjd+Bx9kbj73i/XEkPLKfrHZH1j7h5haG8l/37+QqMib/a6wUL28TD//hjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607535; c=relaxed/simple;
	bh=TJvJ7Zu/1CvR4WDYdMs0v1WZYDpjP2sSze0sfnr52Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN6EyHKNG5yKfjRc5YqTlXAdN7RpIhBjoeOdGnpsYz/sd1Kh+1KauJLTtQjhY6gLK8DpRn3KHVQOqm5pcLXonLPGLNh1dATaAIEBfdPZZ6Ea1ugMW4b1cLMKRY3mRntJQQDyA5391wq4YQL55ABsQQplrRlotnmF+zU+/EIsmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0PM1Nb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63751C4CED0
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734607535;
	bh=TJvJ7Zu/1CvR4WDYdMs0v1WZYDpjP2sSze0sfnr52Wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q0PM1Nb9bCTGBfV5pqV2jkTUhcTTL1kcGanuZazKdvPNMGYWR5nZPzGCb6odJPLS2
	 7etWbl4Zh5dzqqn+KzJ7IYS3D+80dANN3xhVALnxK87H5dad0xmJdvZcUqR8dBAjnM
	 HSiSp/8ALVnyvXtEp/HTw2JQffMkuplOc6bqpdg/bM+Ea2yvmMorzIP8yvEYXV1y40
	 1YqYaPb0+xgQf1FYa9fko9gG52RXSL+um84thTwcQF13W4gF62wawASmx/Y0ZbT5lI
	 2oR6OB/2pkvvEgW5BS4q9vbMqzl215l5NSe7ixulHx3HCR0cTG3DBN+L9oTlhViekW
	 TTVLVFmiAwdIA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e10e6a1ceso118622a34.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 03:25:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ8Y7MdOeA6OJQAkcBv2Cq/XZdX00VBgxCtl6UbJUnrOlBuGB7acIhgBVIgkYqA8ksKqS95cB2NQ0d@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5nur26ELb2+b/nUxmJhvhUG9j9IuupfMmHh4yFqgdLqaeVqJt
	idblbcZs2laQHdbEllORqr+Czl9A2oY31Tpaw3THYKVX5nFbng5Uoe7RaYiKQkyoVFeeSOP0HmQ
	XYVJ7KjoU2QKqhwiLZB9sK2YNz4A=
X-Google-Smtp-Source: AGHT+IHkSsUIWKAIkz4q8JGX2PB1EeE61LnQNsPNuwX3dfEjRTID+wi/E5xsvbl9fP8ayeTHzdsASFVr4n6l+nm/IR4=
X-Received: by 2002:a05:6870:ff0b:b0:297:23a8:1e0 with SMTP id
 586e51a60fabf-2a7b2bb70e8mr3399879fac.0.1734607534502; Thu, 19 Dec 2024
 03:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com> <Z2P2KegQlxYLd9sd@kekkonen.localdomain>
In-Reply-To: <Z2P2KegQlxYLd9sd@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 12:25:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hkaR=1wDO3MuzSGWwryDUb+CBDupwm-kffdpYKPU8RDg@mail.gmail.com>
Message-ID: <CAJZ5v0hkaR=1wDO3MuzSGWwryDUb+CBDupwm-kffdpYKPU8RDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Consider data nodes as being available
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Thu, Dec 19, 2024 at 11:32=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the review.
>
> On Wed, Dec 18, 2024 at 12:07:52PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 18, 2024 at 10:16=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Years after fwnode_device_is_available() was introduced, new function=
s
> > > making use of the function on data nodes have been added, such as
> > > fwnode_for_each_available_child_node(), it becomes apparent that retu=
rning
> > > "false" for all child nodes on ACPI wasn't a workable option.
> >
> > Can you describe the problem in a bit more detail?
>
> How about:

This is better IMV.  At least it actually matches my understanding of the i=
ssue.

> Years after fwnode_device_is_available() was introduced, new functions
> making use of the data node availability information have been added, suc=
h
> as fwnode_for_each_available_child_node().

I would rephrase the sentence above as follows:

"New functions making use of the data node availability information,
like fwnode_for_each_available_child_node(), have been added years
after fwnode_device_is_available() was introduced."

> To enumerate the data nodes in
> various ways specific to those functions, the node availability test need=
s
> to pass.
>
> On ACPI, there is no explicit information on this

I guess by "this" you mean the availability of the data (non-device) nodes?

> in the first place and
> the original fwnode_device_is_available() implementation simply returnes

returns

> false. This leads to the new functions enumerating only available nodes t=
o
> never return any nodes on ACPI.

I'd say "This causes new functions that only enumerate available nodes
to never return any nodes on ACPI for leaf devices that have child
data nodes."

> On DT side most access functions, even
> those without "_available" part, did only operate on available nodes.

On the DT side, :device_is_available points to
of_device_is_available() that calls __of_device_is_available() which
returns "true" for all nodes without the "status" property, so if I'm
not mistaken, on the DT side fwnode_device_is_available() will return
"true" for any nodes without the "status" property.

I would say something like this:

"However, on the DT side, fwnode_device_is_available() returns "true"
for all nodes without the "status" property which are analogous to the
ACPI data nodes, so there is a difference in behavior between DT and
ACPI in that respect."

> Thus from now on, return true from fwnode_device_is_available() on all AC=
PI
> data nodes.
>
> >
> > > On DT side most access functions, even those without "_available" par=
t,
> > > did only operate on available nodes. That wasn't the case on ACPI whe=
re
> > > only device node availability is known explicitly.
> > >
> > > Thus from now on, return true from fwnode_device_is_available() on al=
l
> > > ACPI data nodes.
> > >
> > > Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_ava=
ilable()")
> >
> > Do you want people to backport this patch?
>
> Good question.
>
> There are just a couple of drivers using the new fwnode_*_available()
> functions and I think they're used on DT-based platforms *currently*. So
> nothing is broken right now as far as I can see (but likely will be in so=
me
> time without the patch).
>
> I guess just dropping Fixes: is an alternative, this wasn't really a bug
> honestly. Backporting shouldn't hurt either though.

Yes, I would drop the Fixes: tag.  If need be, the "stable" people can
be asked directly to pick it up, but it's better to avoid automatic
backporting of it IMV.

> >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 80a52a4e66dd..1ee81e771ae6 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwn=
ode_handle *__fwnode)
> > >  static bool acpi_fwnode_device_is_available(const struct fwnode_hand=
le *fwnode)
> > >  {
> > >         if (!is_acpi_device_node(fwnode))
> > > -               return false;
> > > +               return true;
> > >
> > >         return acpi_device_is_present(to_acpi_device_node(fwnode));
> > >  }
> > >
> > > base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
>
> --
> Kind regards,
>
> Sakari Ailus
>

