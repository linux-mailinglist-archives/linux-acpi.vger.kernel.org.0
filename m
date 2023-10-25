Return-Path: <linux-acpi+bounces-945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD06B7D5FFB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 04:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7111C20CDE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB663CA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 02:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH4NtPkn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B3185F
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 02:05:12 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529F10D5;
	Tue, 24 Oct 2023 19:05:11 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso4722106276.1;
        Tue, 24 Oct 2023 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698199510; x=1698804310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbdytW0refUglybCsXX0Y9h8CNgKWOlTE2eFIrGTl4M=;
        b=BH4NtPknv7zzofaqxPicccCF8PWycl0Hbmaxxo5Aa5LJQVNISQayehHeiXXhwaHmGV
         qaA9MxSr+nn8VTl7s1X2HagOLitwaSFrt65ZfTggVwu4G07kvPAXA2oJYwcgJiVP5/6V
         KbsxIkHijUrQtWBafP0yYouStpmYE/Vh/at2+X9ov7kVJ1PyvQPZdUXX6DCSS/GRW+xE
         pVW9srUV0uDCphu4ItQinALub3Kq/Fy2fHXh0Jxky9JEedwYO7XBc5nJHG4X2bAZggTn
         u1qDW7lj447TQ5Wmp9NayBhezIq6SY0r2VmqP7t7uLrrGiWJT0iPJYrW1m1t3TUG/eE9
         95hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698199510; x=1698804310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbdytW0refUglybCsXX0Y9h8CNgKWOlTE2eFIrGTl4M=;
        b=JvigR/rQUuF88HxLvsp9QXf8cyCVrn6fIXT34vqgDG6N2qGM3kR6kbRRvHB/7VL5rv
         BHfADocN3aqy9Ym8Mv5njH/rBQXjwRJ5kbPa9PFvjLceB9a0QCNi/JzeLNRsyc50CJUy
         Yhh4vkwODSL8KT0kD1AUcyJCcQNrqr55xpIav/oZ45+LMcTj9VkLlPnoaKnRk4EqSO4I
         q74ABs/30K9VlnJCo75aZw5vMA54dGd7sIWY8/oep+IhmvzX3EjJq9ARlzlYJKR81/Pl
         fiKm8R29ykRWVwVJcLqks1Tthg2Rab4tXOkn/rIA54NXvKzKVk7dMAtnYFXOKKKywoqz
         x1yw==
X-Gm-Message-State: AOJu0YzYzvBXeKiUU/wTpEtXG7t7LK7wj4uCwmPADPQQyi6wPjvSuJra
	G8ERKgihTsNqBd2qTgoM2SU=
X-Google-Smtp-Source: AGHT+IERNV1QcSoqDHejS2ogA8dmntWOcfRPDiTPSWgt5OxcGIpls9S0uiTOXeqKjsqjLApnPEgISA==
X-Received: by 2002:a05:6902:1083:b0:d9c:7b92:90b9 with SMTP id v3-20020a056902108300b00d9c7b9290b9mr16261960ybu.14.1698199510279;
        Tue, 24 Oct 2023 19:05:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b136-20020a25348e000000b00d89679f6d22sm4022356yba.64.2023.10.24.19.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 19:05:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 24 Oct 2023 19:05:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>, len.brown@intel.com,
	robert.moore@intel.com, andriy.shevchenko@linux.intel.com,
	mark.rutland@arm.com, will@kernel.org, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
Message-ID: <16cf6c19-20d2-4d11-80b1-b8e3c7e58803@roeck-us.net>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
 <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hLYcN_CxUOocKoN8EsQTwyL-sLbWENfFaQ+f3fjHRvqw@mail.gmail.com>

On Tue, Oct 24, 2023 at 09:51:08PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 24, 2023 at 11:30 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > > This series refines _UID references across kernel by:
> > >
> > > - Extracting _UID matching functionality from acpi_dev_hid_uid_match()
> > >   helper and introducing it as a separate acpi_dev_uid_match() helper.
> > >
> > > - Converting manual _UID references to use the standard ACPI helpers.
> > >
> > > Changes since v2:
> > > - Drop review tags as suggested by Andy.
> > >
> > > Changes since v1:
> > > - Change acpi_dev_uid_match() to return false in case of NULL argument.
> > > - Drop accepted patches.
> > >
> > > Raag Jadav (6):
> > >   ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
> > >   pinctrl: intel: use acpi_dev_uid_match() for matching _UID
> > >   ACPI: utils: use acpi_dev_uid_match() for matching _UID
> > >   ACPI: x86: use acpi_dev_uid_match() for matching _UID
> > >   hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and
> > >     _UID
> > >   perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and
> > >     _UID
> >
> > For the series,
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > >  drivers/acpi/utils.c                  | 34 ++++++++++++++++++++++-----
> > >  drivers/acpi/x86/utils.c              |  3 +--
> > >  drivers/hwmon/nct6775-platform.c      |  4 +---
> > >  drivers/perf/arm_cspmu/arm_cspmu.c    |  8 +++----
> > >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> >
> > This pinctrl one is also fine by me so if Andy does not have objections,
> > feel free to add my,
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Whole series applied as 6.7 material with tags as per the above, thanks!

Ok, that means I will _not_ apply the hwmon patch through
the hwmon tree.

FWIW, please note that I would have very much preferred applying
it through the hwmon tree, and I did _not_ Ack it.

Guenter

