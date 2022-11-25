Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2F6387CD
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKYKsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Nov 2022 05:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKYKsI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Nov 2022 05:48:08 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C727FC8
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 02:48:07 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id e18so1061805qvs.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 02:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFIHzSrKIdoVSEXH/DL5q2QlF+ZbmYDTNWshu0fHnUQ=;
        b=Wa1RVb8mb6tok1HOCqI5z0ZOTRYrM3QgUd/4ek2xXbi7lchEaw+WHSEjlSM1k/mtN9
         zCacnrhQAEks8mgTm5YPG/ESEsVStn6z7kAvIv4nqs6mzABepk7UaFR4m6VPsNC50UZ7
         /SVyvLH56pPAxsCZZFe1cmn3EC7otiRFxL1OTnl2v3vQgJ+aJQ+9BL2sC0oDD1aOZttE
         FFO+bR47ZDZ/Z/RRCJGdSVwWa5B8zWyA4aVrDN0l5UvsMaO5OCzjZMZ0dvv/i9XjJfjw
         hZDF16EY5tJ48sBuq8GwHinMvbTRaiLIaliIGvc6SdVR5GSpv9WpjsCLx9IK+g9YP6OB
         iNtg==
X-Gm-Message-State: ANoB5plFFs2vayD8T0dlwWeE0x8FrNDL1vDXFlj9UAEPEWUahYb89i16
        lso7Oqbw0/7Jxc8YKRRU582J4kf/UrdZOu/2lrA=
X-Google-Smtp-Source: AA0mqf6LZS2S+QnhpqmwN5H+nOij/0uFiXqMEOzB0AoFhECfWL4iMOp8gYzKSWVbEtgXa9KmgVGk1ap5eMQibIrzNPw=
X-Received: by 2002:a0c:ed50:0:b0:4bb:f952:c799 with SMTP id
 v16-20020a0ced50000000b004bbf952c799mr16472533qvq.3.1669373286542; Fri, 25
 Nov 2022 02:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20221125031120.3946901-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20221125031120.3946901-1-bobo.shaobowang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 11:47:52 +0100
Message-ID: <CAJZ5v0hcOdC5kzfVnB9sCK1_k+-Pw22uT-NN-eveQAXOGO=BBw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Disassembler: Fix missing decrement reference
 when attach operand_object failed
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     rafael.j.wysocki@intel.com, liwei391@huawei.com, devel@acpica.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 25, 2022 at 4:13 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> The acpi_operand_object object's reference count has not been decremented
> if attached to associated value failed, so may cause this object cannot be
> released forever, this add acpi_ut_remove_reference() to handle reference
> decrement.
>
> Fixes: 6ccd7b5acc41 ("ACPICA: Disassembler: Add support for Operation Region externals")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Please submit ACPICA changes to the upstream project on GitHub.

Thanks!

> ---
>  drivers/acpi/acpica/dsfield.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
> index de175f1b4beb..3a3d3ab3e2c3 100644
> --- a/drivers/acpi/acpica/dsfield.c
> +++ b/drivers/acpi/acpica/dsfield.c
> @@ -93,6 +93,9 @@ acpi_ds_create_external_region(acpi_status lookup_status,
>
>         obj_desc->region.node = *node;
>         status = acpi_ns_attach_object(*node, obj_desc, ACPI_TYPE_REGION);
> +       if (ACPI_FAILURE(status))
> +               acpi_ut_remove_reference(obj_desc);
> +
>         return (status);
>  }
>  #endif
> --
> 2.25.1
>
