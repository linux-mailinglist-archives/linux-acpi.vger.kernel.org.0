Return-Path: <linux-acpi+bounces-18675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B6C41788
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 20:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 961F74E517E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA9336ECC;
	Fri,  7 Nov 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef58Lus/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334532D7D3
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544913; cv=none; b=Gnn+95e34eVJGjFDUrjKA47S6F4o0iXJDl0o6eP81yVK9OXt4S1oTC4bKziA5Bqei8tycs1RTaLxnoqD6w5ast2KTn1Xn+DsbbOXRg39AmbmMfpKTJmFf2nCeFy9prkySimSEwbTEICz3Oguy4wrEbL8EZ3TXN5n3o/sjl1Btqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544913; c=relaxed/simple;
	bh=jVmrd4OImxyn7gwQSEP1GTQ4NDcZIuueF+51qwhy7Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSM0tHj0CeGjfUH8xXxErWLcM0BhwDDmSBM5+NUSESjhYnAtWwMbVTebN8Eb07VHaiZbCOyZrvoKR5yG0TQJ2Hs0GygqRIJoVHNAwpAUQuYI8+yL98rySFt1Ms8wDusiBpsk4V24tROOnrEZA7b4Co4ziwgHeg0oFJOkqJyuV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef58Lus/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ED7C4AF0B
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762544913;
	bh=jVmrd4OImxyn7gwQSEP1GTQ4NDcZIuueF+51qwhy7Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ef58Lus/T4l61OLQyp3LuWhB4ykyNSOTnZve3WeJtIWNIjIu7DtTPYdUo65b51np3
	 5nP2Aix/uRNEDOV5f2XfNiAuSy392lJ8pE+H/4WHede8R/gBk1mnBQhAHtOFDag0Y3
	 AYjc54nhVDMP7en0zClM8jMTStFGzRjtybyDdJCXQPQ3IC1lHuTYZpDPyGT6RmL/1d
	 IQV0lIs6BG6DGx5XrKEihBaOL2et+TZvewZR40aTB3SELTNaNyG7+icgZvTIveuZg+
	 ND1S3YOz0Oelwtg3vTBIjVwoRM/oorpAtqakl/9fyJTUcEgn3M0IjTZioDTwD3K2I6
	 tfvcbpQ9uNr/Q==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fffff5f73so562490b6e.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 11:48:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvgw6ry3xTjJ3KfQYBa5rMENrqgcMxiIqAsuVYq9tJOkSSDBKbUdBtgMf+vjs7sa0qatlNRN0DrYDM@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1kbxQFvcnnKcnavil0ylicCVOlmXTNTWRHLti14Eq2yis0U9
	wbQ8bu/yBd4pVpIp45elmTY1B79ZXs68JLg7zi+u6yOHBAxsNbJd0axc+OUJkX/ZtHGPIVoMs4X
	SCa8eJqakADBgAMZzdzl6GS9C0YjNbvY=
X-Google-Smtp-Source: AGHT+IFfjcZQMaSMf/O0E7bHDvyenSz2TU7wnFXyLVZ2U6iGaSEGM0Li0KrPZeYcaNcWs96gi7YlfQIKTtL1lzqsBTE=
X-Received: by 2002:a05:6808:4f13:b0:43d:2e06:4e84 with SMTP id
 5614622812f47-4501c747f7fmr1415267b6e.13.1762544912008; Fri, 07 Nov 2025
 11:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103162516.2606158-1-srosek@google.com>
In-Reply-To: <20251103162516.2606158-1-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 20:48:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jPdfut_QHz9f0x+SSexD_i8xEb5bhkzMv_m=a598Hqxw@mail.gmail.com>
X-Gm-Features: AWmQ_bk_tz9nQGJAp7GZKrIe43u7pcO4azGS2YQ7FnFcvmD2-6KLrj0eNLfHFuw
Message-ID: <CAJZ5v0jPdfut_QHz9f0x+SSexD_i8xEb5bhkzMv_m=a598Hqxw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ACPI: DPTF: Move INT340X enumeration from DPTF
 scan handler to ACPI core
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

On Mon, Nov 3, 2025 at 5:25=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
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
> The DPTF requires thermal drivers to be loaded at runtime, thus
> ACPI bus scan handler is not needed and acpi_default_enumeration()
> may create all platform devices, regardless of the actual setting
> of CONFIG_INT340X_THERMAL.
>
> Link to v1: https://lore.kernel.org/all/20250830053404.763995-1-srosek@go=
ogle.com/
> Link to v2: https://lore.kernel.org/all/20250917120719.2390847-1-srosek@g=
oogle.com/
> Link to v3: https://lore.kernel.org/all/20251002113404.3117429-1-srosek@g=
oogle.com/
>
> In v4 the SoC DTS thermal explicitly depends on the X86_64 and NET,
> so the INT340X driver may safely be selected by the SoC DTS thermal
> driver. In addition most of previously submitted patches are dropped
> as they are not necessary, instead the ACPI bus scan handler is simply
> removed from the kernel, thus all platform devices are enumerated by
> the acpi_default_enumeration().
>
> Slawomir Rosek (2):
>   ACPI: DPTF: Ignore SoC DTS thermal while scanning
>   ACPI: DPTF: Remove int340x thermal scan handler

Both patches applied as 6.19 material, but the subject of the first
patch has been changed to "thermal: intel: Select INT340X_THERMAL from
INTEL_SOC_DTS_THERMAL".

Thanks!

