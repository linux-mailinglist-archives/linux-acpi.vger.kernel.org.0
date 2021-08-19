Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762E3F1203
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Aug 2021 05:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhHSDlV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Aug 2021 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhHSDlV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Aug 2021 23:41:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D4C061764
        for <linux-acpi@vger.kernel.org>; Wed, 18 Aug 2021 20:40:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y9so3470879qtv.7
        for <linux-acpi@vger.kernel.org>; Wed, 18 Aug 2021 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAqubaJQZFXuzPjRQ5ike/qcb5qForDAioJ7hjbMGvs=;
        b=s0LDO30ETapMi8Vb+cnM/JeloN08Wt+wkTviykKH+SoIzz83dtKOqvzHTFO9sJ1Jgi
         pJY+fAr1/PKDDl7D4flWpMCVLvbv65TWm098WRCT71OAYinmI+ndqCZFowh4hrxyZDBu
         aQ8rYmDLmH1Wd1shV2znq1AO2sMMj64h1agXdwBin+XjJP3UpbZqfdWjTPQzuXd6VI5m
         QjMpXxggxFbW/Nl6edH4Gvdv/6mVOwSn62unssDAObc1bzknhD7BohfLosObYDAlKyxI
         4w80wZttHkEE3npzDcFaVVZGODacQdrUN4VgJ2u55hVlLn4pCQ60UGTwfuCpntPmaOVD
         hONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAqubaJQZFXuzPjRQ5ike/qcb5qForDAioJ7hjbMGvs=;
        b=t0KDio9NpLzqy/i3DcYNOEyG7wzMP913szi34NztqwMH62LJEaAQz8cRisfSfkBSPS
         yFFqmzn0Zc8btOUGsvf7OYOOimlJOVMDk2eYUwgxbC9jsLHyAOd8L+pKuapdnOzUuhAh
         UC+olu+vCRKG9OIvRQN9UKz1bJSTQQ2ck18E6bIJamEGK9bIqwpv3glKOhrKnGYQjSE5
         C2FtQJCPCahq+FTk2WYr0DGKbCUkLdrQcZqypWXbgt87YnyUc70NLC41QXbQ5WZ30/DR
         kXwRRU/7dTyFoHjrKoxBCSEypJ/64CYFNqBd7ofycoh+GPvr2pr4hp6/fcUmTNsPm/Ew
         6nLw==
X-Gm-Message-State: AOAM530RYjRaAhhYbgTIDPJAMZ21RBYfMdE+rkzzOgCXhSGr4PRiVAYv
        gbl8tNGoqhdvBnaEqOrBFJ1WNl3kpMUsc8xCmL4=
X-Google-Smtp-Source: ABdhPJxWR5RE1WWuamFOXQ5D04zE8MFNYkUsvSezB6FQWIDO/VO1wMqXszOc2KAurrhcJ1JPcb+J4IviQ9/PBjDQmyw=
X-Received: by 2002:ac8:7774:: with SMTP id h20mr10897435qtu.133.1629344444902;
 Wed, 18 Aug 2021 20:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210818063831.1349-1-adrianhuang0701@gmail.com> <08895a6117ee6155f15764ad3fafae35b98b7ece.camel@intel.com>
In-Reply-To: <08895a6117ee6155f15764ad3fafae35b98b7ece.camel@intel.com>
From:   Huang Adrian <adrianhuang0701@gmail.com>
Date:   Thu, 19 Aug 2021 11:40:34 +0800
Message-ID: <CAHKZfL37M8-nMUQLH1p+U5hsekjSP_kP2Z+GMKNPBz0YCpGT8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: tables: FPDT: Do not print FW_BUG message if
 subtable types are reserved
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 19, 2021 at 10:56 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2021-08-18 at 14:38 +0800, Adrian Huang wrote:
> > From: Adrian Huang <ahuang12@lenovo.com>
> >
> > Table 5.90 "Runtime Performance Record Types" in ACPI 6.4 spec [1]
> > says:
> >
> >   These type values "0x0003-0xFFFF" of Runtime Performance Record
> > Types
> >   are reserved for ACPI spec usage, platform vendor usage, hardware
> >   vendor usage, platform firmware vendor usage and future use.
> >
> > Users might be confused with the FW_BUG message, and they think this
> > is the FW issue. Here is the example in a Lenovo box:
> >
> >   ACPI: FPDT 0x00000000A820A000 000044 (v01 LENOVO THINKSYS 00000100
> > 01000013)
> >   ACPI: Reserving FPDT table memory at [mem 0xa820a000-0xa820a043]
> >   ACPI FPDT: [Firmware Bug]: Invalid record 4113 found
> >
> > So, remove the FW_BUG message to avoid confusion since those subtable
> > types are reserved in ACPI 6.4 spec.
> >
> > [1]
> > https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#firmware-performance-data-table-fpdt
> >
>
> In
> https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fpdt-performance-record-types
> it also mentions that "0x0002-0xFFFF" of FPDT Performance Record Types
> are reserved, so it's better to fix them all in one patch?

Ah, I missed that. Will send the v2 patch later.

-- Adrian
