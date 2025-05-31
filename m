Return-Path: <linux-acpi+bounces-14035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14714AC9A3C
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BB1188F548
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100FF238C1B;
	Sat, 31 May 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Eabi1BoP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971708479;
	Sat, 31 May 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748683277; cv=none; b=rst5PfSz2wWAc0F7nz0RcXbkLjiNlH9vPZcdPzszznyhFDHz/qkaWVJ6/2hBAiK8Ft4whPxy9YVp6CcCrZEw5EQoXxh/rV6elKjmy7SjfaUwr/j2tT413BaFzdPD5bf1+HP2WZTkvoJ/T0UXbDfw1WhZTb38Ojev6nCvInLDh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748683277; c=relaxed/simple;
	bh=2cKWC+jp3T+h4rEeMC3I3qwW+MyoPZ9M8l6BinJBIvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpqK7YW63sWocy7wGnS/2OT7Yf4VmJ77ScXGBpxKDiUh7ELyGEzxwYwyKM3lHNiOg9gyhuPHTmWHc+PUW9ApxYyuPMfxgVehdIBEuI36zrN9UgXqRaEVeEKOYa/ghnf+DZUSHTiMVYo7qVjVbX9M6hekU+SoGGjkYkZ5dIiEqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Eabi1BoP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E00A40E01B0;
	Sat, 31 May 2025 09:21:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C7FoGxDnSMSc; Sat, 31 May 2025 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748683267; bh=hPncIQfmkOc9jGoevaB6tq3hVWi4s4eLHLj2UZams40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eabi1BoPz0FpYimj5i2YRLX7/2E9Xtq4U8idvjkw8cbbHC0QwCeVLC7UgwkOPqnrm
	 0h+//cn/exUzXZSWpM6G/fpg7oFOAmc0GAs7JTWvdmzlWzADSxEsLJI8ok5Fk2HJRw
	 5Rpo3sHvt/JXvJPSGWSBt9udWuIwRDLhPqKoXbtdmqPAmxO2oqOQ9SpK8W1Jb8pk8W
	 BYr+pOMAoOQ2lTTtH10C+ZRdbLq2Vtssb8Ds1QiACiU4e9ZFxay1MYuCwuz7ol0pl2
	 RL31ECgAhjjngJ7Gijo93stVn546NZ3IIaB1JilP1tVqn0KWeQcJjkd+1bsa007mmI
	 tVSF2U0G2vZ56jU4NfSNe3yeFJOm/YV0Qr0+hEHO6HdKEdye+1fG/8MZmex8h8tlU2
	 oXvMwiY5OugDmUvM51P++Z/OJlKICZ0UY14K5ANqrGEWZco2/fSIa/ZmQBSRtRJ4L/
	 XJZ+PeuPV2tiyl7txx6dcBton+J+UDKMPplCCkW8m/8Ui3IkqOHt5h1/vlB0xpPSw7
	 DRlIKp5MPKDG6AsUYoAjHiK24YCnVhF6iDHYp6MIS198cYJS3roE85sxxlt81uDJcf
	 rxSkqL5J+q+kEe01zJi1ZWZM6JXsrxdLIl72r/LHrdSinNJk0rCrsK1yJe34JTobwF
	 g/MexLYzvAuNhvcpr6b/yhf4=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32DF240E016A;
	Sat, 31 May 2025 09:20:51 +0000 (UTC)
Date: Sat, 31 May 2025 11:20:50 +0200
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
Message-ID: <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDoal24J-BMTIBCq@agluck-desk3>

On Fri, May 30, 2025 at 01:52:39PM -0700, Luck, Tony wrote:
> Use case to inject to one device would be:
> 
> # echo 1 > nr_components

What does that do?

The interface probably needs a little refinement, but...

> # echo 4 > component_id0
> # echo A5A5A5A5 > component_syndrome0
> ... set other files and finish with usual
> # echo 1 > error_inject
> 
> There isn't a fancy "debugfs_create_x128_le()" helper to manage these
> 128-bit little endian numbers. So I've coded with the basic building
> blocks (though using copy_from_user() and copy_to_user() feels like
> back in the stone age). If there some helpers that I missed I'd be
> happy to see that part simplified.
> 
> Patch is on top of the existing v7 set. Obviously it needs to be folded
> back into the earlier patches to make a clean history that doesn't add
> functions and then replace them with different code.

... yes, definitely much better.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

