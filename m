Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BEB3037CD
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbhAZIXp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 03:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbhAZIVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 03:21:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79923C061573
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jan 2021 00:21:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e15so1931941wme.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jan 2021 00:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+jmRovbHoJFIPsxdXAY7r0V1zGJfwiz2YjhcYRzpajM=;
        b=PxUN3nqggnDRnjIg//589fa4L1h6sSUPQup32s/k9tsY1DOKHbiY07oQpUffQPQ0S6
         Hjyb6TEEApQdEuHzAXuTm9jOnPEHJWUxI/neKhqfWxZgx576UI8YQORSxwI0f8HpTvnB
         3Y8arwDxSK4Mbl+fWIXurbvmHeZ1c9tRuCK1JXRa4pQa6OEIsgk1kkKdyWwicY+PiHvw
         FmbZkaml8GNQNpNkeeMS+I2iClvaXvN6gHPAy6D7mkLhLMOpt/mqS5lCBHCxhCOpDmJ8
         DtaDUBVZCPdvJBF/RbcoF7YqQ/RbEYvcRYz59yrYb0Al1URb4qryjElzKZ0vmWu4kMlK
         f4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+jmRovbHoJFIPsxdXAY7r0V1zGJfwiz2YjhcYRzpajM=;
        b=iJh7EKQ23NulNWxSNlu0tsOAnjbP46I6ciT/i2iXLn8XcXNuMc+XpvgGbmag/fdocG
         l8S9OhpCyq1s/2KpaUXSGhz2N7nPpdvhEVQnhT7TuNm5t9kUtO6X+NJnN+uVWQkD5uW8
         QZiY+x4Q0/UeD22CnZfHwFsWi6x5nNyI3vL0aPgU/MkHhSfH6pDRfUwavIX7NQIz9f0N
         Xl/6yiybZgXXnqWpFgGgVp/rU0uYA/udmuQzI66OBhPXwee/DNujTxrU/PNfLtKe8F+y
         DMBqa+ecdo6ySdhW4k3Q8biTeyyXxwIgLuaEdZpsh/nOLLGBNQ54a5Li6aX61vby2wr5
         WCqA==
X-Gm-Message-State: AOAM532+e7xoIzykux06n9A2v2op5eoqZtBeJVrkM7FID217VIPwd83s
        X99aDWrX0ZViJlnMJOzT56opng==
X-Google-Smtp-Source: ABdhPJzWMEJBAbelnI6VV/+tPmVfTI0FrXf0cV2oFryj7tJwUA85QEhadchYojFzQ1oygPTv16rZ2w==
X-Received: by 2002:a1c:26c1:: with SMTP id m184mr3611308wmm.49.1611649264241;
        Tue, 26 Jan 2021 00:21:04 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id g194sm2259715wme.39.2021.01.26.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 00:21:03 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:21:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Message-ID: <20210126082101.GD4903@dell>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 25 Jan 2021, Andy Shevchenko wrote:

> This is a second part of the Intel MID outdated platforms removal.
> First part is available as immutable branch [1]. The series has functional
> and build dependencies, so the mentioned branch should be used as a base
> for these changes.
> 
> Note, that some of the drivers, that arch/x86 covers, seems never appeared
> in the upstream (like msic_ocd).

What platforms stop working after this removal?

Are you sure no-one is using them?

I wouldn't be keen on breaking Janet's PC that she's been using daily
and keeping up-to-date since the 90's.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
