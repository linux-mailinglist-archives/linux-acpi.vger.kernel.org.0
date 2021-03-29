Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADD34D057
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC2MsU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 08:48:20 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39442 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhC2MsS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 08:48:18 -0400
Received: by mail-ot1-f53.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so12133521ote.6;
        Mon, 29 Mar 2021 05:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/qRvSZnocrUkJIjUj3RIeK2bv6WeJu2zPlnvgABVUs=;
        b=En8d3DFEBB20JOcs19dsetZjgt64wz2vlhMc7Q/QWDAN4fn/qNpro9yisx3LQ/Z8cc
         uzs1n1P+BgxuJJlO1cxXsnNQcp4XQUOAJLqk5hzuu0bWwdVPvzexeJZn/wmVdWC9I8DV
         pPnDqjseekTb8Mc5z8oCYn0C0VQmaNNAVDvJn95t1AwvQncD28YEdSJ0gD4vfn8TLj74
         OTHEYqtmaikvBJZk2FkLOZReohn5SqdwseKWkja4F8fcm0pTF1fVhEGDYcKnJGxCLf/M
         lGPyIRt1H9iwRoe8Wc95f/pLOO2zaW3Z3cEZZbYERgwAtx9zxJ6Wx76oCxg7k5CZkdVU
         5wHg==
X-Gm-Message-State: AOAM532d4zh/APz5XrAqYtq7ZF12YIBQsX06ziGFrDxwSFNrbW1vSPG4
        ZRe4oH/uQBILjsH7Prb5nvaO1zUBaGWroxN4fwwjf30B
X-Google-Smtp-Source: ABdhPJwkgJLl49WQ4DxYiQVIcNf/J/OnassAwchwhv0O0Rs+I5HMhr+pP4QpbTC0BN/6y8NIvD6p8GS/V8ODT7ZoALA=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr23083606otr.321.1617022098413;
 Mon, 29 Mar 2021 05:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210326001922.4767-1-unixbhaskar@gmail.com>
In-Reply-To: <20210326001922.4767-1-unixbhaskar@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 14:48:03 +0200
Message-ID: <CAJZ5v0izUkL=7NSFuefNYcqdq2vSxseDCCLKUTOZGC82WjJNPg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Robert Moore <robert.moore@intel.com>,
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

On Fri, Mar 26, 2021 at 1:22 AM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
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
> index 1538a6853822..1b4c45815695 100644
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

Erik, could you pick up this patch, please?  It is simple enough IMV ...
