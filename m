Return-Path: <linux-acpi+bounces-12554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32DA76536
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258BF188B283
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D01E260D;
	Mon, 31 Mar 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKKr66Rb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508C3FFD;
	Mon, 31 Mar 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421977; cv=none; b=oztWDWJJ03Q3uk8fI9GEFZLHYPexNx57O5zHfxdOJseRJYGVoMUuoJ9skGmD+5hojnoCm17Nl7tHBxBMS+p22Kdg5yN+XaVv7rGY+6NZE7MEmvbmlNcnnQUA43tx+GKh4cqXYbVBiN8xfCWWqzCV0eTCDwHESlNP3Jq0x2kikbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421977; c=relaxed/simple;
	bh=9KMR49+PrufVovv2R9w12T/lYLKZ8NydmQ95HlmkTYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdaSokNAy5QripH5Pzxw9kJ98d7OWc0lZGhJG7Sp7j6+WlTejM7sMwv/Yx0CXX9hCeD5JYRw+65l5bzZnftwCarqwio3o7QMFmAudokdcBKjMu+5ekHo/wZliw7TMxWg2MUP04GE/X0lCppWCAObub0bxQsra/g9HnFA/HdVhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKKr66Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388FAC4AF0C;
	Mon, 31 Mar 2025 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743421977;
	bh=9KMR49+PrufVovv2R9w12T/lYLKZ8NydmQ95HlmkTYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KKKr66RbrvASKh4yhqpuj5Soo+Pykx6Goa1Ns4KMQdSOmHDkvdu6hVVr3KpdR8XQl
	 GpHVgwrT+IfpocF2qWu8C3WohF4K0pFYdydTSCNQ1FHkZHkwDEp/VDpMUBcAJGp8H/
	 4LrEt1JwahFMUoBzTzTq/xXGgwnq8kXGKN7fWOlbW5Fp3RZDFSRWLTmTdbD5gagU9w
	 qCY9rT7KAVlFosEaWkctQwRql1V8SX5Z/fth76Tix7M6BcQnyyvNy//62V5ZZWui92
	 O88dZBXR/gHhC2AC5q6VLJ9zKXd6QHtUiQHdhJ8GYBLbD/b/GyXnrB9ClbLWFYwg9M
	 j16Ob66oXsDlg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-603be85490bso31033eaf.2;
        Mon, 31 Mar 2025 04:52:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCaYhlxj5oH/NDvIY+yIe761NGMmAGGqTUDPb4VVgf/67mVyb/ksrpY+Pfk4irzqE0ambhTCP87C8zyglj@vger.kernel.org, AJvYcCVRzAYxjZU4himXnZXC7qw5CexdPgiTAZEaGMGKEEWCIsnfWzgFBk+ALpFXqqtVfPtenJ2EyM4Tuhjg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwu9hZi/qfQOIaT4WvTBOSD/iCTtoySYkCRJWe6tcTZM0UGKx0
	koIeTfYM4OB5YnIylMZnptVK4qWk/DJh6Y/+RczNo4Ag8zklneVXpycqb+vn+u2q3JJ/vz2GCZQ
	uqF6ZQMsnLkJFFnQK5639uzbdbeQ=
X-Google-Smtp-Source: AGHT+IEW+T8lg4skl+EXd58usiutU6y63d+E6SF/+rbhWOnbpfd3S1oqjmnCXNnekxkr714brDTwd1TrNSy6BCYPUdk=
X-Received: by 2002:a05:6870:7009:b0:29d:c709:a76c with SMTP id
 586e51a60fabf-2cbcf49116amr5545639fac.4.1743421976501; Mon, 31 Mar 2025
 04:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328074750.3524280-1-luriwen@kylinos.cn> <20250329010721.GA11319@workstation.local>
 <TYBPR01MB5470C91FC2902D16D3FB9707B1AD2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5470C91FC2902D16D3FB9707B1AD2@TYBPR01MB5470.jpnprd01.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 13:52:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jy21xWDSrTxSzg0YPBQYrntXvDYK-GZtH2we+qGjw3Bw@mail.gmail.com>
