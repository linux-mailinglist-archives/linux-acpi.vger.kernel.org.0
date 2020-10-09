Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E23289082
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgJISDr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbgJISDr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 14:03:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D82C0613D6
        for <linux-acpi@vger.kernel.org>; Fri,  9 Oct 2020 11:03:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so7528982pfb.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2020 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gAAMCepqobw6tAv0NKnu0DRBRmHRA3EpSxx1Y4BJ/ao=;
        b=iiTNuyzuEmUSEE/Hru+Y3B6KbrrOPsp8fAtOvbJ8mesODX2DzYvlOxWG0bMEGSA3ao
         YcgG/aEDxmOxo1Agatg0s3CfdWn6fgaz30eymOcckXmvkDOG8T/5pnArNF8z9q7q1ch8
         T7c+WYhFXX6wq88srZeVbX0XazKryeUuBjlrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gAAMCepqobw6tAv0NKnu0DRBRmHRA3EpSxx1Y4BJ/ao=;
        b=HlVhPYPye5JoWJaBHom2Wauk2CRR9S/p2nYfHTgX7v9DNSHjjY4jbqlCx4PUvQXkjt
         EC27kCOqtsAVUui/yrxg6i/j6W+Lvk/v0WduYgbHAFQLXYZ+7OPMoUBObd8ykh9U16Jg
         gZuqHKDfzaNL6y3NtNoWa4b6Lo3eKTwPXKjB5Q9pI1R/E6DdcGyCZLS0hxsIvFoDzTxU
         MAtr6wVNHBKa9gw7oiswXi7U3gatVU+ugX1N2u0cBRdoZnwkINeWpM44QRsTFslYVVDe
         RQJ/pPUZZMgfB7vu4+1h9Vo7/Ft46IUr4dCW0cN0uCf38t7yS0gxUuAISFvXeHaf/Lxu
         wVqw==
X-Gm-Message-State: AOAM531fPpGefVbChNfZrJbLahZez7zaAm+Tqf3N7uk2r/5F+lxKPC0M
        VLw8oGYfKEuI6tWLp2wIvhi7RQ==
X-Google-Smtp-Source: ABdhPJysT12No1lDoGSMw/H2+Oq/8cLgq6b3+eY2EubBXnsEpPWixk4MotSHSqGPQyU35R7/5GB0Cg==
X-Received: by 2002:a17:90a:7f8b:: with SMTP id m11mr5894826pjl.121.1602266626529;
        Fri, 09 Oct 2020 11:03:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d128sm11815809pfd.94.2020.10.09.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:03:45 -0700 (PDT)
Date:   Fri, 9 Oct 2020 11:03:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
Message-ID: <202010091103.5E435B42@keescook>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602209970.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:55AM -0600, Shuah Khan wrote:
> Note: Would like to get this into Linux 5.10-rc1 so we can continue
> updating drivers that can be updated to use this API. If this all looks
> good, Kees, would you like to take this through your tree or would you
> like to take this through mine.

I'd mentioned this in the v2, but yes, please take via your trees. :)

I'm glad to see this landing!

-- 
Kees Cook
