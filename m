Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322D74FF90
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjGLGnq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjGLGnR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 02:43:17 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9082682
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 23:42:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3460815fde5so33127205ab.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689144167; x=1691736167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWfOSMrv6do4PAbxZtLX2gDNrKPpyct3TAi/IYd4WYM=;
        b=Hw3Ob/+Yca4KTN3qdRPzFpwgrFDjP8sfy07Z33AABHGClFhVX6UYE1MammcWVscMir
         8n4Nliv5JgZZHfjaxFTBijG/ZAVgEWmafu1isleFjWACqIeDDFhT7w5w8mHN87RzVUCZ
         yVoTRkyXLTHCc7Yc8bFXeWlv5XnnrERq42SrN7DpU6CUOzOCH2SYtuKAhAKJBMsVSRiw
         5RgriE8ZfTyHNr2wnm0e2s47CS0l38xItxBOdR7FGpuvKq2jN+mpaTnOg+zBP6FMLL/c
         AeoWkmE1YQZM0RdZGy0M/d9uCLyLJNNLeiPslnXfDcaBUeenAnevW54WtoYOxiU1UfEr
         hoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144167; x=1691736167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWfOSMrv6do4PAbxZtLX2gDNrKPpyct3TAi/IYd4WYM=;
        b=DBuDXhnv9fnWSPbUjsYIu3YxUDyXMEHi+dHnpcdB7Wr0xNWGzf9jZuAMHrNVZPWfIC
         8tVVk3jYQ5X8K6B7jpGiYzZTyzbKvhnZsdyz0KgOVcswZcTVpZohNxe5SIhg9nB6DwzL
         vZ5XGL6PXJbk0cYhwENtyU0yElEAIKYGKl/eFmcRCLBAFuMBwn2F7hc9Nb8eACnxN+Fg
         riI29+7LqBuCo6yiwdlO9uAJ1mDRiZpsv9Y7CITA86i0H7VVjBVlflGfMYn27Nw2cirS
         QnztbislMiqAT8EGdsKhiXZ1kuGjK0xZcLM3L8ldVrojb+yM7lUP3yT0zi72GN7tLL/S
         Huqg==
X-Gm-Message-State: ABy/qLaigxi6yq7VjXYZ8zjZuv5jaGUEwzA83/7bgw6K99Tm5v0YEvV6
        HSqaULIYEYFVIbGfOb8WI/K1Kw==
X-Google-Smtp-Source: APBJJlGEvuxhL5L8C2Zwfrw9CRqcNzRA6M8IHu9gQ0y7YWiEP67ewnRtBRT1y1ssYvl/ZpHqbrdUKQ==
X-Received: by 2002:a5d:950e:0:b0:783:72d4:8c38 with SMTP id d14-20020a5d950e000000b0078372d48c38mr18434142iom.13.1689144167545;
        Tue, 11 Jul 2023 23:42:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id h22-20020a02c736000000b0042b48d372aasm1038592jao.100.2023.07.11.23.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:42:47 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:12:41 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
Message-ID: <ZK5LYcQ0ZTmkiP4y@sunil-laptop>
References: <20230711224600.10879-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711224600.10879-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 11, 2023 at 03:46:00PM -0700, Palmer Dabbelt wrote:
> ACPI ISA strings are based on a specification after Zicsr and Zifencei
> were split out of I, so we shouldn't be treating them as part of I.  We
> haven't release an ACPI-based kernel yet, so we don't need to worry
> about compatibility with the old ISA strings.
> 
> Fixes: 396c018332a1 ("RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
LGTM. I agree with Conor that Fixes tag should point to 07edc32779e3.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil
>  arch/riscv/kernel/cpufeature.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index bdcf460ea53d..a8f66c015229 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -317,19 +317,14 @@ void __init riscv_fill_hwcap(void)
>  #undef SET_ISA_EXT_MAP
>  		}
>  
> -		/*
> -		 * Linux requires the following extensions, so we may as well
> -		 * always set them.
> -		 */
> -		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> -		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
> -
>  		/*
>  		 * These ones were as they were part of the base ISA when the
>  		 * port & dt-bindings were upstreamed, and so can be set
>  		 * unconditionally where `i` is in riscv,isa on DT systems.
>  		 */
>  		if (acpi_disabled) {
> +			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
> +			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>  			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
>  			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
>  		}
> -- 
> 2.40.1
> 
