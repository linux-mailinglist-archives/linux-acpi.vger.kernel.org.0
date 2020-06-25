Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0D209E96
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jun 2020 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbgFYMkh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 08:40:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41117 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404518AbgFYMkh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2020 08:40:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id k15so5066073otp.8;
        Thu, 25 Jun 2020 05:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4Q7cNyCHgFwtbixvXKVMYOkWKngQIt9leUsi1ZtkmU=;
        b=fqmwjjEho73coxsbOZ/2HAcQY3hZo7jli08pJp5Wr3APDUCRPxRgpSmieJH2czw93d
         BP4X564KggSGR8M4TMWmpQpgiiVs3uO47NyQVs4X3inIUFlYsGpv2rkbqQ9d2m+RaH62
         6FtvnqwUo8deB37KBhco/4yYEcfxOKWHm0CkVRo8bNf0W9CBYlIh1oF21SAf1iwVeGOK
         j4agO11+wpxIFoUlltJ3h07BVHhEYfVwolBalZRj6TY/bzuyANgG7RHys54WArOjaMyU
         e6Llbbi5p4VK2fcbbbyc3p1OxDcxKNYJxjbNjw5yfFSR4NETX4oW5+BWfRk3gYbeO3dI
         XV8w==
X-Gm-Message-State: AOAM532BlB8Ybyvxsy4TSQAI+0+tSGtAxUpr/F+V2qDjBuwoi6PWU7o/
        C9n790dNlTO7d7Tpx4tNuQ2G//NXqkIpf8p8SI9BLVrt
X-Google-Smtp-Source: ABdhPJw0un7objV5flfnnBnZo+tmdqboDoqdw8ng5kschQs75L/mr0KqDdim5q59tFuZUJKYRf/TlkEPSUJxKiaEkJg=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr27085381otb.262.1593088836602;
 Thu, 25 Jun 2020 05:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185140.3842391-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200624185140.3842391-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 14:40:25 +0200
Message-ID: <CAJZ5v0j1DiySSO+5Vu3SUB9T_yOGbYhX=+g=tZu8jK43ANASdw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Add battery participant for TigerLake
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 24, 2020 at 8:51 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added ACPI ID for battery participant for TigerLake.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/dptf/dptf_power.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index 5fab7e350db8..92b996a564d0 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -228,6 +228,7 @@ static const struct acpi_device_id int3407_device_ids[] = {
>         {"INT3407", 0},
>         {"INT3532", 0},
>         {"INTC1047", 0},
> +       {"INTC1050", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> --

Applied as 5.8-rc material, thanks!
