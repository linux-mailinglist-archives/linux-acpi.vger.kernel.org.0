Return-Path: <linux-acpi+bounces-10632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A8A10D4A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC6D3A0579
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F18323245A;
	Tue, 14 Jan 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Cke8AF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B331F9F60;
	Tue, 14 Jan 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874969; cv=none; b=tonJwcWuMtFuctdJTL9TCiWBe5oLWhthHioqAP2QGc7WVgX+ESWHUMe+Oo6PINoVWcwJSx2k183vnlTgzlB/hXagqT2g8sGtMTR07mn6Gyk+H5dccuhjwq4PqJj5l07LIUQn6DU7X0nuJf3NxbTWs7O7WMaQtNowkYsi1KsB3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874969; c=relaxed/simple;
	bh=48ICMic6ZGY3goYZwu+6B+5sfS14sVuJxRC03xYugCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkJoFFhHhUcdan+idhgJI2ShaVwXaYdfh91K7dO8icMiV8xSzp4toHqcH69jknFaqVMdc3EG4YpKUUEGO0pnF7pHWBm8pO4qDyGyohes2FhouPxp2ce/d9QwT59Vu4a8SuBZqCe22MJeTtU3kqCUbW1a0U5j/T7VVgWbD8vq5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Cke8AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8FDC4CEF1;
	Tue, 14 Jan 2025 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736874968;
	bh=48ICMic6ZGY3goYZwu+6B+5sfS14sVuJxRC03xYugCQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m3Cke8AFT47qcHpaUtC2bUsktu5VQ2/0+8jtk/NMwm9qOJqLbHt778XBt5TbSbmpj
	 1wAvhCRh6eOVbkDV+VjngNZdCx0OTYoP8VfCzLASrq1u2YRc+AhNoOQGOII19fQ6GN
	 GWGFZ2/DvxCoCrSPNTTCyNEdctsaOl3q/XbUOL26/8WDiw/vFyh9/DnVh1D+9Bs0Dw
	 7ZE7yQRrFvEo1Lub8UaLDwJxTXfmcb/vqzC+rRjQm3p4javqR4YgbXGae9uSnzig4+
	 GeK7AJoRu9tUGUz4X0GgQ/YbDDwwsgatgGYYZXYzh36lx1NYaMesBHLXyUjC2KE8ZA
	 DJ2YdGFDE/XGw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb9ba53f90so1432802b6e.1;
        Tue, 14 Jan 2025 09:16:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUB1QxWQAvIsDaoSmnmsBrQXDCbW4r0YKhdbUCbp2fxRi8OGJHrb6a0klZ3iRNePpLUqde1/MjRcUzVYQwD@vger.kernel.org, AJvYcCXgmjaAoeTGvS8JlyL2+ecLfwtcSFqdoN6yEn5OFtFBfFIK177HAcmSrSPZ38wK1SzY0zJW2bQZopOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa1ALcRH1410XyhrISl+r+f9DhjEt4lkH7ntn2j4xI6YeAURD
	8tIiu3Kxeo3k1qhYFqMQ8KErPZwKf2YOpVlFXAryBtSlIvNN8a3eiVIQy23gHwQcD9QRM1RbWov
	oH3aMqKlnHPjfNwgbg2NhiFBDSfU=
X-Google-Smtp-Source: AGHT+IFQLMH4Rl39Gt5IdD2nAY7jzl9K8Sve31dV391tpB8Rt18vGtcQvfE1Pi22pkeQ3or4Z2ifnf+fuoJuMCVhexs=
X-Received: by 2002:a05:6808:124a:b0:3eb:42d0:f3e with SMTP id
 5614622812f47-3ef2ebb90d0mr17932558b6e.7.1736874967201; Tue, 14 Jan 2025
 09:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114153726.11802-1-kuurtb@gmail.com>
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:15:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h44oOKNgfBhufpqaqOeeOJjwZrZbiCv4AD1V30JSuCSA@mail.gmail.com>
X-Gm-Features: AbW1kva1WPEduQNkdxKbrcDJicyDYI_muixIfDnk3juH-JJhyR75zh75bSZmVf8
Message-ID: <CAJZ5v0h44oOKNgfBhufpqaqOeeOJjwZrZbiCv4AD1V30JSuCSA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Hide platform_profile_handler from consumers
To: Kurt Borja <kuurtb@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
	Joshua Grisham <josh@joshuagrisham.com>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	"Lee, Chun-Yi" <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Lyndon Sanche <lsanche@lyndeno.ca>, Ike Panhc <ike.pan@canonical.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
	Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:38=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote=
