Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BF4F46DF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiDEUuT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbiDEUsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 16:48:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D3F1AFC
        for <linux-acpi@vger.kernel.org>; Tue,  5 Apr 2022 13:22:54 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x31so502783pfh.9
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2022 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIHQKyxUpgpxOWFNPXjTrKl0ddNnEy6g9QXsjbdAZCM=;
        b=d/Y6KZO9645gdnl4o3upqi/iG9kjHXCMROn5f+LebItqV4LN4zekkBGAIgaf4F8Yvi
         dZudafPooWwy8sgynVt4vyd56kL99iIvSunXkn+J15FpyNKUVZSaTCSTjOmONCsAU2Vx
         3MRqypy/kGoqtalGE7YwzrikMN9L1iUDe+bVxELbBw1yU1ussZxmNop3XCZFpbQcaMh+
         X2NjgLkMNsS8p3lgHQQ4MYafNqIk7bCo6pg/BYTeT12ogE0ipCprm09MR8lVQwH+vK71
         RQrmXn9GBx+pDmhBG5dTlkm/9I9HrfDR5U2nwHNQCPHCHP6wmxjaY8LP9L8GveM1CigB
         nm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIHQKyxUpgpxOWFNPXjTrKl0ddNnEy6g9QXsjbdAZCM=;
        b=RUbldyZnbcxQguTu21UgkLPYEfeN9h58i90CJ8SiHsXx0xeVG72jawOEJNSeeRbCD9
         3nNSffHSM4IRzT0b8pjNOlUZ78fhiowhxC3e1y96O+WDjaPIPYBO/AIWJ4HUfCHU1vDL
         fuqsJJj9N0eQUI5AQyeASvxgDLP74Hw83OKOJakLxR3GYNHL1R1+c4Lt3PJIb3eI4cn9
         zf6xsfxsXJxA9KbTI/RBXlZyIaZ6h5jthvDoV8kM1syxK2HdFiXK6yfXdYDOILDkVQqA
         xarANBSS8qcpHUmf7Duh4OlJNf/3n4f5HIg4yLztkW4/7aXepeHnOMmuq4UmGy7R2Cfy
         S9bg==
X-Gm-Message-State: AOAM5331IZKhMpjH45P+SrdDCK4jxYlf5ICmAniLGY2KaUZ4Et7/Hy9M
        H2C4jEUyq9dR22jCIbuIwY7HopXrMFXfKEG5RV6QDg==
X-Google-Smtp-Source: ABdhPJygHRFzz79Dv7ynI/sD1a/ihGODe4mcJ8u3f/SfJGfUVLl6h8mn409eGbTIBdC8IEGgY5FI40jzYwbmSswzPlI=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr4420099pgl.40.1649190173580; Tue, 05
 Apr 2022 13:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
 <SJ0PR11MB48956875FB15F900B5CF130BE0E49@SJ0PR11MB4895.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB48956875FB15F900B5CF130BE0E49@SJ0PR11MB4895.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Apr 2022 13:22:42 -0700
Message-ID: <CAPcyv4h=A4UKzjzQ5DAQFD66KnAU4F9MZRu6kGAgi6U3nX1hfQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: CXL: Disable suspend
To:     "Brown, Len" <len.brown@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 5, 2022 at 1:05 PM Brown, Len <len.brown@intel.com> wrote:
>
> Is it possible for ACPI to be aware that CXL on that system doesn't support S3, and for ACPI to thus simply not export S3?

The ACPI domain has a chance to be aware of CXL devices attached at
boot and were configured into the System Memory Map.

However, there may be caveats that limit device visibility like
platform firmware only scans CXL devices directly attached to root
ports, not behind switches.

It would be welcome if there was an ACPI data structure to indicate
"device-X is in scope for S3" which would mean that it has aux power
and all HDM decoders (the registers that enable access to CXL memory)
are restored by the BIOS before OS resume begins.

Absent that the OS can only assume that the BIOS has no knowledge of
any HDM configurations that were defined at run time by the OS, like
after hotplug, or configurations that the OS rewrote by triggering a
secondary bus reset to unlock what the BIOS had locked and put into
the EFI memory map.
