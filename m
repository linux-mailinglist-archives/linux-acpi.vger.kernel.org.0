Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78098311634
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhBEW4f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Feb 2021 17:56:35 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39776 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhBEMuI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Feb 2021 07:50:08 -0500
Received: by mail-ot1-f48.google.com with SMTP id d7so4488790otq.6;
        Fri, 05 Feb 2021 04:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqRyDP3o2KaV0mpb9HT15XfChTbTMwx2Qv/rMgDpYEw=;
        b=HO8f70FOkY5D8wPKrghr5StiDc3/DdYaU6vwgAtnXGgLMW8G4iQtgUT811KSoOvv3v
         7xv95k2qfvsU2GcomK48P8c7PrLCFRqOByEOiBJCdywkoWO+0HsUXWuoZovPvFRpIEOr
         fquJwOrOszLwE4V/2/7Kke380P41EYIC2+czY5iHRWM9zce/7QtIBz2IvQUC3at4KQ6G
         myY3FHPbeQk6Eq4mo/tnuuKIyUgf2hMTO4D15KU4SLO9/eV9FRXLxoUp9cHL2oml7iWg
         Z7AQXM6lvDR2nvj+mIrwIaOx9KsU8iLF5+/2OveaZBdFgbiiwK0xRPpT0rJAmGJVR9CQ
         wdcw==
X-Gm-Message-State: AOAM531Rxf1gSQNcGlFbUPMd4HZRRLpuRB+4z+1J7qARlpxws4UPXzwh
        12D3bWsqa1F9iAbiklldkhMx7fxwRHwj7bNOEYA=
X-Google-Smtp-Source: ABdhPJxIPFvDHycbQBhWwuaGY1zHG6BD0M4BzNHUb6Ucxne4yGWgioJ9OdGOLZrLRU3//xDNrSTzUBj0T6tt0Kk847c=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr3364809otm.206.1612529366005;
 Fri, 05 Feb 2021 04:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20210203154437.15949-1-unixbhaskar@gmail.com>
In-Reply-To: <20210203154437.15949-1-unixbhaskar@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:49:11 +0100
Message-ID: <CAJZ5v0i63RqvJNT1xfeX2yRvLkraj+89DW8z0XUZ2jHp0Bt40w@mail.gmail.com>
Subject: Re: [PATCH] include: acpi: Correct spelling in the file acoutput.h is
 optimzation to optimization
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 3, 2021 at 4:45 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> s/optimzation/optimization/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  include/acpi/acoutput.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> index c5d900c0ecda..1ba212372e79 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -362,7 +362,7 @@
>   *
>   * A less-safe version of the macros is provided for optional use if the
>   * compiler uses excessive CPU stack (for example, this may happen in the
> - * debug case if code optimzation is disabled.)
> + * debug case if code optimization is disabled.)
>   */
>
>  /* Exit trace helper macro */
> --

The file being updated is part of ACPICA, so I'm leaving this to Erik
& Bob, thanks!
