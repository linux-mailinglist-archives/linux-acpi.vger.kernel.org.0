Return-Path: <linux-acpi+bounces-18837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92CC54712
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32B93349BCF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17229DB64;
	Wed, 12 Nov 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys9ZEhnT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFA263C9F
	for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2025 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979150; cv=none; b=AtVGZWJCfqJY7GuvIhTBm/vjnAd4aGQRifFxP9a5zZ7VfoH8SUKWaNudhUjmlM64oe7vFL37Jup6H8QTODFTSYULZUVqBvZdxlhrlxXYaFqGao2DoddX7q3lrOUaWs7OltoPotdlK506RP8oXxFLx0p9gFlqqkAh9QKmF265Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979150; c=relaxed/simple;
	bh=cgGge+dwMmPrK+ciZBU6rz22dQLRcQpKCH3b3eB23F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4sBA2cfMoTtj143EyE2kTWxhcjJ8OjjeZNGWjWydFI/JRTszBKcHZtAlsZThLLCAKXK0oJpF7VXCXNWt41MRHexAov7v/GxBD1aWS1sWgaMoy/bj2e9s+kYadGPll8QmPPbsaE6dN2gYhoNapNQGrrRAz3Ny+BL8DeprvpvKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys9ZEhnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22DCC19424
	for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2025 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762979150;
	bh=cgGge+dwMmPrK+ciZBU6rz22dQLRcQpKCH3b3eB23F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ys9ZEhnTRUU/WQsJyDqtH4tu0XL4CkeJy9WLUw1LRHhc78hs6eI1hGeh6Q7qGegrk
	 JG+X35ejUuMFETs/ez6McPTFUniBbfr43nGMWiitG0N8TexDkyOnOGvkg4ELxvi+Fm
	 MPngDYBgSgL6Cr0bsZtfxkbswglJBXbcqmZ1iarSVlJ8w7UCZyqj1iz0RNdZErBjC0
	 Vv0E1m97SlSrame1QgaFqan2t7rHUXp3lt3kz10h0eKsRxE3xdN+G/1iaAhTlGE3fI
	 y9E/peOoePlqdYY+FGbpPyGb7UIx8lgQDdWawBwsA/0aK7cH8BadB7iVs8FzKXrrEK
	 BsZanNhF3Ht7A==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65704dae718so57411eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2025 12:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZ5LITTjqaUIjinU73FHCaL1WbcAyjsW6i5PtwF1dZjAx62eGokX7+48NmIYIO9HAL2bbPSrZCd3zt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Le8z0lIn/KQQWA4t2mAAF4UhsWXSYJpV+SVnyVk3eGxmMmjD
	uF9GXvuLcLlApGtZiEDwLHbPehLd0cH4XwiTQAReBJM67NavL0rCEKDN24IhKtiA5UkycgQLPL/
	/Dr0fMkH762hskNCgyB95A7Rls2hZOWw=
X-Google-Smtp-Source: AGHT+IEKwzEfElibNCzBiXdHUCqix10pctigzcdu3yw3bAN4/xs6NPsBv5VxA5wX/pqJykBBwUm9XCNPfQC6Jukronc=
X-Received: by 2002:a05:6820:308c:b0:656:9e1c:3a6a with SMTP id
 006d021491bc7-657161afa92mr1698124eaf.2.1762979149224; Wed, 12 Nov 2025
 12:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111075000.1828-1-vulab@iscas.ac.cn> <CAJZ5v0gs8nor-fgwcY8x4bkd9Swiu8yJn9296U7RHRnQUYDpdA@mail.gmail.com>
 <aRSczeIXvymTQN3D@kekkonen.localdomain>
In-Reply-To: <aRSczeIXvymTQN3D@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:25:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtmBGOP2fBPRJr7r38iboHCa9ZyLR_smBmBNzQD2jxnQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnA7q5-ZmGsQRkP6w_V7WbKpsTDmpy4nagzAHslZceJDIC7BER6lZexzlI
Message-ID: <CAJZ5v0jtmBGOP2fBPRJr7r38iboHCa9ZyLR_smBmBNzQD2jxnQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:42=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael, Haotian,
>
> On Wed, Nov 12, 2025 at 02:48:30PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 11, 2025 at 8:50=E2=80=AFAM Haotian Zhang <vulab@iscas.ac.c=
n> wrote:
> > >
> > > acpi_fwnode_graph_parse_endpoint() calls fwnode_get_parent() to obtai=
n the
> > > parent fwnode but returns without calling fwnode_handle_put() on it. =
This
> > > leads to a fwnode refcount leak and prevents the parent node from bei=
ng
> > > released properly.
> > >
> > > Call fwnode_handle_put() on the parent fwnode before returning to
> > > fix the leak.
> > >
> > > Fixes: 3b27d00e7b6d ("device property: Move fwnode graph ops to firmw=
are specific locations")
> > > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > > ---
> > >  drivers/acpi/property.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 1b997a5497e7..7f8790e8dc4e 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1714,6 +1714,7 @@ static int acpi_fwnode_graph_parse_endpoint(con=
st struct fwnode_handle *fwnode,
> > >         if (fwnode_property_read_u32(fwnode, "reg", &endpoint->id))
> > >                 fwnode_property_read_u32(fwnode, "endpoint", &endpoin=
t->id);
> > >
> > > +       fwnode_handle_put(port_fwnode);
>
> I'd add a newline here.
>
> > >         return 0;
> > >  }
> > >
> > > --
> >
> > Andy, Sakari, this looks like a genuine fix to me, any comments?
>
> Thanks for cc'ing me.
>
> On ACPI fwnode_handle_put() is a nop, and presumably a parent of an ACPI
> node is an ACPI node as well. So this doesn't change fwnode refcounting b=
ut
> is nevertheless a good thing to do for API usage correctness.
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

OK, applied as 6.19 material, thanks!

