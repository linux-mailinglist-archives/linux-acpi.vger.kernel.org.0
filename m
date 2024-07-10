Return-Path: <linux-acpi+bounces-6840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60F92D0F1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F4B25F2C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071319048D;
	Wed, 10 Jul 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHeJP201"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE17D412;
	Wed, 10 Jul 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611850; cv=none; b=pBWwx4a9bch8SctQFxieW64xCUnPKLY6WZIXju5uchrPbCFgM07wpRAQgAGLPWSYlEeKummPYBsTr5WcLu8Aso4zAGycBgj1darW5kBLsose2xvoXTsspGESYRSFWHsBgqJHeTfG0DLBKVkZ4ajEYmu6nX5yl5sVT130hUZh1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611850; c=relaxed/simple;
	bh=GInUImvgEURMx4uz6lxWpkUxGam+DojfjB0upQp954I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCDGU94qDVbrjLz2lpAsT8FGzjkGQb0CN9O5OgosHSZvfEnEp3nIIp4zM2nWjelD0+1IoNyHyAcU9Z6SpTdVugS+M04VkyXAb8OadZhw7tBXCmSurrjC3PtfoPe4+FW6AQMMBEWLjv5X2E5nmvl/zaaOBBXAAavRYy26EYimUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHeJP201; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82259C4AF0C;
	Wed, 10 Jul 2024 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720611849;
	bh=GInUImvgEURMx4uz6lxWpkUxGam+DojfjB0upQp954I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHeJP20177RaNg/Osm1PsRmOQe4sLfjFTV+Q8QbjpWV8cZpFhSHgmTPGt3CmnrS/7
	 FEwQ5rgOgY0C3eKDCS5ll/NxbTPkiktT0zUDlMc0zHd7cWKbIkHILzYXF6y8Y7WM7X
	 GtcH/vZXVLBfBpkztAjACjtTqbB7WUzPO9K0QfNSyFOWKLHA0NKhZvavi0BlYnYjfi
	 pnMRHZUP5Ir/lUbQLOUk/SCjWIHp3BDkAz6bTVRpwDtJpyuW0iNVloPP4t0cEeetDg
	 63uaMu+VBT5pB8XxwM8SsgbffF2Rt3r8YLhtt4IkvBJq8H2pVYNi1qKfKEcPx+bwjH
	 GJuSCIwZMxT9A==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d92693f63cso349400b6e.0;
        Wed, 10 Jul 2024 04:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU4Cp/nsSAL6MNdCWFWkweRKGQDAxZ/WGtmh0c/lAAk0Lg+A3ix83ZYVMlzPVe2ROx1wcsHMXjW/rIF0or+7A9aOFw4/TwUndLmnlPHScLvPNe7GFkQKAOtu/qCd+2KP+Q1OVd/RvmebuoDhlfzQyYJ22T+51yrT+Gin9ZJAqaow==
X-Gm-Message-State: AOJu0Yzjf0qJm9QJ8jDvQUKEeac6rTyibhOhjvdopFfo8nBhdEbU37ow
	LCMCrO4a56/f8mc51AawKNhFP54VBHKGKx0a9KdJeLeHaoy665SAO7veFrTToYs+cJhmmI9VzlM
	EsME6bJZvrctZv/njs6khjh+cEws=
X-Google-Smtp-Source: AGHT+IFONFlDGqACq5VK0QgfJgq8g2wY016Po2bpccj0rG2PJVlPpT7CNzACWLDaebZTHByYi3xDIVbGmOy+25VQLBA=
X-Received: by 2002:a05:6820:2c05:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5c7b58743aemr1328361eaf.1.1720611848685; Wed, 10 Jul 2024
 04:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 13:43:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>
Message-ID: <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ACPI: sysfs: manage sysfs attributes through
 device core
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:38=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Simplify the lifecycle of the sysfs attributes by letting the device
> core manage them.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Add fix to validate buffer type validation (patch 1)
> - Drop usage of devm-APIs as these are unusable for unbound devices
> - Evaluate _STR on each sysfs access
> - Link to v1: https://lore.kernel.org/r/20240613-acpi-sysfs-groups-v1-0-6=
65e0deb052a@weissschuh.net
>
> ---
> Thomas Wei=C3=9Fschuh (5):
>       ACPI: sysfs: validate return type of _STR method
>       ACPI: sysfs: evaluate _STR on each sysfs access
>       ACPI: sysfs: manage attributes as attribute_group
>       ACPI: sysfs: manage sysfs attributes through device core
>       ACPI: sysfs: remove return value of acpi_device_setup_files()
>
>  drivers/acpi/device_sysfs.c | 196 +++++++++++++++++++-------------------=
------
>  drivers/acpi/internal.h     |   3 +-
>  drivers/acpi/scan.c         |   6 +-
>  include/acpi/acpi_bus.h     |   1 -
>  4 files changed, 89 insertions(+), 117 deletions(-)
> ---

If this is not urgent, and I don't think it is, I'd rather defer it to
the 6.12 cycle (that is, I'd apply it after the upcoming 6.11 merge
window).

Thanks!

