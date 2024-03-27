Return-Path: <linux-acpi+bounces-4504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E71888E974
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE63A1F254E7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A36FE35;
	Wed, 27 Mar 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lunxU8RP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4194503E
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553901; cv=none; b=gBCL4dtR6BwDFkaLsEsbSJkX7vcuTZ4ezdKt5KNqQE6feo4f85nCheTwFsga73NbFnLrNWIIsbVR5wlwweBFK5kAibyINtji0ctb3j66t25raZX/Fk/CF5jXCIgRzsQZ8yc3wV/7tU1BT7mlBxjQ+FpQxelSP+zH9OgNiAGvDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553901; c=relaxed/simple;
	bh=TGWadAQ2tq+tUMMTgxCSdYAEq4JOsOJtttw1w9qZKOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlhGTugkGv//4jqDgLO7M4THsIgmZf6lL6g4UDAomNx9vc8mmvGRthvXHpLkj2LkG+uVenqGclDCbQq/0p4WTxoe936l9PWOKNNazj30+OzSiOP9fqRcLelgEQACOVv6VQYRlmstFWl0VZMHGpIyD+47LGKiUVKLcC9MRysaAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lunxU8RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB8EC433A6
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553901;
	bh=TGWadAQ2tq+tUMMTgxCSdYAEq4JOsOJtttw1w9qZKOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lunxU8RPo8KfeYLsx9DflJhnnKCrYWqRiBTy0anmWpnIbmQWZ9PtTSDctAuvHS8et
	 8/8BS+r8LN3Q7r82ZGbOoonEDhPhwcrn9QPqygS5xb1zCPhFVVb8hm3icP8pdBmDME
	 1sLndGbTVl/YrxXXx1+v5aaklpbP6g1GHRDiyJNbekuid9tQBUYqZ1yfHZpDGUe0gG
	 dfwcZzdfNTDfj850j6tz8hMPRHKOUFsrtuuRDUjcZtEi4VJ8HVhfarxxWrvVMv4qZ5
	 dXkZ9JUvxnUcMC9I+UrSwRL/vwWvmCd09umLc+SxAmgkZevK4+Q3+ydUMBGbyhfuzb
	 NUdBFpwaZEUXg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a47680a806so1674327eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 08:38:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUen/0YfXkcFOAlr7TSI0T0FVaUmwV4WUyJP2jm9o4YtCOneaI4SmKaqSPi99NR5nt6aBml9ZYi4xs1QtYtrYuicttLOVYKAgbPIA==
X-Gm-Message-State: AOJu0YxeGWXkX9hTqCKxo33MQ7BGtvv29mM+KpigRTTt3TI1QI0L62E3
	282fwwnTpjdFE1QWynnL/BqWcxVi36j8lwf03enlHM+cbppKyUcHp7CIbMD/uMIG+HGaNKw2XM3
	rJ5hVpAR6ibTBCicbX1ZX/qjga7g=
X-Google-Smtp-Source: AGHT+IHoWak7xNJJgMoGB8zzNTCbHPaxIgA8QqRXrG/qY+kTaMz3BM5vrxEIrAPlebjcSKXMXnX5Kfyy4tt8O1xsYog=
X-Received: by 2002:a05:6808:13cc:b0:3c3:ce25:ac93 with SMTP id
 d12-20020a05680813cc00b003c3ce25ac93mr288708oiw.2.1711553900445; Wed, 27 Mar
 2024 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319083018.3159716-1-cezary.rojewski@intel.com>
In-Reply-To: <20240319083018.3159716-1-cezary.rojewski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:38:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ixaTvE2pejR4mTZUQHsYJU5MTaoCVsdq19UwcEgqqo1w@mail.gmail.com>
Message-ID: <CAJZ5v0ixaTvE2pejR4mTZUQHsYJU5MTaoCVsdq19UwcEgqqo1w@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] ACPI: NHLT: Access and query helpers
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, 
	amadeuszx.slawinski@linux.intel.com, pierre-louis.bossart@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:28=E2=80=AFAM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> The goal of this patchset is to refactor existing interface of
> Non HDAudio Link Table (NHLT) table so it becomes useful for the Intel
> AudioDSP sound-drivers. Right now the useful duplicate resides in
> sound/hda/intel-nhlt.c.
>
> The API takes form of query functions that help access device or
> audio-format configuration space. This information can be then utilized
> by a sound-driver to perform necessary programming and facilitate
> streaming over I2S/PDM interfaces. Once the series is merged, existing
> sound-drivers can move from utilizing sound/hda/intel-nhlt.c to this
> very code and ultimately the former file can be removed.
>
> Paired with equivalent change on ACPICA [1].
>
> -
>
> Non HDAudio Link Table (NHLT) is designed to separate hardware-related
> description (registers) from AudioDSP firmware-related one i.e.:
> pipelines and modules that together make up the audio stream on Intel
> DSPs. This task is important as same set of hardware registers can be
> used with different topologies and vice versa, same topology could be
> utilized with different set of hardware. As the hardware registers
> description is directly tied to specific platform, intention is to have
> such description part of low-level firmware e.g.: BIOS.
>
> The initial design has been provided in early Sky Lake (SKL) days. The
> audio architecture goes by the name cAVS. SKL is a representative of
> cAVS 1.5. The table helps describe endpoint capabilities ever since.
> While Raptor Lake (RPL) is the last of cAVS architecture - cAVS 2.5 to
> be precise - its successor, the ACE architecture which begun with
> Meteor Lake (MTL) inherited the design for all I2S and PDM
> configurations. These two configurations are the primary targets for
> NHLT table.
>
> Due to naming conflicts with existing code, several structs are named
> 'nhlt2' rather than 'nhlt'. Last patch cleans the situation up.
>
>
> Changes in v8:
> - fixed file headers for all added files
> - commit messages now carry links to ACPICA PRs and relevant commits ids
>
> Changes in v7:
> - added missing headers to nhlt.c/nhlt.h as suggested by Andy
>
> Changes in v6:
> - added comments explaining usage of LINKTYPE and DEVICETYPE constants
>
> Changes in v5:
> - split find_endpoint/fmtcfg() into tb-less and tb-aware variants.
>   This is to make API scale with 2+ NHLTs and removes the need for
>   acpi_gbl_nhlt to be accessible globally.
> - acpi_nhlt_device_config now a union that encompasses all device_config
>   types.
>
> Changes in v4:
> - relocated ACPI_NHLT kconfig in the drivers/acpi/Kconfig to a more
>   relevant area within the file
>
> Changes in v3:
> - uncapitalized acpi_gbl_NHLT
> - fixed compilation problems when CONFIG_ACPI_NHLT is disabled
> - dropped Reviewed-by tags in the 2/4 patch due to above, those were not
>   one-line changes
>
> Changes in v2:
> - minor wording improvements in kernel-doc for patch 3/4
> - dropped parentheses around loop cursors in for_each_nhlt_*() macros
> - readability improvements in compound if-statements within query
>   functions
> - dropped NULL-checks in query functions
>
> [1]: https://github.com/acpica/acpica/pull/912
>
>
> Cezary Rojewski (4):
>   ACPI: NHLT: Reintroduce types the table consists of
>   ACPI: NHLT: Introduce API for the table
>   ACPI: NHLT: Drop redundant types
>   ACPI: NHLT: Streamline struct naming

All applied as 6.10 material, thanks!

