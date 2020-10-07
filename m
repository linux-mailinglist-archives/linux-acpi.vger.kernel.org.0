Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8600B2866BE
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 20:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgJGSRW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgJGSRW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2020 14:17:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F7C061755
        for <linux-acpi@vger.kernel.org>; Wed,  7 Oct 2020 11:17:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so1797435pfj.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Oct 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Wr8M1Qh36tSqKp6w8/lDIv0//m1RW5mLlz36/2Ni1Q=;
        b=g7gOFEiy1sOqqYAYERbLN6WH0IwqZ5zMKieyVAInvO35YJe1BP3MJbKUbTtCZhl3rz
         1jJREqOeO/hTWqMHOh3bCPZTbwJtifOk7mdLaqPTtQOdKQHvhPtdJL7gaQBudzUl57TK
         ikbEq002wdyAkN5lspfKFnv7sD5s2IhwmmU0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Wr8M1Qh36tSqKp6w8/lDIv0//m1RW5mLlz36/2Ni1Q=;
        b=FOxfesF1E5jm8IJ8JHyzWm0U/jG9FLpAutStmA4+ZbVxUpbJ0NHGidWUx0i/Mte5Gk
         0hUgPBc+08rdj+aif43nXXZ8KauXIvqGHqCH4ssRhw5y9T0Mmj8wRuqbIh+RLuRap+wQ
         HcbqGAucOwtfsTYvtfCoVvVYvM5ILhhpkWKETMGJQVrTbCqjZ4BLSE3W3AspbULzapgs
         dUrugGxfwGy78Y4JrCL6CJuoUGQSey05uOpsMwy+bhw39lkoRzuq87QW0Di/EyJ8OZlQ
         bh+i3CPI9nOYc+QnD42r0jrz3Qjvl+in6Gy1oLdNxkSIhBu9vsR53qofRC8NstwBJ2wJ
         xPlA==
X-Gm-Message-State: AOAM530WrqgrCO9bKekxl/+Xy30UnH6EGYroOw9CdZ+1rCUk6dZxZyRe
        Vpmmos3+SxvGarE5N3tOtHhxWg==
X-Google-Smtp-Source: ABdhPJztA70Yj79UqNw6GXm7l+OCeFkP2endjiCt8RUj4CG5muoB6uKT/eNBphWqUJm9DSqYA3/0zw==
X-Received: by 2002:a63:4083:: with SMTP id n125mr3608164pga.290.1602094641961;
        Wed, 07 Oct 2020 11:17:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm4145336pfr.197.2020.10.07.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:17:21 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:17:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 06/11] drivers/acpi/apei: convert seqno
 counter_atomic32
Message-ID: <202010071117.B0C6EA7A0@keescook>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <884f1fddfbc1a991f5f5bbada3ea63c1e3afab20.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884f1fddfbc1a991f5f5bbada3ea63c1e3afab20.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:37PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> seqno is a sequence number counter for logging. This counter gets
> incremented. Unsure if there is a chance of this overflowing. It
> doesn't look like overflowing causes any problems since it is used
> to tag the log messages and nothing more.
> 
> Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Yup, also logging only, it seems.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
