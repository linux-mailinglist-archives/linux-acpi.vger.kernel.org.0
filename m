Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48437BE79
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhELNri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 12 May 2021 09:47:38 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38608 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNri (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 09:47:38 -0400
Received: by mail-oi1-f169.google.com with SMTP id z3so21066012oib.5;
        Wed, 12 May 2021 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FO9kJ+b8x1JLXLkbxxF4NNo5vEWgE/7j3BQaY1Hzph8=;
        b=KVifyYQqqqHydbSzCz976hqv4ide4etfM7fyX1t5+1tuJ/1LEcaWCdaIxXI70le5FH
         McGegwKrQio59v8pTKW+eoAzvsYBbSJ84wmlcFTQvW3p98ejoaeZOkcE7RoMtgHxZYW3
         1k/81TZwGlBT0QgjQVfAH1zdoiEh4n9shyvNgHbECGFVPC505e7S6LDWOxpQ2lNLxjcg
         uOpo7QI+6o5/HsUU7A0lDau8HcD+xWSQauy96F8tznReL22ybjCUz+/rOKXepF2K9z92
         rp5YfYDK42mc2YyRMuavZT712z3g6zOk4qYs/ymium0uIgQO0x9b24YBbrjbF17oAV1F
         QVuA==
X-Gm-Message-State: AOAM531Ik1pkdadSYhTkqA/UQ/h49Sv9rvNvyy6eLWPGKDAnHCiXrsUc
        mur8eeN8NpVqlk39UqDZnCT1vDK+trnfOKELDjFfeNTJ
X-Google-Smtp-Source: ABdhPJw04Q8b2d2WMH54gp48NYOZpg54ce9CF0WHxsWceg5d4ctFV/dx03lgJxIP/XuforxOBNTOD2NMIzw//w0WW5M=
X-Received: by 2002:aca:1815:: with SMTP id h21mr6941028oih.69.1620827189861;
 Wed, 12 May 2021 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620823573.git.mchehab+huawei@kernel.org> <14b86d84efa6b2c5a7a27e58671e0abcb493cb57.1620823573.git.mchehab+huawei@kernel.org>
In-Reply-To: <14b86d84efa6b2c5a7a27e58671e0abcb493cb57.1620823573.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 15:46:18 +0200
Message-ID: <CAJZ5v0iShOdq13k4OQnp5Kz8nj58jvot6GxhKBmMLc=7aenBnQ@mail.gmail.com>
Subject: Re: [PATCH v2 37/40] docs: firmware-guide: acpi: lpit.rst: Use ASCII
 subset instead of UTF-8 alternate symbols
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
>         - U+201c ('“'): LEFT DOUBLE QUOTATION MARK
>         - U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/firmware-guide/acpi/lpit.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/firmware-guide/acpi/lpit.rst b/Documentation/firmware-guide/acpi/lpit.rst
> index 37922a903573..d7d6c406074a 100644
> --- a/Documentation/firmware-guide/acpi/lpit.rst
> +++ b/Documentation/firmware-guide/acpi/lpit.rst
> @@ -5,7 +5,7 @@ Low Power Idle Table (LPIT)
>  ===========================
>
>  To enumerate platform Low Power Idle states, Intel platforms are using
> -“Low Power Idle Table” (LPIT). More details about this table can be
> +"Low Power Idle Table" (LPIT). More details about this table can be
>  downloaded from:
>  https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
>
> --
> 2.30.2
>
