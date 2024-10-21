Return-Path: <linux-acpi+bounces-8869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22A9A655C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 12:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082701F21C91
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943D1F8909;
	Mon, 21 Oct 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I/n5yJg9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B31EF084
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507816; cv=none; b=oPLi3VmogP4+dW4pddUw/S4014nnTKabBQqapssgcQGZQVh6f5KfASJbbioCVLI+LR1S9rHe200YsKKUy3aTnBDhvgYmPG9F9/zWXXFsu/rHcBZMDyda4/HLAre9/tZIOqng6+SQMAP1GzSoECSrihddKQBq46k21CjPG1H9oXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507816; c=relaxed/simple;
	bh=lpt7XGrrmK/z49x2nGshDNYD4X44QR9REzDYaWUpEQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ0uDEjUsaa3dj3etMIwGjY3pq5CLJ66adLGZGsZj9rDMhhbA6vY1mawO+0HZDCUC8ZTRAg6I/pLtQ5FAEwIh0zVPns8k2M6JpdJDdqwDOl7pbVi3IZSAMlwA2QHsqCYFuY9gpHPpDTUz7QhQleYxhaudwQlRHAubpTUbs777Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I/n5yJg9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3690540E0198;
	Mon, 21 Oct 2024 10:50:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6Uh-frHOsQMb; Mon, 21 Oct 2024 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729507800; bh=TdW3azBwytdbtsJKfBGL5ps/+ipPW4VizcMAf9DtfrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/n5yJg9aWkXUWjpW0/PqxXEfUm9hkp1Hc+4gREVprYVQnyihpx0pclfWqLWOIuYn
	 MLwK+6ueiQwzgyJ/zx+mBUPS+E6YuOhz8swmNivDQjqGdV4U28SJXlN3ToqAsoDbYY
	 zIUMWQuaFuXLCs5tgR3sRyL3ZlZXv6pZ1F11oPfd+0Wgvw9nXbK/uls6zN/czdOZNZ
	 MrNVR/hMMAJo7yaeUBsB7Ie8Ln2jn4Hf/4Je5FYW2fXs3bHH5MBPC8Nz+oUxASn/xa
	 nBzmsqT7LuYIuXFcrklM5K9N98AFL6YO5AIl46IkRGWmXPJgR3bXGFTEPq0yuHdz8k
	 7z8dDy88+lI0f0I1wmt7E4fOVaCwJIf3ojVg+S5bIGg0bCQgxD+kryjS543kKmWIBP
	 IONMdIvOAB9AIHvu5g2j3ShwdAW7eUu+7t+A4mPbIa/RdFPR0wzWgmNoupo8B/mbWH
	 c/8Hk7QDQExi/qgI9jMW/0D5KWfCjEihoa+oM/R7aQz8xu7caKMH+lQA6H49Gyo1e+
	 IOyAwVGJDm5dR+b18Y9P+yBhzxHrkGyCS1fHg4CpZnvf3wX6Ws7nIsiCxLSQQ9RKW9
	 DJBluez/NI7w1+2u2IP4hlsw14RKzAV6ZHqD3d1wUkxL4lfjjaLJAQPXIb+bDepHsq
	 +EMpAt+1pgl+U0noqYzNuHSQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C05540E0219;
	Mon, 21 Oct 2024 10:49:53 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:49:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, x86@kernel.org,
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20241021104946.GBZxYxykR-1DKcCB6N@fat_crate.local>
References: <20241003213759.3038862-1-superm1@kernel.org>
 <20241003213759.3038862-2-superm1@kernel.org>
 <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local>
 <6271aaed-fb4c-4101-82a2-e18aba05b4d4@kernel.org>
 <20241019101042.GCZxOFooaiQPq-Q-2p@fat_crate.local>
 <CAJZ5v0hw-yxaqfOO4mdnFt8cVci1iVthYBAyH4nx__RJvYBJKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hw-yxaqfOO4mdnFt8cVci1iVthYBAyH4nx__RJvYBJKQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 12:32:41PM +0200, Rafael J. Wysocki wrote:
> I'd prefer the former.

Ok, lemme look at those patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

