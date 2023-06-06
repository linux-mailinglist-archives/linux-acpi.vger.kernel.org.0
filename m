Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C481724971
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjFFQpD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjFFQoz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 12:44:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244510C2
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 09:44:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so64626495e9.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069892; x=1688661892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKrnL5fFNQzbQFmnUPBnsx74Ionu/zzOstCHK8ugozc=;
        b=YHxDSs/kvmEPiJzoMc/V9aYoQxPKUyBBxLp+t83EqQfosSkKxMJCKS4ip8ATQyRQdK
         kOLIXheKpCcqiZguXhX1WeSghe/Ny5gaIDoSDHv1HB6F2ZIhZX2CWf0JA1M9RqDhT5Cu
         ptx4btRTa3N0kzQ0SqiHoXiV1xyqUNwiUzZFVeYxcPaq3guoVJaXwDXJDf+nPzo+MAvE
         yQ4bShkZ6aNQh86Wq2ZLhzHjQrrp19K8Dj11GFSLG5JbmWgSrIyJI9+kOmgV1jkxZ7d7
         DK0vGfkSAWgioNggT3PC9TRMvnp+7r69vVFU9UukUGMIHWVc4QfU2+RAze5D0QW2qNtJ
         35Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069892; x=1688661892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKrnL5fFNQzbQFmnUPBnsx74Ionu/zzOstCHK8ugozc=;
        b=SVIptlu0C5iHRoIepDOuqnZ05c3H+IePXMFDA57tOhqKmgPMgmvr0tkhGXpazvT8RG
         2RGrmUi2d1cnqnUfslHTX2ddCCwMD/bZkVGL+0ioNg0hjlzYf/a2eEmdPjr2z59U4HIX
         DIWTV/GDUj61wM4VSQWIVRwQLgPFccn2OudJCBxrQxqchU2PZYio3/d2q8suWkfIQ5XC
         P/7fndo41IYHO2Ni8m4gfLp/Km13HFAV9PvsM8Tf5AYIh6VyRxY40FnagbpmctMRvcO7
         /9VmX+nYdOVCtB2MnERDpSuTTU1oNeTiXzyZRyUsXeOBSsOKDnhdrnqZf104U7MHTTDq
         VnYw==
X-Gm-Message-State: AC+VfDyoQAvtK0fdQPQQMfmeP7yYNSa4E+HazA5/Px5OxO8oc8LmNv0n
        Kcna9utNOnfWTzxrg/VU6O5upPvQK3Xd9wgqF0w=
X-Google-Smtp-Source: ACHHUZ4dwP9Zhduqpo9pZyXWylH8WE8EQUgx6APW2qPwTCaWF71Rxicj/dYv50r7vF0eztGxslo2gQ==
X-Received: by 2002:a7b:cb8c:0:b0:3f6:e79:3a8e with SMTP id m12-20020a7bcb8c000000b003f60e793a8emr3022290wmi.12.1686069892593;
        Tue, 06 Jun 2023 09:44:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05600c210100b003f73a101f88sm8448391wml.16.2023.06.06.09.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:44:52 -0700 (PDT)
Message-ID: <c4a2a189-c8d6-dd9b-6842-c6d8fb05a69e@linaro.org>
Date:   Tue, 6 Jun 2023 18:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/7] ACPI: thermal: Drop struct acpi_thermal_state
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <3443012.QJadu78ljV@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3443012.QJadu78ljV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/06/2023 14:19, Rafael J. Wysocki wrote:
> rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop struct acpi_thermal_state which is not really used.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

