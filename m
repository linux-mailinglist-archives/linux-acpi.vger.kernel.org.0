Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3689146D5DF
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Dec 2021 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhLHOlM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Dec 2021 09:41:12 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40839 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhLHOlM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2021 09:41:12 -0500
Received: by mail-oi1-f176.google.com with SMTP id bk14so4362516oib.7
        for <linux-acpi@vger.kernel.org>; Wed, 08 Dec 2021 06:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb7IbPviEYmH8VHKgSN3rqfV+7O0S1aNR8xN78V2ehA=;
        b=6XwX2JDnqvW5WOH4LTNdKgrO2eHZ9H7CK61kp0F8E3iY/cNMr/eO3UZHXn7AxaW8wD
         JnH2H9d91P9oYt25uQ2IeEfGWo9bwgtEw/Obwg/fA4HGHmnjhxyNmcmTawGDOLXZvvYs
         pgxDQA1cyS5tBto8UByXeEqFoVHth8c/IotbwSgr5OhUTfMPnCc5UTrV2xVkXxzFV6BH
         XcXizW+PtVtIgGyrzJFqEodH2ju5O0BnTt9MSUBYHIonYPeT34NfrAvY72nTNpflB+kY
         w/HhMuwR0yoMg2JdgqqU4XRwhaGw8RVonCFLe4AOCO2cPcLHTVzY+fnQKITxsBmmjD/k
         6OkQ==
X-Gm-Message-State: AOAM533xMwVVGLD5hcpMjIFWuaJBtiIMOtAyhgdpddkElB1od+nq7htO
        y/D2Kn2XHRGeSw2ApJ6jhBD2eWGHLuBTDrUbRvo=
X-Google-Smtp-Source: ABdhPJz7aGbICzMNWSQMZc6LfyC6qzhDvFv/1xDW8BBezl6HOoiCkmNCSC1MDoladpt0WOvzYIgfxrE4FNLO6oKCZ3g=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr1638483oiv.166.1638974260131;
 Wed, 08 Dec 2021 06:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20211126152109.230986-1-hdegoede@redhat.com> <YaEA61kEgkneyOlH@smile.fi.intel.com>
In-Reply-To: <YaEA61kEgkneyOlH@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 15:37:29 +0100
Message-ID: <CAJZ5v0hcQyn7K8VZ6K_nRUBLK6wLLMDyL9CSjCD7uwYgGqY8eg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: PMIC: constify all struct intel_pmic_opregion_data
 declarations
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 26, 2021 at 4:50 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Nov 26, 2021 at 04:21:07PM +0100, Hans de Goede wrote:
> > The struct intel_pmic_opregion_data declarations never change,
> > constify them all.
>
> Makes sense!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Applied as 5.17 material along with the [2-3/3], thanks!
