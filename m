Return-Path: <linux-acpi+bounces-11940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5ECA5731C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9293B3B284C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255BD2571DD;
	Fri,  7 Mar 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSoOhW6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA023E23D;
	Fri,  7 Mar 2025 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380750; cv=none; b=o3s+9HZm2A2M3Vr0LoSGeemJk8/XoNNqt8frsjCWCeO34TOuIQccvL94P9J7GWqigkvh7qdjLP9zym9SFxyOBNO0nmFt+WK3aKGZDyCyNATk1zuP/0KlE/+Tr6ze+sKgjcNA/Q8IW20AwgW365/z377L37z1ZeKPKWONQ/vc6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380750; c=relaxed/simple;
	bh=epIESvwJQ4A800m0OQuNtY9wYZR7fyWidu1Wwrp0+MI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LUyog2ExMs8A4bGKxP1LDE+0OWW9H4w+1aWqCsn2eDCdAknVH0y1ccffh20jkwUX5o5o66fLaSMPR9CLbGahkYcgLccwSSdqkm3GJlzBQiAnWipru+L0De9oY0hukBXYO+VSZkVgTVgZW/xaC0bzHf8uuI6TjhmIA18xO4x/MZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSoOhW6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7E1C4CED1;
	Fri,  7 Mar 2025 20:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741380749;
	bh=epIESvwJQ4A800m0OQuNtY9wYZR7fyWidu1Wwrp0+MI=;
	h=From:Date:Subject:To:Cc:From;
	b=jSoOhW6m8KcOBhWinGWXVdJzZV987iMoCwwx0Or8XupMN2i6YSMIa81RvvcwoYMQq
	 OmzN04w+BqqtAw2G92GQz1f5WO6x4Slzqd28Vd5xEaJu0w6MoXga4aB29nph8k8ht0
	 g/frb7JAHPX/2LyrCn1qszuCZ/7GRbEv5V1HbbOP2C3dVfIVjPP6bf8Bn0HxP5Amgr
	 F1pZVUNLnsMbEK4DfrVJkiLKwoV2XS3LDVU+/D3UFGDVXKUjpKMtvPhzmgSXH/EK8T
	 /pvtTex6OSqhCIOJh4+SRoBaa7r+q2EQSISMJpQVKfPhZwAU5z2e55TseNLxI5bT5w
	 XjahZTEo/LBTA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-600250a14f4so1748800eaf.1;
        Fri, 07 Mar 2025 12:52:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGR4DuLbsPrsoY5Sd6qREBFFy5I0swsBHGZhVqzzQ+s4YwJtTmeLksLngPdg6xIbDy0kOsAXA2AbWWZBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHHwqmKL47G6KAm6iCiv+pLPYJrIuPdU1Ma2t95oxRsr7nXo55
	VggX/wZVK+r495okehaSptwOS+W/xokDN9lhrHX2GKF2NVmxoUBozsYZ39PU6pPCYwh+1HiRJRz
	ESLwlbmBuUnlcfBZDao9tB/MohIU=
X-Google-Smtp-Source: AGHT+IGJyazw4kTZ1p2w16Mu1ZD/qhBMjysOjGezvcsEH/kYyi+Jc0C4Epq9u2wZKkcMRpPo9Btbya+7HsCqEVSnohs=
X-Received: by 2002:a05:6870:f719:b0:2c2:37db:dad with SMTP id
 586e51a60fabf-2c281e514f7mr500774fac.1.1741380748756; Fri, 07 Mar 2025
 12:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Mar 2025 21:52:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g8fE1TvUNyN5PXiRexycuWn63inwdKon5aR=BM7cBHYg@mail.gmail.com>
X-Gm-Features: AQ5f1JrGMZDwJeo9jEaE6ckyVlQ71kxPsuGRLBKIfbLqKmEF_MOKd_oXBLPuLdo
Message-ID: <CAJZ5v0g8fE1TvUNyN5PXiRexycuWn63inwdKon5aR=BM7cBHYg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.14-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.14-rc6

with top-most commit 9a43102daf64dd0d172d8b39836dbc1dba4da1ea

 platform/x86/amd: pmf: Add balanced-performance to hidden choices

on top of commit 7eb172143d5508b4da468ed59ee857c6e5e01da6

 Linux 6.14-rc5

to receive an ACPI fix for 6.14-rc6.

This restores the previous behavior of the ACPI platform_profile sysfs
interface that has been changed recently in a way incompatible with the
existing user space (Mario Limonciello).

The tag above has been signed with a new subkey recently added to my
key, so if there's any problem with verifying it, please kindly let me
know.

Thanks!


---------------

Mario Limonciello (3):
      ACPI: platform_profile: Add support for hidden choices
      platform/x86/amd: pmf: Add 'quiet' to hidden choices
      platform/x86/amd: pmf: Add balanced-performance to hidden choices

---------------

 drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++++++++---------
 drivers/platform/x86/amd/pmf/sps.c | 11 +++++
 include/linux/platform_profile.h   |  3 ++
 3 files changed, 87 insertions(+), 21 deletions(-)

