Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76F2AD321
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKJKFP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKJKFP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 05:05:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A02C0613CF;
        Tue, 10 Nov 2020 02:05:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j5so6243347plk.7;
        Tue, 10 Nov 2020 02:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8sRzW2c8RZd5QnVu3t+S6Fnb+20BTMVKuWncZbl1Mk=;
        b=jBcpCAYC6h2D3GoGnFV9cBxCc9ihl/hQbJiRz6wM7XpT5AuSL0Fw4vcMyRRXe4AuQH
         H9TaKMzjMht4L6+hGrbu2MI/U8zSfjxD1CNttqQRY2Kw18QCZo9Wc4iNtwNcEvIZcGCx
         rU30zHzuvtrd3dkHAEiiDiDoTW7gxmatDRYMvUQddIxw3ON45/p1UtEHcHQIuXimvqvP
         ncNt4SKNKprevnp2EjUITCnyw0xHPjcdLVLXWn2ezdO3EgYsMdDGx7WrT7J+RFQAqoB+
         tklyy4ynp/oE0lWq4fNYpt+mJXkuLi+HMDpHV1rxAKINXzI1nGIoThcrW2Vt9cXPiZtd
         a/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8sRzW2c8RZd5QnVu3t+S6Fnb+20BTMVKuWncZbl1Mk=;
        b=CcxtVe3+L1nhqEtVc7D+qWwbFXsztMk8vISNnUR7riAo7tfeeS0l4nPryp81rC48CB
         Su4CbDuyDOEIDabs1twPxgfzY89lYTwZUaOphdRUMBnFPbuML6FiG32u68xxb32SLTlb
         0IwfcEn5j5UlwgC5naZ6Ey8c+LTmC/nhZen32BO21CmwznZ4HPzb/uLIDpPS57zNE3Wa
         40iT9nuPKeshUkyR2dGkEuTwTOX9285RO6BqEYKxeSU4Ot+a2qaiGx6CIJ9YAhMB14QZ
         kTs+MdKX+PA4LO86Tzzxh/GnC9A8wvRtBKl1raHi1gdcsSVC5aNelPwiGZ6VdBXscdYR
         eQXg==
X-Gm-Message-State: AOAM5315BFaPs5LRQReT2hdtZ/GsYhL6FNahlmil/gIb83bSja/KefQ4
        hN5n6FQoU1fwz3qeUMvAYRmL0NYVXOinpdykpdUWj+OtG78=
X-Google-Smtp-Source: ABdhPJz7EIDi7TpkeQVyGVIaKm597GLSUIoxNxMS0YZWUcXbvLj9JjlGRtGw5Mlby0VhEpyewymJxDmNj7/gjUPHbmM=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr265438plt.17.1605002714599; Tue, 10 Nov
 2020 02:05:14 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201110033124.3211-1-markpearson@lenovo.com>
 <20201110033124.3211-4-markpearson@lenovo.com>
In-Reply-To: <20201110033124.3211-4-markpearson@lenovo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Nov 2020 12:06:03 +0200
Message-ID: <CAHp75VePnNAmiOHKpLui3J_nh6_qVsbEGB4rjEAnFVhxkxbGsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: thinkpad_acpi: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 5:34 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
> version 5 support or newer to use the platform profile feature.
>
> This will allow users to determine and control the platform modes
> between low-power, balanced operation and performance modes.

...

> +#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
> +               platform_profile_unregister();
> +#endif
> +               dytc_available = false;

> +#if defined(CONFIG_ACPI_PLATFORM_PROFILE)
> +                       dytc_profile_refresh();
> +#endif

Better to use (e.g. test coverage) if (IS_BUILTIN()) / if (IS_ENABLE()) / etc.

-- 
With Best Regards,
Andy Shevchenko
