Return-Path: <linux-acpi+bounces-343-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92827B5A0E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7CA69281D02
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B41EA8C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296C1E533
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 17:54:11 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA49FF
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 10:54:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so17898833a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2023 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269248; x=1696874048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TsD3ZHZijN9S1sfcV2n15VGsYEU63cv+c2MU+o+0ccc=;
        b=hCohXojvHeopXE/R8GCPb3l8JenKcOrvA6MruOmeJY55F6clvMr6OV9fylmNDcV3hP
         pIU7B4LuvkNC0JLdk4hww8juxlx0GYz/SBaUZCLNkKhmDYlFPOh/2ClWfUQ+hliY9c10
         0A3fytBmOOcIouJxzmYu158tWJESEMkubpIf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269248; x=1696874048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsD3ZHZijN9S1sfcV2n15VGsYEU63cv+c2MU+o+0ccc=;
        b=bDLQ4CP8VgogLsryyzV1vp3maWeLEPCqQLMkCaJvl3VFajFxke/TQGDYOVZ5ICbkNn
         i8FAhK1ujJJylZ9Q/lVirnd/xbSBAA/GtaGfziwU6Z5DmYKd+/xDmYnWXtbpISCEmM2m
         Pr2U32fpUme0p2NgDWSDnlPX++mjsNil3RKJX0xThCV6LKuHloiAFBheRERIsSCEHybF
         wnBmjPVPgFfdc1rNeQ1o5XuatQedFtPmuJFdbIVOFniWzJ6Wz/Rd3XLzHAlQk9CRD1qk
         RK1C4MiUWC7JDUZNh7YmuLZOs0qchsFqDj7hf05mreZ3erYHl2jzU7EVAcFKQc2iScg5
         rnTA==
X-Gm-Message-State: AOJu0YwwARPmRHK1uf29hOWrcgQdU5qRYysio3w+offv8054akUl9tOJ
	yO+bXP+iOtoUNnuO72/5NL+TvLBj/2o0Hx+FYcbQ/A==
X-Google-Smtp-Source: AGHT+IEtCxySMkh42I2CvgUj5aqq7h5MglNyXJ6gmXIzyE5bAMfwobhiZlavHruHjwW8M3Pas9ZdXj3GPE0ymKFjY74=
X-Received: by 2002:a17:906:19:b0:9a3:c4f4:12de with SMTP id
 25-20020a170906001900b009a3c4f412demr11349374eja.37.1696269247617; Mon, 02
 Oct 2023 10:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20230926194242.2732127-2-sjg@chromium.org>
In-Reply-To: <20230926194242.2732127-2-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 11:53:56 -0600
Message-ID: <CAPnjgZ0Xf3U1aj32LbU-xiU1AqwnM3JL1F8xX-wZ18oEmg+irw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Lean Sheng Tan <sheng.tan@9elements.com>, lkml <linux-kernel@vger.kernel.org>, 
	Dhaval Sharma <dhaval@rivosinc.com>, Maximilian Brune <maximilian.brune@9elements.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Guo Dong <guo.dong@intel.com>, 
	Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>, 
	Chiu Chasel <chasel.chiu@intel.com>, linux-acpi@vger.kernel.org, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rob,

On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
>
> This aims to provide an small schema addition for the memory mapping
> needed to keep these two pieces working together well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Rename acpi-reclaim to acpi
> - Drop individual mention of when memory can be reclaimed
> - Rewrite the item descriptions
> - Add back the UEFI text (with trepidation)

I am again checking on this series. Can it be applied, please?


>
> Changes in v6:
> - Drop mention of UEFI
> - Use compatible strings instead of node names
>
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>
> Changes in v2:
> - Reword commit message
>
>  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
>
> diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> new file mode 100644
> index 0000000..f7fbdfd
> --- /dev/null
> +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common memory reservations
> +
> +description: |
> +  Specifies that the reserved memory region can be used for the purpose
> +  indicated by its compatible string.
> +
> +  Clients may reuse this reserved memory if they understand what it is for,
> +  subject to the notes below.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    description: |
> +      This describes some common memory reservations, with the compatible
> +      string indicating what it is used for:
> +
> +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is reserved by
> +           the firmware for its use and is required to be saved and restored
> +           across an NVS sleep
> +         boot-code: Contains code used for booting which is not needed by the OS
> +         boot-code: Contains data used for booting which is not needed by the OS
> +         runtime-code: Contains code used for interacting with the system when
> +           running the OS
> +         runtime-data: Contains data used for interacting with the system when
> +           running the OS
> +
> +    enum:
> +      - acpi
> +      - acpi-nvs
> +      - boot-code
> +      - boot-data
> +      - runtime-code
> +      - runtime-data
> +
> +  reg:
> +    description: region of memory that is reserved for the purpose indicated
> +      by the compatible string.
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        reserved@12340000 {
> +            compatible = "boot-code";
> +            reg = <0x12340000 0x00800000>;
> +        };
> +
> +        reserved@43210000 {
> +            compatible = "boot-data";
> +            reg = <0x43210000 0x00800000>;
> +        };
> +    };
> --
> 2.42.0.515.g380fc7ccd1-goog
>

Regards,
Simon

