Return-Path: <linux-acpi+bounces-5642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F58BE161
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0007128255D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB90156232;
	Tue,  7 May 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzP9AeLY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D48153812;
	Tue,  7 May 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082541; cv=none; b=tre4YSIrzaKjSTIgU+QUJpF0n+fmovr+nPHCOatNfzLMJd6COi0JCRHCPOEnLcoOGe7fg2yRlHekZYAMR1v35DFM/o3ZMm7Xg08uqvtrs5WHB//yvRniPqGfkF1IfYYRtEvUwxW0I7FX/LMF4KYcZ+TxjPvjKVUURzEnLEaKARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082541; c=relaxed/simple;
	bh=l46mjhyiRGZnsJnxurBGbw9J+XDezpuskZK4nvwuBCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVO2lZteaqu8NIYAssOce+sv9zaY5spqAZpXdodYdWpo9qE0PSvSxvDoE5xWhkSTWr55DJbwX0JjFScgsOHtr7TifEU7QY196aIyVpZcVAOh2wFS+HWycF98bxtyfP24TEf2N8KznI7ZThQRlerAyE1lplyD81FI97UuWSZtv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzP9AeLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E568CC4AF67;
	Tue,  7 May 2024 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715082540;
	bh=l46mjhyiRGZnsJnxurBGbw9J+XDezpuskZK4nvwuBCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nzP9AeLYA6p3W9EelU4oswzDMMPF/yc4VpQxUmAsmTw1mTNUOo06+51wbxrsJWMEs
	 deGyBOL6Reh7fIJn7Dz5FAqlHTG+I2fgM9V5TqqU1RwUrZwOClG3wwCPtEvkeNxWR8
	 slHsrj4kq7m0RcbGwcOBGdl8+RJf+/TjnXJOC3wnxVlqF36PUNNGGXBRyVRL4d4Y6n
	 Q9uaHWPP0loI85XURzUmgWXZt49ZGAusQGm3QW/HCVEYPBS2/2/mv6zxUpg4Q5kIzE
	 taXSd105jId1Yn/MQvQ0U+dDNMtdkxa2HV5t7dPyRKr6+rMB56EH2OvUnTuYqtFi8r
	 LSO3JKUsdiAXw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac4470de3bso871386eaf.0;
        Tue, 07 May 2024 04:49:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMfirTJaqTImPNIi5MQ800RcoA4C7cnSaOinUwUZmTJjXoGQefC4BmqNaDNlSzX7QlaKdKSXxTW4eGACsxJChgpCMWeAwj00LZ4XLwA3Ux6LEC/8U3qxaN5EJ4WvPJSqfRMHLatpwiEkquTJC852U+5V8WIyugoRN+VGjuXs5dFHBfmw==
X-Gm-Message-State: AOJu0YzIwJI8PtTPpAwipLmI65j0cnbgGGhUQUJe0kxZR6a8N0urnHRI
	uWzQJQF1LG2Y0UgmNyailAuIpxij+JgCRXeyoh0E0Dihfl6kUregO5yx3plF7GssKNfD09CTPK3
	h2TZq5gbNuwzLI0Ul1IYyoJ5JEAM=
X-Google-Smtp-Source: AGHT+IHKm+n8JrihalvSOOI3GVpZIpZ0FPm7U1eIAdmMyIBoURUnJJoIV3KskUgjHuc8gidPhYjX3eejTKtaMdtuTks=
X-Received: by 2002:a4a:2511:0:b0:5b2:f29:93f0 with SMTP id
 g17-20020a4a2511000000b005b20f2993f0mr5312891ooa.0.1715082540247; Tue, 07 May
 2024 04:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502131012.2385725-1-rrichter@amd.com>
In-Reply-To: <20240502131012.2385725-1-rrichter@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 13:48:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHqbFyCARK9+OegRjdFNpq+nX+QMb+gF1w9333DOXe0g@mail.gmail.com>
Message-ID: <CAJZ5v0hHqbFyCARK9+OegRjdFNpq+nX+QMb+gF1w9333DOXe0g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] SRAT/CEDT fixes and updates
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:10=E2=80=AFPM Robert Richter <rrichter@amd.com> wr=
ote:
>
> Some fixes and updates for SRAT/CEDT parsing code. Patches can be
> applied individually and are independent.
>
> First patch fixes a page fault during boot (fix as suggested by Dan).
>
> Patches 2 to 4 remove architectural code no longer needed.
>
> Changelog:
>
> v7:
>  * added Reviewed-by tags
>  * dropped printout patches (#5 to #7)
>
> v6:
>  * rebased onto cxl/fixes
>  * fixed 0day build errors in patch #1:
>    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/x86-numa=
-Fix-SRAT-lookup-of-CFMWS-ranges-with-numa_fill_memblks/20240429-205337
>
> v5:
>  * dropped: "x86/numa: Fix SRAT lookup of CFMWS ranges with
>    numa_fill_memblks()"
>  * added: "ACPI/NUMA: Return memblk modification state from
>    numa_fill_memblks()"
>  * conditionally print CEDT extended memblks
>
> v4:
>  * updated SOB chains and desription
>  * added patch "x86/numa: Remove numa_fill_memblks() from sparsemem.h
>    using __weak"
>  * Reordered patches to move CEDT table printout as an option at the
>    end
>  * split print table patch and added: "ACPI/NUMA: Add log messages for
>    memory ranges found in CEDT"
>
> v3:
>  * Rebased onto v6.9-rc1
>  * Fixing x86 build error in sparsemem.h [Dan/Alison]
>  * Added CEDT node info [Alison]
>  * Use pr_debug() for table output [Dan]
>  * Refactoring split in 3 patches [Dan]
>  * Fixed performance regression introduced [kbot]
>  * Fixed checkpatch issues [Dan]
>
> Robert Richter (4):
>   x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
>   ACPI/NUMA: Remove architecture dependent remainings
>   ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
>   ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
>     acpi_parse_memory_affinity()
>
>  arch/x86/include/asm/sparsemem.h |  2 -
>  arch/x86/mm/numa.c               |  4 +-
>  drivers/acpi/numa/srat.c         | 82 +++++++++++++-------------------
>  include/linux/acpi.h             |  5 --
>  include/linux/numa.h             |  7 +--
>  5 files changed, 35 insertions(+), 65 deletions(-)
>
>
> base-commit: 5d211c7090590033581175d6405ae40917ca3a06
> --

Whole series applied as 6.10 material, thanks!

