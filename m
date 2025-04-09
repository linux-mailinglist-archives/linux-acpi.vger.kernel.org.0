Return-Path: <linux-acpi+bounces-12928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA95A83097
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 21:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736733BEB91
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8491F2BAB;
	Wed,  9 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+S20Ogz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9E143748;
	Wed,  9 Apr 2025 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227265; cv=none; b=VAQlniUQ4EDCDTsRYHEWKzMGmxECLd2VeBKsA+jv41RZ3byLiIFL4d9iLSD3+r/QY/DIJpEg2XU33El+tOvwlBofBVRzJMhFh07K9zbygKCqKZS/8kOPGG08ur2rmAImvnpwWghv+LnlFo+Cs0Zuc8uaCnTHaD2npxfhOd5CK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227265; c=relaxed/simple;
	bh=2vOJoxdNP20mQK3UiS0RfjI+E8Wm/mByxTHPEUjCAOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz/GyG1b9QyvCZFWO4H+HME+epkiTI8qvogCfrBa0pm+Z7LfwXiSum9Lp27/3Dse9FSc7+l+B165HxBf/16Yof5sACyj9vIQsQRUCCJ9tPHdtmYCc9HEaB3HguwoUTVmL4SQzb84ymp75RFe94Se/1gfAvHClY2gVuF115MhHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+S20Ogz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D694C4CEE9;
	Wed,  9 Apr 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744227265;
	bh=2vOJoxdNP20mQK3UiS0RfjI+E8Wm/mByxTHPEUjCAOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a+S20Ogz2aBgFaushLkB5eVBNyZIgUSX4KMnHqk+g7Ec4GeJWIdSdhuNiorMwTW49
	 FQ+wxLaq7NOAe8qKD+sV4ApTiICjCssaVX33XA8+XmqoOGTBVMwqEXhJyybgtn3FbM
	 YcGmv9OJmrp0B0gg2m/dehIMUYpIsDxfTrLupo7nslm9fIqMMQyopuzGR1OoiHz6eP
	 QfIwE2UPlJZRqhfjsp8PwfXgZX6P5aXfuZfJ6SOoN5j9rRrLtu2V25gC0vTJKhSpUU
	 xpSXYBDkAfYFOhpd4ujWxHaj23lCHcsTEenxg5j53OpDM+EtdhDAvZfwRhW7aW7tNh
	 EXec9K/yJr+fw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2a01bcd0143so9188072fac.2;
        Wed, 09 Apr 2025 12:34:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmxCe4h6zLy0HgwNOCN8+H/DkB1HA+wnw1hpHhUv70gOW8onD3MsVHPgA2UzptKBFJOHQbwKgvPRoR@vger.kernel.org, AJvYcCXQ5dWGsj+UztbxBmkVvPDrLkqrVCR/9gaF16VvEaakX+RDm55usDUfaklIWd5Prq2WwL5j0Zv1OSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LiT3y3BtuGWTjPTtabEE9Ma3wVHPvKRrXYI7zLwZzEFl7Qnu
	pIQynp+p2N5hr6H0J+9SmkXJBExmvwCgw4jEkqx/3c1KtTK/0vH87gfmpoYRrnX/rwjRemAr9yH
	rciknaA4RUetJZhBj6KoDMsOOa5c=
X-Google-Smtp-Source: AGHT+IF1EOTSsHu6PwO7CQca/F8ZGj5qwdWoncQouS6lp4WoUO8bFBjNu283luRGQSJDHNAzpoZaPGEr9HneQ1apEeM=
X-Received: by 2002:a05:6871:e418:b0:2c2:260:d77b with SMTP id
 586e51a60fabf-2d08dcdf089mr2503514fac.5.1744227264335; Wed, 09 Apr 2025
 12:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504100128.AjbVDQgK-lkp@intel.com> <20250409-wine-swift-of-tempest-eae2cb@sudeepholla>
In-Reply-To: <20250409-wine-swift-of-tempest-eae2cb@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 21:34:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaxP9wz14WSi4saEJTiQau5vDBxWi0t_e5UzGrJAHe_g@mail.gmail.com>
X-Gm-Features: ATxdqUFGJglX_EWRCO_-dcl4UqyApcv4Gv2qoxdxwy54YWSlW7CBu3F3gBCHGzI
Message-ID: <CAJZ5v0iaxP9wz14WSi4saEJTiQau5vDBxWi0t_e5UzGrJAHe_g@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 39/52] drivers/acpi/apei/einj-core.c:877:43:
 error: expected identifier
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:25=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Thu, Apr 10, 2025 at 02:10:04AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git bleeding-edge
> > head:   089d4e79e2c932faef79e0061cb874000f755009
> > commit: 4ec052af63c58a62a896508cc5f8a0a2f516a590 [39/52] ACPI: APEI: EI=
NJ: Transition to the faux device interface
> > config: x86_64-buildonly-randconfig-001-20250409 (https://download.01.o=
rg/0day-ci/archive/20250410/202504100128.AjbVDQgK-lkp@intel.com/config)
> > compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58=
df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250410/202504100128.AjbVDQgK-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202504100128.AjbVDQgK-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/acpi/apei/einj-core.c:877:43: error: expected identifier
> >      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remo=
ve), true);
> >          |                                           ^
> >    include/linux/init.h:397:21: note: expanded from macro '__exit_p'
> >      397 | #define __exit_p(x) NULL
> >          |                     ^
> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >        8 | #define NULL ((void *)0)
> >          |              ^
> > >> drivers/acpi/apei/einj-core.c:877:1: error: type specifier missing, =
defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplici=
t-int]
> >      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remo=
ve), true);
> >          | ^
> >          | int
> > >> drivers/acpi/apei/einj-core.c:877:19: error: a function declaration =
without a prototype is deprecated in all versions of C [-Werror,-Wstrict-pr=
ototypes]
> >      877 | module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remo=
ve), true);
> >          |                   ^
> >          |                                                             =
         void
> >    3 errors generated.
> >
> >
> > vim +877 drivers/acpi/apei/einj-core.c
> >
> >    876
> >  > 877        module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_r=
emove), true);
> >    878
> >
>
> The macro module_faux_driver() was not merged as most of the users I
> posted in v2 of the series depend on modprobe and modalias and that
> doesn't work with faux devices.
>
> If this ACPI APEI EINJ also needs that support we can't use faux device.
> But I think this doesn't have modalias, so v1 of this change[1] which
> doesn't  introduce/use the macro module_faux_driver() can be used instead=
.
>
> Sorry for the noise with v2.

No worries.

I've picked up the v1 instead, let's see how it goes.

> [1] https://lore.kernel.org/all/20250317-plat2faux_dev-v1-8-5fe67c085ad5@=
arm.com/

