Return-Path: <linux-acpi+bounces-20995-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHJ0BxNLk2mi3AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20995-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 17:51:31 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E631466B4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67EA3023E1C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Feb 2026 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12979236A73;
	Mon, 16 Feb 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaoiFfDb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336084A35
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260544; cv=none; b=ulS3ZL7HUs0Jh/DKANMXNRQCBPuW9tXuNwxFlwirEwb4h3WcPF+0jOIsy1eJjPodII7aSxUVMdQqdQg9f34IchpG/CYbHJGfKQWIUscMry18rdWAYYr5vFQok3/BrwRmIGeSlKdYW4SO0VgJMNiCViJdsiuatWeGQ7WD268y79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260544; c=relaxed/simple;
	bh=9HVmltDlDlggU2soJmd6BgCeRMGXKQX4AffdZPBqvpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqf/Re/NBEaJYHe95aZrsjgx2QCD90mKCakRxylGKZT9ds3SSSrkHAkX8T0OeO3Cpzx9MmWaxksEWsPArjV+fVr4tPHVmE726OpNZ5p5UxwZiK4dbuSxZjaPMXM5gGds1Yqk4CRhtvkTxdgtK9rhEOYntkZflay3RnqIURHU48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaoiFfDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AF4C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771260543;
	bh=9HVmltDlDlggU2soJmd6BgCeRMGXKQX4AffdZPBqvpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UaoiFfDbDRidecNWsyY3mxeNKysetjKe6dgiqnh1ZGyT9ZiAav92fzvFSClhwvBIW
	 JDA9TkM2UWWx3kWKnyeO/Wa/ZhFcEMdxkBxgrWbnAEghh9jQkdf/9O/5+A0PAh2wHK
	 uVvtXRqkPorWGEbaigKBHn2Xei4Lpugq80qkmrZmNjFmPCXlZG9xfjbgIVxzpIjXH/
	 1vnIZ4krn18FZSxaTy3YJaYT/0xE9DOU+n9fUh+MGNbicwuZZzx5K1oR/UNz7ahZOu
	 UryAeggQmpdsVnmg4zBgbBVOTBW+u3bKlS1X1WG92lw5uQsvI3jzXbwZH1s1iHLcTd
	 l7Vn30AicV0HQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6630d0685abso2103543eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2026 08:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8EPXdz26Ns3cOuK7GxxW3WrBLUGnSSbZWU8FB79PLejHuNX/naqcI92k5UPQq134S3/2Dh5+1fYtW@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqy8HHlHJ4Jk/mvEyGFtaLsW/NtsD/vct2tq53NuyAXEnSbFa
	G5Fd/9GD96nSVl4cT3iFZiSJ7jWp1uxaBztQgy8irPXI8Lfdhn4hQ6IXcB7j4iYlnZKcotl3Liq
	D/hh5eU/1kjK/U+/F8P2KCaANM4tDKhI=
X-Received: by 2002:a05:6820:f02f:b0:662:f8f6:e8d1 with SMTP id
 006d021491bc7-67766ad58c7mr5937063eaf.6.1771260542631; Mon, 16 Feb 2026
 08:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202602161929.wbtohM5r-lkp@intel.com>
In-Reply-To: <202602161929.wbtohM5r-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Feb 2026 17:48:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0huEjCiQAo3Gt2h8Y2p3tvcDYLop2ZrVb=0bp=7rkR66w@mail.gmail.com>
X-Gm-Features: AaiRm509luy4kP4VeVLbvXsshPFxXclt3QSQE__n5Bi_bSMkslyFTXBTJlJ3A84
Message-ID: <CAJZ5v0huEjCiQAo3Gt2h8Y2p3tvcDYLop2ZrVb=0bp=7rkR66w@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH UNVERIFIED WARNING 3cf2b08de92fc53cbd5632a8d47194932da78534
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20995-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 83E631466B4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:37=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge
> branch HEAD: 3cf2b08de92fc53cbd5632a8d47194932da78534  Merge branch 'expe=
rimental/acpi-driver-conversion' into bleeding-edge
>
> Unverified Warning (likely false positive, kindly check if interested):
>
>     drivers/platform/x86/toshiba_acpi.c:3574 toshiba_acpi_probe() warn: '=
&dev->miscdev' from misc_register() not released on lines: 3574.

This is a false-positive.

toshiba_acpi_probe() calls toshiba_acpi_remove() on errors and the
misc device is unregistered there.

