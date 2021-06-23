Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6C3B137E
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFWFxj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFWFxh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 01:53:37 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8DC061756
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d12so823773pgd.9
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gvifQC5IeicUDnWoUsRHMENVSvoiy4CqG/g46bHGIBE=;
        b=Nfhhac/bZAPq4PYEl8wGoNG3LtOlUf0ySTTBOT1i1L2PgBv0e5wt01FLhqlJmLQz8j
         bkVCQAyMVaPjFnbOvJEsa/+w7he3kCWPerUO8x1LcddUFd7zGgL/G7/iplT3Ssaxmc9C
         +7CXA1AJ638YsSQeYWXKnMaIevl4qskFAg0xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gvifQC5IeicUDnWoUsRHMENVSvoiy4CqG/g46bHGIBE=;
        b=OXjNW1UpOTNpWTJzAczAsfI/GFPohC7q/16A/u4jU+EkfGJclAQukT1ySoLC+4SU17
         w5lJOpg/GgJAcXqMvhnueRzYlVe65VnVNjcmZhQuT2X4jkUro/mZHM9v22umVd3h9Dax
         GLpXWh8sS6JLuWJuM6wErlC5nASFw916E1BM5Xneqe/Z+/xeImguC0UGzSl1l/bBbbpu
         v4vzTi+V7uBdq3CCDoaZ9TR6lA38Jj0Zm3uUWyMXNKY7psz4uUTq5pPGcsq+poHEHcTn
         1RIBEnQ/obWoLS0Bp9qLTDzCZIhEndCpFub0YyigXo06RF4AUpR69rVHcncDXHntswLI
         RQyw==
X-Gm-Message-State: AOAM530vs1uaIbWnRGZYZqtpkOWJ1PbDtBlkUp+FgjUBOcSLNn+ZIhlR
        /982G+ldqgfYb9c+HXMDfSguww==
X-Google-Smtp-Source: ABdhPJwS551YzUKPlrLg4xaKTDfZblIg72w73yK6vsDqeuSfN09P1F0/y6J/wAAl/1MV9m/6mJxyMQ==
X-Received: by 2002:a63:5553:: with SMTP id f19mr2218816pgm.419.1624427478576;
        Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v129sm1108705pfc.71.2021.06.22.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 22:51:17 -0700 (PDT)
Date:   Tue, 22 Jun 2021 22:51:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
Message-ID: <202106222250.7BD80A12FF@keescook>
References: <20210623013802.1904951-1-nathan@kernel.org>
 <20210623013802.1904951-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623013802.1904951-2-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 22, 2021 at 06:38:02PM -0700, Nathan Chancellor wrote:
> sysfs_emit is preferred to snprintf for emitting values after
> commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
> sysfs output").
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Perhaps just squash this into patch 1? Looks good otherwise!

-- 
Kees Cook
