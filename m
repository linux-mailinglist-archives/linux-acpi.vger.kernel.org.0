Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C6D120876
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfLPOV5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 09:21:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41905 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfLPOV5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 09:21:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so3400321oie.8;
        Mon, 16 Dec 2019 06:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaHjW4n0zvwoawguKMSzzinC58G2gxyriauO/X4GMCM=;
        b=MW885Dak5dsQioDYXdbfU3nhTqapSRqr7FbHhXdegeeN5z91ISQpyizEXp4Loq3Qir
         6ZkBC3ujouZmYcTkKwkmgqt3elY2JpM+eipY3uarzqY9XEOfkdW9ML4iYRVeyHqy4mw2
         M0h0HzW2o4wBT+F0WQpfUmb4zC714xKjriIFBwvVXPf8axjEAUtcT5B481NXIEyDj2bv
         qn1FAVEHmULzkjv3yiySWeeB+66EKYfz5Qxgy/OWYpcvv3yW8iZa6tqhqNbyvOnehzGU
         mcwBKLTv98kS9AhvpoPE3iURtYVSoDL19m2iwNnoF1QzLiCsYnE5y+TC67A7v+koenFq
         erBg==
X-Gm-Message-State: APjAAAV2zkZEYkFhOYB/mGJ+LuEU6XFSYiX++SeHJpzhdLk42dSSNgnZ
        nu9bn0mt1x+Yast+pmwkrdzMT+FWtgcgPY8cbkRvKw==
X-Google-Smtp-Source: APXvYqx7e1cUSJQewGZjGCWSnzYCUwFNC6T/ar6UamMUtChiL1yRn9RrIJ5esh13a0l7XzpmylQ57sR31ILTFk2gVgU=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr9945222oic.57.1576506116067;
 Mon, 16 Dec 2019 06:21:56 -0800 (PST)
MIME-Version: 1.0
References: <201912162148.hTRbNfPp%lkp@intel.com>
In-Reply-To: <201912162148.hTRbNfPp%lkp@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Dec 2019 15:21:45 +0100
Message-ID: <CAJZ5v0iTOSnvZqKuL7gy7QBtdHxcM7wPS8qdgbvs6+sQxZX5yg@mail.gmail.com>
Subject: Re: [pm:intel_idle+acpi 4/10] acpi_processor.c:undefined reference to `acpi_processor_ffh_cstate_probe'
To:     kbuild test robot <lkp@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 16, 2019 at 2:26 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_idle+acpi
> head:   dcedc03145600b929a32acb85b212131b079bc46
> commit: 0300cf31f061e6287810c894337f29df2e200e2d [4/10] ACPI: processor: Export acpi_processor_evaluate_cst()

Outdated.  Please stop sending these.

> config: x86_64-randconfig-b002-20191216 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
> reproduce:
>         git checkout 0300cf31f061e6287810c894337f29df2e200e2d
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/acpi/acpi_processor.o: in function `acpi_processor_evaluate_cst':
> >> acpi_processor.c:(.text+0x542): undefined reference to `acpi_processor_ffh_cstate_probe'
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
