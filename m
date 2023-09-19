Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F307A680C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Sep 2023 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjISP1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Sep 2023 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjISP1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Sep 2023 11:27:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F958AC
        for <linux-acpi@vger.kernel.org>; Tue, 19 Sep 2023 08:27:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so7221168a12.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 Sep 2023 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695137247; x=1695742047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7IiDhzqVRViaPiP3Yrz/dU073U7qJAZKLNrsBgMV2Tw=;
        b=Eyt/iTBx3ftNJPnx8bmWplznR4eVNMbgvUnGKpBz6jyMSvdehWBbgBMhcm6D1B8JCX
         ofIJ5Ry+Q3l8vM3NCFDcYSwNsuZuD4itnd21mabVe/ERIOXOH1T6XkXxvxn0+4wNuQBD
         Ct6IWTTMY4oXGqE8TyCU5QjRmC9JN51vn6ctM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695137247; x=1695742047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IiDhzqVRViaPiP3Yrz/dU073U7qJAZKLNrsBgMV2Tw=;
        b=fPyxJVUu5Iw2f8bzdqMe5ojfDlqyLad0sxaP6f6sGMhw+bMujBAwZ6a0rFX1IXVa9u
         9FtRdR7kitWNELHm1zI71fcu4ajYxT95hvwQdbypVxZmghMDgu+d027+yeEGmMr91B3a
         +MW/BE+FrWExSu24cGNMGqchy8U19PvAxCNn8DFMbagL1CHEHujC/H16kC3WrV8iejpg
         Nm5sdEpsvaeHw/zEl5G3Kb7kEiQYx16XMOX+ptK+asdN96SApLjnCXfOvuXeQVoWu3+u
         c+UAzAEKeJ3+01ymnJVcajA26Bn0FKXTZl/xVN+NZUEdZzbXFraFJDE9Vu+sLiKd3paI
         dXmA==
X-Gm-Message-State: AOJu0Yznz6KKLjcutrkQ6b6Hc9FDdH1528jSWToUOefwExeZ9F88kj9q
        J1xHMDt0CX1Z5VTcRPeP28p27PaN7kH8BtkJEA4Yow==
X-Google-Smtp-Source: AGHT+IEShODQtR6RpsbkfAzvQ/ybHrV9M952GG7Y+mw69LaMX/6Ci6R6Yot+oMMY9xVeekh9lPjb/tEBBQHmfDHNn1Y=
X-Received: by 2002:a05:6402:14c8:b0:52f:bd60:b54b with SMTP id
 f8-20020a05640214c800b0052fbd60b54bmr12402599edx.37.1695137247467; Tue, 19
 Sep 2023 08:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230907214012.74978-1-sjg@chromium.org>
In-Reply-To: <20230907214012.74978-1-sjg@chromium.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 19 Sep 2023 09:27:09 -0600
Message-ID: <CAPnjgZ1Twk4Vq9OXEUeYUK4VXXC_niMzc47ZLk4Zf7f822K5iw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] schemas: Add some common reserved-memory usages
To:     devicetree@vger.kernel.org
Cc:     Dhaval Sharma <dhaval@rivosinc.com>, Guo Dong <guo.dong@intel.com>,
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
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Thu, 7 Sept 2023 at 15:40, Simon Glass <sjg@chromium.org> wrote:
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> This aims to provide an small schema addition for the memory mapping
> needed to keep these two pieces working together well.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
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

If there are no more comments could these two patches be applied, please?

Regards,
Simon
