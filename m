Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14E798694
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Sep 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjIHLqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Sep 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjIHLqB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Sep 2023 07:46:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B961BE7;
        Fri,  8 Sep 2023 04:45:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1DC43395;
        Fri,  8 Sep 2023 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694173557;
        bh=aODHL6mbNW0WLyQo2/gZhYlzuWIMAbhDYth1ivLfiJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPEtcWZrdC/o+gbIBKtuvpPZ1GJmKxqF8z7Tz15gNxu4UNu+zchX6c78qd3GRiBv6
         4admkoRJfGJ1JRASdiZVyzOAzbVD15sV9Au+hZXXr1Ki+RGk0otXyHn9GIHe3tpviv
         xuPclUkDl/eHCxBguoAm9ALCQdoAtY9kgQ3qOjO8bNIkVsaB9sHidwYoSs3pIYqzHs
         hFPvYxIicGPwDlT3cylZmTxfyJ8t+rJsH+XXd6eM9sKjPP7N42uE9LdASVzOz/1lMI
         MWVhybkcBY41VIQkAT5IOwzG0RmDpCZ6nw4VpoSnrr6ETXoZhycu+mxWc/zEOPAXj3
         tH2as6Q8nzqZA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so34742501fa.1;
        Fri, 08 Sep 2023 04:45:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGCHJqf/4IVog+SPJODWRYYakHzojvldIfx+9pjAHGoZVUAJR+
        SeHzsKekjc90+GApEWdh8ynhnt9DZbcmoAdqYA==
X-Google-Smtp-Source: AGHT+IGGKjJmemgNHpyI56G1+q2fUiJV4ppgzoy9LEO/x9T0+wAy75B+QGXgy5XYMiqRpu3pH/RANsVfOlTDWayxIDc=
X-Received: by 2002:a2e:7801:0:b0:2bc:b0c3:9e8d with SMTP id
 t1-20020a2e7801000000b002bcb0c39e8dmr1610795ljc.41.1694173555929; Fri, 08 Sep
 2023 04:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org> <20230907214012.74978-2-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-2-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Sep 2023 06:45:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
Message-ID: <CAL_Jsq+N1=XuZqFsVEgBeVpJzTBJRJ+w76roOUBtbP2Y8f3bEw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] schemas: memory: Add ECC properties
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>,
        Guo Dong <guo.dong@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-acpi@vger.kernel.org,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Gua Guo <gua.guo@intel.com>, ron minnich <rminnich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 7, 2023 at 4:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
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

Why? '|' is not needed for any of these.

>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -

blank line between properties.

I can fix these up when applying.

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
