Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4B648E9A
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Dec 2022 13:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLJMYM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Dec 2022 07:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJMYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Dec 2022 07:24:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0819C28
        for <linux-acpi@vger.kernel.org>; Sat, 10 Dec 2022 04:24:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so11103672lfu.11
        for <linux-acpi@vger.kernel.org>; Sat, 10 Dec 2022 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ntMKn2p9kxpu5j1uY9R0oVW09w0Sy+4jvmvXlu/bLE=;
        b=MsCPGBLXvljE/8n3GeFKQvjbG2pwOKSfJMq7SeHHoHgid3FYwkgVPDXuoVEnVrukvZ
         UytqfBxRNvEzNvgrzDHzzumq7Cv9KOldxETiE5uDUxSh0s9wnH/8B0BxBbT0NltmF7Ae
         aOagJ+O6DUTtrSN47ipyEiXDgKSISrIbcON6GoaQ1PJHYpIaMp3vdX2oLiHnMimxcdfC
         nGLKiz+aR65lhfpG795dluJPgTbo1xcESioTtc9ePsUlqT1Pn6s+1sNUxatV4D2WNqMd
         apq29eoIsqmbssuDnzzraT3Y0xh4OC9JKWe2N1eFw3pXMVj/jfzTmwuQ8Vs8ac2+8vzo
         6OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ntMKn2p9kxpu5j1uY9R0oVW09w0Sy+4jvmvXlu/bLE=;
        b=PCgmoYplUckoTP8tLtOoyqObaJa5XxbgaPCBd4mGMX1zdkGQWjYptZVPWiLNMQvRVe
         D3h+G6u77n2CnnJr7mVj2njprUfoPMYORHq75ZGCFvvdwq1lBr0Gbfas+I7FtQ1b/9cn
         TGb1cEVSU1wt/xrArVRd8cIRZaUkaBaQE3b9sc159hLrFIpi7KGW1/rJ37TCyP5ZLleh
         Vuqmf6yZ3g62OnOlUAhWP1c/dI5w9vIJe8gXwOiFoyx/fD7/gdnJRUuUdM61FhywjLtA
         JzH3bBlNKu1x39L1hi48ew0qLg+D/b42XCy/gocHUFrQnLAujBP5huhgVk5WAJ5Hb3iZ
         HYQA==
X-Gm-Message-State: ANoB5pmQqjG209afujpZspSUxeyG/2Lx0Olbfc5QfLnXWCToMGDrjaw4
        IjD9NlJoD6Nb+SvFgw0swBex0w==
X-Google-Smtp-Source: AA0mqf5FvTpHbVoAOjsn2K0CO52k9pxEzW8xUPW8Hev+c9m9rHmgeApBz3E2gn3k7UwRWZISsNi6Vg==
X-Received: by 2002:a05:6512:3d86:b0:4af:af1e:f966 with SMTP id k6-20020a0565123d8600b004afaf1ef966mr3327522lfv.38.1670675047999;
        Sat, 10 Dec 2022 04:24:07 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c10-20020a05651200ca00b004aa0870b5e5sm703328lfp.147.2022.12.10.04.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:24:07 -0800 (PST)
Message-ID: <7cc6ae49-4109-c6aa-2278-63afca33b1e8@linaro.org>
Date:   Sat, 10 Dec 2022 13:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Arm RAS EDAC & AEST table driver
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc:     Alex Elder <elder@linaro.org>,
        Tyler Baicar <baicar@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!

I've been working on an EDAC driver utilizing Arm RAS for
some time now. It's based on the (many) previous efforts by
Qualcomm and Ampere folks. In its current state, it supports
system register-based operation and error detection on CPU
caches on DT platforms. I've started adding code for ACPI, but
that has not been validated at all yet (other than compile
testing), as I don't have any suitable hardware (RAS extensions
& some kind of UEFI & a proper AEST table) to run it on.

I made it by taking the Qualcomm Kryo (fancy Cortex)-specific
driver that was written just for CPU cache error detection
and generalizing it to the point where (I think) it's
ready to handle all the configurations that it should as a
generic impl (modulo IMPLEMENTATION DEFINED/vendor screw-up,
of course..) when support for them is added.

I've tried to make it extensible, so that support for other
error sources (SMMU/GIC/vendor-specific/RAM/CPU_TLB/
CPU_"generic") and implementations using MMIO registers can
be added later on (again, I have no means of testing most of
these things).

Could I ask you folks for a general/first-impressions review
of that said driver? Smoke testing would also be appreciated..

As far as I'm aware, generating errors yourself for testing
purposes is only possible if the AEST node interface is a
MMIO one, as ERRnPFGCDN seems to only be accessible that way..

Either my boards are super stable and never throw errors or
the driver simply doesn't detect them, hard to tell :)

It probably leaks memory like crazy and there are some obvious
style issues, but please take a look at the general structure
and share your opinions, especially if(when) you find errors!
You can consider this a v(0.01), I suppose..


Available over at [1], with an example dt part for QC SM8250.

Konrad


[1] https://github.com/konradybcio-work/linux/commits/ras_edac
