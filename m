Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2F560904
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jun 2022 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiF2SZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jun 2022 14:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiF2SZv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jun 2022 14:25:51 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90352654D
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 11:25:49 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-318889e6a2cso156450667b3.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Jun 2022 11:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiTMGZ1Oor7xHDMn7+pM1tWPeKIIB+ASfs2U6Er3qi0=;
        b=T/K1VGwDCOovxPYOUeCJo7XJILe9wB3mI1gmBeHUYHFKLLxuF19qbvT51yjARfhvOv
         EzWsw3GxYHzSqMyWLNBFqxB00LZ6wXHMRrcNHvSqRC5bO8/krMO5Z0TZzOAh/HOCz+y3
         KOxqNAK0YmT2EzSIlb7t1MHAAZHVU9z94u3HlmNNMNFKsLsOCLr9FwutWcVQeobIKham
         Qc62gr5GydRlAtc1EaZkBE8ITlVU1H1QluSr7uGhUtHDC4ZeDlhMfaX2tC4pxrblL4tU
         8m1kyxExNtz5ZLark5+M4T1J77kYOVKCTTgBz3CwJ8nFCAJswNAKszoJgTBLIM6izLzw
         H0jw==
X-Gm-Message-State: AJIora/bCJsGUnLVBzlUi+CvvZWLIPVyxt1jF0frz+z+Zy+GP8em6Cly
        4myuUFRsgdix8cPoduaKKYSvCbGdKxI2X1cSUuc=
X-Google-Smtp-Source: AGRyM1smcSnklBIPzyeeyuMsfwAbAZCh1f1al96TpLvROYcYrsIjaBhd617UXVfMMs7YBNiyZznf+OuDnlggwpg/g2M=
X-Received: by 2002:a0d:c486:0:b0:31c:3b63:91fe with SMTP id
 g128-20020a0dc486000000b0031c3b6391femr535206ywd.7.1656527149184; Wed, 29 Jun
 2022 11:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <165611192645.990447.9154951000881269149.stgit@dwillia2-xfh>
In-Reply-To: <165611192645.990447.9154951000881269149.stgit@dwillia2-xfh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 20:25:37 +0200
Message-ID: <CAJZ5v0gGO+gDLXpbKhD+dstGA3Oz05myd3Uh5XvEb4h7-yUMDw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Fix _EINJ vs EFI_MEMORY_SP
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mustafa Hajeer <mustafa.hajeer@intel.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Omar Avelar <omar.avelar@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 25, 2022 at 1:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> When a platform marks a memory range as "special purpose" it is not
> onlined as System RAM by default. However, it is still suitable for
> error injection. Add IORES_DESC_SOFT_RESERVED to einj_error_inject() as
> a permissible memory type in the sanity checking of the arguments to
> _EINJ.
>
> Fixes: 262b45ae3ab4 ("x86/efi: EFI soft reservation to E820 enumeration")
> Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mustafa Hajeer <mustafa.hajeer@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reported-by: Omar Avelar <omar.avelar@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/apei/einj.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index d4326ec12d29..6b583373c58a 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -546,6 +546,8 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>                                 != REGION_INTERSECTS) &&
>              (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
>                                 != REGION_INTERSECTS) &&
> +            (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
> +                               != REGION_INTERSECTS) &&
>              !arch_is_platform_page(base_addr)))
>                 return -EINVAL;
>
>

Applied as 5.20 material, thanks!
