Return-Path: <linux-acpi+bounces-816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA737D15DE
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C68F1C20E98
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0C52230D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DBFC1C
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 17:05:53 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D29D6F;
	Fri, 20 Oct 2023 10:05:49 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57de3096e25so92223eaf.1;
        Fri, 20 Oct 2023 10:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821548; x=1698426348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8AIn6/iR3E8CT+JQB0gST5WJCIAr7Wh8y0iPNdS+AQ=;
        b=ptUlr25gRHNzmmLXc0mp2K2CFT3kcfCh2/YEOHyFSYpHjdRFIFy83N4CyEyo+SmCgk
         gpYbjHDagjqidrZsx2x7u0CKRdeeOn4wzHPsjzej0dOQj1LnZdfAX5bJOYJKy9ZA2c3Z
         73WbE/BeMe+qxtCvvXBjhhL8fv4GEMI2La4KwKiRw5yY7TKXTDPkxJwHhUR0Fix42rfe
         7AO0tE8yaatWpztUXBEgbHVCRXwLKeSDyB7kA4eu321VU+byERJfzCK1MLw/eLXED75H
         jVhsda5lcbadIIxgx60hA3TMrGU1ywI98EBwIIUtRVJc9ICezyIzwmSbwOP5YNP8lxVp
         kN8A==
X-Gm-Message-State: AOJu0Ywkg3mN4ex/Rln0sAHgWs+XUKgE7Mz/tGqseNsdyXpyHmsZYiEH
	hGujcLP3yjpO25skhzhd0ik1fv72MTgiYuH+/8s=
X-Google-Smtp-Source: AGHT+IFSQ1zCkW05M9khBFLMCYZDLgibguIFQzo/kLEk64piidec4jtkFdB09yj4U6zdpHktR3/Riw2Hytar5/gTwX4=
X-Received: by 2002:a4a:bd18:0:b0:581:e7b8:dd77 with SMTP id
 n24-20020a4abd18000000b00581e7b8dd77mr2851560oop.1.1697821548724; Fri, 20 Oct
 2023 10:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-6-raag.jadav@intel.com>
 <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
In-Reply-To: <ZTJYgnugWHwBhtxv@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:05:37 +0200
Message-ID: <CAJZ5v0gqFgkhPHudqYUdg8ZgbEtF0Jf1ATbYACYEq3fNyaDW2w@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] ACPI: x86: use acpi_dev_uid_match() for matching _UID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org, len.brown@intel.com, 
	robert.moore@intel.com, mika.westerberg@linux.intel.com, mark.rutland@arm.com, 
	will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 20, 2023 at 02:17:29PM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use standard ACPI helpers.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > -                     if (!adev->pnp.unique_id ||
> > -                         strcmp(adev->pnp.unique_id, override_status_i=
ds[i].uid))
> > +                     if (!acpi_dev_uid_match(adev, override_status_ids=
[i].uid))
>
> The check for NULL argument inside that API does not affect the behaviour=
 as
> otherwise it will be a crash with the current implementation.

What current implementation do you mean, exactly?

