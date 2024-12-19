Return-Path: <linux-acpi+bounces-10192-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66D9F7CD5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F215818891CD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03466221447;
	Thu, 19 Dec 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad2gyJT/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBD200A3
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617357; cv=none; b=ryxeJ2lu/iosk+ROI8kDhs9uxBLIG4Z7WwHalcKS6Q6Bf1YgtFl46m44iVdOASXgfSqEBI9GMyQL60PI99hVqhSYiTDalOGbd0UEdTN7/Bl0NruJ4xe2asxin9Wc+adQY0zt6AYqjgF2+5Jn2hpxWnXbGlnDwQG4jmmpkJT5Uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617357; c=relaxed/simple;
	bh=KVHR68tksDzTIZEbK2ieNprp1XI/QKZtbf9rR9CjrbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG2Y7BKfaP5w42QfRJMDP+s5jPFOVwBdqJYrPEqvqVzGsDsB/I7jDw+76dE6F/jz1RrvBnk32JebdSamf93z6lal7YqB06OgM/bOSPBbNbuVV379/wbY4lncmf1W5ftCwV7DOzPA2BIX5fS7aQ1lJt7qJ8nWWm+lvv/EU4NdsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad2gyJT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572FBC4CED0
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734617357;
	bh=KVHR68tksDzTIZEbK2ieNprp1XI/QKZtbf9rR9CjrbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ad2gyJT/i6WS5tOtMYjHiOmMvvf5rRMbVawrym/GK2FAMmPVffRNKDH79YIpU+XTI
	 XxVWOauaMumQk4owzs8sxAGwfH6jTeFLEAc7/8FFN9+waEfTalswaqAhy8ZUA4EwAn
	 SE92LuSzLywJ42lae5HzLsQ2/nHD1VM5fdEInSCFctaijjkvp7Rt53AdcCHlLHU6eW
	 0RPz5b38EwA0nE374mwbUdqbclxSpTZ2IKO5DsBuINS4tmB9NyWRw0HyX+ocbtAdnC
	 OUreByaRkXYiYi5vZXs4bbwLXcAF0YXLmCzJsRWzBECK8zphJZyg8NmNweoq29beeY
	 7DXPzsHVHfWaQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e3005916aso202344a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 06:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFC0ygjT93T1SXCCktHw+AmKfCRCX18f2bZg2h5swDyi/4+CloafQioafXy9xJh4Rfd/MYwCO+E77I@vger.kernel.org
X-Gm-Message-State: AOJu0YzxH784eN26Oz70nH/pfi5oDefUr8iOa7GeHKtC2jajPFBkBlqN
	JOhwRLynFnWN0qjw3CGWb/WHCCRYDsPXosQOmaG58Lx1aCRLD8qwjsKl9MkMvWdk5zc3fY6uT4t
	ryIM6lwBija9M2Jh7ycBK7wGFPSY=
X-Google-Smtp-Source: AGHT+IHcY5grudYSFn2fSj+QCQuaXUzaf4PQgyFKRSeZ3r9oJ4mAoYkgKuYjZCZh2aLHKqye+jKeyjnzPx65RMnCp0E=
X-Received: by 2002:a05:6871:8308:b0:29e:353b:8f25 with SMTP id
 586e51a60fabf-2a7d07c66d3mr1558546fac.12.1734617356591; Thu, 19 Dec 2024
 06:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>
 <Z2P2KegQlxYLd9sd@kekkonen.localdomain> <CAJZ5v0hkaR=1wDO3MuzSGWwryDUb+CBDupwm-kffdpYKPU8RDg@mail.gmail.com>
 <Z2QhhyduwdVItAbs@kekkonen.localdomain>
In-Reply-To: <Z2QhhyduwdVItAbs@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 15:09:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gf2zm9jmzYUWJ6V0rtNWhXGDGmvBxu9HAan_cWxCg7_A@mail.gmail.com>
Message-ID: <CAJZ5v0gf2zm9jmzYUWJ6V0rtNWhXGDGmvBxu9HAan_cWxCg7_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Consider data nodes as being available
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Thu, Dec 19, 2024 at 2:37=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Thu, Dec 19, 2024 at 12:25:22PM +0100, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Thu, Dec 19, 2024 at 11:32=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > Thanks for the review.
> > >
> > > On Wed, Dec 18, 2024 at 12:07:52PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Dec 18, 2024 at 10:16=E2=80=AFAM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Years after fwnode_device_is_available() was introduced, new func=
tions
> > > > > making use of the function on data nodes have been added, such as
> > > > > fwnode_for_each_available_child_node(), it becomes apparent that =
returning
> > > > > "false" for all child nodes on ACPI wasn't a workable option.
> > > >
> > > > Can you describe the problem in a bit more detail?
> > >
> > > How about:
> >
> > This is better IMV.  At least it actually matches my understanding of t=
he issue.
> >
> > > Years after fwnode_device_is_available() was introduced, new function=
s
> > > making use of the data node availability information have been added,=
 such
> > > as fwnode_for_each_available_child_node().
> >
> > I would rephrase the sentence above as follows:
> >
> > "New functions making use of the data node availability information,
> > like fwnode_for_each_available_child_node(), have been added years
> > after fwnode_device_is_available() was introduced."
>
> Looks good to me.
>
> >
> > > To enumerate the data nodes in
> > > various ways specific to those functions, the node availability test =
needs
> > > to pass.
> > >
> > > On ACPI, there is no explicit information on this
> >
> > I guess by "this" you mean the availability of the data (non-device) no=
des?
>
> Yes. I'll use:
>
> On ACPI, there is no explicit data node availbility information in the
> first place and the original fwnode_device_is_available() implementation
> simply returns false.
>
> >
> > > in the first place and
> > > the original fwnode_device_is_available() implementation simply retur=
nes
> >
> > returns
> >
> > > false. This leads to the new functions enumerating only available nod=
es to
> > > never return any nodes on ACPI.
> >
> > I'd say "This causes new functions that only enumerate available nodes
> > to never return any nodes on ACPI for leaf devices that have child
> > data nodes."
>
> Ack.
>
> >
> > > On DT side most access functions, even
> > > those without "_available" part, did only operate on available nodes.
> >
> > On the DT side, :device_is_available points to
> > of_device_is_available() that calls __of_device_is_available() which
> > returns "true" for all nodes without the "status" property, so if I'm
> > not mistaken, on the DT side fwnode_device_is_available() will return
> > "true" for any nodes without the "status" property.
> >
> > I would say something like this:
> >
> > "However, on the DT side, fwnode_device_is_available() returns "true"
> > for all nodes without the "status" property which are analogous to the
> > ACPI data nodes, so there is a difference in behavior between DT and
> > ACPI in that respect."
>
> That's also true. I'll use that, dropping the quotes from "true".
>
> The commit message would be, in its entirety:
>
> New functions making use of the data node availability information, like
> fwnode_for_each_available_child_node(), have been added years after
> fwnode_device_is_available() was introduced. To enumerate the data nodes
> in various ways specific to those functions, the node availability test
> needs to pass.
>
> On ACPI, there is no explicit data node availbility information in the
> first place and the original fwnode_device_is_available() implementation
> simply returns false. This causes new functions that only enumerate
> available nodes to never return any nodes on ACPI for leaf devices that
> have child data nodes.
>
> However, on the DT side, fwnode_device_is_available() returns true
> for all nodes without the "status" property which are analogous to the
> ACPI data nodes, so there is a difference in behavior between DT and
> ACPI in that respect.
>
> Thus from now on, return true from fwnode_device_is_available() on all AC=
PI
> data nodes.

Looks good to me now, thanks!

