Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44791964B2
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Mar 2020 10:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgC1JON (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Mar 2020 05:14:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36193 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JON (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2020 05:14:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so11078425oib.3;
        Sat, 28 Mar 2020 02:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKuq7d8jIrlk/0WIZMtVXkIzDVpSUtAwY67akVyTnGQ=;
        b=BZghq3LShx2NjkLK1+E2dhJoqdO6I8mXoNsIq3/ZKpN5QmaXlb+W4biTIiUL6e9Mkj
         2bZ6VSLGR6qF1o9fVvMicHOeH+5fNVyBYRca5hgUiTXGGaH6tl9TyH/s0kqVAhDK9Dfz
         tJWFN2EBASMO++Yqqc4LyeBX5KWGzKjMZPJblmH7Yz0/5g5BLOgD438X+qAxj+S48+Sb
         mxR2laxuBK13JpcjGhPpWtMDDbKvfF5LhdB4McJvWxbKVHUqUklo73Ell6vAVHLlViRs
         TGLwhetCwMlmQsHGd6W4nBs3EhNzoxJ5veSuS0HPFzOIFZFZo50Bpd5E980JxCxpAWQe
         33Rg==
X-Gm-Message-State: ANhLgQ1ndGa4wLYqwcVmkXURmQFSKffRyLeKNq6F5ANYxB5lXwSoRkdh
        a4lewt/TK7Tc9GAmwKvHiyYFkjyYenkJaBJK6sM=
X-Google-Smtp-Source: ADFU+vsfJR2e/2aZ0DaWjMu+tQUrurQ6g1o3VVqYm7WMOdLXNBdUKFaJxhA5WPw5Gut1INgv2J6DN7h1qQGSWlRPcTw=
X-Received: by 2002:aca:f07:: with SMTP id 7mr1821111oip.68.1585386852511;
 Sat, 28 Mar 2020 02:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200328034706.17840-1-yuehaibing@huawei.com>
In-Reply-To: <20200328034706.17840-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 28 Mar 2020 10:14:01 +0100
Message-ID: <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
To:     YueHaibing <yuehaibing@huawei.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Mar 28, 2020 at 4:47 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/acpi/acpica/exfield.c:25:10: warning:
>  symbol 'acpi_protocol_lengths' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Bob, Erik, I'm leaving this one to you.

> ---
>  drivers/acpi/acpica/exfield.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index e85eb31e5075..3323a2ba6a31 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
>   */
>  #define ACPI_INVALID_PROTOCOL_ID        0x80
>  #define ACPI_MAX_PROTOCOL_ID            0x0F
> -const u8 acpi_protocol_lengths[] = {
> +static const u8 acpi_protocol_lengths[] = {
>         ACPI_INVALID_PROTOCOL_ID,       /* 0 - reserved */
>         ACPI_INVALID_PROTOCOL_ID,       /* 1 - reserved */
>         0x00,                   /* 2 - ATTRIB_QUICK */
> --
> 2.17.1
>
>
