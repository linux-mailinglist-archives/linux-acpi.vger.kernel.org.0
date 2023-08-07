Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2072F7722E7
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjHGLmJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjHGLly (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 07:41:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027655A1
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 04:39:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c10ba30afso1166226766b.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2023 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691408297; x=1692013097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaTgcJnET5axySMhn1ansn2vWDflHknuCQCKOYFZG0I=;
        b=retWyAfVMRTDCPcF4lpzecQUZC8FhWhEnJ2sdMaZv25SUb2iZdD8SmjZfBYCQMdUr+
         u9R9smvSLnH5ZU2jMbBwJRicqPiI8L/3+0oC/4Njys4JadacmuH7eWVMD+L3dUCdiYP/
         QTbrDlCMVRmsrySTLX4ndmx2/E4+KEYOeMhCvhI0nrCqdafjj3oTzwzt6MVcmFSsUkaE
         drjN312937gbqMKieiNWN68GaoK5MIWB2GT+WACm+fcbr8HSpRnyp9WXu0PBzQ/GSYaD
         bdhgFNivUHSGmItCwZTy1i4Qik3/UV8FvlsWoGusrESf2evRXS4W+WbKhVhYEUGDcPYj
         4qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408297; x=1692013097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaTgcJnET5axySMhn1ansn2vWDflHknuCQCKOYFZG0I=;
        b=gCNIkzR8P4tmMrk28FWF4fRwteLZh7nS34F/6bfVdE7nP30EvpFxG6q8DqsGRNOLDr
         p5rQOSq6uZO5fkolKI+kfp3P7ShmOm02l9RBKQChUfMAsUDnCMctTpNK+D2E2BABBpxn
         un1g33i0H3T7uTdGEWGBhp2iEU8uG5115OXNIbjJ4FjskpCDkDEn2xv+5dOSdWR+w4sm
         kmOglZWxODpiPvy4BOOdMpHSn84VeJMtBPrZ/3418cXOHW8gTabj9WR/OfUe1Co4tMcX
         ApNnl8P3nfXA2iAzGuStzQ1MRJ9MhN15lcfHw/VtQcJzF0pdveBE6QlPnzhDcdTc9LXW
         cagQ==
X-Gm-Message-State: AOJu0YzPB/raiZyVly0nSHs0RKOVsu/oIeZl62FLI975pspBo0XAmGvC
        Gt4pqly5e+GeVJ8SYJtMiZGxdUMmLAoRa19dQxk=
X-Google-Smtp-Source: AGHT+IF+kqj+cozNxEOXkK9z4mLBo8nEFcsWl+nAJBlldz47RgyxOBAZOl5hWhRhdZQO0pfqXKgWIQ==
X-Received: by 2002:adf:f08e:0:b0:30a:e70d:8022 with SMTP id n14-20020adff08e000000b0030ae70d8022mr5035723wro.26.1691407537921;
        Mon, 07 Aug 2023 04:25:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm10397141wmf.30.2023.08.07.04.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:25:37 -0700 (PDT)
Message-ID: <78fffdd5-045e-3a29-bc7d-91d5379d63b4@linaro.org>
Date:   Mon, 7 Aug 2023 13:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/10] thermal: core: Add priv pointer to struct
 thermal_trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <10344810.nUPlyArG6x@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10344810.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04/08/2023 23:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new field called priv to struct thermal_trip to allow thermal
> drivers to store pointers to their local data associated with trip
> points.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

