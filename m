Return-Path: <linux-acpi+bounces-10200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304BF9F8582
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FCB1895CD6
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F971B3933;
	Thu, 19 Dec 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iaef0Q69"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7D1A08CC
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638819; cv=none; b=qhFCYGyPMs1IcOElhbsAZhF256p22ZjGMfXl3VFuW1ZGlWpYFgFJ9TdbkyVV2E8av0xx94WK2WJ7Dpi/fgtSDz39N1zxRVzDsgoW4KSBwYbb0BhSY+1QwSshhIdZYSsn+pgEtjdK/AYrKJSoWROsXBEEPWD1pA8N1y+tRt8HUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638819; c=relaxed/simple;
	bh=glThAdQKp1WcbTarMaMx/0GycW2Us912gcPRgCtA4/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUlxoQRHc0GBOTWHO5h8ISkdXZVrokT9IYDgqA9hTVn8/r7po+u4qh42PKUpHUUJH6lZGGlj4dmx4IS4TcT88F9+sC67BIOErway0WpRF8X+Dcp+5h0TVLjw97tJrn/Q4pz/UdKJdUVxqLjrsgo2nTtjFYyHDmkE0IvgBUhnRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iaef0Q69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA427C4CED6
	for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734638818;
	bh=glThAdQKp1WcbTarMaMx/0GycW2Us912gcPRgCtA4/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iaef0Q69gwrgQXRkBKK86bSfcCdwzFE11Tae+e1ChoNw8ZS5vWJa4W/jEnFGOzyGg
	 r/JgDggHQCw/n6QtJf7aRe/MBAVPGNtyKaebGFFepZIhVldbliv9N4kS9Hz9NgMm3v
	 sEFUy0l9vkQsil3yrvmpXoRnXk8JPiqx1+CDNTTwxWqoOa95ZnAgvwOuFgy7HMuQv0
	 GcKV+C4/RA/hh+nhUDN1td1H/q2sWJiQ/UDnQw5pBPwyhsDRWNjFZmTEIDBFxwBpPP
	 yvS9Ois38k1YYWCsNGqL5QfXo4hBgEKrJbuxRoclBknU/Xptl7P+0+In9wN+OGOBW2
	 3PZTMC7M6dujQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29fc424237bso553347fac.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2024 12:06:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yw98B01H0L3ASRRnbV1g2ETh4rzVTf5KWmqIcOyAcV7UApnvjeC
	xy7djijuac340/LYMNdxK7TUQSo/hlIpBjmsOZdpib+4z1f8tCqEF6SHmq0ATt3+DvSDDPdTi0Y
	QBcqePdaIvwB+DwLwiu2o0vbGbJo=
X-Google-Smtp-Source: AGHT+IH5+HUwx/o7s384TGTieuoH/zte9bj4GqV5A26ugGQaiRzylSGnFwanCfBuWBUHtKhjXgVb12NvsXGDTksj2vs=
X-Received: by 2002:a05:6870:2e0e:b0:297:285e:f824 with SMTP id
 586e51a60fabf-2a7fb0a9205mr197945fac.10.1734638818133; Thu, 19 Dec 2024
 12:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219152148.975622-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20241219152148.975622-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 21:06:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCOPNYN0ReW53dX8RBO3otsSzEmbSoX5ESSrT8oGQpeg@mail.gmail.com>
Message-ID: <CAJZ5v0jCOPNYN0ReW53dX8RBO3otsSzEmbSoX5ESSrT8oGQpeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: property: Consider data nodes as being available
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:21=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
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
> However, on the DT side, fwnode_device_is_available() returns true for al=
l
> nodes without the "status" property which are analogous to the ACPI data
> nodes, so there is a difference in behavior between DT and ACPI in that
> respect.
>
> Thus from now on, return true from fwnode_device_is_available() on all
> ACPI data nodes.
>
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
> base-commit: e14d5ae28eb28c5edef53bd648037d2bb4fce1b3
> --

Applied as 6.14 material, thanks!

