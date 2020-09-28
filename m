Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0327B78F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgI1XNK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1XNJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2020 19:13:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F472C05BD25
        for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2020 16:13:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so2608340pfg.13
        for <linux-acpi@vger.kernel.org>; Mon, 28 Sep 2020 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NftyTi1bwuaE14e4XfgcQF93EOxKUsMOEEQqaDTCXJ4=;
        b=gb3PRHELtfh8s0n7btbKHS7gdHecLDH27/WSx/dTaEZqzwAyfLHcApZT5c+IqoShdm
         0LEtidHDj3nYkCuzJeB2PL+jPZX/ntrn70g8bHDhQFR+CUPr0IDYs3hxi4tZpkrlg6d9
         hrDzPZTP54zHmpmIZZBNppWuJmHgMncA/mXvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NftyTi1bwuaE14e4XfgcQF93EOxKUsMOEEQqaDTCXJ4=;
        b=cZP11WY/lFCql90stGAdk8P7sxfC9sWOmAGg6b/3Dxk2F0z/Nm5WcoUSZIS4Piw/mT
         8PjgvLansvehKqbympYb6d6zaFZ9iIUOWDpVhs9BJ9H3/48Juuo6z+5eZ0hpWjAMKMoc
         NglcP2k1Dq7miNwDjzzwOaVMg2CirpRDbgs+Gx+kPOZ44UFlHXAGeo6BuZZEx/wrX1SG
         cvAT/RPRSCaFt4/ms42+8cQ6ytQzITsMvO7RM0myStK6MmrfLhsf70hJoeBDnofUWdwu
         MN6HkccbSfNU88ivULGnj06DWttldOTIPI/yWDjDkwCsSXPAA42LlraHJr8dH7IR4zWi
         waxA==
X-Gm-Message-State: AOAM533YvqCSA2QceNivnk2w3BOfUloddRRubmQs30ofP7VoUGoXNxbg
        FdMU3wjmlrHvIvFq4PLA5aWCbQ==
X-Google-Smtp-Source: ABdhPJwQDKOxa8hqpizwqXPcIZmf1ybA5/FNT7GiN+5miNLUE3lYvrdUP8suk6yqrm6piIZGkrVe3g==
X-Received: by 2002:a65:494e:: with SMTP id q14mr1006851pgs.281.1601334788954;
        Mon, 28 Sep 2020 16:13:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23sm2835217pfj.177.2020.09.28.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:13:08 -0700 (PDT)
Date:   Mon, 28 Sep 2020 16:13:07 -0700
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
Message-ID: <202009281612.EDC1C0078@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009260923.9A2606CFF6@keescook>
 <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 28, 2020 at 04:41:47PM -0600, Shuah Khan wrote:
> On 9/26/20 10:29 AM, Kees Cook wrote:
> > On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> > >     7. Verified that the test module compiles in kunit env. and test
> > >        module can be loaded to run the test.
> > 
> > I meant write it using KUnit interfaces (e.g. KUNIT_EXPECT*(),
> > kunit_test_suite(), etc):
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/
> > 
> > Though I see the docs are still not updated[1] to reflect the Kconfig
> > (CONFIG_foo_KUNIT_TEST) and file naming conventions (foo_kunit.c).
> > 
> 
> I would like to be able to run this test outside Kunit env., hence the
> choice to go with a module and kselftest script. It makes it easier to
> test as part of my workflow as opposed to doing a kunit and build and
> running it that way.

It does -- you just load it normally like before and it prints out
everything just fine. This is how I use the lib/test_user_copy.c and
lib/test_overflow.c before/after their conversions.

-- 
Kees Cook
