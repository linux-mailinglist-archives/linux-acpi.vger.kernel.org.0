Return-Path: <linux-acpi+bounces-10179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02239F644F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 12:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EA1169CA9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FCF192B94;
	Wed, 18 Dec 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu9vmsQ9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A727726
	for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520085; cv=none; b=NLvwG6BnBOmkG0cvVdbufsgHJNZK5eD4KU07PC2ATj7HX86v5pxAWF2FxC7uXhR+6uiIofspSz3aIBNI7znEzkveWVj6Ttr0caEorA83IwAtiBMWf2kYvH3jRhjh8O0l5G2wjK4SYNPaQy7xpZ4bMipsEmhqv90xIsBAdauq1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520085; c=relaxed/simple;
	bh=SSgeIiqb2llNAcnpcNr8PPoxSXNJwBC0untgbTRRamg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdvmmGTJXs4TexAxizWusQoRqK9bFeB4EX/rrG7hKLg3U30+KUwQh+rVHaOhMriK82yd5x5yhfId0wYy3ssg4EYwT01S7cq+EUonNrAv0y8TrFxsS5XvHQKxfO3XKUQ5npOvAbW16Lyb/LOvc62If+kq+HHVKifXd17H+314oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu9vmsQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BBC4CEDD
	for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734520084;
	bh=SSgeIiqb2llNAcnpcNr8PPoxSXNJwBC0untgbTRRamg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gu9vmsQ9gwjr/iHjYvSqwbN8K6F84GqTaKW/rK/8CtFnsEgPHr4QaSzpLKFTwtci2
	 YdkcSQRtmp7gENRkx4ZWSi9nrESb03ctL/KfTJXzA3/453YG073+1zMTXJvs1rxMWn
	 onHJnsd7rpbBWlL1EajvO4qD061YFWPDH66Udv6WM5LzJGoCA3bg75lM58JkbnUipP
	 14Ur9rek83RU6MGKEUPQDCtLrdP8w2QWgqGxKGjQ8cFOgApeVusPlBJP7hMwNxLhnx
	 rv6VqNPhtuVLBca8YZk0qMdAFL1sLwvFwwBwgf36CNgWI5kZJNzjDgQillzZ/gzSX+
	 uM+ekNS139P2w==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb3c143727so330695b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 03:08:04 -0800 (PST)
X-Gm-Message-State: AOJu0YzfY5opCdNVzP4jPE1NPIjl/HLkf1XX5ur/WahF36NMT4NH6Lu0
	Zg4cH5bj7N2kWZbd/zxzYSIjCGfSdm+ZUVkD0cXUylRSPmXm4sKlo+nFw71FYojTTxth6YKAenR
	iCBdOroqIqjbD9XatLovm70K/ZoA=
X-Google-Smtp-Source: AGHT+IEo/hrettq1lYQOOm8sOCsgvutQS9ZvUzZNGm43l1A/Sworn5sPDy10Q69njRH06GIijgoFU40fVsWmOQob8Ao=
X-Received: by 2002:a05:6808:1409:b0:3eb:4189:4431 with SMTP id
 5614622812f47-3ebcb3d4112mr3049915b6e.13.1734520083917; Wed, 18 Dec 2024
 03:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20241218091622.914266-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 12:07:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>
Message-ID: <CAJZ5v0jRLJEUS=-6Ciuy1O7KG2B8sSvKgtzcK+85umbefLU=UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Consider data nodes as being available
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:16=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Years after fwnode_device_is_available() was introduced, new functions
> making use of the function on data nodes have been added, such as
> fwnode_for_each_available_child_node(), it becomes apparent that returnin=
g
> "false" for all child nodes on ACPI wasn't a workable option.

Can you describe the problem in a bit more detail?

> On DT side most access functions, even those without "_available" part,
> did only operate on available nodes. That wasn't the case on ACPI where
> only device node availability is known explicitly.
>
> Thus from now on, return true from fwnode_device_is_available() on all
> ACPI data nodes.
>
> Fixes: 2294b3af05e9 ("device property: Introduce fwnode_device_is_availab=
le()")

Do you want people to backport this patch?

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 80a52a4e66dd..1ee81e771ae6 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1492,7 +1492,7 @@ acpi_graph_get_remote_endpoint(const struct fwnode_=
handle *__fwnode)
>  static bool acpi_fwnode_device_is_available(const struct fwnode_handle *=
fwnode)
>  {
>         if (!is_acpi_device_node(fwnode))
> -               return false;
> +               return true;
>
>         return acpi_device_is_present(to_acpi_device_node(fwnode));
>  }
>
> base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
> --
> 2.39.5
>

