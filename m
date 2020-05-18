Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E651D7416
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgERJcS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERJcS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 05:32:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02BC061A0C
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i22so8408733oik.10
        for <linux-acpi@vger.kernel.org>; Mon, 18 May 2020 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=p+4e8OGbkl4jtB21Kp0Taies1F3UglkyxEVlBRQUQ1JCB7uuaBDtommPyyPp+nFWc3
         1Xguh2oulhrEM1GT03E7NzWVydFgKZNO9PxIrx2t4zUNhN2e2Yzekzb5Kd8ItHWtaWJ+
         DJRzZRP0Zod3TVkJ8lxGJbG7FIMvQZ7pP+Yi5IcziQk+yOTY+8Ijv+n/4M4sTFnh95o/
         YyGb1xwUv7sa8c9Jbj4KOSqiGGjhEjVMmHGmH4kDJ/f+dly1SZSizUV2p+nmhaft5URq
         EUcitTFvt2xe/bdolmFD5KvRRInAoLbZB0WCOCNiPysMYx9wph5eWaErFcbLXSzPw6Y3
         SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4y8pOF1U2hIXUEaQHB5pp1+f6cCMjasAlccauvS3u8=;
        b=JpegazoNRwJeMEQRrnmOJOXwZutMzHsE1WSpOBm/fjqVoDxnvTL+cxjOeimO0pijgZ
         9vnMX4QPhBLTN790Oci32WkCed0rW8BkX7Pdb8bpLQk65i8eqeKQiE5PA04HRw9vUa1b
         aTlnUByY8/k5CIUhLIpzbbqYzp5KUIIrx/Ulj0vy5GvM6636bA/bhPcSRPsEB8UO1fBe
         lRgO0Gl6zwrklDcPEY/GhzuSHI+OK6+E3bfUtRDXrRpFjkowqt1LrJDVrPkufn56lhsK
         dmFzLDX5bcOsZRlVsmPoprB5O3W/BIb1YkK9N9VtE7iDbzZ2EQIrDivp6jTfVJKHEvUP
         Ifug==
X-Gm-Message-State: AOAM533UtfXS0FG46LlebV2gGVo/Dm1CCi7+tqpm8b03btl55ZlaK4Mv
        R82Loy5xY+OSeyrVnNlTsWmt8OYXm2ifDyWfCKTzuXlwBDk=
X-Google-Smtp-Source: ABdhPJyrEJAISIZWsXEyVlyc4BlPLuXVfhVNfJE1HrEOPfH8Lbw8GOfGkNCHlNzM0DGX7IOc1TiEmiYBdJ1xs3xDRQ4=
X-Received: by 2002:aca:ea46:: with SMTP id i67mr9709314oih.152.1589794337493;
 Mon, 18 May 2020 02:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <4502272.pByIgeXik9@kreacher> <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j6S+we7tHeV9TM30LS+TO3zWigACe0ZUFfWphg2FBBZQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 18 May 2020 17:32:06 +0800
Message-ID: <CAB4CAweV+U_pPv9877S+j6UVUPjcTzJq26rarxnJfwc6on1ESA@mail.gmail.com>
Subject: Re: [PATCH[RFT]] ACPI: EC: s2idle: Avoid flushing EC work when EC GPE
 is inactive
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 18, 2020 at 4:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 12:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Flushing the EC work while suspended to idle when the EC GPE status
> > is not set causes some EC wakeup events (notably power button and
> > lid ones) to be missed after a series of spurious wakeups on the Dell
> > XPS13 9360 in my office.
> >
> > If that happens, the machine cannot be woken up from suspend-to-idle
> > by a power button press or lid status change and it needs to be woken
> > up in some other way (eg. by a key press).
> >
> > Flushing the EC work only after successful dispatching the EC GPE,
> > which means that its status has been set, avoids the issue, so change
> > the code in question accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Chris,
> >
> > Please check if the key press wakeup still works on your system with this patch
> > applied (on top of https://patchwork.kernel.org/patch/11538065/).
>
> Hi Chris,
>
> Since I haven't heard back from you and the problem at hand is a
> regression on the machine where it happens, I'm going to push this
> patch for merging.
>
> If it causes the key press wakeup issue to reappear on your machine,
> I'm afraid that we'll need to quirk it in the EC driver.
>
> Thanks!
>

Sorry that I missed this email. I'll apply this patch and test again.
