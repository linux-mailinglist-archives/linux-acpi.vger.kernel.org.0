Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D68383019
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhEQOXr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:23:47 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43564 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbhEQOVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:21:46 -0400
Received: by mail-ot1-f47.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso5659457ots.10;
        Mon, 17 May 2021 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyV5+NjioeFbNr5mvQvX0+uqpbSmoa5E+RH0L4Driwc=;
        b=LnkxpXO8cJbr8v3l4uGq+X+lLq9wIuPWolxDov9WW6nJOezhVBgpzeMf1/rAjaf10s
         2t2K0gdcO73HdIO4nhOQ1zwByhXcltPWuBrCVjEKL0alT2BRtyflm1mlUH8ubeu+ylsI
         JEyhoN0NGZDP6R5t1Ej3MuPU9ZL6h6HOFiZvoermLaoUP28Pg9iaeHd+5bt3DUd+w+3U
         KWqhdgKlu99vlat52Gd6BTTXO31d8KAAXLm0oFBGwh1t8P1MxntIePSd/39VTwyt0hOI
         oo4R+Stz7k4Tx5bom78l7aXsQwWxk7Uu3GUA2D2ibbL14jcZsvjFhQecsx7pbMkCzDqj
         k/XQ==
X-Gm-Message-State: AOAM531vh9u+IPze7YkNr25TEXiUed6HVJlq3R1kX6rzsWH5ydCW1a5y
        Abe/gzsFmpsmUjEElq1CYesNPX8tMSj8JJD0zCpmFGrq
X-Google-Smtp-Source: ABdhPJxHpSNLd2r4UtEGdWeLHbjIWjCedSJ86POVarSHXSUYsXfoMSP2AF45gaZn4eIzb9knh0O4vP2AuGvXwNVVumw=
X-Received: by 2002:a9d:1e1:: with SMTP id e88mr678575ote.260.1621261230060;
 Mon, 17 May 2021 07:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621159997.git.mchehab+huawei@kernel.org> <5c846d672267ceb314978bc775940e6b82ef05c0.1621159997.git.mchehab+huawei@kernel.org>
In-Reply-To: <5c846d672267ceb314978bc775940e6b82ef05c0.1621159997.git.mchehab+huawei@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:20:18 +0200
Message-ID: <CAJZ5v0i=ke-Sxo8ALJagB6NYj6t53e7T=q9nkCtsO9E_VC+wrQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] docs: firmware-guide: acpi: dsd: graph.rst:
 replace some characters
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

On Sun, May 16, 2021 at 12:18 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
>
> Replace the occurences of the following characters:
>
>         - U+00a0 (' '): NO-BREAK SPACE
>           as it can cause lines being truncated on PDF output
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
> 2.31.1
>
