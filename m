Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B6682FD7
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 15:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjAaOzQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 09:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAaOzQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 09:55:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257DEF9C
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 06:55:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso7985801wms.4
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQJ5yta28BW2AX6ajuuuroUNS/GTWbM6J5Z+4pB9i5Y=;
        b=z0TyZRGBjOclUC4hfL/T4CYUupUaJlH+rYUpzQ5mWedkJ9Kq9RagJB5HvCR8fNmi7+
         ZCpiqCnGHIMpnx/C0KwBVK5/bX9yWQWN73lc/jytWTcsi3sHG2PEe4zM+Jxnwr/b/ioh
         Bha0prZ/DA4YWP5hiBWFV8EgPEglbdnwr3L5kdPanFF4dUaopDb86xlpFjfr1KEZ3Fdg
         QCQVn2nTYqQUs9+2SS3pw78NPDKvEEftrm6sTJV6wolkURD/635aIaa+KoZyMCzIDQhR
         722ZIOrithI1RHwd3qiOiGEB2exdnIkZFsmz+jx64zOp8Lnn4EBgKRP8ifoshiAe3gFY
         BeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQJ5yta28BW2AX6ajuuuroUNS/GTWbM6J5Z+4pB9i5Y=;
        b=nsOoEcMQp+vxiRi7ZcEIt6zVvfpmpZRxtbpaX6lkyJV/cOy8nOeffeOrtXREJryHBZ
         ZYidZHiZdaO32exEh4UnBhiFzwZXzczrXlhLxiP+OUgVfNHGJma0mkPwY4kooo12CfA3
         KyipyqxcVXu8B4h09+zLNquAS1OmaqTjfzIcM56U/Vd+azlhd7/dDcu2+jq5ZRRIkIY0
         SK2HdwZZHRasafXMXwJiCyUsVEqaXBJVOOJyqyddPelWs24Lt+W8E1UJuIJ+qLgO4JiA
         mNw9YVwKaAgYBmwRlPCuPyK5iSNlWlUh4L08cmJ8dAaXqDaLroYbwXuK1BKLjMThsacP
         m1eQ==
X-Gm-Message-State: AO0yUKV++A7upgAISbr872xEAzyAsOf0hKF50eBRFQ1iHX6qIvx7e+QG
        13lX4l34ZdhoF8jjMbFQAO7kdw==
X-Google-Smtp-Source: AK7set+u+7E1D7bUEvbCwlmYHqaODmjU1eHMFmKu/hsCb++/mUVNtrzFtBfNz61iDYZ7klMQbA/RKw==
X-Received: by 2002:a05:600c:4b1c:b0:3dc:5bd7:62ec with SMTP id i28-20020a05600c4b1c00b003dc5bd762ecmr6703773wmp.32.1675176912442;
        Tue, 31 Jan 2023 06:55:12 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j14-20020a05600c130e00b003dc541c4b13sm7763802wmf.21.2023.01.31.06.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:55:12 -0800 (PST)
Message-ID: <4be21bd9-a9c7-989c-2ce5-2fa2c916b072@linaro.org>
Date:   Tue, 31 Jan 2023 15:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/8] thermal: intel: intel_pch: Rename device
 operations callbacks
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <2546853.Lt9SDvczpP@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2546853.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 30/01/2023 20:00, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the same device operations callbacks are used for all supported
> boards, they are in fact generic, so rename them to reflect that.
> 
> Also rename the operations object itself for consistency.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

