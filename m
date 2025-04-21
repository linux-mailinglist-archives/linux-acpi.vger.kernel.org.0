Return-Path: <linux-acpi+bounces-13132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D177A9549D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401C4167D17
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53E1E0DF5;
	Mon, 21 Apr 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPGMQ69+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A51D54E3;
	Mon, 21 Apr 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253551; cv=none; b=Z0pZHt9UXAW/C1t7SKrsb/reJVAmyGO/eOW+T6VL25C+A+pRbV4KZ6gwf6I0s29AaU81fi6QYNTbqj8NBx/wedVUVj8Se8VNHIsozDE4VLUZUcSYKmghmlTozJe/8GMEmp3SHVuFeWa2HX3rZrD6KaFgxnf3qyKBSsSQhmIjncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253551; c=relaxed/simple;
	bh=rlF7RX5n2a2mK17OOJE7rTy8NtTk6ZIM9tzAsu8dJws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA1cj8NQyu9aPh2oaLcPyBFPvimDHzcPcPwUCg/xBC+xE9PZiiyg+6Lv7cYwfcaF/jzUHp4cB/jjffCwApMkY3f2iQQk721xTZQX67UbnPwsdv1ATw6E4h8UdlenkucF9/PKreLk+1xKIGjcskwxO225H17bI96/u3G2/j8Mf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPGMQ69+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B3C4CEE4;
	Mon, 21 Apr 2025 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745253551;
	bh=rlF7RX5n2a2mK17OOJE7rTy8NtTk6ZIM9tzAsu8dJws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPGMQ69+1a7lvC/dSvRfw5vuTqYLjGlwF1lLonH/4r3INbLxo9AHMUX9MX8aqv0bu
	 Scgu8ryMTUMz/nIi8yQlpK0BGloMSErSRBaLxSoRSI+XJC0AbFWa1J6BpmUIRERScH
	 Tjm5Q0aoNdO6fxRDrLENMgPKnZtPIL0m8im9SfFZcP4op82BXDvO2IdF9i/UDlEikT
	 Fmv8o0c6DioPpBi6O5cOlkBN4NE/lnN98kgBZsactm3bqDpzCUSE/wCRsTqKJDTvWC
	 yKz4U5WzbpHHhMt8VMzZduoe7ufoMAHiWzP+VHPSdhkQieXepI+iWbLcS2F1j9bntn
	 TN+PLBE2ufFiQ==
Date: Mon, 21 Apr 2025 09:39:07 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles
 around
Message-ID: <202504210909.D4EAB689@keescook>
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
 <202504201840.3C1F04B09@keescook>
 <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whryuuKnd_5w6169EjfRr_f+t5BRmKt+qfjALFzfKQNvQ@mail.gmail.com>

On Sun, Apr 20, 2025 at 09:33:19PM -0700, Linus Torvalds wrote:
> On Sun, 20 Apr 2025 at 18:52, Kees Cook <kees@kernel.org> wrote:
> >
> > Can you please revert this mess and use what has already been planned
> > for this warning? It is, once again, really frustrating when you update
> > to unreleased compiler versions. :(
> 
> Ehh. Kees, that's the compiler in F42.
> Really. It's not some "unreleased compiler version".
> It's the main compiler in one of the biggest Linux distributions, out now.

Fine, perhaps I'm nitpicking the fact. F42 made an unreleased compiler
their default, so it is technically "released".

> Why do you think I made the change? Because the kernel DID NOT BUILD
> without those changes.

Yes, I understand that, but you didn't coordinate with anyone. You
didn't search lore for the warning strings, you didn't even check -next
where you've now created merge conflicts. You put insufficiently tested
patches into the tree at the last minute and cut an rc release that broke
for everyone using GCC <15. You mercilessly flame maintainers for much
much less.

Why make compiler version upgrades a surprise? I'm hardly the only person
who was working to make the GCC 15 transition smooth. This made more
work for people, wasted your time to recreate existing patches, and broke
the build. I am hardly being unreasonable in asking you to do better.

-- 
Kees Cook