X-Gm-Features: AQ5f1JqNXBOBZs1mBlPxML04pTBlgsnqjsJNA70u0N79xSM8uU0o7kM7LvRz7Pg
Message-ID: <CAJZ5v0jy21xWDSrTxSzg0YPBQYrntXvDYK-GZtH2we+qGjw3Bw@mail.gmail.com>
Subject: Re: [PATCH v1] tools: Fix compile error of pfrut/firewire
To: luriwen <luriwen@hotmail.com>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, rafael@kernel.org, lenb@kernel.org, 
	robert.moore@intel.com, linux1394-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:15=E2=80=AFAM luriwen <luriwen@hotmail.com> wrot=
e:
>
> =E5=9C=A8 2025/3/29 09:07, Takashi Sakamoto =E5=86=99=E9=81=93:
> > Hi,
> >
> > On Fri, Mar 28, 2025 at 03:47:50PM +0800, Riwen Lu wrote:
> >> The value -rR of MAKEFLAGS implicit do not use make's built-in rules a=
nd
> >> variables. Previous commit d1d096312176 ("tools: fix annoying "mkdir -=
p
> >> ..." logs when building tools in parallel") removed the MAKEFLAGS=3D
> >> command for tools and caused the built-in rules for pfrut/firewire
> >> failed to take effect.
> >>
> >> Reported-by: k2ci <kernel-bot@kylinos.cn>
> >> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

Yu, can you have a look at this please?

> >> ---
> >>   tools/firewire/Makefile               | 7 +++++++
> >>   tools/power/acpi/tools/pfrut/Makefile | 2 +-
> >>   2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > As long as testing with v6.14 release, I can not find such failure. I
> > guess that some one has fixed the issue between the commit and the
> > release.
> >
> > Would you please recheck the issue?
> >
> >
> > Thanks
> >
> > Takashi Sakamoto
>
> I have reconfirmed that this type of error does indeed exist when using
> make tools/all or make tools/firewire at commit 4e82c87058f4 ("Merge tag
> 'rust-6.15' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux") in the 6.14
> kernel.
> The relevant error messages are as follows:
> $ make tools/all
>    ...
>    LD       pfrut
> /usr/bin/ld:
> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acp=
i/tools/pfrut/pfrut.o:
> in function `print_cap':
> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acp=
i/tools/pfrut/pfrut.c:179:
> undefined reference to `uuid_unparse'
> /usr/bin/ld:
> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acp=
i/tools/pfrut/pfrut.c:184:
> undefined reference to `uuid_unparse'
> /usr/bin/ld:
> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acp=
i/tools/pfrut/pfrut.c:189:
> undefined reference to `uuid_unparse'
> /usr/bin/ld:
> /home/luriwen/workspace/kernel/kernel.org/linux-git/linux/tools/power/acp=
i/tools/pfrut/pfrut.c:191:
> undefined reference to `uuid_unparse'
> collect2: error: ld returned 1 exit status
>
> $ make tools/firewire
>    SYNC    include/config/auto.conf.cmd
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    HOSTCC  scripts/kconfig/confdata.o
>    HOSTCC  scripts/kconfig/expr.o
>    LEX     scripts/kconfig/lexer.lex.c
>    YACC    scripts/kconfig/parser.tab.[ch]
>    HOSTCC  scripts/kconfig/lexer.lex.o
>    HOSTCC  scripts/kconfig/menu.o
>    HOSTCC  scripts/kconfig/parser.tab.o
>    HOSTCC  scripts/kconfig/preprocess.o
>    HOSTCC  scripts/kconfig/symbol.o
>    HOSTCC  scripts/kconfig/util.o
>    HOSTLD  scripts/kconfig/conf
>    DESCEND firewire
> make[3]: *** No rule to make target 'nosy-dump.o', needed by
> 'nosy-dump'.  Stop.
> make[2]: *** [Makefile:72: firewire] Error 2
> make[1]: ***
> [/home/kylin/remote/kernel/kernel.org/linux-git/linux/Makefile:1438:
> tools/firewire] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
>
> Thanks
>

