Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20D300714
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbhAVPWz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:22:55 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40030 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbhAVPWm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:22:42 -0500
Received: by mail-ot1-f52.google.com with SMTP id i20so5374131otl.7;
        Fri, 22 Jan 2021 07:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaRbnqB9fYa/HtGOKLuNSjqkXS4Fu+4TnCBvbrPBfVI=;
        b=Yx2Wf3AOSswf+CkDeJ0ICSAh85FJ1tvn5GxwqjJ2kU7XhiGlGgBqn5w8Lhf+1XUQtC
         knjTIh5JnYrGJ6tIVxPUyUgrSSDMkfeZAZsd/ZMSUBwftNXUTUZXxfwAEF8EvVpiH5SR
         fxlNlImYmtqzpm/Msvh61nMmO9GMSBHvoOTLbiVR34beJOGkpz1oraXasq3f8qoGkoIk
         Aq39uxNrathltXzWHWzha6E4q3yWH2FuDEyMyRzAD+I7F3U6ipE9mI7Kpw8OIPQ/PAOl
         4VRdfvhoRS92B/fzSKiNVebjVms6UKThfWZL4w8ZT6JrgzvwmSnm/AAhyXBYfJSG1Y/4
         7YFw==
X-Gm-Message-State: AOAM533wJYY12l3haBQAfYiArNdWVhboLsnXRM2LcbIW+D2iRBU1cNLB
        WSE5Njie2x+13q7kwNyG6m1AxLKYmP7sxgf0NIU=
X-Google-Smtp-Source: ABdhPJwu3z8n5JFE4Um3XCGoc8xEBZ2K8zYk0onZqG2ndbdrErIpV2+EYdlvoElPTK4RDdSlVYb5+O5YT8YLsGuRvmo=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr3638896ota.260.1611328909960;
 Fri, 22 Jan 2021 07:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20201221160302.3752887-1-trix@redhat.com>
In-Reply-To: <20201221160302.3752887-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:21:39 +0100
Message-ID: <CAJZ5v0iUVf_5QFKWJBQwy41CK=+FShUxWK05L_2ANqiFRKvfZA@mail.gmail.com>
Subject: Re: [PATCH] PNP: add printf attribute to log function
To:     Tom Rix <trix@redhat.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 21, 2020 at 5:04 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Attributing the function allows the compiler to more thoroughly
> check the use of the function with -Wformat and similar flags.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/pnp/interface.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
> index 187e4a1175b0..602c46893e83 100644
> --- a/drivers/pnp/interface.c
> +++ b/drivers/pnp/interface.c
> @@ -33,6 +33,7 @@ struct pnp_info_buffer {
>
>  typedef struct pnp_info_buffer pnp_info_buffer_t;
>
> +__printf(2, 3)
>  static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt, ...)
>  {
>         va_list args;
> --

Applied as 5.12 material, thanks!
