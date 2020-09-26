Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50A1279AB1
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Sep 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgIZQWu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Sep 2020 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgIZQWt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Sep 2020 12:22:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9BC0613D6
        for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2020 09:22:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so5807303pfd.5
        for <linux-acpi@vger.kernel.org>; Sat, 26 Sep 2020 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=56nCuRUirvF7dXeR3ek+2dKjHsN+uDHepkMc5x/GUbI=;
        b=Isi2jLYXO6Dg8qyvVuPVHRyByy5BJbI/6gQ7oyreYCwo3hF2HZWbgFd+OR7hRce1fZ
         2U/ZQbjFTvRuIeCm/BU9DG+iLYnBeO1MwXQ0sQdx/BPZPYKSow2g5lkv8xfIdoh/h6P+
         yYMV58dnKIat08n/3yoDRx3fvWRtDiWeJp814=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56nCuRUirvF7dXeR3ek+2dKjHsN+uDHepkMc5x/GUbI=;
        b=iQamaWR83yNrfNHsARAcjw6JVmpd1GhsewxvQGgv8Ff/AFkojh34ZAkcXL8tu36pkl
         lnkEbKU0qgOv8yIoCbr5//IC/yb7dxTZW0jM8Suyf+bsUG1OxkIxehwoCZ/qnByWPlPu
         xPCb5LKHkMNqFEcgO2HH9seZVI8Ecv43AINBaV2xrsIot6jh9i6S6dp0xjVdw7Isg7jc
         ShCVYjoqdyJsUE8G6VJOHen47KUl3mC7aQqsMMcXQfuaWAAG627jCRHnyrHczH2ldDlH
         r4I9PJVwtf9TvoFp65O5i5+7yyNvHKVERBfcwrt/+jcVE1bkVv/qr8uOLB7AgsIxNMws
         5gGA==
X-Gm-Message-State: AOAM531yHYBcc1IIDq21LLamjez/qoM+C1SuQiU1nNjNwCPgACz84e5s
        12moK+1iPHIbLwvc/2MwFv1cZg==
X-Google-Smtp-Source: ABdhPJz7HHjVeWBhAtMxjtcOjPKebh0qtmEHXOfr7MHXU6sFu9+pz+tyh0OJt8n2B09hRbUf6d5KgA==
X-Received: by 2002:a65:6883:: with SMTP id e3mr585170pgt.250.1601137368721;
        Sat, 26 Sep 2020 09:22:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm5156438pgj.15.2020.09.26.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 09:22:47 -0700 (PDT)
Date:   Sat, 26 Sep 2020 09:22:46 -0700
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
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Message-ID: <202009260920.DC9C2743@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> This patch series is a result of discussion at the refcount_t BOF
> the Linux Plumbers Conference. In this discussion, we identified
> a need for looking closely and investigating atomic_t usages in
> the kernel when it is used strictly as a counter without it
> controlling object lifetimes and state changes.

BTW, I realized the KSPP issue tracker hadn't broken this task out of
the refcount_t conversion issue[1] into a separate issue, so I've created
it now: https://github.com/KSPP/linux/issues/106

-Kees

[1] https://github.com/KSPP/linux/issues/104

-- 
Kees Cook
