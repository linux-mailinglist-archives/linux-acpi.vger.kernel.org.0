Return-Path: <linux-acpi+bounces-12634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231C0A78BB8
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAED47A4751
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C5233144;
	Wed,  2 Apr 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9pH4/Kz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858EA92E;
	Wed,  2 Apr 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743588420; cv=none; b=S59z/RrWQ7+QhVHHKLDkhGrwjNx/88GHwrFBkhVCVIG9M2hljBc39afrTAM6CrSp39n2bv6OXzxK58C9iu91bqVl5woNRRkAhXuBvYJ41c3HqiZ5mgjDEGKE27Sr4Id9OMGVv++7Ved5OjniQgXjGSv9XZv9pQI5f9nMyp5urho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743588420; c=relaxed/simple;
	bh=irBICWazUjg9zC/J8c5JnsvICKb4bWu56+cxmqXLuHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecHAA4CWbR60eC8r7kQ/PhmuifRsW3JBuwmwv1eHPS/2W2KEg+IW/dyH3sGvmDTDcT0JX4coHzcdXVs4hE1qGHBmqZjxWe9wRDsjXiTujiHinktACRM3W1wCYDOire9x0vzQfqvCXHcjBe9Av5VDjVm+Xfc91eVOSvxphYPcrrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9pH4/Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8084C4AF09;
	Wed,  2 Apr 2025 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743588419;
	bh=irBICWazUjg9zC/J8c5JnsvICKb4bWu56+cxmqXLuHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9pH4/KzNTaOwBuqD1cIyO1su7aRcqZUSmqY1s2YwzZJAU38sZ3LF+RqLSf3Dr1wp
	 VePdi+WxQZVXq/xrg3tKHcsn79oMFJA5eNEJ5C4hQo14l8Q1ZnQSbMP+7FzA/Op4s1
	 jD6au5dOwY9fN62ycxRANHPowcspWKQB/KtIvFbjR/fxC6OYgivPZzCNxBKi5Nbf1n
	 MR4DyKZXXKWw4HqvbHdAukjBqdQ95+uQpnawr1+liAhhzgX0rlk/99xRZRI6QozPku
	 wtVPhU8v+J/+pzXeO0TesifrUWXSzJqtK81Z5rDBF2+8aaZcERryVoytrYHkFAOOW/
	 Fe06WVjAAsj2g==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso2529401fac.1;
        Wed, 02 Apr 2025 03:06:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU/hMKBqGzQcxgwX/aEjUA4kX8dSoeyufbKORp8tk9pQqI4JxFUr/3/pbWXtL+/zknG9XnV1Gtyc7Q@vger.kernel.org, AJvYcCWEUWj5xs2aGUlkfpewckiCqzFSwNUUiIAcNtH22uPjCO9DQUUdn1MM3Xcg9LBEYwhp5oQwxXLRLVqfiIp5@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDM3h0V60Oh7yyvwFRLE4gfkyf/Ap4fgMKk2RopAKq/kwOTnp
	DbzGUv8JiNA4ws+TbpqmriLYzJJUID1wDrxAAgD6+FUWAgDIW5g9xVGzXRkZfftNw1UK0yaetBN
	lgM0qMC2YgGAsw7rXsPpR+/OZTy8=
X-Google-Smtp-Source: AGHT+IHyHEk44Pjw38ptToiDK1CORXfebWNx8bDOoxh98GOHqSdTsEMXR+gfZiqJBOQOX8uxaQzRjLd2gxqM1zwvEi4=
X-Received: by 2002:a05:6870:7e0f:b0:2c2:3a7f:e702 with SMTP id
 586e51a60fabf-2cc60ac20d8mr965761fac.11.1743588419202; Wed, 02 Apr 2025
 03:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402075253.1772541-1-luriwen@kylinos.cn>
In-Reply-To: <20250402075253.1772541-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 12:06:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2w8sSer1rWMRKh10QwhXSXW6j_ePTm7CEY=4n7nJWhg@mail.gmail.com>
X-Gm-Features: AQ5f1JpmLE-LDuqVoCSKiRJQ6XXkuPnmm98ndmwNupTxRYuKSg3LAZSf-Hq1-VU
Message-ID: <CAJZ5v0h2w8sSer1rWMRKh10QwhXSXW6j_ePTm7CEY=4n7nJWhg@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Restore built-in rules for subdirectory tool compilation
To: Riwen Lu <luriwen@kylinos.cn>
Cc: o-takashi@sakamocchi.jp, rafael@kernel.org, lenb@kernel.org, 
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, yu.c.chen@intel.com, k2ci <kernel-bot@kylinos.cn>, 
	Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 9:54=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrote:
>
> Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> when building tools in parallel"), the top-level MAKEFLAGS=3D-rR
> (disabling built-in rules/variables) was overridden by
> subdirectory-specific MAKEFLAGS during tools compilation. This allowed
> tools like pfrut and firewire to implicitly rely on Make's built-in rules=
.
>
> After the aforementioned commit, the -rR flags from the top-level
> Makefile began propagating to subdirectory builds. This broke tools
> depending on implicit rules because:
> 1. -r (--no-builtin-rules) disabled implicit .c -> .o rules
> 2. -R (--no-builtin-variables) hid critical implicit variables like CC
>
> Fix this by filtering out -rR from MAKEFLAGS.
>
> Fixes: d1d096312176 ("tools: fix annoying "mkdir -p ..." logs when buildi=
ng tools in parallel")

It would be good to CC the author of the above commit (added).

> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d138b17b8840..abf9cfebaf4f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1431,11 +1431,11 @@ endif
>
>  tools/: FORCE
>         $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS=3D O=3D$(abspath $(objtree)) subdir=3Dtools -=
C $(srctree)/tools/
> +       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(filter-out rR,$(MAKEFLAGS))=
" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/tools/
>
>  tools/%: FORCE
>         $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS=3D O=3D$(abspath $(objtree)) subdir=3Dtools -=
C $(srctree)/tools/ $*
> +       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(filter-out rR,$(MAKEFLAGS))=
" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/tools/ $*
>
>  # ----------------------------------------------------------------------=
-----
>  # Kernel selftest
> --

