Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B45750F3C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjGLRFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLRFm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 13:05:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F119A7
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 10:05:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666ecf9a081so6417179b3a.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689181540; x=1691773540;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21TFtO47lX1gePbfGONsWzXilAI2kPVFSsUHWiu16KY=;
        b=s4bOORzC8HM4m19JGZSCJhSSPeRSR7TDt//M5UaL5GAPJQG/PqQ7OjG7zBPuM21pl6
         mHv1OcECZhWBz0dZq2SLi/hF3HLi6X9cpkpdTjg07LcCvtUnOkU+w0Tub7UQ0ht9bDb8
         TyqzPSwNYOcP+B0O0B5BKjuCfcBe/ZxQXsgtT+vPwccgTbGVYJ/zhODCvVLwweYjJ1z0
         1/MC7XNFCjDSTiW+bihgNyVX+jOZd+FyXdx9j/d8pP0v2FfWC4Q+OddrHtitjjgIIGXj
         WLwrEJ8cfWBT0p0NyrXD2bJ8P+SHezP06DukuDwyRohenvEIBQa5NnAS+zKjH2KXmlWT
         Lk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181540; x=1691773540;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21TFtO47lX1gePbfGONsWzXilAI2kPVFSsUHWiu16KY=;
        b=WXs974bhML3Fg2bLR6yKRZHSTNjNgzNarXeUYrbWGV2hgdm1BRWH4/Lk947bTkzqeE
         N7vXTtW5V2AQCeJoqYi5o5BDZ29c+gq+Vc2gvk9AvayzAc8ZyGrvx310t6BgOoWLPW23
         E85f6kN8ycTXZJOSc2SdDcOGYZslDr+ogaL+fGYsajtqorjnSUOlIXc4gGw9rvH1stuu
         X2M6W98na2Oup6wevbGEGzJt5/Xkx/JPHQMWygwUmCfc0l/Qt61gZ+mbRdHTDWWyII81
         laclSRA29eBwY98UKma0jK2D+kUpnAJbgGkLR/MyFnoOFjaxpft2B84pM69gjNniFe+8
         /weA==
X-Gm-Message-State: ABy/qLbPzNrM52ndqOo12xfdffpkNrlTO4YtjNVUoQp4uMz1xT7XbB0T
        a5jRCF3XKgWS7wUCxchGguoQHA==
X-Google-Smtp-Source: APBJJlF/hYh+SvwXGm3heNKVtObAeBTQ3BflHoRR5j7nTnXOsc0C3K7htOdn7DIq4aIheE43bQNblg==
X-Received: by 2002:a05:6a20:938a:b0:132:bdba:5518 with SMTP id x10-20020a056a20938a00b00132bdba5518mr3757873pzh.54.1689181540368;
        Wed, 12 Jul 2023 10:05:40 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a637e51000000b0055b30275adasm3832634pgn.37.2023.07.12.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 10:05:39 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:05:39 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 10:04:35 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
In-Reply-To: <20230711-slideshow-plaza-4ceaa37f6c00@spud>
CC:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-c30cb4e2-0574-4051-b220-01601d9579de@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 11 Jul 2023 15:52:56 PDT (-0700), Conor Dooley wrote:
> On Tue, Jul 11, 2023 at 03:46:00PM -0700, Palmer Dabbelt wrote:
>> ACPI ISA strings are based on a specification after Zicsr and Zifencei
>> were split out of I, so we shouldn't be treating them as part of I.  We
>> haven't release an ACPI-based kernel yet, so we don't need to worry
>> about compatibility with the old ISA strings.
>> 
>> Fixes: 396c018332a1 ("RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()")
>
> I think, if anything, this is actually:
> Fixes: 07edc32779e3 ("RISC-V: always report presence of extensions formerly part of the base ISA")
>
> Although my rationale was that if we get as far as here, then Zicsr and
> Zifencei are going to be enabled anyway so there is no harm in setting
> it for both. I probably should have been less of a cute hoor though.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I think there's no way to get here without the extensions, not 100% sure 
though.  I'm mainly trying to avoid going down the same rabbit hole of 
ISA string compatibility hacks in ACPI that we have for DT, though -- 
I'm sure we'll end up with a mess as soon as we release, but might as 
well catch as much as we can.

>
> Cheers,
> Conor.
>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index bdcf460ea53d..a8f66c015229 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -317,19 +317,14 @@ void __init riscv_fill_hwcap(void)
>>  #undef SET_ISA_EXT_MAP
>>  		}
>>  
>> -		/*
>> -		 * Linux requires the following extensions, so we may as well
>> -		 * always set them.
>> -		 */
>> -		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
>> -		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>> -
>>  		/*
>>  		 * These ones were as they were part of the base ISA when the
>>  		 * port & dt-bindings were upstreamed, and so can be set
>>  		 * unconditionally where `i` is in riscv,isa on DT systems.
>>  		 */
>>  		if (acpi_disabled) {
>> +			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
>> +			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
>>  			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
>>  			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
>>  		}
>> -- 
>> 2.40.1
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
