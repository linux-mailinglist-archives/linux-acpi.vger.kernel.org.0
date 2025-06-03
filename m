Return-Path: <linux-acpi+bounces-14080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB4ACC236
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A1D188723D
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680D52690EB;
	Tue,  3 Jun 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ibDcVAEV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF62C3271;
	Tue,  3 Jun 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939556; cv=none; b=asgtekvNIj0wXYHBl7ySIZT5t3yNgd9vjYBLVa+0vIbivt79dWWr7erxOE0eu9VOXXFBWty5nYr+XoSPxka882vNMEe8ZTmj2wDfl41q6wKxUlBpqHhFYY13wyfSCYKRbw+SIUFfAngLHxKcEGQ+Gi3Yofn7M3VVON2X4JJ3tjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939556; c=relaxed/simple;
	bh=yHGaE1OTEpeQQ4gsYu4gvSam/RgWFQyoLvAOVXlQrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4JwIIV6MmcOqn3nwF6ooLVa/gXjhefP/LDsJeg7lQw3vPLejiafpjc2OZYxrarD0qAEnpnGu8EnMeZjohvltzuetfI1dB8q1voNcog1ZkY/hhCDCLpGgnSAohrlRthNE/aHI4/qaynHZGn+YA/6boJt1xNt5jr1jIzb+6cbS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ibDcVAEV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E164140E01A0;
	Tue,  3 Jun 2025 08:32:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R-jqQBazJ1f3; Tue,  3 Jun 2025 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748939540; bh=uSTsJyP+dNpREMtqhis9XtwrNy3656bwDJMkEsaZjPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibDcVAEVYUbVRIZzxABOqWDfjhCywQTaNqo3Wc8czzBXR6BDUCmo8oWet5vr4R71b
	 PKhH2VoU1Hv39L1UtOzOQVbMF1j2qB7oTf5QUFDy77uWvrT1CSKdSGbBbfD5UedPXB
	 BY0K4sHBTbM1QUy6B4nBNnkjJIQlzOuwOSNif0J7FN4aBkvtFR3DyLsyh+bcl/KXI2
	 mTmFhoAWA5hFjK108RdvahHfiwcAHKUWGRmNAHa0JaM7O3IkyqoUPIb6O7YdOaeboH
	 tsSAI90uUedmB4kAOC7D1hvkPa77vSnezVATJ5aWeWJfmVAk4r0pNPn03Azc6TI4uT
	 M33BGTm6ZJYAzy+bNdn//cWeP5tqW/wooXBdFJx2Zf74bIp0uWBQfumpELovZIVCS7
	 bdrVj3dxm0+79YqI5eA/lNTOS39QPnH2yq71rg0/pF9iCSpXSJ3FqN7vfwFu8BuBdx
	 UTU5hBGYnKJMHOFpZ20PgLvSHCYbdeOt5cVBZiHnOrSCKoxL957XrDz0XQfT8Q1b8n
	 el9cHOVzRQv4mHH8kJiNx6rSmOzhZWOWvU/u1fZQz96qf9yHnEuztah5wtukdzSN8M
	 NKEhGBne8SvIikogWqwLCTelkBaaHOAtGOkdANTS5G/Rk5LpS+V+/xXG+HB4/ZBFAP
	 ovCzbBnncZ9brCmWPpWY3kks=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4B3440E01AB;
	Tue,  3 Jun 2025 08:32:03 +0000 (UTC)
Date: Tue, 3 Jun 2025 10:31:57 +0200
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
Message-ID: <20250603083157.GAaD6y_fec2X_hTnav@fat_crate.local>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
 <aDuBjopy_nE9A-ph@agluck-desk3>
 <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>
 <aD3ZFyBW4SCyaGI9@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aD3ZFyBW4SCyaGI9@agluck-desk3>

On Mon, Jun 02, 2025 at 10:02:15AM -0700, Luck, Tony wrote:
> The actual structure passed to BIOS is the same each time. Just the
> set_error_type_with_address::einjv2_struct::component_arr_count
> changed to indicate how many errors to inject.  In theory the
> driver could allocate and copy a correctly sized structure, but
> Zaid's code here is simpler, an this is hardly a critical path.

Right, allocate it once on driver init and keep massaging it on every
injection. Simple.

> This is just an improvement on my "option 1" (improved because all-ones
> for the component ID is going to be invalid for sure, while all zeroes
> could be a valid component).

Right, you need to know at injection time which of the components are valid
and which are not.

> Or just stop collecting on the first invalid one.

That would mean that you punish the user at the first typo. :-P

Considering how complex those interfaces become perhaps not such a good
idea...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

