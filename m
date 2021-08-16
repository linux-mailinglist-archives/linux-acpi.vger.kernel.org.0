Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D173EDB0A
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhHPQkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 12:40:15 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37503 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPQkP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 12:40:15 -0400
Received: by mail-oi1-f178.google.com with SMTP id u10so27570238oiw.4;
        Mon, 16 Aug 2021 09:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPGtgvFIqUx3vK3Op89ueWs/a1jCj1XrScm2f+zVuLU=;
        b=KIsW+mhrg6kwP/lbkdBpz9eOKJ1LYM95KjUuYaHxKW0sW/ZI90VhA/IdYBX/+aaFF9
         m7wicLwr3PZox9+H831tjGbhehPCbPi2zluMUxvO6cdMuqo5YAP18UkzEJ9jaqOZlEdu
         eN8v/vYSoCmicPmrOVS2sgzC4eJqll6APErw1MnAEFkrL7/3zQBUHVxfiN9qdSiExdHl
         FXfSnShZlQNdGFttEc74GPoEZpBvhXtZDYdlB+lSrCFPnxBgHKZjGkBcQ2hLYXrTXqzS
         hMw44gwJrUyV37KDr6FsjURc5+lH2os8zDbw0HFLzkXjdhLkHHGX+T7os1Ih6i5UqeyN
         UbRg==
X-Gm-Message-State: AOAM530ZHgBHXHJ9PVWVmXRTM5h9lapi5QbtNS9e+ZTQsLStkhCm2Mr7
        GDMeMP9tWbUxLHjdVPTklK/uew0kbcY6LzTwmCz/LJgF
X-Google-Smtp-Source: ABdhPJzbFDRF2s2lkiW9qW3ocAuPdizsEFD6bAZiZv88fahHFEZvSSGzBNmyqwKbruliSyE5Imrq7nMpEkGH63GLwtY=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr1629991ois.69.1629131983535;
 Mon, 16 Aug 2021 09:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210714214346.1397942-1-mw@semihalf.com> <20210714214346.1397942-3-mw@semihalf.com>
In-Reply-To: <20210714214346.1397942-3-mw@semihalf.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:39:32 +0200
Message-ID: <CAJZ5v0gAmajYYDhYhum-QbyreWYf-4R0ecrDL_hLXp=w4T1FBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: SPCR: Add support for the new 16550-compatible
 Serial Port Subtype
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon <jon@solid-run.com>, Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 14, 2021 at 11:46 PM Marcin Wojtas <mw@semihalf.com> wrote:
>
> The Microsoft Debug Port Table 2 (DBG2) specification revision
> May 31, 2017 added definition of the 16550-compatible Serial Port
> Subtype with parameters defined in Generic Address Structure (GAS) [1]
>
> Add its support in the SPCR table parsing routine.
>
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/acpi/spcr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 88460bacd5ae..25c2d0be953e 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>                 break;
>         case ACPI_DBG2_16550_COMPATIBLE:
>         case ACPI_DBG2_16550_SUBSET:
> +       case ACPI_DBG2_16550_WITH_GAS:
>                 uart = "uart";
>                 break;
>         default:
> --

Applied as 5.15 material, thanks!
