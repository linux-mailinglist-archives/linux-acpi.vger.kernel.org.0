Return-Path: <linux-acpi+bounces-16229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972CB3DCFF
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DF93A381A
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463222FF150;
	Mon,  1 Sep 2025 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0jtSfZS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9E2FE57B;
	Mon,  1 Sep 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716588; cv=none; b=m+D3Z4kJIOIq8mmRXL0SGug+3v/u28C6Ge2gCECfdm5TGQ3HyR9MSCuYHTiciIAew8C6aD1273uMwpT/VFBk6qMRd77olHQV+G7E59tHUz2i4ehYSk15nT2a6hhATCCjNNMMZdgdPQS/r+77PyR7XVW7QtmdnBeWgCf5SFrx8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716588; c=relaxed/simple;
	bh=eN3rF/XpgxlbHB7iVL/6wxQWaYXDjUVfI9JNDeD3dIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9gGTpk2QCQuCZBq/9DKZsI+y38q8qSwYtG95ekYEkHU1BGAyUE4MmxMxvcKi1Ie5Lml69UZhVtFZ4TuOYBOWoWhWab/EkDAEHWSLPNuEgum5gnATd/4jjOM3ttZ3TS1hErQTJILOk59B0xDBXOSS5u5AcWA8KZPRq2JjNfgQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0jtSfZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F34DC4CEF7;
	Mon,  1 Sep 2025 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756716587;
	bh=eN3rF/XpgxlbHB7iVL/6wxQWaYXDjUVfI9JNDeD3dIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X0jtSfZS/Q0x4Npcm1JKzCNN/H86TijIwtlufeP2WvBfRjHhMc6qaMczDeFucyWZg
	 4u9YG111UTdwhQFCwcozVdUhNGreyhzDXpXDJmExbGwTH09Zs5rgbvDELNZ2T+Hrzz
	 7UosiZBaw50Fk1KqJ7Qxnutv1FvD2hMZtu+fiYVq9v5S4z2i8rXu0C/LPz6sAp1Zmk
	 GhFnH2tJh62YA86JTAGCHaMM1Oy+ABRPP6rIWO/X4mRCahtse+/id3Oy0lYTRbV5BI
	 r2zPwNC7sx+zni7g/luznwyi/rphrVTIyT9SPFNEGzo1f10Rmr2wNDD8A8j7PlOtP7
	 cJowot3SQmS9Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e494a31c9so156400eaf.3;
        Mon, 01 Sep 2025 01:49:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/vm8/L6ByNsaJtaZywj1jKeU+0D9suH2TIPbam78gnJvhZorzdcJRxaTxB2+GGN/jJj52ppV2QYg=@vger.kernel.org, AJvYcCUutA0uhOgwDq+b0rpEBgKwOZt+fIb8tWfP2txMIDYZnwF/rc13p6GIJU3vZvXUQnYRJLCM2WJJO/88bSiY@vger.kernel.org, AJvYcCV4CijHmCEluNTREApeqp9IPUeVkz/lrfTOzLsg/E89R48zCJU+5f6T8sKR6YD6ACzJa0kQALpSDtLV@vger.kernel.org, AJvYcCW4ZqrMmH4i/MH3ET+3g3IsJH0krwjxwXXi8001vLkUB1R6IkuOKnJa4UO1S/R/qYtv3F3ixvaclsTClHaSTfqIUyAItw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8k5tBKjBz4CNJDBhy7ZCP7USeYS+ilIsfxlZcvmtAzvJzLJfp
	9xVYnMK7mrR8mjzXUQ9fH2l5igM4Fhm6F9DY04Iuym2LDaDhUX7yXQEmtSbTlVdMP/goAldXJOu
	MqI31WUGgXMonOjmILm0RCgrUJHI5aTs=
X-Google-Smtp-Source: AGHT+IEjuklhI2HgxrXlTU5+xNBZluh9ZtUHEtPXn51Tt8mrOvCD1WsbE+HWuA+OothJ+D4XnOTGy0MsWgcylLE0USQ=
X-Received: by 2002:a05:6820:1acb:b0:61e:2be3:97b4 with SMTP id
 006d021491bc7-61e335b8e70mr3291212eaf.2.1756716586860; Mon, 01 Sep 2025
 01:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 10:49:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hShKgPB42p4dOgKoRuMCkGhe+ZHMeAuFQO0Soa1ty_LQ@mail.gmail.com>
X-Gm-Features: Ac12FXzMmEpy7_S2vPwKHZCBK16NbUyLqit83VaVrIQd7I4lHmsDoPN7itRHEeA
Message-ID: <CAJZ5v0hShKgPB42p4dOgKoRuMCkGhe+ZHMeAuFQO0Soa1ty_LQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] ACPI: DPTF: Move INT340X enumeration from DPTF
 core to thermal drivers
To: Slawomir Rosek <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 7:34=E2=80=AFAM Slawomir Rosek <srosek@google.com> =
wrote:
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
>
> Slawomir Rosek (12):
>   ACPI: DPTF: Ignore SoC DTS thermal while scanning
>   ACPI: DPTF: Move INT3400 device IDs to header
>   ACPI: DPTF: Move INT3401 device IDs to header
>   ACPI: DPTF: Move INT3402 device IDs to header
>   ACPI: DPTF: Move INT3403 device IDs to header
>   ACPI: DPTF: Move INT3404 device IDs to header
>   ACPI: DPTF: Move INT3406 device IDs to header
>   ACPI: DPTF: Move INT3407 device IDs to header

Please avoid sending multiple patches with the same subject,
especially in one patch series.

Thanks!

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
>  drivers/platform/x86/intel/hid.c              | 41 +---------
>  drivers/platform/x86/intel/vbtn.c             | 30 +-------
>  drivers/thermal/intel/Kconfig                 |  1 +
>  .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
>  .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
>  .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
>  .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
>  .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
>  include/linux/platform_device.h               | 17 +++++
>  16 files changed, 161 insertions(+), 188 deletions(-)
>  create mode 100644 drivers/acpi/int340x_thermal.h
>
> --

