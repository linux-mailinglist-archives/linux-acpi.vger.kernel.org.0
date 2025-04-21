Return-Path: <linux-acpi+bounces-13130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247FDA94A8A
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 03:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119733A1E28
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Apr 2025 01:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A26255E38;
	Mon, 21 Apr 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU/f/QkB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B9645;
	Mon, 21 Apr 2025 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745200372; cv=none; b=kY1o6EVfl6BTU7UGlaAx4mLbXrDXdCjUR3BxnUqeNo1/yChKVNGabEQCmxo5arrgv34lcLQtu3FNAvSkaULzHeEqiCaUQe3CAmBMvuS0qirwkdFx3zKk3BHL6mC9lHoUfjZelJKRMEKsYhUEnzdUs0x7UwZEEMmWULrgvrU+InY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745200372; c=relaxed/simple;
	bh=m/bqnPbluCsWOLV1Rfb6Xj7XPE/FjxTjQ6XQCSbphhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF+Ni1yCz4CUbJG5BQx1JVDZW141sTEq17dFSsnnO6X/nRvnwo9Uhk3PGBs1qB9EVtLTwYNDTI77i4dXO/d1oJQohDSfsA4UDLvq2KYIRk6s2Li36v3U4hmgjcggdOz9ZhnNv2AndA0biwT0Nzk49u4VObW1iWT4fbn0wct0mLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU/f/QkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB04C4CEE2;
	Mon, 21 Apr 2025 01:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745200371;
	bh=m/bqnPbluCsWOLV1Rfb6Xj7XPE/FjxTjQ6XQCSbphhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU/f/QkBsj8oX65HAVr5XmsZqbiGS9nhNgKLuJla8K3c3+S00wIRB7LnL+A5mAo6h
	 PX/FlZvRlfuBZnOv9AEZKC/FS6ducxC5r/1WH+9mnqiW4qe+tjfbyZBZoD5T4/hVt4
	 fFyMwUkyT56PEBR8C+Hs9n8EDnC7oqzLuEGSxG21/7Csp/Nk9K7h4dakVohLYpIJtQ
	 tl93wKeAbN8NQtDiHW/ruXiiMY0puDbB+UQZQbRa/y6FsXRJ9HPavVuPB7fMcMkh5T
	 VQAr5dRSIAg2QTsfHHCrNo/sdG/C6xZ+gq0nZY12FOsLMkYY4JX9IEDgHMckisuzSA
	 9VwAs2l95lvMw==
Date: Sun, 20 Apr 2025 18:52:48 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-15: acpi: sprinkle random '__nonstring' crumbles
 around
Message-ID: <202504201840.3C1F04B09@keescook>
References: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f941c51-784a-4f10-8df5-6bd103d1d80e@roeck-us.net>

On Sun, Apr 20, 2025 at 11:02:18AM -0700, Linus Torvalds wrote:
> This is not great: I'd much rather introduce a typedef that is a "ACPI
> name byte buffer", and use that to mark these special 4-byte ACPI names
> that do not use NUL termination.
> 
> But as noted in the previous commit ("gcc-15: make 'unterminated string
> initialization' just a warning") gcc doesn't actually seem to support
> that notion, so instead you have to just mark every single array
> declaration individually.

Linus, this is already a solved problem. I've sent patches for all
the warnings already[1]. I worked with GCC to get nonstring working
on multidimensional arrays[2]. I got it fixed in ACPICA upstream[3],
and I sent the non-CA ACPI patch too[4] using the compiler-checked
"nonstring_array" macro from commit b688f369ae0d ("compiler_types:
Introduce __nonstring_array").

Can you please revert this mess and use what has already been planned
for this warning? It is, once again, really frustrating when you update
to unreleased compiler versions. :(

-Kees

[1] https://lore.kernel.org/lkml/?q=f%3A%22Kees+Cook%22+nonstring
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=118095
[3] https://github.com/acpica/acpica/pull/1006
[4] https://lore.kernel.org/lkml/20250415232028.work.843-kees@kernel.org/

-- 
Kees Cook

