Return-Path: <linux-acpi+bounces-18155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE2C01E51
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29D93BBD0E
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DD32E6A7;
	Thu, 23 Oct 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Md1/zZu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7232D451
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230487; cv=none; b=qn5Mllm8MNzSLiBbXFhFb17tY6r74gT6CEyvn52w9KG92rRCEB1o80dUlAbDzby7/VloR4j+qX2KpxVHEmT++W9vmLFK878VFQED7g282sEYlKFWbUD253gLc6eqcRRfXkmDZ8Ap9TZGDZex3MDaPNNZzP4wiwvrFCDeGU3Fa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230487; c=relaxed/simple;
	bh=Y9/1BzztPmNXuHFwGnjGAxY+D28zd6qccSzM/BYo1Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3t7HY3HsSUK6S1xj3S993vTl3kTuy0p9sOS3HWmtLM216bnyOH+AXCP9LBhbbHwjQjLLZV++NOyh9BX5M/K5WpzH5HPryuqxMvjxjKVpY2BHVZv6B7QbtTPlMrU1P2YMD9LQUesDGs3ZU15PdwqC+g6uFs1E/4YWpNx3xQUeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Md1/zZu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso1624318a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761230483; x=1761835283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaEXjkuohH+KmJn3E+dIuGaKSZVXQrhbRhs6LOkPta0=;
        b=0Md1/zZu61Ejqbz1+JjJ0GWXiOQ51W8AM0fzGF7g5qKPFDCEZ21xskk0Z+4AXXedyN
         jC+0FfplzpaDrmqfQhU0HDwLPbrQ7vwOnMxoBBmtUQAalKwR3Hi8bLHUDKFbNAGkO/KC
         1SWqBuo1FElHckXULx4LZ+/Ymolk8SFr6eGWuQ9lpNssAhEs/E/6Vtt9RkSKPiz8hljt
         EUCW8JRhkAWgELjWyK6TkSkVL80cCLKyrFQsFMKVGx9dZVOjNqdTwgtxp8Fh5TEn0VlO
         uoqLmujy+m6tJfTxCjAao3OX+R30MJt2S+YRQBQeWdEfvesE6NHXVbuNBDg7fH55lWoF
         /wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230483; x=1761835283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaEXjkuohH+KmJn3E+dIuGaKSZVXQrhbRhs6LOkPta0=;
        b=uAzCmiyCjXqEDjj6D4tgont6rU1B0F0HnWXYKNSTgVv3D/Ls8WPVmZGQTbvEYpNV9R
         nPQW3z/e8waBls12PIgV6A2YQTVdUWyQEwJyT7NUwhtR1Mjvffmb0Y3NBZKwxj75uJU3
         o6uYXG0Tw/oRMmFJoBzk4y0QFkC05BzO34kjzv82sveVKJViUCKohdcyWSFR/qRXpfP3
         Iax780Usoh0JAlUBGttCCJYpcJ7RF71G9dKzXhisvYR1KzpbA7DziqcPaYXIFm4laUEK
         hV4/0awcD7KQYkaf8XhqevBYYvIJY4P2opfwfZb2FTciLoAdyqQyFohzXstziI9wkvvY
         XhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs42M66cmENs1+XPnBkYAc/ICTq/ZcrqBmowLK7uAb41bvXIsnruUATP+vC+W9wtyBduUTcpM1A3Ba@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhP8QonER7VRcD4hAiAA7NnbPUVjXwT9HCTjK4sGMCJZ0LeXo
	VsTPavLH7qem339dVYT9MKS3ZTH2Z3lGu8HWcq81c8yr6aZFGvch99AX0qAs4mGHkTU1Y6nZ6qD
	x5R8+Y4nXa5C1zdgknXUzLsw3wCA8KVVCKSoZSOCe
