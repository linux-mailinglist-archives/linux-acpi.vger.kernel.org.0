Return-Path: <linux-acpi+bounces-18112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF62BFD7C7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C47A4FC075
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5361272E63;
	Wed, 22 Oct 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRlhloua"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EC270551
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152570; cv=none; b=c9hFXeA6UO33QqFQ1cn4lsQsKXL+gyL9kRM5WGfQch1DZkCdGjmLSjVT/TFFCRimu26eiAddDQs7JdL0huBgUuUshSkGQL3DMdQam708+ebUO8Q1a0DCnncV1HKtIbOGO++RBWUpsr7OlBErS3CFCMsgO07y+rFzh1m2jXM56gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152570; c=relaxed/simple;
	bh=uQ64JgFOmAzJd+mPkZtVG+ihpVKVYP1nw4V7fBIcKF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay1/PAfp1CFwybC2s+l0b4t8BTtgB614FWT0AxOpTuPMkSZVPsBA65QIl2nFbX6Gx9jUWJOhqelLWUsZIrCGTSls8tosZ3fNfnnYc4deuHCeeeueye41421LFMikOXrmx0Y+UQaH/Jy3kKWY9WwwjSPAco0iKndQS8A2gEqOqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRlhloua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE23C113D0
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761152570;
	bh=uQ64JgFOmAzJd+mPkZtVG+ihpVKVYP1nw4V7fBIcKF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sRlhlouas6aCSesmJCpwCgMhuTYNTUv7lLIogOIis+naR8orH2qBwGRtTp6L6Ym66
	 RbcQ7kgKTBSTA+jqhjHc3DQQ1YbldHrndwPhqSaMfrG050duDP5+xUoknxXHlTR3mU
	 Y0dgMGREzd843297p5wlSOff3M2Mu3mv9Z2ETUSuhXNudblRQlCxwmeCSJufh2i6N3
	 P+udSZiF6AFs2XTUVollvSIgeXqIEBQ3hM0cAsWlwqkq0b6WcnRTqrggySzQPibwcZ
	 fsg3g0A4uEOsnYjqUcU2O+GgQXs4AlT00CfvPE3IzWq/bCWbTP4AqZRrcbmzWpTlSy
	 Jt+0iQQIs/nRw==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c0e357ab51so5867808a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 10:02:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYSKG1K8edaQMeWizi+2D85h3yGUfNISr5IbLzjs0nakqlMdE8xNObGruKnAWim54xzqYTbF2DMWEz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wMr7Tm0VQJJKavAMbcAVyyhKapXOmynR0zubUlpv90eEdqaW
	AFWOQsc2hjOh2oCtVRP6kcSJxQwsb4ypurOEJqZWXbHB/1WJ3Ay8TFS/86ozx4jtzaT2YNxGiAf
	A1huzL4rQBTK1wi9yGKvDfJcpXoDl5io=
X-Google-Smtp-Source: AGHT+IFsSLkS4AfOy5xcoE1SIc1rw+OhHunu+bX6yReuGG38wf86nNthgdGGvrwVmspSg8ngis0UUdzl53ovX1AjJdc=
X-Received: by 2002:a05:6808:14c8:b0:43f:75f0:3894 with SMTP id
 5614622812f47-443a2e90865mr8908912b6e.22.1761152569474; Wed, 22 Oct 2025
 10:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com>
In-Reply-To: <20251002113404.3117429-1-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 19:02:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hO3+eznWztqO2B78wpLXr3EZ+Nj0yOxqesfpb20ykOYQ@mail.gmail.com>
X-Gm-Features: AS18NWBlxJkUSv4HdoHV9K7LgQY0Hep2BdtAsCZ074SA2uAIDpGbEU_yqZ8QlaI
Message-ID: <CAJZ5v0hO3+eznWztqO2B78wpLXr3EZ+Nj0yOxqesfpb20ykOYQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ACPI: DPTF: Move INT340X enumeration from DPTF
 core to thermal drivers
To: Slawomir Rosek <srosek@google.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
rote:
>
> The Intel Dynamic Platform and Thermal Framework (DPTF) relies on
> the INT340X ACPI device objects. The temperature information and
> cooling ability are exposed to the userspace via those objects.
>
> Since kernel v3.17 the ACPI bus scan handler is introduced to prevent
> enumeration of INT340X ACPI device objects on the platform bus unless
> related thermal drivers are enabled. However, using the IS_ENABLED()
> macro in the ACPI scan handler forces the kernel to be recompiled
> when thermal drivers are enabled or disabled, which is a significant
> limitation of its modularity. The IS_ENABLED() macro is particularly
> problematic for the Android Generic Kernel Image (GKI) project which
> uses unified core kernel while SoC/board support is moved to loadable
> vendor modules.
>
> This patch set moves enumeration of INT340X ACPI device objects on
> the platform bus from DPTF core to thermal drivers. It starts with
> some code cleanup and reorganization to eventually remove IS_ENABLED()
> macro from the ACPI bus scan handler. Brief list of changes is listed
> below:
>
> 1) Remove SOC DTS thermal driver case from the ACPI scan handler
>    since its dependency on INT340X driver is unrelated to DPTF
> 2) Move all INT340X ACPI device ids to the common header and update
>    the DPTF core and thermal drivers accordingly
> 3) Move dynamic enumeration of ACPI device objects on the platform bus
>    from the intel-hid and intel-vbtn drivers to the ACPI platform core
> 4) Move enumeration of INT340X ACPI device objects on the platform bus
>    from DPTF core to thermal drivers using ACPI platform core methods
>
> Link to v1: https://lore.kernel.org/all/20250830053404.763995-1-srosek@go=
ogle.com/
> Link to v2: https://lore.kernel.org/all/20250917120719.2390847-1-srosek@g=
oogle.com/
>
> In v3 the SoC DTS thermal explicitly depends on X86_64.
>
> Slawomir Rosek (6):
>   ACPI: DPTF: Ignore SoC DTS thermal while scanning
>   ACPI: DPTF: Move INT340X device IDs to header
>   ACPI: DPTF: Move PCH FIVR device IDs to header
>   ACPI: DPTF: Remove not supported INT340X IDs
>   ACPI: platform: Add macro for acpi platform driver
>   ACPI: DPTF: Move INT340X enumeration to modules
>
>  drivers/acpi/acpi_platform.c                  | 27 +++++++
>  drivers/acpi/dptf/dptf_pch_fivr.c             | 10 +--
>  drivers/acpi/dptf/dptf_power.c                | 20 +----
>  drivers/acpi/dptf/int340x_thermal.c           | 76 ++++---------------
>  drivers/acpi/fan.h                            | 10 +--
>  drivers/acpi/fan_core.c                       |  2 +-
>  drivers/acpi/int340x_thermal.h                | 76 +++++++++++++++++++
>  drivers/platform/x86/intel/hid.c              | 33 +-------
>  drivers/platform/x86/intel/vbtn.c             | 30 +-------
>  drivers/thermal/intel/Kconfig                 |  3 +-
>  .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
>  .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
>  .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
>  .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
>  .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
>  include/linux/platform_device.h               | 17 +++++
>  16 files changed, 164 insertions(+), 179 deletions(-)
>  create mode 100644 drivers/acpi/int340x_thermal.h
>
> --

Srinivas, do you have any input on this series?

