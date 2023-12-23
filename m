Return-Path: <linux-acpi+bounces-2603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB781D1CA
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 04:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88D21F2411F
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Dec 2023 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D381FD8;
	Sat, 23 Dec 2023 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luMoaPWh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEB211A
	for <linux-acpi@vger.kernel.org>; Sat, 23 Dec 2023 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78101108e3fso158140085a.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Dec 2023 19:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703300985; x=1703905785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywzTa8fMWuNa/JuhVm+nHhoMjqqOsifKMd1nKPgEx10=;
        b=luMoaPWhIhDUdruoTQjWyw+cO20Zc6DH5XiEW8aNY9Dy5ftPaAGbYc13HyqrgvJ4fC
         ngTb1SeAtW+RwrWh0RSFUyf+dpT8ie4FvJvr19OiP0OenZftbmLJNrz2TqjX8oYZuVJC
         851xJsi7sYB55os698lZ70G178k1Dk8NhEVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703300985; x=1703905785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywzTa8fMWuNa/JuhVm+nHhoMjqqOsifKMd1nKPgEx10=;
        b=RP4Di4tPL9BLoi7dhDmYAz7hZwvCkuiZDVo0aDu6mKKzB9oSkKZrWebkJfU26ApY/P
         /JY69xGAtphBzQDGT0EjhouSkA8Yuy4Zlg2gsWfrUZAZMQOU13oLqGpm9CaeGrQf0qVA
         uu9zpcioa4nUsnI6DWLrqyEiYmt4mHi2s+oEh8AnrRm7eOWNgL9DgC+2v2AAl+ET2jS4
         8CEvAnZgviwbtG6TrYNHoecxsIK/GPab+f2ge+7v9wGkhpKRH0j2wYnBpI91K487M/bI
         DmnJw0O8As9KgK4SAirF/PLdi24TiayXDKvzgLGWchz9e+0hMT9vW6S+1f3XtEU+gjys
         fz7Q==
X-Gm-Message-State: AOJu0Yzeh/EDP0EpBXNhQU8Mx+LMHZ1pNIGA+sNa25hiepyMGyQDpsOS
	DpL/dB38ddYXLzsKx9l2xd8OEsTnvAdkdH6TmUfCJEm4T9NS
X-Google-Smtp-Source: AGHT+IEBvqegMfdoedSyh3kxbutEtn5gV5GDWkisfZz7Iuigcnj/FFwhpAcdsdZp1jH/qHyBjmxuTEjnkwczuhHeur4=
X-Received: by 2002:a05:620a:4f6:b0:781:37c2:f17a with SMTP id
 b22-20020a05620a04f600b0078137c2f17amr949586qkh.92.1703300985054; Fri, 22 Dec
 2023 19:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220165423.v2.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <202312230907.szXqJyXq-lkp@intel.com>
In-Reply-To: <202312230907.szXqJyXq-lkp@intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 20:09:34 -0700
Message-ID: <CANg-bXBWNQpnz99Yf5NmfX03Xa5jsiiw-89NVBqBwhmESnueuw@mail.gmail.com>
Subject: Re: [PATCH v2 01/22] gpiolib: acpi: Modify acpi_dev_irq_wake_get_by()
 to use resource
To: kernel test robot <lkp@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, linux-acpi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:09=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Mark,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on chrome-platform/for-next chrome-platform/for-=
firmware-next wsa/i2c/for-next driver-core/driver-core-testing driver-core/=
driver-core-next driver-core/driver-core-linus linus/master v6.7-rc6 next-2=
0231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Hasemeyer/gpi=
olib-acpi-Modify-acpi_dev_irq_wake_get_by-to-use-resource/20231222-172104
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fo=
r-next
> patch link:    https://lore.kernel.org/r/20231220165423.v2.1.Ifd0903f1c35=
1e84376d71dbdadbd43931197f5ea%40changeid
> patch subject: [PATCH v2 01/22] gpiolib: acpi: Modify acpi_dev_irq_wake_g=
et_by() to use resource
> config: x86_64-randconfig-161-20231222 (https://download.01.org/0day-ci/a=
rchive/20231223/202312230907.szXqJyXq-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231223/202312230907.szXqJyXq-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312230907.szXqJyXq-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/gpio/gpiolib-acpi.c:117: warning: Function parameter or member=
 'shareable' not described in 'acpi_gpio_info'
>
>
> vim +117 drivers/gpio/gpiolib-acpi.c
>
> aa92b6f689acf1 Mika Westerberg 2014-03-10   93
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   94  /**
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   95   * struct acpi_gpio_info =
- ACPI GPIO specific information
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   96   * @adev: reference to AC=
PI device which consumes GPIO resource
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   97   * @flags: GPIO initializ=
ation flags
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   98   * @gpioint: if %true thi=
s GPIO is of type GpioInt otherwise type is GpioIo
> b7452d670fdef8 Dmitry Torokhov 2022-11-15   99   * @pin_config: pin bias =
as provided by ACPI
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  100   * @polarity: interrupt p=
olarity as provided by ACPI
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  101   * @triggering: triggerin=
g type as provided by ACPI
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  102   * @wake_capable: wake ca=
pability as provided by ACPI
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  103   * @debounce: debounce ti=
meout as provided by ACPI
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  104   * @quirks: Linux specifi=
c quirks as provided by struct acpi_gpio_mapping
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  105   */
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  106  struct acpi_gpio_info {
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  107          struct acpi_devic=
e *adev;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  108          enum gpiod_flags =
flags;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  109          bool gpioint;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  110          int pin_config;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  111          int polarity;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  112          int triggering;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  113          bool wake_capable=
;
> 189f4620fa2d51 Mark Hasemeyer  2023-12-20  114          bool shareable;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  115          unsigned int debo=
unce;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  116          unsigned int quir=
ks;
> b7452d670fdef8 Dmitry Torokhov 2022-11-15 @117  };
> b7452d670fdef8 Dmitry Torokhov 2022-11-15  118
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Ack. Missing documentation for acpi_gpio_info.shareable member. Will
add in next version.

