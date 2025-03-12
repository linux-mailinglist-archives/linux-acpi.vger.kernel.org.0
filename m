Return-Path: <linux-acpi+bounces-12130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4741A5E44F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B3A3B70AA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E272571DE;
	Wed, 12 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZxxX5jk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9B1CF96;
	Wed, 12 Mar 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807424; cv=none; b=lZ+hsEcjbyVSiw+boSHfQ6IHeunjrswXnTzXO3rVz8QuIu7/di2hPjG2N2wOCQcEIKbH1hyjFFUMng5oJqaEUnvL6cRij5fmQc9GqzSfK2mDvJDz1o9sgwRKHQTq62VBaoQiV2mzSqo1cSUg4uAVp35Nf7AsBzVtYHgcf0mmozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807424; c=relaxed/simple;
	bh=qk+sYtAMNjTS8ab4Su+xjDH77o6/bEg0NUz5rCc1fxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnfDZCAxPutg+gBv3jRv27lBfrqAyFt8hJZ+kKEJdtY2aSjdowEo6YtXkEd71cj7sRXGp3hvDiXmqV0I52NRBBXYFaqc6kcIAzoGhhZ0iIxXsKqLT4qXVCYyTX0qlCIDcuriv54/3LLeC83w5l05eU4oU4te7D2PzSOZmhK3eBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZxxX5jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AF8C4AF09;
	Wed, 12 Mar 2025 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807423;
	bh=qk+sYtAMNjTS8ab4Su+xjDH77o6/bEg0NUz5rCc1fxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bZxxX5jkYKR4OcWAOnzFnD2w6bIg8MkwTtyDBEW9ouNRejSJavZdjhXY3HnG1MNlF
	 4chb1d4U53NTDcwV1nDi7w0dY6i9i6RD2hOufrb38rYPFpaue4dWLi4lvSWKNPNtmZ
	 vGDl4yzaTpbkcppWfc0yAH1RGpBCEhR4/asO99BoTy5T+hHuTSO5+jnSo9JZmRFBi/
	 WCfWAfVlrMN7dp3PZs0dbbrW3JcK+SH1EokS3uDL571FgJyRga8SvM8rc04MP+mzNX
	 IpJBeRrWMM0HTXSxiyfS8VG5QqtSwVZINNdukEut1HulIzEQMRvk0TG+MMutOZyf0M
	 AU12S2OSLGGtA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b2b6019a74so139181fac.0;
        Wed, 12 Mar 2025 12:23:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/kBwEhu89uY2QkfBlCBYli9avO3AdY1Z5B5mulITOkI2/GzUyQNKhP6GILSXbRVmyyUeklZ3He/dPZjsT@vger.kernel.org, AJvYcCWzKRSVw8v00rpJFF5y+eME3fDaYkRfIoU9MtSasrp2qQ6ie+1FWlYbs+Gcp4JXlZew150uvbevOmUW@vger.kernel.org, AJvYcCXxWTfKVzkWMwb+s6GtjAnDXu2NfnakdrTnU26gmSY1PvYHYIVVIKBenk0G02ugY+97mRYEAJJcNkIy9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rlxT3BScs3l5/2T9ldgbnpT7JeuIcpzDwdszpPPV24PGtK/l
	8JQNe0qvJc60Jv9HYVJo/qOOhE6hHL0AtencGnqP/pXP52NUQ5Spx30xIa6H2GV/vZbYeJYplW1
	faF2+TDbJg2ZaaPswI/p2YInrxSA=
X-Google-Smtp-Source: AGHT+IExKgixAomysE1WTCv5vmvxjoRBLCX7DMiIhR9d1Y81QNdc/yHsmgNJLtvKlgnFJXlDKYUVhGUN8K8l76IvkUQ=
X-Received: by 2002:a05:6871:109:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2c261304b27mr13457476fac.30.1741807423019; Wed, 12 Mar 2025
 12:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305220146.3932955-1-superm1@kernel.org>
In-Reply-To: <20250305220146.3932955-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:23:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gowcNwmLc_q508DcqgtGAP3z9bNoFB-0jdtLBZZ1TNzQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr013KghzqSJ9xWt3J1PWumwVjVKxjebppmHBRt5pH4Ho1Xwd8wne-zQd8
Message-ID: <CAJZ5v0gowcNwmLc_q508DcqgtGAP3z9bNoFB-0jdtLBZZ1TNzQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 0/2] Add LPS0 check() for pinctrl-amd
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:01=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> During suspend the pinctrl_amd driver disables the interrupts for
> any GPIOs that are not marked as wake sources.
>
> This however does not prevent them from changing the wake status
> bit during suspend, it just stops the system from waking.
>
> If the system wakes from hardware sleep for another reason (such
> as plugging in the AC adapter) this wake bits might be active.
>
> This could potentially cause problems with going back to hardware
> sleep.  Add an extra debugging message when PM debugging is enabled
> to help identify if this is happening.
>
> ---
> I'm resending this because kw seemed to have split the patches on
> separate mailing lists and the lkp robot didn't know and reported
> failures.
> No changes from v3 -> v3 RESEND
>
> Mario Limonciello (2):
>   ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
>   pinctrl: amd: Add an LPS0 check() callback
>
>  drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
>  include/linux/acpi.h          |  9 ++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> --

I've dropped this because of a build issue in linux-next introduced by it:

https://lore.kernel.org/lkml/20250312235829.2ac0c991@canb.auug.org.au/

