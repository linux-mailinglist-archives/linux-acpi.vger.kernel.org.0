Return-Path: <linux-acpi+bounces-19675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D1CCCA65
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F815302AF85
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC3382561;
	Thu, 18 Dec 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwM4D9Kk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08029AAF7;
	Thu, 18 Dec 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073899; cv=none; b=cJlzDjo238aM+O+qEBkTyE/qEvGpr30RSz20QVo74rV2WNVNUxGyHaZ0DEr7bl25rl7ghdQ8nqq9/GjQdM3FFJ/LSxLDxLh4Gqdns/bv0sTetNMni/GQQ1ZKGio3dmFeegVViimMBswNjVAS5ZFNKuLqAdZYuK31mmG+LIgNovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073899; c=relaxed/simple;
	bh=gzFkONFYOr71raXYHjqduidbBwfeoTNGqEuP2iomJ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUwEatCBznRZZXy4Hw7TMsBZkbZG7G/87s/rbE5X1pixJb0zjJ3lQuU5xHATTOBcZKk5mUbDTdfCZeIyvUw6kHUcFjlkFZ/CoX/4jd24SyewHW6ADkqp316/M9stGxrcGihBE7wOEvKElU8/4ZHpuCox1bGpV57FveTYAQU8264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwM4D9Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2BC4CEFB;
	Thu, 18 Dec 2025 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073899;
	bh=gzFkONFYOr71raXYHjqduidbBwfeoTNGqEuP2iomJ+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwM4D9KklNSbYCtuU9tVvtuEfH4VpJ7/nAc0EItPJdiI1dhki+01lCXdVgCIgcHRa
	 CoZb3CSjm0/FhxeS1PVJYRNUPZUTKJpbHnqNO6I3+4nn4fp5MIGISMo/eah8yKEDOJ
	 BhNgpmKLiD2tkFtW7W+/O+96MaGEzmpdepQQTrp9Yb7wCALEAkWCp2F8b/XrZCdGFS
	 w1eNsNglFFbiWKCTY8MXKXKB6IXuLtiQz5lZTfBL7QjqusOPkroUyZ9f/EfXMtxuHO
	 h14y8oAPRCmsPMm/ZptP2fq54jPO/wO+8xCgPPvIAeha/vQQZGARJBEQ+wpod49nFR
	 JG9dBvlPoWo/g==
Date: Thu, 18 Dec 2025 17:04:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 tony.luck@intel.com, bp@alien8.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com
Subject: Re: [PATCH 03/12] ras: add estatus vendor handling and processing
Message-ID: <20251218170453.23be9049@foz.lan>
In-Reply-To: <20251217112845.1814119-4-ahmed.tiba@arm.com>
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
	<20251217112845.1814119-4-ahmed.tiba@arm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 17 Dec 2025 11:28:36 +0000
Ahmed Tiba <ahmed.tiba@arm.com> escreveu:

> Teach the estatus core how to walk CPER records and expose the vendor
> record notification path. This adds the section iteration helpers,
> the logging helpers that mirror the GHES behaviour, and the deferred
> work used to hand vendor GUIDs to interested drivers. No users switch
> over yet; this simply moves the common logic out of GHES so the next
> patches can wire it up.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

...

> +static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bool sync)

Huh?

This is a CPER record from GHES. Why are you moving CPER code out
of ghes.c, placing in a file named estatus.c? Doesn't make much
sense on my eyes...

Same applies to to other GHES CPER record types.


Thanks,
Mauro

