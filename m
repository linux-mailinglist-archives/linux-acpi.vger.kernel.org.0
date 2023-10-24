Return-Path: <linux-acpi+bounces-943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7477D5C84
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 22:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1852819B9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861003E48E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50995266B6
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 19:51:21 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322919F;
	Tue, 24 Oct 2023 12:51:20 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e9e4636ce6so865383fac.0;
        Tue, 24 Oct 2023 12:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177079; x=1698781879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCcbj2+TpX1AiuupFD6KpXlDV8cvFcM8RGiHrVCQ+ns=;
        b=tiGA9/eTCuKxbl36HTl42k01YBTlVyybJtnxgqDE9zze39mzoX9yRKKiKL0KtmzE/D
         3H5Oc9aUa/1uCjOEvj2gkeAbvRMsj+Sl8AeKQAyZrJnHR08+cHPjmSfEHH5qE1nRI44h
         0giukjekpBZD/rOBo4Mm43YRCrrDfV9IsAMLDjPGPelpaR/WaQReJl/ic3tLQmZIcOHE
         7e3wG7wi9kZdTVFFUqq09AwLpIU/+w7rVwwzc9RPcifFtLBhxHV3wcfa+hOY5NmbEQ6+
         p2KWNZ4nblQr179zA2nAEZ8q0HUk+CxPhZjEeMMXZH2uZOV4sGzgkl4e20gMNbN1C3El
         0MCw==
X-Gm-Message-State: AOJu0YyaSGFSEbBFp4eRSYHTRPgtSKZ8O2qLwjdnG0t9FpwIwUqgt+Lc
	PvCEXgzYO3mjxmA+QsikgEZllo8VlYk88Y8Dl2s=
X-Google-Smtp-Source: AGHT+IFA7hP6NhXLZCvkE4cfS644IU/fZFM51E6Latf3f9Vn4OdA8wXW6fRY9TNiSPPwJblhkTQr7AoOS/GUegqK0X0=
X-Received: by 2002:a05:6871:220e:b0:1e9:adec:bf5e with SMTP id
 sc14-20020a056871220e00b001e9adecbf5emr13474628oab.2.1698177079400; Tue, 24
 Oct 2023 12:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024062018.23839-1-raag.jadav@intel.com> <20231024093010.GF3208943@black.fi.intel.com>
In-Reply-To: <20231024093010.GF3208943@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 21:51:08 +0200
Message-ID: <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, 
	andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, 
	linux@roeck-us.net, Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 11:30=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > This series refines _UID references across kernel by:
> >
> > - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
> >   helper and introducing it as a separate acpi_dev_uid_match() helper.
> >
> > - Converting manual _UID references to use the standard ACPI helpers.
> >
> > Changes since v2:
> > - Drop review tags as suggested by Andy.
> >
> > Changes since v1:
> > - Change acpi_dev_uid_match() to return false in case of NULL argument.
> > - Drop accepted patches.
> >
> > Raag Jadav (6):
> >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
> >     _UID
> >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
> >     _UID
>
> For the series,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
> >  drivers/acpi/x86/utils.c              |  3 +--
> >  drivers/hwmon/nct6775-platform.c      |  4 +---
> >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
>
> This pinctrl one is also fine by me so if Andy does not have objections,
> feel free to add my,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Whole series applied as 6.7 material with tags as per the above, thanks!

