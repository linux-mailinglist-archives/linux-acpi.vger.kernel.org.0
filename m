Return-Path: <linux-acpi+bounces-20104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37770D089AB
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C3F304718A
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9143382F6;
	Fri,  9 Jan 2026 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Gki2PIiu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A46332EB8;
	Fri,  9 Jan 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954898; cv=none; b=GXhSC3hyV5vyUEo1ANSnyus243kw+rlGWJ8j0T7abazH0WcipGXsuNwFhTO2+2iM0lSXhWmVflWUDrPbxWYl2Nqi/kLkqhTLvWb5LK6o3Zy2EBcyYR/1sFMR/t3BNz1dLUST48cyn8OV1n3TTz9+CPpGdZUXSswRQyR+jAVIM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954898; c=relaxed/simple;
	bh=1tS3QUzcLykC5z1S8LvAVBP9AunlpKkAg6Ox0uD81Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrF90pq34T+tFbIZNLjFozB/tPyCOAmwxU8X7uEedTLUs0cZ8sv1tMm91c/W3ECLvrqaVJXwkRM8t6bwX9fjcBaJJ3YMdH7JzKnOElcNk6b3DLzy2tVfonnUmtPG61365H+tedELse60dPOb0Ji2MBpxIJho8JDb6cty3qRPi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Gki2PIiu reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E23C40E00DE;
	Fri,  9 Jan 2026 10:34:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZLtoArDXc47o; Fri,  9 Jan 2026 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767954879; bh=tf79nQltkuFcnhXHTJqEKH0yZcFm9B9epYWrL4oDSRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gki2PIiuSlT1PBmvROB8Vm90PtLWIOjzJvrW3yIpsdu1pFvSl6ZylNI1AaXbFOCGQ
	 ON5VUUw27g3PXWdR4z+HJx4yQxlTNSYgFFAuFtCMLYLBsrKfwfKAOaeWaJZfGrgolE
	 o+UWbl4NyTfOfMp36/v+Gc3NJZtep02/ozs1ud8tvzGJbx6d0iGZmskko/n77PP3Kj
	 7nK1X9czaCvK+Ufi3QJ63vGmkj7sAwbkrsuJWUOlzEXdrGBQ1TXOGRJqN/ipeAC5+i
	 A390Dgobe1GE85YxAkTgP7bpjixa3Uu4QcuUushqxjHysAc3YZXVly3pVaG/iusupq
	 xY6/Y0PCSH0A8RXSbDbCuVldT25MVX2eBjtgVfuXNZUfF+4T75uH/YH150jD8+tdc/
	 YtEMbmzvY43SM4ilach0YiKuFatN+vs7lQz+PGLM+59TV16PHaJzxRcCnYHV1ixs3w
	 VjsjFiFAv6NsjDyhxMRPPwiEHFwGMFc/3zrc8EWNdV3YjpQXJM7Ho1P9ElFzb8uzj8
	 h+3jLRljVQ/Sbvb/sikaWeLoD+551OgU7ZrSAkTC7hiEPUCEdPPXTedoCRXqh0AcH0
	 8belyZOVl3wpHt43l9J+BVHFYXS5xMJZjjtWl1rIuXust3KMexrJjQZ5BOqpNv9MNp
	 jg4nLDnWI+GuLJtzX3NI5EWc=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C54B940E01B0;
	Fri,  9 Jan 2026 10:34:22 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:34:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
	yazen.ghannam@amd.com, misono.tomohiro@fujitsu.com,
	fengwei_yin@linux.alibaba.com
Subject: Re: [PATCH v5 00/17] ARM Error Source Table V2 Support
Message-ID: <20260109103416.GAaWDZqDYoyt3KRAE9@fat_crate.local>
References: <20251230090945.43969-1-tianruidong@linux.alibaba.com>
 <20251230202211.GAaVQ0cx8o-CqzGU2O@fat_crate.local>
 <0038141b-713f-4024-9f8b-e5f748f5a6a9@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0038141b-713f-4024-9f8b-e5f748f5a6a9@linux.alibaba.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 05:12:25PM +0800, Ruidong Tian wrote:
> > What is a "RAS node"?
> A RAS node is the hardware interface for error reporting and control,
> consisting of one or more register sets (a collection of RAS records). =
It is
> responsible for error logging and interrupt signaling[0].

OMG, one more meaning for the word "node". Because we're not ambiguous en=
ough.

/facepalm

> A single hardware component can feature multiple RAS nodes. For example=
, a
> memory controller is treated as a "RAS device", where each memory chann=
el
> has its own RAS node. Interrupts generated by these nodes are typically
> aggregated into a single interrupt line managed at the RAS device level=
.

Nomenclaturial tragedy, I'd say.

> Comparison with x86 MCA:
>=20
> RAS record =E2=89=88 MCA bank.
> RAS node =E2=89=88 A set of MCA banks + CMCI on a core.
>=20
> The key difference lies in uncore handling: x86 typically maps uncore e=
rrors
> (like those from a memory controller) into core-based MCA banks. In
> contrast, ARM requires uncore components to provide their own standalon=
e RAS
> nodes. When a component requires multiple such nodes, they are grouped =
and
> managed as a "RAS device" in AEST driver.
>=20
> [0]: https://developer.arm.com/documentation/ihi0100/latest

Yah, thanks for explaining.

> > The ATL is very AMD-specific. What does "conceptually similar" mean e=
xactly?
> By "conceptually similar," I mean that both ARM and AMD share the same
> functional requirement: translating between a System Physical Address (=
SPA)
> and a device-specific address (like a DRAM address) for RAS purposes.
>=20
> The goal here is not to share the hardware-specific translation logic, =
but
> to provide a unified interface (an abstraction layer). The actual
> implementation of the translation remains entirely architecture-specifi=
c.

And why do we need an arch-overlapping unified interface?

You can just as well have aest_convert_la_to_spa() and none of that "unif=
ying"
churn.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

