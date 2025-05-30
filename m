Return-Path: <linux-acpi+bounces-13965-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6750FAC8C18
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3115116DB99
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A02222C0;
	Fri, 30 May 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JOE1VagW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14C1DA5F;
	Fri, 30 May 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600867; cv=none; b=ScoZeQ5UF+nT9mAmBROpF6drPPWXCPJYCK5s/rVaMtPPk/MyA8dRQTYyP1Her8I2P5H46+64DaLnpYOLERm0lc2ZqpLN/76q7vyOJe1X3DFN4bhKsY2du1cwDqgRicLUq8b7MdfzJKfboiXi/7x3Ua5//1Ij3ulCkugGm59nLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600867; c=relaxed/simple;
	bh=yimb/h/oIv9nrFU36k+skWXKj5ccHe01EMDttikc/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhmRshq2Jipx3iFUE7BKXnAQlpGnYVT4uim8iXJ81cyCM6+0H/zyslFNL1NnL+fHI4XQl7/CKSjqdOnZ8qKAXRkwcs2DbqK6JYnyGdQSGO5eqgZqJPh/tKbUWd70dNycVse5e4nIUJQs5PQy2ZAbKPoiVoVq4iulawdmpbsRD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JOE1VagW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D951140E01A3;
	Fri, 30 May 2025 10:27:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P9lM-Eo2BI2t; Fri, 30 May 2025 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748600856; bh=blS/JssQQ0agsCa6iwZIdjI/QV/iJgq7L8Ra63G35JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOE1VagW3LYq3qu19XX/Arlt27IOQZt4+zPdZpViVzMy6uWRVk/mkXSNTXzPr38xn
	 D/b7Z6745UcKg3okH4WGahMbGP3+iNOG9Zb8Ocmq3U74uV9bOJwdIX7oWX44dCQkQP
	 u54doDUI/UV45/wP7sFLZX2Fm/wTlcL4ViWNmT8PuylToQrstROVIiuYpaIbWFksYQ
	 WJ3vhjMZX7ELJ0SzQI2EW9MeZtuZleMry3k1Qlx3kB0EKDmpl+PvEUe9FysqMVOWqU
	 H7FwKfyrJxQl9HxIgiHB+3aZ3UVoe/v75/3n7ZEJyAMF0CJ+BoIvyqBJuOu2qgQoW9
	 31aqPfQ/9l61h+oYXz3wgVNUVlXwx0REwbhlLlSZE2EucBbrENuNX4gdRx5g0of8vP
	 pO/OVN0jCutGg56HJVf3dd0hFNQ8ds/AYpdrVTQe46XUiryBQEPWfsuPflXOsqVD46
	 1S9AORwC8RP0TBzzGrWu6+nVQ6RGbYwaMKAWbR0UuFEhEMf6LGlvIUvHhDFf/H47Si
	 upGfGM5fsHupxhda7XSxT11MLb5MnOgteJFK5AuuTI1soRoL0qL++hETl1ZMwk7UGu
	 FHFr0o/klRY4IWEVWnuiVHaqAy3lgKTE+3sH0C9hrJe1s3hT+oaEnBKN6I+M2Fwppy
	 rRS45TdAQBSTODtdNbAILmSc=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B32D40E015E;
	Fri, 30 May 2025 10:27:19 +0000 (UTC)
Date: Fri, 30 May 2025 12:27:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, u.kleine-koenig@pengutronix.de,
	john.allen@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-10-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:13PM -0700, Zaid Alali wrote:
> +- einjv2_component_array
> +
> +  The contents of this file are used to set the "Component Array" field
> +  of the EINJv2 Extension Structure. The expected format is hex values
> +  for component id and syndrome separated by space, and multiple
> +  components are separated by new line.

How is this a good design?

Do you guys not see that the other injection files are one value per file?

> +  # comp_arr="0x1 0x2				# Fill in the component array
> +    >0x1 0x4
> +    >0x2 0x4"
> +  # echo "$comp_arr" > einjv2_component_array

Oh boy. Srsly?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

