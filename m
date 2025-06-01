Return-Path: <linux-acpi+bounces-14042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA5AC9E57
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A7718969E8
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 10:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388201A3175;
	Sun,  1 Jun 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cl1G10K4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA276025;
	Sun,  1 Jun 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748773585; cv=none; b=B6h9XG2A2BnrbcFJEzcbcE8DaMU+yojoGJYsELJsLOZy2oGZ4u97DNO/MoEt2/Hsa618+UiS0XZYPlVV9IblddkIJ/U5olGefCYqpRNID379HvOt/TiuPiYkLqNEyya4Ox/EjRntGl5Nl0kK6mKED9WSo9iWYZK4A3uRf8GRyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748773585; c=relaxed/simple;
	bh=Bmo7ipxl3L6iPB/EfZHYxh9n0+XfLJTO2vLZ9RBxReE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOIDx978sv7bUr0qStsnuz4msZjPy3w6VTcJhE2I3AIt5QbLsG1INxm74qaJc3Ub/+4poRaYUHsyCBacl9Pg79koPtMNRoNlRnRF7MhBJkRfZIZNs5K470GZEmXFe2FPIn6J1KGr7KpEOmtKmP4YtgP/TvOrXgn/yymRot2f4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cl1G10K4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E992B40E01B0;
	Sun,  1 Jun 2025 10:26:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gtcQpti0-juV; Sun,  1 Jun 2025 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748773576; bh=X2hdjNqzaXawS+C1EkrP1A41VrUp5qnQPvrxqGdIiL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cl1G10K4dhDyphQmUYRagU7FdFQLC70NYOjElY8xTnAMX1Be6lpPnybz7QNQZTAl2
	 3ybzELP0AZG+o72zs7+E0KXEH5+mD4XC+srlDxCIecrmwqxF6Nu4YYaYUvtzRRaknY
	 PhQf3XR4S13o86K3hy1N2PHgi4uWI+s1eObUD8yzvvoeM4bW6893pViKGMuUGS7uhx
	 c5USnTkeji0KbccXh7XP/lplV4z7fuCeFOrL/9MlRQdrSlMowWlJy1kSdhxMvjxKVA
	 kdeE/Ra9tBFXb/fN3MZsdpVPjG5JnAX1BFyX7FvvUkgfrPz8dhhhJlXon2YFDaww+L
	 uzlualxnlPfsetlSuv2jvDR6VYwliK8gx/UD4WUa5upmFQLGC/Ym1LpzFCyB+mVyMb
	 W36Pcf1sWKlM9olwiIIDVoX47PSS9m8wIXsqBGqDkB47o1opg/enjjHi07d1yAYlCj
	 cgaCtN4E4c4hrVB/+Vf5RhbNb7leyAJfULoeAir7zcNZwEhUYNyPjyl/P/vIYdn9nB
	 5x1IB+4YNzrtcBGdHsFSKlAfxraNRHZ2dRXxFz/+281BBjGlpKl4cfu4HXGFqsjY4r
	 Ap/+pYv883bm51C9UJm+8gKdUpQCvY6XjmU7Gw6vPTQpCc4xo94t0A3RDtWqTudTch
	 Htd+RuMYg2+Y08VWuM9CdKD8=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 99ED540E01A0;
	Sun,  1 Jun 2025 10:26:00 +0000 (UTC)
Date: Sun, 1 Jun 2025 12:25:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
 <aDuBjopy_nE9A-ph@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDuBjopy_nE9A-ph@agluck-desk3>

Some questions inline...

On Sat, May 31, 2025 at 03:24:14PM -0700, Luck, Tony wrote:
> EINJ V2 allows the user to perform multiple injections together.
> 
> The component_idN/component_syndromeN pairs of files direct the
> "where" and the "what" of each injection.
> 
> But the kernel needs to know how many of these pairs to use
> for an injection (to fill in a field in the structure passed
> to the BIOS).

The kernel could realloc on each write. Or we could allocate the struct to max
elems and trim it before passing it down to BIOS.

> With EINJ V2 the user might want to inject to 2 locations with
> one injection, and then just to 1 location on the next.

Right.

> Zaid Alali's version took the approach of zeroing the input
> after each injection so the user had to start from scratch
> for each injection.
> 
> I wasn't fond of that because the existing Linux EINJ interface
> saves all the paramters allowing the user to repeat the same
> injection by just runniing "echo 1 > error_inject: over and over
> (e.g. to force a soft offline by injecting multiple corrected
> errors to the same address).

I agree with you here. Linux sysfs, etc interfaces do keep their values
usually.

> User interface options:
> 
> 1) User can zero out the component_idN/component_syndromeN pairs
> that they don't need and have the kernel count how many injections
> are requested by looping to find the zero terminator.
> 
> 2) Kernel could zero all pairs after an injection to make the user
> explicitly set the list of targets each time.
> 
> 3) User provides the count vis the nr_components file (perhaps
> needs a better name?)

Yap, agree that the name is not optimal.

> 4) Something else?

See above.

User can inject into each component pairs file and the kernel can put that in
the tracking struct. So you have:

# echo 4 > component_id0
# echo A5A5A5A5 > component_syndrome0
... set other files and finish with usual
# echo 1 > error_inject

<--- here, it goes through each component pair and builds the structure to
pass down the BIOS.

And you track valid component pairs by setting the IDs to -1 or something else
invalid.

All those component IDs which have remained invalid after the error_inject
write happens, get ignored - you gather only those which are valid and inject.

And this way you can keep the old values too and gather them again and inject
again, over and over again.

Right?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

