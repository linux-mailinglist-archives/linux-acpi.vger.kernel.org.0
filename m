Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC32F02E6
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbhAISoU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Jan 2021 13:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbhAISoT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Jan 2021 13:44:19 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA54C061786;
        Sat,  9 Jan 2021 10:43:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i7so9815136pgc.8;
        Sat, 09 Jan 2021 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jF6VdGJxWmDWa7dHF17UAded0tYZ8eT3kZWL5vZ7tGs=;
        b=f9Kcpo3HDTN1/Pmd/iQ0bHpjbaBiEsgUKQMFxDnQHM8BpXb143UIvPiDdHahWtgLZ3
         MaGJtrFl8MAyt5+zqGdxjCviLEMDs4EsHOgtcfZBQAuCxj74NNOcikRaI7ayP36Yt214
         RHyY+utuv0KD89drRbms4fPc4KyiLz9oCRX90bbYrzx8zAyikheLVDrxyZ+j6vaR6VtN
         cK0SpD87FAVayVxPYCxMF/UyKlAIpBSkGkauCo/Vw7ZE9ZGYjGrpzdamE18yGgCH70Kd
         /1weQTbUlobIEnr9rM0Wo30mECZeEa11/ZYIPe4igMIh175Jy1f6kL0dl/U0aVuJK2S2
         GcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jF6VdGJxWmDWa7dHF17UAded0tYZ8eT3kZWL5vZ7tGs=;
        b=l3ctj4bxF5/nOh3rPzZrvj0L2n1f46KkoxJtdVnG7Rmrk5IC7ANWAyzFSX3gTv0cEo
         Ua0WI4fgQU4ATy5Me60TeOG4dqU2bIieIbPtcQJZZ0o/J2KSoH/fcZq49EnI4MAc38U2
         WBNMl+pNtF7IaBmRRTNYK2YRqjrFkYHFonQPxrYVNhcv/ZZawqiaaC6dUNlFADRybm9Z
         Y3Ce1EcfUOVw6IJZQTGEYfUnvO7tufI7mlcCzPLP8rGcfCxS4An5xfdLcyevmnPuNMwt
         YBbxt/4fISZ5wh1b6SZUV3vV7+MxHWsfs8TLNtjnMPhjwFEyylX61w5oWLzH0Gbq2wdn
         SKZw==
X-Gm-Message-State: AOAM532Rrg/5MnOfBbXgVgy2vF0lpi3gfTThrKh7PAGm+odW9E9+S5iE
        8CqXYXll+KXh6kmdVbDb9207wEgvIPmqgtn5lOw=
X-Google-Smtp-Source: ABdhPJxnSUuAn6njem/U1DeZIftUrkjtGDByzPNhXB52ODPfTqwBxTHn3OEDGeuM1fU+jw7Kh8ZeFwGs7/R+DbH9Rww=
X-Received: by 2002:a63:4b16:: with SMTP id y22mr12576677pga.203.1610217818960;
 Sat, 09 Jan 2021 10:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20210108072348.34091-1-decui@microsoft.com> <CAHp75VfPsMNZxN-hA3Cytjpm0K9xGoQpcGY_FZR4hUrtyqMj=w@mail.gmail.com>
 <MWHPR21MB0798C62978C2E6F23FAB953EBFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
 <5464224.fTvfEN5hHQ@kreacher>
In-Reply-To: <5464224.fTvfEN5hHQ@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 9 Jan 2021 20:43:22 +0200
Message-ID: <CAHp75VdwnL_=En1soZX_STdrWY86rm2zqsPLx4pv0NK52SDgkw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 9, 2021 at 7:08 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, January 9, 2021 10:37:41 AM CET Dexuan Cui wrote:

...

> > Do you want a simple strlen() check like the below, or a full
> > check of the AAA#### or NNNN#### format?
>
> It would be good to check the format too while at it.

Let me summarize. It seems from my perspective that the best is to
have two checks here (as far as I got word "too" in Rafael's reply):
 - per length with a message that "length is exceeded"
 - per format with probably different messages depending on the checks
(like "vendor prefix has incorrect format" and "device id has
incorrect format").



-- 
With Best Regards,
Andy Shevchenko