:
>
> Hello,
>
> As suggested by Mario, I moved patch 15/18 to position 3/18. This indeed
> simplified all diffs. Full reordering bellow.
>
> Series based on top of pdx86/for-next branch.
>
> ~ Kurt
> ---
> v1 -> v2:
>
> 01 -> 04
> 02 -> 05
> 03 -> 01
> 04 -> 02
> 05 -> 06
> 06 -> 07
> 07 -> 08
> 08 -> 09
> 09 -> 10
> 10 -> 11
> 11 -> 12
> 12 -> 13
> 13 -> 14
> 14 -> 15
> 15 -> 03
>
> [1/18]
>   - Call put_device() if device_register() fails
>
> [2/18]
>   - Set and use drvdata for every driver in these series, instead of
>     patches 6-14
>
> [4/18]
>   - Renamed the `choices` callback to `probe`
>
> [15/18]
>   - Improve error handling in amd/pmf
>   - Improve error handling in asus-wmi
>
> [18/18]
>   - Fix typo
>   - Added documentation to platform_profile_ops
>
> v1: https://lore.kernel.org/platform-driver-x86/20250109150731.110799-1-k=
uurtb@gmail.com/
>
> Kurt Borja (18):
>   ACPI: platform_profile: Replace *class_dev member with class_dev
>   ACPI: platform_profile: Let drivers set drvdata to the class device
>   ACPI: platform_profile: Remove platform_profile_handler from callbacks
>   ACPI: platform_profile: Add `ops` member to handlers
>   ACPI: platform_profile: Add `probe` to platform_profile_ops
>   platform/surface: surface_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: acer-wmi: Use devm_platform_profile_register()
>   platform/x86: amd: pmf: sps: Use devm_platform_profile_register()
>   platform/x86: asus-wmi: Use devm_platform_profile_register()
>   platform/x86: dell-pc: Use devm_platform_profile_register()
>   platform/x86: ideapad-laptop: Use devm_platform_profile_register()
>   platform/x86: hp-wmi: Use devm_platform_profile_register()
>   platform/x86: inspur_platform_profile: Use
>     devm_platform_profile_register()
>   platform/x86: thinkpad_acpi: Use devm_platform_profile_register()
>   ACPI: platform_profile: Remove platform_profile_handler from exported
>     symbols
>   ACPI: platform_profile: Move platform_profile_handler
>   ACPI: platform_profile: Clean platform_profile_handler
>   ACPI: platform_profile: Add documentation
>
>  .../ABI/testing/sysfs-class-platform-profile  |  44 +++++
>  drivers/acpi/platform_profile.c               | 164 +++++++++++++-----
>  .../surface/surface_platform_profile.c        |  48 ++---
>  drivers/platform/x86/acer-wmi.c               |  58 +++----
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 +-
>  drivers/platform/x86/amd/pmf/sps.c            |  51 +++---
>  drivers/platform/x86/asus-wmi.c               |  55 +++---
>  drivers/platform/x86/dell/alienware-wmi.c     |  33 ++--
>  drivers/platform/x86/dell/dell-pc.c           |  60 ++++---
>  drivers/platform/x86/hp/hp-wmi.c              |  83 +++++----
>  drivers/platform/x86/ideapad-laptop.c         |  44 +++--
>  .../platform/x86/inspur_platform_profile.c    |  48 +++--
>  drivers/platform/x86/thinkpad_acpi.c          |  37 ++--
>  include/linux/platform_profile.h              |  51 ++++--
>  15 files changed, 474 insertions(+), 306 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profil=
e
>
>
> base-commit: 58126788aa7726c0e91de6b25e6e332fa06089ab
> --

Ilpo,

If you need any specific input from me on any patches in this series,
please let me know.

Otherwise, please feel free to route them all through platform/x86 when rea=
dy.

Thanks!

