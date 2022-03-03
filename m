Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCB4CBD4D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiCCMD5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiCCMD4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 07:03:56 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216666634;
        Thu,  3 Mar 2022 04:03:10 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id u61so9690857ybi.11;
        Thu, 03 Mar 2022 04:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjboJ/G8/4W1otFWQPurTWNijZtDW4ypJBpfagbu43Q=;
        b=I++uDh94bYmCUJPzkbgxy3acFhroljN/X0Im82TLX6pGtTutnp9Qq+4DBdh+aNjCij
         JBe0xT/uWSTTlBwmzS5atrkAdHMiLa9LJi1O4pqR71Za5qjnYihcbD4bp2aH5666rACl
         zjWPkvg4sOEXFoAnpxLbHIVzB9gThKaNNy/MG0nkF0m2cF0hKSwkiOlEpIvwATgSPP9x
         TgTnEybmexJEugDY2eIcMRDZhKmzIHEAESexjxPm35PShaHo3uiuozYRHLaStNkqmoY/
         f+r+f7NaaokBl54jBYY3moTTwOwUWXqPH2pg+KoQJqmwqUWygaQAzhWo2Z8ZzrV78Q6A
         KrLw==
X-Gm-Message-State: AOAM530C85me92Y4Thzizk09o9YorzLRnbYzk5nDFJ9tO17h9Q4b3Rkj
        e8F+OQUggloI0BAHVNgnDlaJsXE6VJ1v2eeEYxQ=
X-Google-Smtp-Source: ABdhPJyFQlRdBXJOEnibIE8dJrLYvPNawvDuXGBJsAA7xwYFswO5AfyOOTNNrJkTz8ToR2mU7ZhMqq+odTlqZZ8ACQk=
X-Received: by 2002:a25:24d7:0:b0:628:79dc:1250 with SMTP id
 k206-20020a2524d7000000b0062879dc1250mr12298601ybk.153.1646308989266; Thu, 03
 Mar 2022 04:03:09 -0800 (PST)
MIME-Version: 1.0
References: <202203021037.WWnG44C5-lkp@intel.com>
In-Reply-To: <202203021037.WWnG44C5-lkp@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Mar 2022 13:02:58 +0100
Message-ID: <CAJZ5v0jUyneipaAU+xhJnO-Dce8RC6O9Un_Ly0vLiNyrj6eYXg@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 113/118] arch/x86/kernel/acpi/boot.c:1394
 (null)() error: buffer overflow '(acpi_dmi_table[6])->matches' 4 <= 4
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Mark Cilissen <mark@yotsuba.nl>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 3, 2022 at 12:52 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   f7307721a01f4f14d21c699b270a870370cf34b9
> commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work around broken XSDT on SEGA AALE board

Yes, this commit has been dropped already.

> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220302/202203021037.WWnG44C5-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

Thanks!
