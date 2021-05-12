Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34FA37BEC8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhELNsn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 09:48:43 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46998 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhELNsT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 09:48:19 -0400
Received: by mail-oi1-f170.google.com with SMTP id x15so8532215oic.13;
        Wed, 12 May 2021 06:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVt1p5SHmhDVWSXHXwKOAt0atSnLGbn9g6enDYXV3RM=;
        b=HhccjEdipZgGlZgJsMtvOAmSWYFwPJ8xgPZvVXgPFHvnsX08e/axLCEKdwXkZFE7/X
         d1HXtd9X2lly0ETYu8jYgO4UZWFSZLoF6UkJDKV6Ifym+TAjv556sY3PU6vY5XrZlzZS
         wmiXDb2of79dSwlxs5H2FT9pWrE7EcNntgW0SnRpZ0eXYyAmzPih+ldw8uDzhlKnZ7a4
         lHi5fsBFKiJ1hfyUVyvtQcwdpN9dZJsy5/xuyG/HaIPj03rQ/V0JuHbyHSS6LmkmQzYi
         vxGwONtau/iAWsp6xWDkP2qosqX7z0bOXYJveapRDKHIlZ8SALTAwUXg46fbSgrMzSXW
         SVcw==
X-Gm-Message-State: AOAM531FyiuFbM81BW5OFhVkxQwLe3Cv8Rxg3hkLWkX9SUk74IGATohd
        wefw17Hm1eh5EYWAeydTCTxXlV6F2MDvsB2IPtM6wD/nFZI=
X-Google-Smtp-Source: ABdhPJwqfslqDE3FClpdtRaWzdU38oTBpsUvH6tw7DtCzDvwDnJu3EGwdfaTMbXBZ/KdyDH9UzlvpxAFoKX4cLUVzII=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr11574688oih.71.1620827230530;
 Wed, 12 May 2021 06:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620823573.git.mchehab+huawei@kernel.org> <afeeee8d52dac14c8e86e326b8fcee300dcb0d59.1620823573.git.mchehab+huawei@kernel.org>
In-Reply-To: <afeeee8d52dac14c8e86e326b8fcee300dcb0d59.1620823573.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 15:46:59 +0200
Message-ID: <CAJZ5v0iGGdyNwq4GgZ8+b6-GJGA2nALWZL5QXm=bA4c5wFHNTw@mail.gmail.com>
Subject: Re: [PATCH v2 38/40] docs: firmware-guide: acpi: dsd: graph.rst: Use
 ASCII subset instead of UTF-8 alternate symbols
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 12, 2021 at 2:52 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
> and some automatic rules which exists on certain text editors like
> LibreOffice turned ASCII characters into some UTF-8 alternatives that
> are better displayed on html and PDF.
>
> While it is OK to use UTF-8 characters in Linux, it is better to
> use the ASCII subset instead of using an UTF-8 equivalent character
> as it makes life easier for tools like grep, and are easier to edit
> with the some commonly used text/source code editors.
>
> Also, Sphinx already do such conversion automatically outside literal blocks:
>    https://docutils.sourceforge.io/docs/user/smartquotes.html
>
> So, replace the occurences of the following UTF-8 characters:
>
>         - U+00a0 (' '): NO-BREAK SPACE
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
> index 7072db801aeb..954b99ec6b77 100644
> --- a/Documentation/firmware-guide/acpi/dsd/graph.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -159,7 +159,7 @@ References
>
>  [2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
>
> -[3] Documentation/devicetree/bindings/graph.txt
> +[3] Documentation/devicetree/bindings/graph.txt
>
>  [4] Device Properties UUID For _DSD.
>      https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
> --
> 2.30.2
>
