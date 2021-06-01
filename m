Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517DF397AF3
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhFAUHB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhFAUG7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2021 16:06:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D6C06174A
        for <linux-acpi@vger.kernel.org>; Tue,  1 Jun 2021 13:05:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so363451pjg.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jun 2021 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o9p8UlSILojbClGj20W0rNi82tKZc7t6kB2kgeRUdo8=;
        b=Zx2c+QuNrk7HwIMZjxH4PMHtozrBsnFTdjz7Ab70x4TPfpS3yIBWeB8UX4y0cEb8vH
         hudLJ57eZCPJ39kXUCgK3eOPo96EtRahhCDZewPMJ2fINT+Y7yJzz7mg8Vf0LCjrjcOE
         L4wnZI6pcoAiNHmnwKGlTV/lJhuSZqeuctRVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9p8UlSILojbClGj20W0rNi82tKZc7t6kB2kgeRUdo8=;
        b=Ng0FiQl7mmIGSWWXdGu9KhquAUzsnDZED902wcJj749bk2Ed7FJT9zNeoQfjSZDM8t
         bVKshAewaDBZQPvhw8BA+A1kt2RJLPcEedP8tgOjdyW8Nkw1dk/VrutpNfE6F/F+f24y
         ktmUBGXTidrSDPdDIZn/hdNH1AEa3uIP6+G6+ezqRUSJeMKI60W1PXwN4Gbnc8mzHQRj
         mNzUVLt1PofInRC7P+Ayj6mnMysPJ3d2sAX0FVOdUC6GPOd4l9fzKICY0/Tl8T1vJyqm
         3SshwRUiAU+GdeN/P1+c4LDIxN2+I/CUpdg7PjT5UDJmJbWQFw3ry6UmWnocVRU5bstG
         60qg==
X-Gm-Message-State: AOAM533UwOkb8R2GPgPLALOOonAzwgY8i9CguxqchAAFHS0yBexAWz51
        TScI2AfWBYOsWZiZ2KKOI3cX5w==
X-Google-Smtp-Source: ABdhPJziLdIIs14u76Q114+bOFUUqz4DgCK1VRejvmpcZtzTAbhqibYZ/3QpT05TlVNfMD/bDSTnLQ==
X-Received: by 2002:a17:90a:668d:: with SMTP id m13mr22399494pjj.144.1622577916879;
        Tue, 01 Jun 2021 13:05:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm13657452pfj.40.2021.06.01.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:05:16 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:05:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        james.morse@arm.com, bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] ACPI: APEI: ERST: Fix missing error code in erst_init()
Message-ID: <202106011259.317BFFAF@keescook>
References: <1622545553-19160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622545553-19160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 01, 2021 at 07:05:53PM +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'rc'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/acpi/apei/erst.c:1114 erst_init() warn: missing error code 'rc'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Is this a bug? I can't tell if this is meant to be a "silent" failure,
like with acpi_disabled, erst_disabled, etc.

If it _is_ a bug, then please include:

Fixes: a08f82d08053 ("ACPI, APEI, Error Record Serialization Table (ERST) support")

-Kees

> ---
>  drivers/acpi/apei/erst.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 242f3c2..492d499 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -1110,9 +1110,10 @@ static int __init erst_init(void)
>  
>  	status = acpi_get_table(ACPI_SIG_ERST, 0,
>  				(struct acpi_table_header **)&erst_tab);
> -	if (status == AE_NOT_FOUND)
> +	if (status == AE_NOT_FOUND) {
> +		rc = -EINVAL;
>  		goto err;
> -	else if (ACPI_FAILURE(status)) {
> +	} else if (ACPI_FAILURE(status)) {
>  		const char *msg = acpi_format_exception(status);
>  		pr_err("Failed to get table, %s\n", msg);
>  		rc = -EINVAL;
> -- 
> 1.8.3.1
> 

-- 
Kees Cook