X-Gm-Gg: ASbGncv+3WcgHnCcFPlJ2A6J33tpuu350z45PDI/8Zv+hErn7dPCu5eXEV2LDBQLvMU
	6NfI+mhcf6LclzYPQu+5x9aAssiKRXrPnH9mBypNd7OeGiTNSuh1J3Da3GunkfHuznmknCnGdRT
	7PEYxmudOMl52v8f1SSsWWECsg3v8FTfUylo700ONiv3+ZPiGUiF79fFvj8OXnmvPnlCS8PHl4X
	ff1aJK8hl8MCflPkXlBxWJE7ADaerWAxACfLE3YDqE58o+kI5i2lHpl2Kg66OiwC2uURI85
X-Google-Smtp-Source: AGHT+IHmhFuczXJUmW7c3vl0wCNckC1qUDj9DOSReH7wwga8TRX10XBNkjoga3GNxG38+O/PkU4kcMH4C4EtJkwXoRw=
X-Received: by 2002:a05:6402:2686:b0:639:fd12:65a2 with SMTP id
 4fb4d7f45d1cf-63c1f6459b1mr25694183a12.15.1761230483142; Thu, 23 Oct 2025
 07:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 16:41:12 +0200
X-Gm-Features: AS18NWCFYP5vhu6QggBNtBcvu36fQ1kLuqVb3qOI__iGzdkkrdPRbBM5XNZN1OI
Message-ID: <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com>=
 wrote:
> >
> > The ACPI INT340X device IDs are shared between the DPTF core
> > and thermal drivers, thus they are moved to the common header.
> >
> > Signed-off-by: Slawomir Rosek <srosek@google.com>
>
> I've actually started to wonder if int340x_thermal_handler is needed at a=
ll.
>
> It just creates a platform device if the given ACPI device ID is in
> its list,

That's true. It creates platform device for the given ACPI device ID,
but only if CONFIG_INT340X_THERMAL is enabled.

> but acpi_default_enumeration() would do that too with the
> caveat that it would also be done for CONFIG_INT340X_THERMAL unset.

Not exactly. scan handler returns ret=3D1, so device is marked as enumerate=
d
https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c#L2314

> That should not be a problem though because if CONFIG_INT340X_THERMAL,
> there are no drivers that will bind to those platform devices, so the
> net outcome should be the same.

If CONFIG_INT340X_THERMAL is not set and there are no drivers to attach
to platform devices and int340x_thermal_handler is removed then you are
right, acpi_default_enumeration() will enumerate ACPI bus anyway and
create platform devices for all ACPI device IDs. However, for me it looks
like it was intentional to prevent this behaviour unless INT340X drivers
are "present" in the system (were enabled for build so should be).
I am not sure how DPTF works and what may happen if platform devices are
visible in sysfs while drivers are not loaded.

>
> Thus I'm wondering if the way to go might be to drop
> int340x_thermal_handler and simply keep the device IDs in the drivers
> that use them for device binding.

Even better. If it's not required for DPTF to prevent enumeration
on the platform bus I can simply remove the scan handler.

