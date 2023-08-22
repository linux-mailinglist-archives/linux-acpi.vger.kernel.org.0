Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5490C784D73
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Aug 2023 01:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHVXp0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Aug 2023 19:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHVXp0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2023 19:45:26 -0400
Received: from mail-pf1-x464.google.com (mail-pf1-x464.google.com [IPv6:2607:f8b0:4864:20::464])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134CE49
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2023 16:45:24 -0700 (PDT)
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-68a36dc1422so2208867b3a.3
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2023 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692747923; x=1693352723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoJziu4hpqNirsaTxxJF0jjBD2lwvBdbeYwFFzOMNgE=;
        b=NE8EzPqXpcVm81gfigYwJcy6TQG8fD79BTNxsGe2QLtbo5aPQ/lcq2OjAX+rldweg/
         1/tHlhUjDhhxw074PkrRd0GXQVKq1hnZd2LVQ/VcIH1Rt27eL18Med9gFKr2YJ3UOI2S
         vhfDRsgI0Zla8M2LANL+WcUoUTj3KyWG1LzcL8zCDjzFonwhUOpNqNcxaC5d5AjYiDNh
         qhHTobgF5Q7+duo9h7IMAivpfiiAfBOJFDk66afaGqc5652B9OPEgkpVnEy8HkVTpEB/
         p6y86WiHWhsyA85ysk2g2q9pV6Uu8XjABL0Set6DVie4Gzno1nJP+PGz9LfKep0fYnCH
         MCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747923; x=1693352723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoJziu4hpqNirsaTxxJF0jjBD2lwvBdbeYwFFzOMNgE=;
        b=NChEVqY7EM1vYnLQ+V6GbCHywsR93vFWwsGKJnWJE9UwjIGCMELbB7j6CIKaAhiZxY
         3PxjYopPY7pEOdls4uPg+FAc9k8LM5L64hixldpq6l6bmpPpcfho0t58veBHmUZVwFmQ
         DWQjGiJTk3+95oFAZDYAt80vndDAg/TKNN09S3PPlgkfpwzfzhWkEtvsNkQ38lJC5jeq
         K9xxKVHqgRaPIOif0LdS8sO4hd/+WiCdhrPqnNXHuG6OkTWgQ8FAk0Tz76awfDnIxXiY
         2MoVilz7YuUFdkDpDCRCVGyGJAhtyOuJgnPYA+BSQFlx5jdBoIauiJUsJ66r+lqVsjv7
         NQrA==
X-Gm-Message-State: AOJu0Yw3cN5TIB/9Obf1QAjl25RWtkq7R0ZO+l3YL8cBmKHnUmqsszhQ
        AxYl8ShyIH64Tydlq15Ld53RvboZYJ7FS2aMjvY+di7VLvZK3pLgYUEhBZ3LoOQBhQ==
X-Google-Smtp-Source: AGHT+IFwbvX86nPDwHG5Njs0zik/dlcDU9BNw1GpeAYb0xXjTXOctyZNMxM7HWb3l+Tjbhpz4ngX+BLuDRH3
X-Received: by 2002:a05:6a21:4847:b0:148:6ebd:2834 with SMTP id au7-20020a056a21484700b001486ebd2834mr7007249pzc.34.1692747923532;
        Tue, 22 Aug 2023 16:45:23 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id a186-20020a624dc3000000b0068718f530c5sm1324762pfb.16.2023.08.22.16.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2023 16:45:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 4320621FC8;
        Tue, 22 Aug 2023 17:45:22 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 3CB70E42F97; Tue, 22 Aug 2023 17:45:22 -0600 (MDT)
Date:   Tue, 22 Aug 2023 17:45:22 -0600
From:   Uday Shankar <ushankar@purestorage.com>
To:     =?utf-8?B?SsO2cm4=?= Engel <joern@purestorage.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Message-ID: <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOQodU1CNMRtjYZ6@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOQodU1CNMRtjYZ6@cork>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2023 at 08:16:05PM -0700, Jörn Engel wrote:
> On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
> > 
> > ERST is mainly used to log the hardware error.  While, hardware error
> > may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
> > ERST functions in NMI handlers.  Where normal spinlock cannot be used
> > because they will be converted to sleepable rt_mutex in RT kernel.
> 
> Non-sleeping spinlocks cannot be used in NMI context either.
> raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
> So taking a spinlock inside an NMI can trigger a deadlock.
> 
> Am I missing something here?
> 
> Jörn
> 
> --
> All art is but imitation of nature.
> -- Lucius Annaeus Seneca

Also want to point out that both before and after this commit, we only
use trylock from erst_write, which looks like the only function touched
by this patch which can be called from NMI context. Trylock should be
safe in NMI context regardless of the type of synchronization used
(raw_spinlock, spinlock, or otherwise).
