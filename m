Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC36287ED
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Nov 2022 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiKNSK7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Nov 2022 13:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiKNSK4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2022 13:10:56 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4BB240A6
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 10:10:55 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id c15so7272469qtw.8
        for <linux-acpi@vger.kernel.org>; Mon, 14 Nov 2022 10:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1df6ms79WMV4EDhwU/PfzEJZvo0+RPK8Gc8k9Hwm8MM=;
        b=4RlBPjRzFKt059wMyJVSoK1xW87DYUVlKIcfmNgga+z4mgbHqO5NDFXQbb2zlads2W
         XOHw4YdDfNcb6y2X8q+SHKZGOUZROshcf5xrU54wkp0cMDYIIpaUxvenDEk8XzfNf0Yr
         jQKalq+Ng8FOcuUrLvxvIANoV71ykQ9vorKgLueeeKxro/BFY9HIx/voMMuBaBtfUV5T
         B2OfvP+7xSvd2UYPX5mbXsbAjAVlkMnjz0i5tB9+oPTOWzWRcx9c+nsHkPKNaZSVBT8+
         udYkDEZisGRmjFY4cN+IwC+YJxg+47OqcfVy5CXWQlHND0X8h6mljY720sjfKlwobC5l
         /rvw==
X-Gm-Message-State: ANoB5pnZNmWbPVIT4zvJqeRvUqtvYl5HYWymSAukpeap/rH1SUnc7/CV
        SvA57R5b+W2gG2xr5LikvcOuenOLP79CTGaWqN5Bjqed
X-Google-Smtp-Source: AA0mqf5c3BLvmEkSrBRtegb3KCdSyfqYJKUIpDW/nE0YxWN6HOR/+J6fNTPXjBzKMMiCDA+NMPaJ59kfLiXd9R9hjoc=
X-Received: by 2002:a05:622a:54e:b0:3a5:7cf8:1a6e with SMTP id
 m14-20020a05622a054e00b003a57cf81a6emr13415171qtx.48.1668449454755; Mon, 14
 Nov 2022 10:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20221110134505.1375955-1-sudeep.holla@arm.com>
 <20221110134505.1375955-3-sudeep.holla@arm.com> <20221114180454.GB31476@willie-the-truck>
In-Reply-To: <20221114180454.GB31476@willie-the-truck>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 19:10:37 +0100
Message-ID: <CAJZ5v0jR_-184X59rUXp_TYRncBZAYH7BrSKyz4wNOD98KnW_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: Add architecture specific ACPI FFH Opregion callbacks
To:     Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 14, 2022 at 7:05 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Nov 10, 2022 at 01:45:05PM +0000, Sudeep Holla wrote:
> > FFH Operation Region space can be used to trigger SMC or HVC calls,
> > using the Arm SMC Calling Convention (SMCCC). The choice of conduit
> > (SMC or HVC) is based on what the kernel choose based on PSCI as with
> > any other users of SMCCC within the kernel.
> >
> > Function identifiers only in the SMCCC SiP Service, OEM Service and FF-A
> > specific call range are allowed in FFH Opregions.
> >
> > Offset can be either 0(32 bit calling convention) or 1(64 bit calling
> > convention). The length must be set with the range applicable based
> > on the value of the offset.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> > Hi Will,
> >
> > Catalin had acked the changes to be routed via PM tree for last or the
> > one previous merge window. Since we were waiting for ACPICA changes, it
> > was not merged. Now that ACPICA changes are queued(via PM tree), I will
> > ask Rafael to take these patches now. Just thought I will let you know
> > since you are handling upcoming merge window and I do see few ACPI related
> > changes there. I don't see any conflict with this, so it should be fine.
> >
> > Please let me know if you are fine with that and ack is an add-on :).
>
> I'm happy either way, so I'll leave this for Rafael but just poke me if you
> want me to queue them instead.

Both patches in the series applied as 6.2 material, thank you!
