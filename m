Return-Path: <linux-acpi+bounces-14452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47403ADF648
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF233A8655
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BF2F94B1;
	Wed, 18 Jun 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa4mfX0y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AC2F94AC;
	Wed, 18 Jun 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272710; cv=none; b=TT/jQ+XPBTSPzCe5YSE5qZy8ujwBNtKy0rm4uidpgDVwVtP/byBY8soe6G6IgZ5r8Z3SLgWQK6Y98T112RXNfE7zcjAGWA8ORHAMocipY9vTk27V3MJOoCknzpuCafxfj39klCV6Zvl3af0EYbGt1xyI+bk0pDsdcUnVfgH4vew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272710; c=relaxed/simple;
	bh=DkX7pN/NvzJ8o7cOYHY8frH4OFrO1vDDFuOeN+VP3v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5iS19Uxb/1o6qwg0dGBFiq2kJ/vJeDPdunjV7IJnTO0XmJfBcBMdgVDalNceAFScS7ypDmoE6/PQDzX22vGbY9ctcnkQ70rqehUMMAemhrAOyria22EZc9cZeSQw5NukLujlp6fo+P6Nn/azbIyUDyWq4T6UnLQylTYt3VxySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa4mfX0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32521C4CEF5;
	Wed, 18 Jun 2025 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272710;
	bh=DkX7pN/NvzJ8o7cOYHY8frH4OFrO1vDDFuOeN+VP3v4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sa4mfX0yo6cuMCyFMUWziAs3z3IyvaXIorRLUa3wiH5fCr9HZACtS6CmmfIn3M1dE
	 y49TwV+xtJtFgbtnObOoORjlmM8Q/rPokwPVh138hleKo1IhG9P1XyfRqUrlgoHt0e
	 EU4d8uq3sNYCHLz69GX1POGg4Jk45//XBjJM4mIfs5FnQKIXeTVyMcRBoa3ewvJn6F
	 doH5LYQvBt3gu7EksneW26gBGq0nauVt7r7MxxfrBECN+LYQAoJIfSlFyeI8Ufg/93
	 Qm7IpD5/eIskOVzS1rpvlPOIIW0OH4CCq2upuj9IT4nF4v5xNuykRMaiN02L93Rixt
	 RgAmi7T8emOKw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a7322f081so1482807b6e.3;
        Wed, 18 Jun 2025 11:51:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUheRI2Mbp1ppcIWcYUv7h7XmCvdO9I2u+48sKwGk/8zMnD8yG9anidNWKunqX+K1rFUek20lJHJ03B@vger.kernel.org, AJvYcCUr9rc9pB3njDuNZk1dt1GS3MFGCMuKs59PBbJhZNY/WbS1zQgp7IVorXQVtWvbKyohkI6UUy6OmI3m8OZnqAEw@vger.kernel.org, AJvYcCXD9YKASsIvatKH+Q3Plfk0ekusAXQ94tD6CCU4gXNoJ8u5dl0tehSLiQFmh1UUojkIg8qLz6Q4JKkZ/XN1@vger.kernel.org
X-Gm-Message-State: AOJu0YykSJai2XJKw4oJzVMMM1miEWZF961cakGYjm8pHDdNUZcMn9ae
	dvO/+jMEYWCItywtkbeYT8KEuzy/wXt35iHtqEIw/kRBRhyC6mdpH7u/PWIkKeTNzmog8iFbLvl
	pXQHBR5RJoAZwMqVc6gR/AV4FeB41XuY=
X-Google-Smtp-Source: AGHT+IH+BfFcUYsoMcXTCwABUQpNamKfhrnvNzmfY/k4kgroLu1trCO3pgHGWepNyD5Ol97gAYjGjDmqO5to1X3XfDw=
X-Received: by 2002:a05:6808:3cf:b0:406:6fd3:ff14 with SMTP id
 5614622812f47-40a7c178183mr8352320b6e.25.1750272709405; Wed, 18 Jun 2025
 11:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
In-Reply-To: <20250617193026.637510-1-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 20:51:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsuD8rQBCt1fwb-bpPF54VHu3RH2x+R4-XTpEHFDmUfg@mail.gmail.com>
X-Gm-Features: AX0GCFsm4q6z0lY2BrgnkbNLfTiTPtdlGrsevaoUjNQiJKmI4hDs1CQBe9bto0o
Message-ID: <CAJZ5v0hsuD8rQBCt1fwb-bpPF54VHu3RH2x+R4-XTpEHFDmUfg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Enable EINJv2 Support
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, kees@kernel.org, gustavoars@kernel.org, 
	ira.weiny@intel.com, Jonathan.Cameron@huawei.com, viro@zeniv.linux.org.uk, 
	sudeep.holla@arm.com, dan.carpenter@linaro.org, jonathanh@nvidia.com, 
	sthanneeru.opensrc@micron.com, gregkh@linuxfoundation.org, 
	peterz@infradead.org, dan.j.williams@intel.com, dave.jiang@intel.com, 
	benjamin.cheatham@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:30=E2=80=AFPM Zaid Alali
<zaidal@os.amperecomputing.com> wrote:
>
> The goal of this update is to allow the driver to simultaneously
> support EINJ and EINJv2. The implementation follows ACPI 6.6
> specs[1] that enables the driver to discover system capabilities
> through GET_ERROR_TYPE.
>
> Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#e=
rror-injection [1]
>
> V5:
>         *Users no longer input component array size, instead it
>          is counted by parsing the component array itself.
> V6:
>         *Fix memory leak.
>         *If EINJv2 initialization failed, EINJv1 will still work, and
>          probe function will continue with disabled EINJv2.
> V7:
>         *Update component array to take 128-bit values to match ACPI spec=
s.
>         *Enable Vendor EINJv2 injections
>         *Moved component array parsing and validating to a separate
>          function to improve readability.
> V8:
>         *Update UI to use single value files for component array.
>         *Update links to point to recent ACPI 6.6 spec release.
>         *Updated commit messages and documentation patch.
>         *Dropped the first two patches as they were merged via
>          ACPICA project.
> V9:
>         *Fix commit messages signed-off/reviewed-by order.
>         *Fix sparse warning by defining syndrom_data as a
>          static struct.
> V10:
>         *Use defined value instead of hard coded for component
>          array size
>         *Unset EINJv2 flag for EINJv1 injections
>
> Tony Luck (1):
>   ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome
>
> Zaid Alali (6):
>   ACPI: APEI: EINJ: Fix kernel test sparse warnings
>   ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
>   ACPI: APEI: EINJ: Add einjv2 extension struct
>   ACPI: APEI: EINJ: Discover EINJv2 parameters
>   ACPI: APEI: EINJ: Enable EINJv2 error injections
>   ACPI: APEI: EINJ: Update the documentation for EINJv2 support
>
>  .../firmware-guide/acpi/apei/einj.rst         |  33 ++
>  drivers/acpi/apei/apei-internal.h             |   2 +-
>  drivers/acpi/apei/einj-core.c                 | 374 ++++++++++++++----
>  drivers/acpi/apei/einj-cxl.c                  |   2 +-
>  4 files changed, 342 insertions(+), 69 deletions(-)
>
> --

Whole series applied as 6.17 material, thanks!