>
> > ---
> >  drivers/acpi/dptf/dptf_power.c                | 18 +----
> >  drivers/acpi/dptf/int340x_thermal.c           | 51 +++-----------
> >  drivers/acpi/fan.h                            | 10 +--
> >  drivers/acpi/int340x_thermal.h                | 68 +++++++++++++++++++
> >  .../intel/int340x_thermal/int3400_thermal.c   | 10 +--
> >  .../intel/int340x_thermal/int3401_thermal.c   |  3 +-
> >  .../intel/int340x_thermal/int3402_thermal.c   |  3 +-
> >  .../intel/int340x_thermal/int3403_thermal.c   | 10 +--
> >  .../intel/int340x_thermal/int3406_thermal.c   |  3 +-
> >  9 files changed, 90 insertions(+), 86 deletions(-)
> >  create mode 100644 drivers/acpi/int340x_thermal.h
> >
> > diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_po=
wer.c
> > index 776914f31b9e..d7c59f016083 100644
> > --- a/drivers/acpi/dptf/dptf_power.c
> > +++ b/drivers/acpi/dptf/dptf_power.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/module.h>
> >  #include <linux/acpi.h>
> >  #include <linux/platform_device.h>
> > +#include "../int340x_thermal.h"
> >
> >  /*
> >   * Presentation of attributes which are defined for INT3407 and INT353=
2.
> > @@ -224,22 +225,7 @@ static void dptf_power_remove(struct platform_devi=
ce *pdev)
> >  }
> >
> >  static const struct acpi_device_id int3407_device_ids[] =3D {
> > -       {"INT3407", 0},
> > -       {"INT3532", 0},
> > -       {"INTC1047", 0},
> > -       {"INTC1050", 0},
> > -       {"INTC1060", 0},
> > -       {"INTC1061", 0},
> > -       {"INTC1065", 0},
> > -       {"INTC1066", 0},
> > -       {"INTC106C", 0},
> > -       {"INTC106D", 0},
> > -       {"INTC10A4", 0},
> > -       {"INTC10A5", 0},
> > -       {"INTC10D8", 0},
> > -       {"INTC10D9", 0},
> > -       {"INTC1100", 0},
> > -       {"INTC1101", 0},
> > +       ACPI_INT3407_DEVICE_IDS,
> >         {"", 0},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> > diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/in=
t340x_thermal.c
> > index 947fe50c2ef6..43afb6141b98 100644
> > --- a/drivers/acpi/dptf/int340x_thermal.c
> > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > @@ -9,63 +9,28 @@
> >  #include <linux/acpi.h>
> >  #include <linux/module.h>
> >
> > +#include "../int340x_thermal.h"
> >  #include "../internal.h"
> >
> >  static const struct acpi_device_id int340x_thermal_device_ids[] =3D {
> > -       {"INT3400"},
> > -       {"INT3401"},
> > -       {"INT3402"},
> > -       {"INT3403"},
> > -       {"INT3404"},
> > -       {"INT3406"},
> > -       {"INT3407"},
> > +       ACPI_INT3400_DEVICE_IDS,
> > +       ACPI_INT3401_DEVICE_IDS,
> > +       ACPI_INT3402_DEVICE_IDS,
> > +       ACPI_INT3403_DEVICE_IDS,
> > +       ACPI_INT3404_DEVICE_IDS,
> > +       ACPI_INT3406_DEVICE_IDS,
> > +       ACPI_INT3407_DEVICE_IDS,
> >         {"INT3408"},
> >         {"INT3409"},
> >         {"INT340A"},
> >         {"INT340B"},
> > -       {"INT3532"},
> > -       {"INTC1040"},
> > -       {"INTC1041"},
> > -       {"INTC1042"},
> > -       {"INTC1043"},
> > -       {"INTC1044"},
> >         {"INTC1045"},
> > -       {"INTC1046"},
> > -       {"INTC1047"},
> > -       {"INTC1048"},
> >         {"INTC1049"},
> > -       {"INTC1050"},
> > -       {"INTC1060"},
> > -       {"INTC1061"},
> > -       {"INTC1062"},
> > -       {"INTC1063"},
> >         {"INTC1064"},
> > -       {"INTC1065"},
> > -       {"INTC1066"},
> > -       {"INTC1068"},
> > -       {"INTC1069"},
> > -       {"INTC106A"},
> >         {"INTC106B"},
> > -       {"INTC106C"},
> > -       {"INTC106D"},
> > -       {"INTC10A0"},
> > -       {"INTC10A1"},
> > -       {"INTC10A2"},
> >         {"INTC10A3"},
> > -       {"INTC10A4"},
> > -       {"INTC10A5"},
> > -       {"INTC10D4"},
> > -       {"INTC10D5"},
> > -       {"INTC10D6"},
> >         {"INTC10D7"},
> > -       {"INTC10D8"},
> > -       {"INTC10D9"},
> > -       {"INTC10FC"},
> > -       {"INTC10FD"},
> > -       {"INTC10FE"},
> >         {"INTC10FF"},
> > -       {"INTC1100"},
> > -       {"INTC1101"},
> >         {"INTC1102"},
> >         {""},
> >  };
> > diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> > index 8a28a72a7c6a..4015ac56c009 100644
> > --- a/drivers/acpi/fan.h
> > +++ b/drivers/acpi/fan.h
> > @@ -11,16 +11,10 @@
> >  #define _ACPI_FAN_H_
> >
> >  #include <linux/kconfig.h>
> > +#include "int340x_thermal.h"
> >
> >  #define ACPI_FAN_DEVICE_IDS    \
> > -       {"INT3404", }, /* Fan */ \
> > -       {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> > -       {"INTC1048", }, /* Fan for Alder Lake generation */ \
> > -       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> > -       {"INTC106A", }, /* Fan for Lunar Lake generation */ \
> > -       {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
> > -       {"INTC10D6", }, /* Fan for Panther Lake generation */ \
> > -       {"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
> > +       ACPI_INT3404_DEVICE_IDS, \
> >         {"PNP0C0B", } /* Generic ACPI fan */
> >
> >  #define ACPI_FPS_NAME_LEN      20
> > diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_ther=
mal.h
> > new file mode 100644
> > index 000000000000..854e4d3bb739
> > --- /dev/null
> > +++ b/drivers/acpi/int340x_thermal.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * The ACPI INT340X device IDs are shared between the DPTF core
> > + * and thermal drivers.
> > + */
> > +
> > +#ifndef _ACPI_INT340X_H_
> > +#define _ACPI_INT340X_H_
> > +
> > +#define ACPI_INT3400_DEVICE_IDS        \
> > +       {"INT3400"},    \
> > +       {"INTC1040"},   \
> > +       {"INTC1041"},   \
> > +       {"INTC1042"},   \
> > +       {"INTC1068"},   \
> > +       {"INTC10A0"},   \
> > +       {"INTC10D4"},   \
> > +       {"INTC10FC"}
> > +
> > +#define ACPI_INT3401_DEVICE_IDS        \
> > +       {"INT3401"}
> > +
> > +#define ACPI_INT3402_DEVICE_IDS        \
> > +       {"INT3402"}
> > +
> > +#define ACPI_INT3403_DEVICE_IDS        \
> > +       {"INT3403"},    \
> > +       {"INTC1043"},   \
> > +       {"INTC1046"},   \
> > +       {"INTC1062"},   \
> > +       {"INTC1069"},   \
> > +       {"INTC10A1"},   \
> > +       {"INTC10D5"},   \
> > +       {"INTC10FD"}
> > +
> > +#define ACPI_INT3404_DEVICE_IDS        \
> > +       {"INT3404", }, /* Fan */ \
> > +       {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> > +       {"INTC1048", }, /* Fan for Alder Lake generation */ \
> > +       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> > +       {"INTC106A", }, /* Fan for Lunar Lake generation */ \
> > +       {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
> > +       {"INTC10D6", }, /* Fan for Panther Lake generation */ \
> > +       {"INTC10FE", } /* Fan for Wildcat Lake generation */
> > +
> > +#define ACPI_INT3406_DEVICE_IDS        \
> > +       {"INT3406"}
> > +
> > +#define ACPI_INT3407_DEVICE_IDS        \
> > +       {"INT3407"},    \
> > +       {"INT3532"},    \
> > +       {"INTC1047"},   \
> > +       {"INTC1050"},   \
> > +       {"INTC1060"},   \
> > +       {"INTC1061"},   \
> > +       {"INTC1065"},   \
> > +       {"INTC1066"},   \
> > +       {"INTC106C"},   \
> > +       {"INTC106D"},   \
> > +       {"INTC10A4"},   \
> > +       {"INTC10A5"},   \
> > +       {"INTC10D8"},   \
> > +       {"INTC10D9"},   \
> > +       {"INTC1100"},   \
> > +       {"INTC1101"}
> > +
> > +#endif
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 908cc1bf57f1..6311125c3ebd 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/thermal.h>
> >  #include "acpi_thermal_rel.h"
> > +#include "../../../../drivers/acpi/int340x_thermal.h"
> >
> >  #define INT3400_THERMAL_TABLE_CHANGED 0x83
> >  #define INT3400_ODVP_CHANGED 0x88
> > @@ -683,14 +684,7 @@ static void int3400_thermal_remove(struct platform=
_device *pdev)
> >  }
> >
> >  static const struct acpi_device_id int3400_thermal_match[] =3D {
> > -       {"INT3400", 0},
> > -       {"INTC1040", 0},
> > -       {"INTC1041", 0},
> > -       {"INTC1042", 0},
> > -       {"INTC1068", 0},
> > -       {"INTC10A0", 0},
> > -       {"INTC10D4", 0},
> > -       {"INTC10FC", 0},
> > +       ACPI_INT3400_DEVICE_IDS,
> >         {}
> >  };
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> > index 96d6277a5a8c..e0603f218d2e 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> > @@ -11,9 +11,10 @@
> >
> >  #include "int340x_thermal_zone.h"
> >  #include "processor_thermal_device.h"
> > +#include "../../../../drivers/acpi/int340x_thermal.h"
> >
> >  static const struct acpi_device_id int3401_device_ids[] =3D {
> > -       {"INT3401", 0},
> > +       ACPI_INT3401_DEVICE_IDS,
> >         {"", 0},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> > index 57b90005888a..213d4535f2c1 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/thermal.h>
> >  #include "int340x_thermal_zone.h"
> > +#include "../../../../drivers/acpi/int340x_thermal.h"
> >
> >  #define INT3402_PERF_CHANGED_EVENT     0x80
> >  #define INT3402_THERMAL_EVENT          0x90
> > @@ -84,7 +85,7 @@ static void int3402_thermal_remove(struct platform_de=
vice *pdev)
> >  }
> >
> >  static const struct acpi_device_id int3402_thermal_match[] =3D {
> > -       {"INT3402", 0},
> > +       ACPI_INT3402_DEVICE_IDS,
> >         {}
> >  };
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > index ba63796761eb..d246c69d4872 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/thermal.h>
> >  #include <linux/platform_device.h>
> >  #include "int340x_thermal_zone.h"
> > +#include "../../../../drivers/acpi/int340x_thermal.h"
> >
> >  #define INT3403_TYPE_SENSOR            0x03
> >  #define INT3403_TYPE_CHARGER           0x0B
> > @@ -269,14 +270,7 @@ static void int3403_remove(struct platform_device =
*pdev)
> >  }
> >
> >  static const struct acpi_device_id int3403_device_ids[] =3D {
> > -       {"INT3403", 0},
> > -       {"INTC1043", 0},
> > -       {"INTC1046", 0},
> > -       {"INTC1062", 0},
> > -       {"INTC1069", 0},
> > -       {"INTC10A1", 0},
> > -       {"INTC10D5", 0},
> > -       {"INTC10FD", 0},
> > +       ACPI_INT3403_DEVICE_IDS,
> >         {"", 0},
> >  };
> >  MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> > index e21fcbccf4ba..d05ca8bc4061 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/backlight.h>
> >  #include <linux/thermal.h>
> >  #include <acpi/video.h>
> > +#include "../../../../drivers/acpi/int340x_thermal.h"
> >
> >  #define INT3406_BRIGHTNESS_LIMITS_CHANGED      0x80
> >
> > @@ -187,7 +188,7 @@ static void int3406_thermal_remove(struct platform_=
device *pdev)
> >  }
> >
> >  static const struct acpi_device_id int3406_thermal_match[] =3D {
> > -       {"INT3406", 0},
> > +       ACPI_INT3406_DEVICE_IDS,
> >         {}
> >  };
> >
> > --
> > 2.51.0.618.g983fd99d29-goog
> >
> >

