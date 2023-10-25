Return-Path: <linux-acpi+bounces-956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA727D6BE9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 14:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A589B20F5C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5CD27EDC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987C125A8
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:32:43 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A9D111;
	Wed, 25 Oct 2023 04:32:42 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1e9c28f8193so1562928fac.1;
        Wed, 25 Oct 2023 04:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698233561; x=1698838361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bpTDlYy28TPceQP8PQQbnHdxroGDzNENEgygFYUDDg=;
        b=hTXHXtLCScXFqONhFja42mi3H4B9YBw7DY4ZcGjfKZFmrO6yaq1dPM9CMoRgcoorQn
         7OUgJJRvBoeSmRSVTpWXFDqFPW1oATfVjmWnEbmIO4+Lj0+CFlrArR0S/rLr3jho9DWI
         FyzcyNIuRD5OP5BtkD2JlGURMiVRrFD7b3A64sqMETH0Pq8RGG1Br2dSFTVEaSvDNKO1
         gPmlCJEL8q9qz1vQv3qUILH21UHpwUKKkq0P9FDr3E6UTK8ejT4hzYkVkoUugKCedneM
         swOuBGyBWUBT0DRMyOnsa9QuRIv88sJVgyNSv/vIMHHHtlGRyLen/2mJUkXIQYvrud6+
         ux+Q==
X-Gm-Message-State: AOJu0YxMVBUl+Wp6/Maj5udTAGX2kGl8nzgpoG4ZJHFauImqQw+IWALg
	wmNW0CfJA3kTL8T2WPqU1355GhyzZ5gzcFLMCbA=
X-Google-Smtp-Source: AGHT+IFOALTrCxeNT9/wx62+knUiOQdgLJyX518saqHvCwbSpb1b9pG/oXGHik2oNple+LIgXdYlz0Wjoc9Rf4+OecE=
X-Received: by 2002:a05:6870:9a98:b0:1e9:9e04:1d24 with SMTP id
 hp24-20020a0568709a9800b001e99e041d24mr18538546oab.5.1698233561419; Wed, 25
 Oct 2023 04:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024062018.23839-1-raag.jadav@intel.com> <20231024093010.GF3208943@black.fi.intel.com>
 <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com> <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
In-Reply-To: <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 13:32:28 +0200
Message-ID: <CAJZ5v0ge6_GK6DXcWM-OkjRszxBbPx+ArW76S8W9pf=YOzGyPQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Raag Jadav <raag.jadav@intel.com>, len.brown@intel.com, robert.moore@intel.com, 
	andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, 
	Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 4:05=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, Oct 24, 2023 at 09:51:08PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 24, 2023 at 11:30=E2=80=AFAM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > > > This series refines _UID references across kernel by:
> > > >
> > > > - Extracting _UID matching functionality from acpi_dev_hid_uid_matc=
h()
> > > >   helper and introducing it as a separate acpi_dev_uid_match() help=
er.
> > > >
> > > > - Converting manual _UID references to use the standard ACPI helper=
s.
> > > >
> > > > Changes since v2:
> > > > - Drop review tags as suggested by Andy.
> > > >
> > > > Changes since v1:
> > > > - Change acpi_dev_uid_match() to return false in case of NULL argum=
ent.
> > > > - Drop accepted patches.
> > > >
> > > > Raag Jadav (6):
> > > >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> > > >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> > > >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> > > >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> > > >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID an=
d
> > > >     _UID
> > > >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID a=
nd
> > > >     _UID
> > >
> > > For the series,
> > >
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >
> > > >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-=
----
> > > >  drivers/acpi/x86/utils.c              |  3 +--
> > > >  drivers/hwmon/nct6775-platform.c      |  4 +---
> > > >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> > > >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> > >
> > > This pinctrl one is also fine by me so if Andy does not have objectio=
ns,
> > > feel free to add my,
> > >
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Whole series applied as 6.7 material with tags as per the above, thanks=
!
>
> Ok, that means I will _not_ apply the hwmon patch through
> the hwmon tree.
>
> FWIW, please note that I would have very much preferred applying
> it through the hwmon tree, and I did _not_ Ack it.

OK, I'll drop it now and please feel free to pick it up (whenever it
is convenient to do so), or if you'd rather let me carry it, please
let me know.

It's only been in my bleeding-edge branch so far.

