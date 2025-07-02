Return-Path: <linux-acpi+bounces-14947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851DAF5F57
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246411C25FE9
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF52D46C5;
	Wed,  2 Jul 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+8BCDQy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B61DDC07;
	Wed,  2 Jul 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475700; cv=none; b=WSheRe9nNTTDAWlXLTNXRq+bD38/t+JFq5UXND4Yiqly2MYx1WOjde/wukn4J56qusyGcqVrGmTR3/nX3slCu/RY+ajDDIF5t/pUosUynnbyB+vOaI4WyADI6eVFJPE4I461cFrMsqJjDda8D5kvS32aoNSeQ7wR/aW9xQ4sM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475700; c=relaxed/simple;
	bh=K6npPwHBi2DGHnFB8cl+vvK8I6ibe7HqdGsOF64ZxCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgcEkWDoFBHVJWhX7mjSm8ECWBrpHsEOFAMJRnHXbvUREFToRlKkBYkf3pl29SBVX2kjXqYukn5iYnqfLvc9vZSEfNj613gEi3+Lf+XZy2NpNaBv9huLHGWuo8VcxMk8nnuih4gMTcqVSulscabAXBhpxUetcVrBDL6S78wAYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+8BCDQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D77C4CEFC;
	Wed,  2 Jul 2025 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475699;
	bh=K6npPwHBi2DGHnFB8cl+vvK8I6ibe7HqdGsOF64ZxCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o+8BCDQyeUWWo69CKGFQez5Cbr20o/NSDZkTrZ0tTOe8blmA9sQucX/SN9hQvQM3z
	 3UNH+1M7T9wUWomD/rBq7FXAztDaRmQNJYaMlvLPIMfwwHxxpHD93CEjlVkwc5LHqJ
	 b5ChwVZdRQH0xpa83i8d5YfPIJ0jeWbqP6eNYWCaEnt33HMn6EFjk4+oJPok8lE/W3
	 x3As9zOkVRITFiQOizLS0IeaySaMNi9tZ18xg9Qdm4D7SPJr+ewiRpv3m98niSMBG6
	 ikU4p1dlCNjNJdnTmJNAjpTqrVD1gdR128NVqBTlrP/B2BB/vXjL0kuMBRZMayNKwO
	 zI+IFgmJdp7tA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60d6303a11eso3324488eaf.0;
        Wed, 02 Jul 2025 10:01:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYwefQOofi5XyJ3rPyOknxKfk4NITVrzf8JyP/GWUYvkBvK+bGA0hNvazM8ZsibPsXg9/ZNFTiCBwYW78b@vger.kernel.org, AJvYcCViqZzvApYk1WL6x4lHgseeK7D8yXBFYw0keYwIziui6JFhhaQdfSu2XleW5Y6SWniMh7ArNilvqbd5Tw==@vger.kernel.org, AJvYcCWMY1Lo7WWxfDtHVhcIXTJ0pYuxwHKy4iFOoUJLWcuk06sBCe3ZcK5eTzC9iH8JKO7Op4PBD/ijdOuE@vger.kernel.org, AJvYcCX+YvXnvqXSWLqqYPf6qxu4bRy12W5csRwU8O0Ai+0MQZG5MAjLkkUGYvZKrLyRo99Nn2slF9tiBE0C@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4xZtmI8ZvEWe4ep03txrSqps5/UCmi7JSDgtQNR68xuP5k1t
	uxvMcsA1HA9LvfZd7md+I8qUDZWOAQuEiD/huS/KjVKlfpci9JLcbQjUDA4QQuasXGms/K7EJeG
	cJSJJwtQPzxOD1OyRJqnXedipNT9Y3Mg=
X-Google-Smtp-Source: AGHT+IGPd++aiCNQ4qfuEIoYUI2K930oDrPPW3BNMd8Apd55Lv82AJ7wV9K+7i8ylCY8TGknSq7EnGbvDAKM/sPSrwE=
X-Received: by 2002:a4a:ca89:0:b0:611:aabf:2b7d with SMTP id
 006d021491bc7-612012d05e1mr2142271eaf.7.1751475698640; Wed, 02 Jul 2025
 10:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-15-apatel@ventanamicro.com> <CAJZ5v0ifCN7OWEw0DHpULSmXn4nCb9EdJMjQPJwmdoF_y0nfjA@mail.gmail.com>
 <aGVF8Gqzs2YZf1Os@sunil-laptop>
In-Reply-To: <aGVF8Gqzs2YZf1Os@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 19:01:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYjc2JurNAJyr1o03Mr7DJyc=MdHvbTsCsC76JR0suNQ@mail.gmail.com>
X-Gm-Features: Ac12FXwjgoj03UiKdGXfM8DuaJdwtG5xtG-ENxekbig-Cp5sM0uIGBwVeivKWu8
Message-ID: <CAJZ5v0iYjc2JurNAJyr1o03Mr7DJyc=MdHvbTsCsC76JR0suNQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/24] ACPI: property: Refactor acpi_fwnode_get_reference_args()
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Rahul Pathak <rpathak@ventanamicro.com>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:45=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jul 02, 2025 at 12:07:36PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 2, 2025 at 7:15=E2=80=AFAM Anup Patel <apatel@ventanamicro.=
com> wrote:
> > >
> > > From: Sunil V L <sunilvl@ventanamicro.com>
> > >
> > > Currently acpi_fwnode_get_reference_args() calls the public function
> > > __acpi_node_get_property_reference() which ignores the nargs_prop
> > > parameter.
> >
> > Which I suppose is a problem.  Why is it so?
> >
> fwnode_property_get_reference_args() documents as below.
>
> * @nargs_prop: The name of the property telling the number of
>  *              arguments in the referred node. NULL if @nargs is known,
>  *              otherwise @nargs is ignored. Only relevant on OF.
>  * @nargs:      Number of arguments. Ignored if @nargs_prop is non-NULL.
>
> You can see that nargs_prop is not supported with ACPI currently. Since
> fwnode_property_get_reference_args() calls
> __acpi_node_get_property_reference(), there is no way to determine the
> nargs from the nargs_prop currently with ACPI. Since
> fwnode_property_get_reference_args() is a common API across DT and ACPI,
> it is a problem for users.

So the problem is that if nargs_prop is passed to
fwnode_property_get_reference_args() and it is a valid "cells"
property, OF will use it to obtain the number of reference arguments
and ACPI will ignore it.  To make it work the same way in both cases,
acpi_fwnode_get_reference_args() needs to be modified to take
nargs_prop into account properly.  This is the key information that
needs to go into the patch changelog.

> > > To fix this, make __acpi_node_get_property_reference() to
> > > call the static acpi_fwnode_get_reference() so that callers of
> > > fwnode_get_reference_args() can still pass a valid property name to
> > > fetch the number of arguments.
> >
> > Are the current callers of acpi_fwnode_get_reference_args() going to
> > be affected by this change and if so, then how?
> >
> Good question!. If some one is currently passing both valid nargs_prop an=
d
> nargs with ACPI, now with this change it will start getting the value
> from nargs_prop which was simply ignored earlier. However, I see only 2
> combinations how fwnode_property_get_reference_args() is being used.
>
> (nargs_prop =3D NULL) && (args_count !=3D0)
> or
> (nargs_prop !=3D NULL) && (args_count =3D 0)

OK

