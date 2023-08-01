Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341E176B44A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Aug 2023 14:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjHAMED convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 1 Aug 2023 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjHAMDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2023 08:03:45 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A61BCF
        for <linux-acpi@vger.kernel.org>; Tue,  1 Aug 2023 05:03:24 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56c9f7830c2so267016eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Aug 2023 05:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690891404; x=1691496204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgyU6F06+yN6tyWt7TXhcNApJaz1s2l68l+UtjWGvbw=;
        b=HDLdyz946VWMr70LOi5rBmMkk9CUhKv9HoBn6cgfURG+8EQUED+ohqb9cj7mMtLVwh
         TvDKcZ+raaJt0DHSXfoiqSJmEBV8yV2bpvuu6glsgxmAiXsSniwo90wXw9ob9v26Vmsm
         wAhdnccbJ/xQq9le3Oeyd/JOjjehZPGPdRFQiuFDM76w+wG/EBE0Imxv6LOLPczC3V9F
         6xSCEsCl5o2aBkzgWdrTgRgYe/Kpe48F5SWq7kuIEu97gDTE95xyXhZdlLPo12+vuvpu
         0KCxXcl9GGqCBA5svyeURa5AWl9tr8d9l1eoZnCndEZNOfryF+UUfOtMa1KLvba+OrD8
         zs/w==
X-Gm-Message-State: ABy/qLZS9PB/UE6Hr/K6uMwx+82cgmR7KVh0FS+BaYS58Vr3G4xcPKCP
        cQ4e0n7u0ccGo9B/AvPzilkZAh3t81+uwGcTryI=
X-Google-Smtp-Source: APBJJlGIJ2OzXr/ZfvpEUo/qs40RF5vEAEZhgWbjU72yuUFdSSCt40PW/OQqOYzurJ1j3baDusHvM7LyaKFc5IJV8BE=
X-Received: by 2002:a4a:e9b0:0:b0:565:a7bd:3927 with SMTP id
 t16-20020a4ae9b0000000b00565a7bd3927mr6752854ood.0.1690891403979; Tue, 01 Aug
 2023 05:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230727133347.648102-1-sudeep.holla@arm.com> <CAJZ5v0heD9EG1Wi3ty17gsFJd1K7U1=BOCcPpicbN4L9BEzc5g@mail.gmail.com>
 <20230727140614.v3zwsurps6x4hm5y@bogus>
In-Reply-To: <20230727140614.v3zwsurps6x4hm5y@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 14:03:12 +0200
Message-ID: <CAJZ5v0hWONN6Ugt5enQ-b7EB0aLyocJWzg++vkMUKe+K+29bCw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Move AMBA bus scan handling into arm64 specific directory
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 27, 2023 at 4:06 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 27, 2023 at 03:50:20PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 27, 2023 at 3:33 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> > > initialisation into acpi_arm_init()") moved all of the ARM-specific
> > > initialization into acpi_arm_init(). However, acpi_amba.c being outside
> > > of drivers/acpi/arm64 got ignored and hence acpi_amba_init() was not
> > > moved into acpi_arm_init().
> > >
> > > Move the AMBA platform bus support into arm64 specific folder and make
> > > acpi_amba_init() part of acpi_arm_init().
> > >
> > > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > or please let me know if you want me to take care of this.
> >
>
> Since all the change are in drivers/acpi, I prefer you take this.
> But for next merge window, the only issue I see is the conflict with
> the coresight change that triggered this work. But git should be able
> to manage that or I can check with Greg, I am fine either way. Let me
> know your opinion/preference.

Applied as 6.6 material, thanks!
