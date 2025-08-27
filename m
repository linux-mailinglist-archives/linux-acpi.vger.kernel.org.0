Return-Path: <linux-acpi+bounces-16115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A88B3879E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20E81B62EF5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F95225795;
	Wed, 27 Aug 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTHWpxXA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469514AD0D;
	Wed, 27 Aug 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311394; cv=none; b=LYmzcUp+5gfj84v/ly3RYnRJoJ6y8EsByg6N8UoP8nGMItlp+Zg/neiQ964m9WFlFSUile+IBvhbyrJrsIdIGvrre8T+jpNMx5AgTt8nYD2ZnaDUfJYF8WDQKNbyWvWvi1XwmTvqPGHhCLuBni7jcs7lX2AaXQ6FNrNxfBehwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311394; c=relaxed/simple;
	bh=zLiz6AkzyNnkBrQOVwv/VSA4M3l/zNcKpbwLcjJ+448=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqi7xQV7uhVf3fux4D6dsbhfYIJRLMU/tyS6mA3UuC0i3fV0g/qSeSrOBw6Ig9VoazB/ARl8+sTmCSch4uwp3ELARaTgAoPTy14h6BexMbhv7g6ZCX+dsqmBnCGBUK+jUS0Ij5z3nXdbHGqYLun6YBTxfv+7eneaFHZC508PInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTHWpxXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22068C4CEFF;
	Wed, 27 Aug 2025 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756311394;
	bh=zLiz6AkzyNnkBrQOVwv/VSA4M3l/zNcKpbwLcjJ+448=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jTHWpxXATY3CaEyQH+uS+P/ItI4kZnjwMDeObQFlhuk73fHfZTwT5HARLnzBL+vtI
	 14H2ZGWhQSzPX8gniBqdW7PB4a2cGecZ+Ch6rMI3pRrc7JFC0/jGo7fXOHrM7pX30H
	 FMRy/4NAQpvIXDVRRiED6LBV0F02Y0GYFctpZyDTC50whJ2Fyn3EJkzrYwSg8Rh5de
	 evn/2WyDsBmSszSpOpSN7OrQ0AsnbF4Yo0ZSB7jp9CzUU3QOXPD5GyO0BsRM/+Ni0D
	 Z/QFAZhmheC9D1Vu01RV1jNK8pbNjM/V3eD8A30Kud9jT2R3iyNybFIG2/FJ3p0LEn
	 SFS4Klj8qA6hw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afe84202bb6so437228566b.2;
        Wed, 27 Aug 2025 09:16:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsfVK2aI0J0uuDxwjeAzHubIW4MCQbB6Oog2au31hBNsV7mZQELGaVHf3SJsiAhVCLKvQMpU7t9WUf@vger.kernel.org, AJvYcCVEQ9RBHvb6RqXH4WF9LwEIKQk2JEt6nNklHbkIn3F8OXa9GCIDx3JdZwigJDN2IiZbPkXLx3/HB8nm0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8pl9/qbb6MgRlx/xFf77331aeTAteMWBh4g6kQGVh7waZRra
	RL4BXp06e5HzR9QY5HJEXJxHuCkpR54G+JDfuoF0f633pUKsgPjZ57qWLZd2MxLTurqOK6zhlP2
	D4iUBPy9S+O3SGlxTo50IBlzjB3DzSw==
X-Google-Smtp-Source: AGHT+IEXg6+7BprsV5EoZDhEEr6bgsBWXcf6QxNl0BWK2TTd4f7AIeyL6z6NHk7g97eiKGWG44PeeKjxlyiXe/1zEDQ=
X-Received: by 2002:a17:907:934d:b0:afe:ceee:87ef with SMTP id
 a640c23a62f3a-afeceee8bd7mr157915066b.46.1756311392573; Wed, 27 Aug 2025
 09:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822153048.2287-1-james.morse@arm.com> <20250822153048.2287-11-james.morse@arm.com>
 <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
In-Reply-To: <CAL_JsqKUSJjmyj-E6eduZt3S=x6v7VUR5JEJV_Ow6O-O49TgEg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Aug 2025 11:16:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDpEHBcWeCqxSiUjpyBs0gEJKVyyR70xJO56x-pYQHMw@mail.gmail.com>
X-Gm-Features: Ac12FXzE3A9FSJi0MT3IqGBLAftR8IWne7jiyyfQlU3jf16oWdruRH4E1uAnKzM
Message-ID: <CAL_JsqJDpEHBcWeCqxSiUjpyBs0gEJKVyyR70xJO56x-pYQHMw@mail.gmail.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com, dfustini@baylibre.com, 
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>, 
	Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, 
	Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com, 
	baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:39=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Aug 22, 2025 at 10:32=E2=80=AFAM James Morse <james.morse@arm.com=
> wrote:
> >
> > Probing MPAM is convoluted. MSCs that are integrated with a CPU may
> > only be accessible from those CPUs, and they may not be online.
> > Touching the hardware early is pointless as MPAM can't be used until
> > the system-wide common values for num_partid and num_pmg have been
> > discovered.

[...]

> > +static int mpam_dt_parse_resources(struct mpam_msc *msc, void *ignored=
)
> > +{
> > +       int err, num_ris =3D 0;
> > +       const u32 *ris_idx_p;
> > +       struct device_node *iter, *np;
> > +
> > +       np =3D msc->pdev->dev.of_node;
> > +       for_each_child_of_node(np, iter) {
>
> Use for_each_available_child_of_node_scoped()
>
> > +               ris_idx_p =3D of_get_property(iter, "reg", NULL);
>
> This is broken on big endian and new users of of_get_property() are
> discouraged. Use of_property_read_reg().

Err, this is broken on little endian as the DT is big endian.

So this was obviously not tested as I'm confident you didn't test on BE.

Rob

