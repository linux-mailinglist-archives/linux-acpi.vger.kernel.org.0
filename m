Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C528B3B1EBA
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWQeh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWQef (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 12:34:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C59C061756
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p9so2230756pgb.1
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLifFSZi/+bGptXglQ0Y5rGhT/pS0AbjzsR58j9fOLM=;
        b=P+rFTJW/zmzSqUJ1hSNr6H2ARNIaejgo0K0y/d9v4USJ4jFCOQRIeL2AE1Ksg1XT3Y
         SEf5ewosYZ8ckiFrjVZNAuWOYBq33toT0rmgGoaskzk/3ImZZNBtKAqB30slDizxA08t
         Cjv6eB324n4QXg8JLNfJup0uIqxDk0qIPAb+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLifFSZi/+bGptXglQ0Y5rGhT/pS0AbjzsR58j9fOLM=;
        b=iijPRu53lQN5UtESbRavP6c59j0eecFGdm4e14wY4iLVRjcaB0O9Z2EgiMNRCNzxkX
         nIbiLQflz2FmrLrIlA1btWYiask1/Y4p5WQcGjE8RXc4iIvd79k6/5pHch4QMtuF4bzl
         YVl1ZimlVtVpTni1ZhdCywatnQazGpV40G9afo04/qjASmhUkFZAdW1VgMyrtaF0iplQ
         xsUYxcTm7WxyVJO2iKrhhi+sXNdlMppFib3MXhzoi8FVAEh4BFftZBNCo9iNloN3a2+f
         OL1r9JBTYIHQVorBMYrNz1DxSMRCRkWL6vhXvQyt79qsswpSJ91ysqQfiJqlyefpaEpm
         ynPQ==
X-Gm-Message-State: AOAM5313YxfsiwbaQJ0fn1XNNmRRco0/yPV2efhcDgX5BVb7hBluQpN7
        z4IJ9orDqgUz0r770z8zv1w6bQ==
X-Google-Smtp-Source: ABdhPJxM6mZ4LoEBla31eRVcezoQntUSNvys2irfkl2e5xZvvklWUKpLZeDrkVx/2PaoMv7bFYg+Yw==
X-Received: by 2002:a05:6a00:1481:b029:304:87ea:8dcc with SMTP id v1-20020a056a001481b029030487ea8dccmr593663pfu.46.1624465937110;
        Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5sm370399pfu.116.2021.06.23.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:32:16 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:32:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] ACPI: bgrt: Fix CFI violation
Message-ID: <202106230932.198A54C1B8@keescook>
References: <20210623013802.1904951-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623013802.1904951-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 06:38:01PM -0700, Nathan Chancellor wrote:
> clang's Control Flow Integrity requires that every indirect call has a
> valid target, which is based on the type of the function pointer. The
> *_show() functions in this file are written as if they will be called
> from dev_attr_show(); however, they will be called from
> sysfs_kf_seq_show() because the files were created by
> sysfs_create_group() and the sysfs ops are based on kobj_sysfs_ops
> because of kobject_add_and_create(). Because the *_show() functions do
> not match the type of the show() member in struct kobj_attribute, there
> is a CFI violation.
> 
> $ cat /sys/firmware/acpi/bgrt/{status,type,version,{x,y}offset}}
> 1
> 0
> 1
> 522
> 307
> 
> $ dmesg | grep "CFI failure"
> [  267.761825] CFI failure (target: type_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762246] CFI failure (target: xoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762584] CFI failure (target: status_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762973] CFI failure (target: yoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.763330] CFI failure (target: version_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> 
> Convert these functions to the type of the show() member in struct
> kobj_attribute so that there is no more CFI violation. Because these
> functions are all so similar, combine them into a macro.
> 
> Fixes: d1ff4b1cdbab ("ACPI: Add support for exposing BGRT data")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1406
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for solving this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
