Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7E7984EA
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Sep 2023 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjIHJjZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Sep 2023 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJjY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2023 05:39:24 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C211B;
        Fri,  8 Sep 2023 02:39:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so32670121fa.3;
        Fri, 08 Sep 2023 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694165959; x=1694770759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmNsFLpdzT7HD0s5ZXq/w5dV3nJ64Nz1IklRYrFXDFk=;
        b=sLiYYawHkMLUmsw1rFuniHXuVxRaeb8Z1uaFDCWB/ScmzAWRfluD64BL/JahHVU5f5
         mDO5I9OHm2p2DG3Sq9Shwf51K8C1CoYNMSBnazrXlV6WzbfBPycXNC4Jd51XsH/lspfL
         GOrVeSTwC9Yn/yNAcX28ONLPvB6VkD8rwSgz+DdABGl2u3WaqVGCLU02DY8VQQc7bpTE
         etpwjLauI9uK8GblgOxayhxyTcIMlK8T4frLRCT9xwvoNPAoiWejyXHPTu4pIxNBEgxD
         GY/M3J6h9Fey17jec8sFHV71VZrtxrdExZEDiyzz2K/UOJ7YREtuMuEaEYklFyX+WyYy
         oKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694165959; x=1694770759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmNsFLpdzT7HD0s5ZXq/w5dV3nJ64Nz1IklRYrFXDFk=;
        b=HHz5R3eb7P1zUU5jxZHvCSxkYG6JpiVcdtfRM2BbeYuqleCqwEsgPLFPTorLq3s5M8
         7AU1F7sqDAFFqCzb7+Qai05M4RNOi0gXLQwVAN6wteIV4GPRb6V3IAiAwq7zFLYWrwJ9
         fjcrBhpEPd1/jE1AYvcK/F4OsaCexC459+nFgRltUUZXa0v5un/hkiHlWwMuYqSA8P25
         IT5FQjXW11S4uMKescn5BQ8kWnESjiR0xFh9Qn/511RiBfbaHcMrgvLKA+7VY9Gd5Jqy
         2kftbRnhEkaUkHRdXVv/rirW6xiqRQfpjiiI0eZhqepHGTf2Q/SZkZmtD40qHaWSia5v
         5AVg==
X-Gm-Message-State: AOJu0Yz0Mc19hzcQBPEFO1Qh6q6iOVwD1ARBCavIYTWvF/rr1DRNSlre
        IFqEaEPAS3eKODGvJZSPIr/JGbko6N4oawJI0/0=
X-Google-Smtp-Source: AGHT+IFjfGA9NdJS6OhiKH64cF2dg48YPknpqmQwImslm67FtorC5iz65zDqt4aJedeew0m5WTNkHCX1TLGmUzaOvdw=
X-Received: by 2002:a2e:9b4b:0:b0:2bd:d34:f892 with SMTP id
 o11-20020a2e9b4b000000b002bd0d34f892mr1397188ljj.3.1694165958609; Fri, 08 Sep
 2023 02:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <20230907214012.74978-2-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-2-sjg@chromium.org>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 8 Sep 2023 10:39:07 +0100
Message-ID: <CALeDE9NwvFRoq7_WQdYAPcurRwOpenEsYt+PKrckaR6asB2TdQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>,
        Guo Dong <guo.dong@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 7, 2023 at 11:57=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.

Have these been accepted upstream? A grep of bindings in the upstream
kernel I don't see them.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..1a48b1c 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -31,10 +31,21 @@ patternProperties:
>
>        numa-node-id:
>          $ref: types.yaml#/definitions/uint32
> -        description:
> +        description: |
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -
> +      ecc-detection-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error =
which
> +          can be detected and reported by the Error-Correction Code (ECC=
) memory
> +          subsystem (typically 0, 1 or 2).
> +      ecc-correction-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error =
which
> +          can be corrected by the Error-Correction Code (ECC) memory sub=
system
> +          (typically 0, 1 or 2).
>
>      required:
>        - device_type
> --
> 2.42.0.283.g2d96d420d3-goog
>