> Warning ids grouped by kconfigs:
>
> recent_errors
> `-- i386-randconfig-r072-20260216
>     `-- drivers-platform-x86-toshiba_acpi.c-toshiba_acpi_probe()-warn:dev=
-miscdev-from-misc_register()-not-released-on-lines:.
>
> elapsed time: 1298m
>
> configs tested: 321
> configs skipped: 24
>
> tested configs:
> alpha                             allnoconfig    gcc-15.2.0
> alpha                            allyesconfig    gcc-15.2.0
> alpha                               defconfig    gcc-15.2.0
> arc                              allmodconfig    clang-16
> arc                              allmodconfig    gcc-15.2.0
> arc                               allnoconfig    gcc-15.2.0
> arc                              allyesconfig    clang-23
> arc                              allyesconfig    gcc-15.2.0
> arc                      axs103_smp_defconfig    clang-23
> arc                                 defconfig    gcc-15.2.0
> arc                     nsimosci_hs_defconfig    gcc-15.2.0
> arc                 nsimosci_hs_smp_defconfig    clang-23
> arc                   randconfig-001-20260215    clang-20
> arc                   randconfig-001-20260216    gcc-12.5.0
> arc                   randconfig-002-20260215    clang-20
> arc                   randconfig-002-20260216    gcc-12.5.0
> arc                        vdk_hs38_defconfig    gcc-15.2.0
> arc                    vdk_hs38_smp_defconfig    clang-23
> arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
> arm                               allnoconfig    clang-22
> arm                               allnoconfig    gcc-15.2.0
> arm                              allyesconfig    clang-16
> arm                              allyesconfig    gcc-15.2.0
> arm                         at91_dt_defconfig    clang-23
> arm                         bcm2835_defconfig    gcc-15.2.0
> arm                     davinci_all_defconfig    clang-19
> arm                                 defconfig    gcc-15.2.0
> arm                          exynos_defconfig    clang-19
> arm                          exynos_defconfig    gcc-15.2.0
> arm                          ixp4xx_defconfig    gcc-15.2.0
> arm                         lpc32xx_defconfig    gcc-15.2.0
> arm                       omap2plus_defconfig    gcc-15.2.0
> arm                   randconfig-001-20260215    clang-20
> arm                   randconfig-001-20260216    gcc-12.5.0
> arm                   randconfig-002-20260215    clang-20
> arm                   randconfig-002-20260216    gcc-12.5.0
> arm                   randconfig-003-20260215    clang-20
> arm                   randconfig-003-20260216    gcc-12.5.0
> arm                   randconfig-004-20260215    clang-20
> arm                   randconfig-004-20260216    gcc-12.5.0
> arm                           sama5_defconfig    clang-23
> arm                       spear13xx_defconfig    gcc-15.2.0
> arm                        vexpress_defconfig    clang-19
> arm                        vexpress_defconfig    clang-23
> arm                         wpcm450_defconfig    clang-19
> arm64                            allmodconfig    clang-19
> arm64                            allmodconfig    clang-23
> arm64                             allnoconfig    gcc-15.2.0
> arm64                               defconfig    gcc-15.2.0
> arm64                 randconfig-001-20260215    gcc-13.4.0
> arm64                 randconfig-001-20260216    clang-17
> arm64                 randconfig-002-20260215    gcc-8.5.0
> arm64                 randconfig-002-20260216    clang-17
> arm64                 randconfig-003-20260215    gcc-14.3.0
> arm64                 randconfig-003-20260216    clang-17
> arm64                 randconfig-004-20260215    clang-22
> arm64                 randconfig-004-20260216    clang-17
> csky                             allmodconfig    gcc-15.2.0
> csky                              allnoconfig    gcc-15.2.0
> csky                                defconfig    gcc-15.2.0
> csky                  randconfig-001-20260215    gcc-14.3.0
> csky                  randconfig-001-20260216    clang-17
> csky                  randconfig-002-20260215    gcc-15.2.0
> csky                  randconfig-002-20260216    clang-17
> hexagon                          allmodconfig    gcc-15.2.0
> hexagon                           allnoconfig    clang-22
> hexagon                           allnoconfig    gcc-15.2.0
> hexagon                             defconfig    gcc-15.2.0
> hexagon               randconfig-001-20260215    clang-22
> hexagon               randconfig-001-20260216    clang-20
> hexagon               randconfig-002-20260215    clang-22
> hexagon               randconfig-002-20260216    clang-20
> i386                             allmodconfig    clang-20
> i386                             allmodconfig    gcc-14
> i386                              allnoconfig    gcc-14
> i386                              allnoconfig    gcc-15.2.0
> i386                             allyesconfig    clang-20
> i386                             allyesconfig    gcc-14
> i386        buildonly-randconfig-001-20260216    clang-20
> i386        buildonly-randconfig-002-20260216    clang-20
> i386        buildonly-randconfig-003-20260216    clang-20
> i386        buildonly-randconfig-004-20260216    clang-20
> i386        buildonly-randconfig-005-20260216    clang-20
> i386        buildonly-randconfig-006-20260216    clang-20
> i386                                defconfig    gcc-15.2.0
> i386                  randconfig-001-20260215    clang-20
> i386                  randconfig-001-20260216    clang-20
> i386                  randconfig-002-20260215    clang-20
> i386                  randconfig-002-20260216    clang-20
> i386                  randconfig-003-20260215    clang-20
> i386                  randconfig-003-20260216    clang-20
> i386                  randconfig-004-20260215    clang-20
> i386                  randconfig-004-20260215    gcc-14
> i386                  randconfig-004-20260216    clang-20
> i386                  randconfig-005-20260215    clang-20
> i386                  randconfig-005-20260215    gcc-14
> i386                  randconfig-005-20260216    clang-20
> i386                  randconfig-006-20260215    clang-20
> i386                  randconfig-006-20260215    gcc-14
> i386                  randconfig-006-20260216    clang-20
> i386                  randconfig-007-20260215    clang-20
> i386                  randconfig-007-20260215    gcc-14
> i386                  randconfig-007-20260216    clang-20
> i386                  randconfig-011-20260216    clang-20
> i386                  randconfig-012-20260216    clang-20
> i386                  randconfig-013-20260216    clang-20
> i386                  randconfig-013-20260216    gcc-14
> i386                  randconfig-014-20260216    clang-20
> i386                  randconfig-014-20260216    gcc-14
> i386                  randconfig-015-20260216    clang-20
> i386                  randconfig-015-20260216    gcc-14
> i386                  randconfig-016-20260216    clang-20
> i386                  randconfig-016-20260216    gcc-14
> i386                  randconfig-017-20260216    clang-20
> i386                  randconfig-017-20260216    gcc-14
> loongarch                        allmodconfig    clang-19
> loongarch                        allmodconfig    clang-23
> loongarch                         allnoconfig    clang-22
> loongarch                         allnoconfig    gcc-15.2.0
> loongarch                           defconfig    clang-19
> loongarch                loongson64_defconfig    clang-19
> loongarch             randconfig-001-20260215    clang-22
> loongarch             randconfig-001-20260216    clang-20
> loongarch             randconfig-002-20260215    gcc-13.4.0
> loongarch             randconfig-002-20260216    clang-20
> m68k                             allmodconfig    gcc-15.2.0
> m68k                              allnoconfig    gcc-15.2.0
> m68k                             allyesconfig    clang-16
> m68k                             allyesconfig    gcc-15.2.0
> m68k                         apollo_defconfig    clang-19
> m68k                                defconfig    clang-19
> m68k                                defconfig    gcc-15.2.0
> m68k                       m5208evb_defconfig    clang-19
> m68k                       m5208evb_defconfig    gcc-15.2.0
> m68k                        m5407c3_defconfig    clang-19
> microblaze                        allnoconfig    gcc-15.2.0
> microblaze                       allyesconfig    gcc-15.2.0
> microblaze                          defconfig    clang-19
> microblaze                          defconfig    gcc-15.2.0
> mips                             allmodconfig    gcc-15.2.0
> mips                              allnoconfig    gcc-15.2.0
> mips                             allyesconfig    gcc-15.2.0
> mips                          eyeq6_defconfig    clang-19
> mips                           jazz_defconfig    gcc-15.2.0
> mips                     loongson2k_defconfig    gcc-15.2.0
> mips                          malta_defconfig    clang-23
> mips                malta_qemu_32r6_defconfig    clang-19
> mips                malta_qemu_32r6_defconfig    gcc-15.2.0
> mips                      maltaaprp_defconfig    clang-23
> mips                        maltaup_defconfig    gcc-15.2.0
> mips                   sb1250_swarm_defconfig    gcc-15.2.0
> nios2                            allmodconfig    clang-23
> nios2                            allmodconfig    gcc-11.5.0
> nios2                             allnoconfig    clang-23
> nios2                             allnoconfig    gcc-11.5.0
> nios2                               defconfig    clang-19
> nios2                               defconfig    gcc-15.2.0
> nios2                 randconfig-001-20260215    gcc-8.5.0
> nios2                 randconfig-001-20260216    clang-20
> nios2                 randconfig-002-20260215    gcc-8.5.0
> nios2                 randconfig-002-20260216    clang-20
> openrisc                         allmodconfig    clang-23
> openrisc                         allmodconfig    gcc-15.2.0
> openrisc                          allnoconfig    clang-23
> openrisc                          allnoconfig    gcc-15.2.0
> openrisc                            defconfig    gcc-15.2.0
> openrisc                    or1ksim_defconfig    gcc-15.2.0
> openrisc                 simple_smp_defconfig    clang-23
> parisc                           allmodconfig    gcc-15.2.0
> parisc                            allnoconfig    clang-23
> parisc                            allnoconfig    gcc-15.2.0
> parisc                           allyesconfig    clang-19
> parisc                           allyesconfig    gcc-15.2.0
> parisc                              defconfig    gcc-15.2.0
> parisc                generic-64bit_defconfig    clang-23
> parisc                randconfig-001-20260215    clang-23
> parisc                randconfig-001-20260216    clang-23
> parisc                randconfig-002-20260215    clang-23
> parisc                randconfig-002-20260216    clang-23
> parisc64                            defconfig    clang-19
> parisc64                            defconfig    gcc-15.2.0
> powerpc                          allmodconfig    gcc-15.2.0
> powerpc                           allnoconfig    clang-23
> powerpc                           allnoconfig    gcc-15.2.0
> powerpc                      arches_defconfig    clang-19
> powerpc                      arches_defconfig    gcc-15.2.0
> powerpc                       eiger_defconfig    clang-19
> powerpc                       eiger_defconfig    clang-23
> powerpc                     mpc512x_defconfig    clang-23
> powerpc                 mpc8315_rdb_defconfig    clang-19
> powerpc                    mvme5100_defconfig    gcc-15.2.0
> powerpc                     powernv_defconfig    clang-23
> powerpc               randconfig-001-20260215    clang-23
> powerpc               randconfig-001-20260216    clang-23
> powerpc               randconfig-002-20260215    clang-23
> powerpc               randconfig-002-20260216    clang-23
> powerpc                     skiroot_defconfig    clang-23
> powerpc                     tqm8540_defconfig    gcc-15.2.0
> powerpc                      tqm8xx_defconfig    clang-19
> powerpc64             randconfig-001-20260215    clang-23
> powerpc64             randconfig-001-20260216    clang-23
> powerpc64             randconfig-002-20260215    clang-23
> powerpc64             randconfig-002-20260216    clang-23
> riscv                            allmodconfig    clang-22
> riscv                            allmodconfig    clang-23
> riscv                             allnoconfig    clang-23
> riscv                             allnoconfig    gcc-15.2.0
> riscv                            allyesconfig    clang-16
> riscv                               defconfig    clang-23
> riscv                               defconfig    gcc-15.2.0
> riscv                    nommu_virt_defconfig    clang-23
> riscv                 randconfig-001-20260215    gcc-13.4.0
> riscv                 randconfig-001-20260216    clang-23
> riscv                 randconfig-002-20260215    gcc-13.4.0
> riscv                 randconfig-002-20260216    clang-23
> s390                             allmodconfig    clang-18
> s390                             allmodconfig    clang-19
> s390                              allnoconfig    clang-22
> s390                              allnoconfig    clang-23
> s390                             allyesconfig    gcc-15.2.0
> s390                                defconfig    clang-23
> s390                                defconfig    gcc-15.2.0
> s390                  randconfig-001-20260215    gcc-13.4.0
> s390                  randconfig-001-20260216    clang-23
> s390                  randconfig-002-20260215    gcc-13.4.0
> s390                  randconfig-002-20260216    clang-23
> sh                               allmodconfig    gcc-15.2.0
> sh                                allnoconfig    clang-23
> sh                                allnoconfig    gcc-15.2.0
> sh                               allyesconfig    clang-19
> sh                               allyesconfig    gcc-15.2.0
> sh                                  defconfig    gcc-14
> sh                                  defconfig    gcc-15.2.0
> sh                ecovec24-romimage_defconfig    clang-19
> sh                               j2_defconfig    gcc-15.2.0
> sh                          polaris_defconfig    gcc-15.2.0
> sh                    randconfig-001-20260215    gcc-13.4.0
> sh                    randconfig-001-20260216    clang-23
> sh                    randconfig-002-20260215    gcc-13.4.0
> sh                    randconfig-002-20260216    clang-23
> sh                          rsk7264_defconfig    clang-19
> sh                           se7751_defconfig    gcc-15.2.0
> sh                           sh2007_defconfig    gcc-15.2.0
> sparc                             allnoconfig    clang-23
> sparc                             allnoconfig    gcc-15.2.0
> sparc                               defconfig    gcc-15.2.0
> sparc                 randconfig-001-20260215    gcc-15.2.0
> sparc                 randconfig-001-20260215    gcc-9.5.0
> sparc                 randconfig-001-20260216    gcc-9.5.0
> sparc                 randconfig-002-20260215    gcc-8.5.0
> sparc                 randconfig-002-20260215    gcc-9.5.0
> sparc                 randconfig-002-20260216    gcc-9.5.0
> sparc                       sparc64_defconfig    clang-23
> sparc64                          allmodconfig    clang-23
> sparc64                             defconfig    clang-20
> sparc64                             defconfig    gcc-14
> sparc64               randconfig-001-20260215    gcc-9.5.0
> sparc64               randconfig-001-20260216    gcc-9.5.0
> sparc64               randconfig-002-20260215    clang-22
> sparc64               randconfig-002-20260215    gcc-9.5.0
> sparc64               randconfig-002-20260216    gcc-9.5.0
> um                               allmodconfig    clang-19
> um                                allnoconfig    clang-22
> um                                allnoconfig    clang-23
> um                               allyesconfig    gcc-15.2.0
> um                                  defconfig    clang-22
> um                                  defconfig    gcc-14
> um                             i386_defconfig    gcc-14
> um                    randconfig-001-20260215    clang-23
> um                    randconfig-001-20260215    gcc-9.5.0
> um                    randconfig-001-20260216    gcc-9.5.0
> um                    randconfig-002-20260215    gcc-14
> um                    randconfig-002-20260215    gcc-9.5.0
> um                    randconfig-002-20260216    gcc-9.5.0
> um                           x86_64_defconfig    clang-23
> um                           x86_64_defconfig    gcc-14
> x86_64                           allmodconfig    clang-20
> x86_64                            allnoconfig    clang-20
> x86_64                            allnoconfig    clang-23
> x86_64                           allyesconfig    clang-20
> x86_64      buildonly-randconfig-001-20260216    gcc-13
> x86_64      buildonly-randconfig-002-20260216    gcc-13
> x86_64      buildonly-randconfig-003-20260216    gcc-13
> x86_64      buildonly-randconfig-004-20260216    gcc-13
> x86_64      buildonly-randconfig-005-20260216    gcc-13
> x86_64      buildonly-randconfig-006-20260216    gcc-13
> x86_64                              defconfig    gcc-14
> x86_64                                  kexec    clang-20
> x86_64                randconfig-001-20260216    clang-20
> x86_64                randconfig-002-20260216    clang-20
> x86_64                randconfig-003-20260216    clang-20
> x86_64                randconfig-004-20260216    clang-20
> x86_64                randconfig-005-20260216    clang-20
> x86_64                randconfig-006-20260216    clang-20
> x86_64                randconfig-011-20260216    clang-20
> x86_64                randconfig-012-20260216    clang-20
> x86_64                randconfig-013-20260216    clang-20
> x86_64                randconfig-014-20260216    clang-20
> x86_64                randconfig-015-20260216    clang-20
> x86_64                randconfig-016-20260216    clang-20
> x86_64                randconfig-071-20260216    clang-20
> x86_64                randconfig-072-20260216    clang-20
> x86_64                randconfig-073-20260216    clang-20
> x86_64                randconfig-074-20260216    clang-20
> x86_64                randconfig-075-20260216    clang-20
> x86_64                randconfig-076-20260216    clang-20
> x86_64                               rhel-9.4    clang-20
> x86_64                           rhel-9.4-bpf    gcc-14
> x86_64                          rhel-9.4-func    clang-20
> x86_64                    rhel-9.4-kselftests    clang-20
> x86_64                         rhel-9.4-kunit    gcc-14
> x86_64                           rhel-9.4-ltp    gcc-14
> x86_64                          rhel-9.4-rust    clang-20
> xtensa                            allnoconfig    clang-23
> xtensa                            allnoconfig    gcc-15.2.0
> xtensa                  audio_kc705_defconfig    gcc-15.2.0
> xtensa                randconfig-001-20260215    gcc-12.5.0
> xtensa                randconfig-001-20260215    gcc-9.5.0
> xtensa                randconfig-001-20260216    gcc-9.5.0
> xtensa                randconfig-002-20260215    gcc-9.5.0
> xtensa                randconfig-002-20260216    gcc-9.5.0
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

