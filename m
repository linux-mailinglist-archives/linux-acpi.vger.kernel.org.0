Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00023446C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgGaLOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 07:14:40 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42299 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbgGaLOk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2020 07:14:40 -0400
Received: by mail-ot1-f45.google.com with SMTP id v21so15083663otj.9;
        Fri, 31 Jul 2020 04:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wrhl52ipoO7lVMpYyYY2X0TUE7l7BgQK1+7/W1Sak/E=;
        b=e8Mf+I+WQ8zZDzTqlM4MFyWH4fWqyDDcS0mXzVUh/UQOfw0B8O1jYrjjXN0Clr3YQV
         fb8oDU48LVz7ioNY0IyavkluCYoh1N2ldM+rPh4DDE1PseIQPc8cYWm9TaDcBa/zDErU
         KMTHDf7LxsSZCuV9nsf5qtq6HKt55mrUfHxxDd/r8Z8QJdj5WwYZEOt2BS2zhbEFWSKh
         SjErkMi+1gmnfQ/zCfb6LjFlk8uF41Erwz2xCDwjzxlI5+vXpqth3TyjlvodiJinCKIi
         W3BsyzAZWkFuRQL4hmN8eYRHkxt2TEDNAgGxuSRJMNcPzvb1lUbBwm/3zItx7ION+xni
         HWrQ==
X-Gm-Message-State: AOAM530X075n3R3ihnyU7Ip7eSqZUI96oAvKAquZhlTw1FQjAzRzlStZ
        1Tgno80ZpOmQhDA8YsN+bktkG4gQwd/AbQewFXo=
X-Google-Smtp-Source: ABdhPJwTgm2RTlfE3PfQw+B3a/e5hImLl3RaslOLRm7NlipEADyPDJaaJa0xVKwSiLmbETPnhGvqZ/WsvQDFktbKX1w=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr2391298otj.118.1596194079335;
 Fri, 31 Jul 2020 04:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200728082857.10829-1-akshu.agrawal@amd.com> <20200728082857.10829-2-akshu.agrawal@amd.com>
 <159598596077.1360974.483730969007254506@swboyd.mtv.corp.google.com> <c5041407-1bbb-82b3-e5a5-c6de0ab16861@amd.com>
In-Reply-To: <c5041407-1bbb-82b3-e5a5-c6de0ab16861@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jul 2020 13:14:26 +0200
Message-ID: <CAJZ5v0hk+kNrHo1VmBRC=VF-dhdRP2143BxeHOGyY==1Cj+Qrg@mail.gmail.com>
Subject: Re: [v2 1/4] ACPI: APD: Change name from ST to FCH
To:     "Agrawal, Akshu" <aagrawal2@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Agrawal, Akshu" <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 31, 2020 at 2:44 AM Agrawal, Akshu <aagrawal2@amd.com> wrote:
>
>
> On 7/29/2020 6:56 AM, Stephen Boyd wrote:
> > Quoting Akshu Agrawal (2020-07-28 01:28:53)
> >> AMD SoC general pupose clk is present in new platforms with
> >> same MMIO mappings. We can reuse the same clk handler support
> >> for other platforms. Hence, changing name from ST(SoC) to FCH(IP)
> >>
> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> >> ---
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
>
> Hi Rafael,
> I see the status of these patches as Not Applicable in patchwork, is
> there any pending action for me?

Yes, there is.

You need to let me know if you want me to apply them (and I mean the
whole series). :-)

Besides, I only can see 3 out of 4 patches, so if you want me to apply
them, can you please resend the whole series with CCs to linux-acpi?

Thanks!
