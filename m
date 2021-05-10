Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C961C3794FC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEJRHS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 13:07:18 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40737 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhEJRHR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 13:07:17 -0400
Received: by mail-ot1-f43.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so4916699otq.7;
        Mon, 10 May 2021 10:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9Y41nhmPOPBNqykP2dYU1c45pvJNiEXKTzaxOZu5Kw=;
        b=ch/ZgthLF01epyu3TNz7zZLNEwMdbhRUk313+H+SIxklWVGNdQsJGvnnsF++1FC6lQ
         /tXEkgItGKQ2rDYxVKPvDAx8w4wWjCvFoBuJaXRY9b7zGqry+GXLSbhQgDjGPgE9L8rV
         aKepmf1feGCi7hTAkwFwAxz44NOnygzl2Ib/iNUbZmx0Tw9+01jPiLMQ8oh+0aDvtd85
         oKY5VNCspUOYExK2L3G4jKfRmRgDEKmAAg/1iEgEnFaPdRV7ylc4QQaw/C0Z56NDP3Ks
         nRLYyjcUyz9kTfAcazCxGwoDVciT9d6dUT08RFhE35J3mDvHKBVZT+/wKF42UX0Jui1d
         t+nA==
X-Gm-Message-State: AOAM531octmHWu0cDaRACBMrrbl+5mtRcl6fPc4ugVEqP3h9YYvvLBfT
        QcG8rlHJTTs4vrh97iNVRBta2bq9gu6EkgmpK9s=
X-Google-Smtp-Source: ABdhPJwXO1Jw0S4KQ/r/4CDdG06ee9HkhBEDrEUr3U13N8JuX70ha4RZNP2j2SuBwqJfzk5ake1vcXx10Au8gE+5XOU=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr22420958otd.321.1620666372712;
 Mon, 10 May 2021 10:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210506124912.7725-1-jj251510319013@gmail.com>
In-Reply-To: <20210506124912.7725-1-jj251510319013@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 19:06:01 +0200
Message-ID: <CAJZ5v0hNXrh04yP3JA0OuvKx9v6b+BKROfX03RZYTC2-m4zkRg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use fallthrough pseudo-keyword
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 6, 2021 at 2:49 PM Wei Ming Chen <jj251510319013@gmail.com> wrote:
>
> Replace /* FALLTHROUGH */ comment with pseudo-keyword macro fallthrough[1]
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/acpi/acpica/utprint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
> index e37d612e8db5..0b511434b80b 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
>                 case 'X':
>
>                         type |= ACPI_FORMAT_UPPER;
> -                       /* FALLTHROUGH */
> +                       fallthrough;
>
>                 case 'x':
>
> --

This is ACPICA material, so I'm leaving it to Erik and Bob.

Thanks!
