Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764DB3F9F53
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Aug 2021 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhH0S5n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Aug 2021 14:57:43 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:34464 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhH0S5n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Aug 2021 14:57:43 -0400
Received: by mail-oo1-f54.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso1306788oon.1;
        Fri, 27 Aug 2021 11:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IVgojgnGhqQ+wkgkjmsrimQe5aqsGL34JdBENArlM/M=;
        b=HRsIau2cInvstsRF9MZ+4xIr7FLeiVeBgNybfCN+nXiAByADTbAYKmI3AOO96tY+yT
         fkJuvCTy/eDvm/Jl52EsGlN0ibVh1rUs952klOjFqR8TdpXZ8+6SGyGsIF2NtW3u6Eim
         pijGbd59dhmFqmO3vQrBKqvpYIkkX6/ZmHhKSuDwOdPklm/1aJRgOOFVotW0hc7VGq2Y
         b3YbLbghCOl5pOBlwUu8V316YIeVEBlXnQuQ6QTLVMoXiW8cq0biqhA+rvvzFA+LdNAa
         kGhv3D1pXhChlbeu2GW446Z59zzBtL+nVltXiMFkbipDLv1L6+7XFGIii0yoOhouzVxt
         09uA==
X-Gm-Message-State: AOAM5319dd7CWf5ilsUAdfaPiFv9jaUW1tAXWO9C9JX/J8HQUPrQJnYN
        4JVV0F659BJqdPb+vidHLMq3CTUqEYG/7buzYz+WC3pXvttmvA==
X-Google-Smtp-Source: ABdhPJzwzdphUl+0nAfGpPcPOTLFkW86A5/1abHeqIpo6qbEZTXN4mWTCkLUVggDnfobi52p5e/TaD15urSJKaExsJc=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr234892ooq.2.1630090613467;
 Fri, 27 Aug 2021 11:56:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Aug 2021 20:56:42 +0200
Message-ID: <CAJZ5v0hxquKvcHR_YYd+csGWwHB5HW2uXMYtM=uT5QDqFLH8ew@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.14-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.14-rc8

with top-most commit 294c34e704e78d641b039064ce72d4531afe0088

 media: ipu3-cio2: Drop reference on error path in cio2_bridge_connect_sensor()

on top of commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93

 Linux 5.14-rc7

to receive an ACPI fix for 5.14-rc8 (or final 5.14).

This fixes an ACPI-related regression introduced during this cycle that has
been partially addressed by an earlier commit (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      media: ipu3-cio2: Drop reference on error path in
cio2_bridge_connect_sensor()

---------------

 drivers/media/pci/intel/ipu3/cio2-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
