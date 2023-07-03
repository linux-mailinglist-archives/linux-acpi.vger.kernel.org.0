Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED58745CBB
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jul 2023 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGCNBG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jul 2023 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGCNBF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2023 09:01:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDFE41
        for <linux-acpi@vger.kernel.org>; Mon,  3 Jul 2023 06:01:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311367a3e12so5934924f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jul 2023 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688389262; x=1690981262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qx5WaH4RmPmPZx1WuP5j36Jr81nkIdIHWjQ2gOPPQY=;
        b=YbT19crgLZeG3vUFlbnUcWc9z58dvbbpGCzZsASfhwG94VUG91/IUiVH6xkJs3fHkh
         SR1c9y2VmonoIv6jvBIKU05WuIkDXMjkf1Zeg67YqLCajjyRwzbkr9zs90+/CS1D6MWJ
         Ke/V/krB6FAKfGU06aWh9J7in6Xy4K7IKzUsHtAkarq0jvWeEsHF9uBp/+Cc6k0SJVxG
         Snmg3M3lf8NZXBZFFNcxPGe+J4H6hsxKdAlQsBRtXvYJkROPDAVJNdOehYlkKEiEY49f
         cAeYwBm+hGcc8pQs1S28NNicYuqIAXey0MaI107nPThcBsJxGTHLGFOOlHgq1t8Emhh8
         o/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389262; x=1690981262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qx5WaH4RmPmPZx1WuP5j36Jr81nkIdIHWjQ2gOPPQY=;
        b=X5yvmdJ8zpMSS486NwCl7u2dXRbMPAk8cCTzZX/RvzQvvCqs4kre6uRVtlLQj2Vt09
         2t3p+RE1uomSdKmAGs30bz+Y24C+2gFUinOqt4uQHNmNZPAND3EI4RyosQ9vDiIkbxMU
         y9vPgtTDf+DL7qClnGWyyFwfUeznZRtf0ttsejTgMlipyMXersctaMsrMHr3l5jRO3Lm
         Ij22h4vLn3QDoM7yF3K6255W+muSEqAE5fwYgEAjEfULAjEW0wlrSYj+avR802IPEd5p
         AJ5cYi6LBQOgXqifr02pBb10xl0iZwlQw9AcnlI6ICl6OwTmxgKVtNYFHVlz6mAYFUYr
         W1wg==
X-Gm-Message-State: ABy/qLalywwLVceg3uo/T8aAfHTarIFmJTfkhxHp1F7w0nIqyHe4U3yF
        F7nVWRo3mTAlawPgj5eE/Q+cnQ==
X-Google-Smtp-Source: APBJJlEN+VabvQdO5H7YoBZJ8Cb4TARJQCqzXHsTLOVDSYj8C3Bev8Jj3MHc7OGthoWrz3vn6v+ObA==
X-Received: by 2002:adf:fe8f:0:b0:311:1dba:ca65 with SMTP id l15-20020adffe8f000000b003111dbaca65mr9754678wrr.51.1688389262225;
        Mon, 03 Jul 2023 06:01:02 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d58e3000000b00314329f7d8asm4254951wrd.29.2023.07.03.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:01:01 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:01:00 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
Message-ID: <20230703-71f67eb66a037f5c0fb825c6@orel>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702095735.860-1-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


(This is a reply to a non-existent cover letter.)

I'm not a big fan of adding yet another interface. Have you considered
doing something like [1]?

[1] https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg

Thanks,
drew
