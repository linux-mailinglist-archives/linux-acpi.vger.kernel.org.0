Return-Path: <linux-acpi+bounces-284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E357B3292
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CD1671C20995
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF41A584
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6B156CA
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 10:37:17 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C561B6;
	Fri, 29 Sep 2023 03:37:16 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ae18567f42so1439281b6e.1;
        Fri, 29 Sep 2023 03:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695983835; x=1696588635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1hsWY5JCWvz2xsWRCM+HzGyDcidNkVmlTTI/NR7R+0=;
        b=RjJxGNGTNE3cY8HDJ6qVof4mhguICoVH0qAFS5f3HtCmJX+usm7QZMQaOM9yuPJPa4
         dCtMqsoUY2BbFMYYESC7eXEEEA4AZoGAOnoeaRCOPmPg1YyTrp6mUWE2KzPUhJJHkBHx
         TbPt01p6hWzLVyYBa/SD13EF1+a7hQNZe39Jl5h45M2+XcyVQA/hexg3mJQo9Sba2JEY
         mepiT6mkbHJpaeGm8+yCejfWKs8OjtqshJ7EMgo8ltwXHOmZujPNHGpI81CjOD4b1AfO
         cmCO+4Gnp5VjxovOj1uyGYgKHUKNdQnSpM+yEJy0Zxa6JjXiIpBkB9vhJWZ2HvW7VpAn
         kIrA==
X-Gm-Message-State: AOJu0Yw0y5B4z68Gux8ZRNrz7BVlPqRu4nZkV/8AHAuFJdt+pDwKp9l1
	l0vXvi4eNw1j7tYd5RcVtr08nB4i2DT38+5tvVMDZkEuCLs=
X-Google-Smtp-Source: AGHT+IFkdyx/QYd+Gh26sWMUYpZu8SsfK/oQaPVxBFOTvbXh6XghmsZnkkctRsN5CVbcEsH52Dm4ahxaV6gO17JbrMU=
X-Received: by 2002:a05:6808:2123:b0:3a9:f25d:d917 with SMTP id
 r35-20020a056808212300b003a9f25dd917mr5371486oiw.4.1695983835330; Fri, 29 Sep
 2023 03:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202309291214.Hjn3gJ94-lkp@intel.com>
In-Reply-To: <202309291214.Hjn3gJ94-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Sep 2023 12:37:03 +0200
Message-ID: <CAJZ5v0gGissufTrvCa+z5i=kPMDM+-RKoQfOHW41zf7o2=z4SQ@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 48/94] drivers/thermal/amlogic_thermal.c:303:16:
 error: void value not ignored as it ought to be
To: kernel test robot <lkp@intel.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org, devel@acpica.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 6:21=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   2cff74feed4a2a3a1c220e0ee2838b85b08d4999
> commit: 88af8b66ffedcad8c5a1522f6a9c02bf8129a951 [48/94] thermal: amlogic=
: Convert to platform remove callback returning void
> config: arm-randconfig-004-20230929 (https://download.01.org/0day-ci/arch=
ive/20230929/202309291214.Hjn3gJ94-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230929/202309291214.Hjn3gJ94-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    drivers/thermal/amlogic_thermal.c: In function 'amlogic_thermal_suspen=
d':
> >> drivers/thermal/amlogic_thermal.c:303:16: error: void value not ignore=
d as it ought to be
>      303 |         return amlogic_thermal_disable(data);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

amlogic_thermal_disable() should not be modified by this commit -
fixed up in the tree.

Thanks!

>
> vim +303 drivers/thermal/amlogic_thermal.c
>
> 421eda108e6c63a Guillaume La Roque 2019-10-04  298
> 421eda108e6c63a Guillaume La Roque 2019-10-04  299  static int __maybe_un=
used amlogic_thermal_suspend(struct device *dev)
> 421eda108e6c63a Guillaume La Roque 2019-10-04  300  {
> 421eda108e6c63a Guillaume La Roque 2019-10-04  301      struct amlogic_th=
ermal *data =3D dev_get_drvdata(dev);
> 421eda108e6c63a Guillaume La Roque 2019-10-04  302
> 421eda108e6c63a Guillaume La Roque 2019-10-04 @303      return amlogic_th=
ermal_disable(data);
> 421eda108e6c63a Guillaume La Roque 2019-10-04  304  }
> 421eda108e6c63a Guillaume La Roque 2019-10-04  305
>
> :::::: The code at line 303 was first introduced by commit
> :::::: 421eda108e6c63a72feb178c441bb769d4076836 thermal: amlogic: Add the=
rmal driver to support G12 SoCs
>
> :::::: TO: Guillaume La Roque <glaroque@baylibre.com>
> :::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

