Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5E4B9280
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 21:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiBPUhA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 15:37:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBPUhA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 15:37:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00616EAA1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j4so2883073plj.8
        for <linux-acpi@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=bGWQFfWY+GOCY9ajK+jUK4dJTPTv2kIB0Yq1hbme80ItJPDtVUuCrducyub/97EQ0a
         GThVGEfbIU6o1qenCjxJXD50S6/ObQWidSyhO1XjNEw7iQRU3mYiOLPWLzMEtydU+TOg
         XrEVvwY9SVG0TkiKWWRS2pgrzzhEh02Lo8/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=XTqVpN55MAqUitBoYoE8EtShuvQXvY7B9t5Emid16pav5ePY9Db2ju8UxKm0Qu2o+6
         clpUmmFcdLOZjm09o5HnFfr1J+n8sc8fbctuzX/u2G2n5JLWJ8tyyKuqRhJk2D7JLGFG
         UINJyonatFBJz5EExZqWhYh3MaGjGdhYc56FImOvts8mxdsvIg+O08ryR+Q9MO3ZbxTI
         keOPdSN5OgXVMoTG+rNnA+WQ7jkN7B/WB0UAjdR8aFfiZkeiXjO3i3bkGrGw0raYmXsn
         NbZfs8mNpwPpDq3BwmH5lan0yKly3JoYpFH4MMc1pXaR6eQ/BI1IzE6Q1hx/UGYPlh7q
         QF5Q==
X-Gm-Message-State: AOAM53317E9KpyyGDAC8SkxUEO75ZnlX3B+9vMVCqt8f65PpBQnNimfi
        B3xZK6WNjy3jAvezYTxKW6edOQ==
X-Google-Smtp-Source: ABdhPJzJF/YEfH5OONFh8EpYA13PwFuw+6/qJPkCze+i5HDTetsTW9VKrS9AD6KT8uYwRyvr45KVbw==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr3717687pjb.35.1645043807401;
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lw3sm18168488pjb.24.2022.02.16.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
Message-ID: <202202161236.FBD5D268@keescook>
References: <20220216203240.GA918517@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216203240.GA918517@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 16, 2022 at 02:32:40PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
