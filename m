Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC63B1EBD
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWQfL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWQfL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 12:35:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E0C061756
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jun 2021 09:32:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4so1836541pjk.0
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jun 2021 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8WDPpTsAABrndh4h0TsCOGWmpZse3T18rg9azPYg3VA=;
        b=WinEuGU6UXINDfoxPFGTaWgSMGV0tcRVCvkuEyuNkeI9KVYKUxrpZLsDbNJToa9yWm
         FtLAuvgRx4S/ZAgM0b7Ww9PGfPhuSa/giWEuBb3tHZDfDhRjXi+sUWyFRdNvm3dAQ55B
         wdpCCKCsv2LHSWC6HkWvcp3rbBK4IPKztUgc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8WDPpTsAABrndh4h0TsCOGWmpZse3T18rg9azPYg3VA=;
        b=UWsf3k2SG+8oR5ZCY5BhS2w5Ji/eA6AMxO74VEJ95q7vkUDCt5dWdtMXTw7NqGij7s
         VB9zYQZvW9c2UwtsMQb9GaP9i89DD7WtzxInNX7FOsL0Y3OJ4RQGpbALCFUHTHsuEPMg
         g2doyBVRSH/v83WuYd30G9Bg5K3YvM6RQoMuWvs3cyw/0rQukJ3IbOmGvwBBCAxka1cu
         3HpQw4JBlNR5jtHJ1VX0FxlgM7/KTzuBtPI6uhQYMVtEsyuuDtTQ1cgDGuLJSLtDdQS5
         JCDAWR0KzcjG909v0UKzx/GEDEa6kzOke8+zU5VFLfcVbg1x1grsovAd0hY6oRBjmcCc
         +zNg==
X-Gm-Message-State: AOAM5301OQVUW0mIqFavi5ayd2n3o6ksDnVNj/FOspRuE2HjLcik6YrL
        90QznMMVZxscJPGs0avJqA1joQ==
X-Google-Smtp-Source: ABdhPJwOpKqsq7WmeQ7TZPAsUZakU8c0IX85QcR9YzJFRPAfyHuRBhtEbEYzYtvUUJnnCHXBx3hDiw==
X-Received: by 2002:a17:90a:de84:: with SMTP id n4mr6082030pjv.62.1624465972559;
        Wed, 23 Jun 2021 09:32:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23sm175748pjn.2.2021.06.23.09.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:32:52 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:32:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
Message-ID: <202106230932.96179173E@keescook>
References: <20210623013802.1904951-1-nathan@kernel.org>
 <20210623013802.1904951-2-nathan@kernel.org>
 <202106222250.7BD80A12FF@keescook>
 <a155e3ee-69aa-408d-208b-06144cf6cf8f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a155e3ee-69aa-408d-208b-06144cf6cf8f@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 23, 2021 at 09:28:55AM -0700, Nathan Chancellor wrote:
> On 6/22/2021 10:51 PM, Kees Cook wrote:
> > On Tue, Jun 22, 2021 at 06:38:02PM -0700, Nathan Chancellor wrote:
> > > sysfs_emit is preferred to snprintf for emitting values after
> > > commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
> > > sysfs output").
> > > 
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Perhaps just squash this into patch 1? Looks good otherwise!
> > 
> 
> I thought about it but sysfs_emit is a relatively new API and the previous
> change may want to be backported but I do not have a strong opinion so I can
> squash it if Rafael or Len feel strongly :)

Fair enough. :) I figured since CFI is even newer than sysfs_emit(), it
didn't make sense to backport. Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
