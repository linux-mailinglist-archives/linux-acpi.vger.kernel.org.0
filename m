Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0455C350
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiF0NJ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiF0NJp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 09:09:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1311A1A
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 06:08:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w17so12987310wrg.7
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O77GUmfuWzZAHz5cdm2ARhc9s7ugUFOvnuezJjvZV0s=;
        b=u5ceCAd+FRBYKKQ9RBvkDwT91qpG/nGwnpaSw1tt4Ey4cfPGcCZ8l/XcstM/n+xelr
         hoLMKP/hGJtY4bKlWZ2xQZEkr+pTxPZiWfKI9JICt33eUiH4fUvHgJ/QN6L2pi41nN8A
         nr/fQ+/UR66bnHCFAwXEjYOveZIsw3sLDIO6pNrLZLQkouobJe3C0v1HA40yYfi7BXAX
         RHLcyf6eAQYXkTgfzWsXpltisgTOvnro8Kb/OSGcP+vMPRAQ9NVos6qnBZV7JkLkicM5
         NYWat71uZX72Fow1R0IBzcoWLyVmudO0HIv61Df+GrmjwoXoApNuG+4lw4A50YYQhUQD
         MpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O77GUmfuWzZAHz5cdm2ARhc9s7ugUFOvnuezJjvZV0s=;
        b=onXKv/KgUgRhdX/GYMPwnCKuHUZJhFjLTj07chJjSC4OhEiJn8f6rNfAtuPzokDuoH
         jJGED6dAVl+kDDhWzJUCqZVtBr4ORcMtBWkCc2bdSJWucflCvR7+CPoIEIl4PvVsI6cH
         rQT9SJhKMPMWqmoXHehIlgXzZCU5LiwBBxesw8WZcBbo8y65Pb110CKTo4YWvNEz2Jeu
         i44lQmb9wzPJboOaC9+1wrr1gmivUnDRIA460XczAsldVtePTUGj7gen1G5ttbydMIUT
         uDgu3jQwObgh9i0hJ3ShE37qbktXpHbRgP7ZNYyVuaWJ0CIsplEaAayUKuTh6lAU/Vao
         y8MQ==
X-Gm-Message-State: AJIora+m0oUD9tp89am2rCM8zGew1kFbIIxVED2lD4VaIuZXNtWN32Ah
        i9hTv7pDDPzPQl+uX1RYY1vYAscGdRG5+Q==
X-Google-Smtp-Source: AGRyM1tL66EN5C/gp7DYi0hK9Gi61ldg+WSctXPPMo87UH3gOC8dXtGeH0o81Gbqis2S2fEY38zGGw==
X-Received: by 2002:a05:6000:1862:b0:216:3c40:6708 with SMTP id d2-20020a056000186200b002163c406708mr12123866wri.101.1656335315136;
        Mon, 27 Jun 2022 06:08:35 -0700 (PDT)
Received: from [192.168.0.250] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003971fc23185sm18626721wmq.20.2022.06.27.06.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:08:34 -0700 (PDT)
Message-ID: <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
Date:   Mon, 27 Jun 2022 15:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 27/06/2022 14:49, Michael Walle wrote:
> Hi,
> 
> I tired to iterate over all child nodes, regardless if they are 
> available
> or not. Now there is that handy fwnode_for_each_child_node() (and the
> fwnode_for_each_available_child_node()). The only thing is the OF 
> backend
> already skips disabled nodes [1], making fwnode_for_each_child_node() 
> and
> fwnode_for_each_available_child_node() behave the same with the OF 
> backend.
> 
> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix 
> that
> one. fwnode_for_each_child_node() and also fwnode_get_next_child_node() 
> are
> used by a handful of drivers. I've looked at some, but couldn't decide
> whether they really want to iterate over all child nodes or just the 
> enabled
> ones.

If I get it correctly, this was introduced  by 8a0662d9ed29 ("Driver
core: Unified interface for firmware node properties")
.

The question to Rafael - what was your intention when you added
device_get_next_child_node() looking only for available nodes?

My understanding is that this implementation should be consistent with
OF implementation, so fwnode_get_next_child_node=get any child.

However maybe ACPI treats it somehow differently?

Best regards,
Krzysztof
