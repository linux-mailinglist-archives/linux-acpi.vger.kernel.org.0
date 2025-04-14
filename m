Return-Path: <linux-acpi+bounces-13026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDFA885EA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5820169D41
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DB28467F;
	Mon, 14 Apr 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ0Y01ot"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737E27979C;
	Mon, 14 Apr 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641987; cv=none; b=hPNxIAs1KUEBZwI03+p2h1hRfmq4NQgQ6aS5vQxtY8KzDf1yvSAF4dok41pEgoWNGe+pjKAQmI60TloBh34Izd42RBT5MbiQ6FJ88VwDRN6VPa8KkjqWVS8D+n+mC8+remjw2aTbmCwHOToPaQZ23NPVuA/1lQ2qDxhbMnYtFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641987; c=relaxed/simple;
	bh=S29U305YrHYWEtS+ERWWLRsX0OdUBwdRGM/0t+nnDt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iy9vFa7ZWHa/UWfF903zJ7joxELgSh+GZq4yFVFOg9yKHRBrggyOB/IbRGy2/sx+t+5Nd+FAofh5+9XGisHz784Nf4fc4otXZicLOUUBt42AUa5iQU1pTCL5s1R5XvxzLO/QX1VMR9yJmP/X05EDH1XwWhxZ0ieOPIXhzbxpDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ0Y01ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF49C4CEEE;
	Mon, 14 Apr 2025 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641986;
	bh=S29U305YrHYWEtS+ERWWLRsX0OdUBwdRGM/0t+nnDt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JQ0Y01otW5+3Zp2JITk0fBxxxGkeCAKlRiQALAwwxZ+PKKc9lOeR6O1WcUunPmTR0
	 qdPnfIWSHSY35E96UftLffNBgJ3F+gM8cw+V4GUSQ4nAwf2RRs6jmtmS576vRsQ4yE
	 bOnXiaqE165UtGAsvoyNypNsuVg0+WD6jDEcDwiY6sZ5YyO0aoNMCaSFy7jahOkUv5
	 PUjWWpux/KXX2+8Ya2LqGoNlM2LTDYFIIJpODXqPA44EZjPB5XOT6/vbsEDOhsMeks
	 Cg5Tuz+vIW/wwN0tMZPsjif3tcY3J+7ZMlrrTIKF4+B8k5pvBXjd6N+2GwRP1vrWoO
	 jEBnJiBEb7KjA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d0d25cebfeso2410361fac.2;
        Mon, 14 Apr 2025 07:46:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpYiWKsCg/F+izMYkNPhjKpguhM92hGuhauPGL7X2JgnN5j/RgU1PS4EL64oC2qVJfSC6x6+B0D9pt@vger.kernel.org, AJvYcCXzaMOtO2GKCVXHdh3zpcqEihIpAc/jvvRDg55n8VeMTZ18SD0vDTSbnnPMZS00tCqsuFMde+GgHPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbGkQpGkCq+H20bu84vE7lzsEVUEEQLplp6D/GAj/5lL7S0+J
	CPGftqFlr3ZlXbw3c/b564LhCPVX1TUbKLaLJLTny/vg5//qvSo0/F15prw4kUO+CQkXUYeIDBJ
	Vt99QFLdPqabRsuJ0aTXvh8BvpEo=
X-Google-Smtp-Source: AGHT+IFD2HAC1uPDSqKMkfmAB8xAHT8A7ARt3gn+V3c7TseAQt505MuQ+0A/mFEcMcpJ6KXXySIlrqdLo6OPRECFuaI=
X-Received: by 2002:a05:6870:cd85:b0:2d0:4780:65f2 with SMTP id
 586e51a60fabf-2d0d5d8dcbemr7376333fac.21.1744641985809; Mon, 14 Apr 2025
 07:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504121050.dgHmFeWe-lkp@intel.com> <20250413-brawny-certain-bullmastiff-da71fa@sudeepholla>
In-Reply-To: <20250413-brawny-certain-bullmastiff-da71fa@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Apr 2025 16:46:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jL4b2fsASHnrM2w6Lb9xu3=OCkuvgMGPQ2jP=vEpFxRA@mail.gmail.com>
X-Gm-Features: ATxdqUEVL59NddJ3KoFp4agwMU_EIdZDUBJyapPhOMzQ1ViKVPFjNlqc--ehfbE
Message-ID: <CAJZ5v0jL4b2fsASHnrM2w6Lb9xu3=OCkuvgMGPQ2jP=vEpFxRA@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 44/52] drivers/cpuidle/cpuidle-psci.c:437:54:
 error: expected identifier
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Sun, Apr 13, 2025 at 5:01=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> Hi Rafael,
>
> On Sat, Apr 12, 2025 at 10:36:41AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> >
>
> [...]
>
> > >> drivers/cpuidle/cpuidle-psci.c:437:54: error: expected identifier
> >      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, t=
rue);
> >          |                                                      ^
> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >        8 | #define NULL ((void *)0)
> >          |              ^
> > >> drivers/cpuidle/cpuidle-psci.c:437:1: error: type specifier missing,=
 defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplic=
it-int]
> >      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, t=
rue);
> >          | ^
> >          | int
> > >> drivers/cpuidle/cpuidle-psci.c:437:19: error: a function declaration=
 without a prototype is deprecated in all versions of C [-Werror,-Wstrict-p=
rototypes]
> >      437 | module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL, t=
rue);
> >          |                   ^
> >          |                                                             =
   void
> >    3 errors generated.
> >
> >
> > vim +437 drivers/cpuidle/cpuidle-psci.c
> >
> >    436
> >  > 437        module_faux_driver(psci_cpuidle, psci_cpuidle_probe, NULL=
, true);
> >
>
> I think you asked me correctly on v1 [1] to pick up, but I assume with
> patchwork, may be you picked up v2 instead. The link in the commit log is
> pointing at v2.
>
> [1] https://lore.kernel.org/all/20250317-plat2faux_dev-v1-1-5fe67c085ad5@=
arm.com/

Yeah, I've applied the v1 now, thanks!

