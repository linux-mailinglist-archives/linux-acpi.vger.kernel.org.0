Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED433AE16
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Mar 2021 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCOI6n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Mar 2021 04:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhCOI60 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Mar 2021 04:58:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C7C061574
        for <linux-acpi@vger.kernel.org>; Mon, 15 Mar 2021 01:58:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so13980376pjb.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Mar 2021 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=LbXdRz8hPnZqXslejUsgqIR1UD+ZWrpimEiaxIRNV2xNX9e7brdrBT+330tAZDGZ76
         Z44Aj1/yyzeGeEkcMYIH//MrHNptNc2k8UMVVIbEobpJRFQZA5XUdWQqiNvRvLYVAtMv
         xoKQqrZLhKUh1J45nJIpEkqDSvu1Tr5FBCilwjOhp0zEm3xGoD9/vG7Dh8s+ZnaHk+U5
         aC4U8SAWGye+HmhE2PCrqjaznbIw1afwdXDR2ixAMyaUV9dRzZFQUIU2zeRr2wSRJLp7
         p1AlF+JfxodPPIujXbeP44SJwrB9ufhws/ELF19RzCKTBjiq4R1k6O0qwSqq/Q2I9TSg
         kWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KaCT2PKawa4ayzRWfCLjxRAOg79RnoRkYRACpNhTfx77XtsfcgX68mImv9z68+2Kp9
         uR4u38FLMLF0SZ8C0BLWefb+MDihDKH5OnmpYLd8teoh6MZBa8Lj+snenHVFsabVM3im
         jgz90ztpMXtwl4I4FsHZ4hH0imIMkhklsDIBurDhDdylDUXSEtf/abXOhbWlzOh3pL5e
         L1TKomFZu9aDHQ3+kdxqBhMC8bZ++SWOR955ciDZQ0r+TDmLKnuFkRDm2n2dbHEBkMpy
         K5xVOVIgu33L5+fXzqZr1F8eZ6JSxevKBPP+tqWY7DWU5Dyt7+lytkPfFjBSL5TSUJWm
         wScg==
X-Gm-Message-State: AOAM530k1d+HJ8S8mPm2NRit3y6ptqFbaEreW7KLSoo6nzXXMWCd5bcV
        /2wjQwaePl9YHIXWzaR8AfSpV5kyTkXBNgSUJy4=
X-Google-Smtp-Source: ABdhPJzM3716DwOVGJCGkipl2s83y6Vr9QPdVnYrrkkfjWixAG+vz2jlo87ubzFNH0zawvhQR6gAd9jVx3Jr5JWxmEQ=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr10466389plx.24.1615798705311; Mon, 15
 Mar 2021 01:58:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:b086:0:0:0:0 with HTTP; Mon, 15 Mar 2021 01:58:24
 -0700 (PDT)
From:   Kevin Roberts <kossietenou@gmail.com>
Date:   Mon, 15 Mar 2021 08:58:24 +0000
Message-ID: <CAG0ufbSHz-LVYuzP1751truEWnrY1BuqX3DX+9fBeaRHrW_inQ@mail.gmail.com>
Subject: I sent you a mail earlier but not sure if you received it, kindly
 check your email and get back to me for I have very urgent information to
 pass to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


