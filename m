Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF9724961
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbjFFQl3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjFFQlR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 12:41:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0511707
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 09:41:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30adc51b65cso5771077f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069663; x=1688661663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TD947NU0QJRcCJUIMGxDxhgGKO+sOlhN3HK0jioLYsA=;
        b=H/iGTgZ2WAYL7ja65GQmoXViBhWcatmCSkySTZYUPATw2qnrQJuclZkX6vbu52z9h4
         PkfjPGkXwkDnAWgx/sG84sCRcZqKKiiiz6Sxpx4lVIP30NX/qblF0unTHTV2nuYz6zQo
         tXy5V/AXE28adQ16UcFTrgIayHxxIM1bRM4sezBY5HTqYbJKnJzsFkN3FUMJvO9k5OGZ
         F6vVmGASUVghKFp6i7JCXn0qwngaLxK49HMg8rkARYGHToF6wwo1qveYDijkQg8M/4nr
         g00H+s2GxFdzEfARw+3MbX5RTq8ah4+6pFopEmm+kTEONYsAqHzQrZcqoX7TtYJFwZrm
         k63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069663; x=1688661663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD947NU0QJRcCJUIMGxDxhgGKO+sOlhN3HK0jioLYsA=;
        b=WpEgkpCTswqk6PGR2Ifv510BnZ/MHiK9exuyddawOXIUHYhJfuHY+hgsmD851kb5To
         9blTkOgim+FIwpWUsV10zX7kzhmXrI2RvK7F7pENSZUDdpwzUi9lbkWpc/3ArY99iq1H
         DQ9Q4G+dBapWzcVfpuXMzkQpWfS0fx6kL60yxmk+2BcuCQk1YjVjgK1B+2sGOb/Cw5JY
         c6ANDBqxq2nux+0QHP9B9Pw/Ux6l840tdLsyTWlMigIViDwLLg/96asasvIlphmwOcX+
         GZR6kTZHB7aqlTWJaQekwHQ8aGkJASHp6mgdXBxDYtRathZmwbJRckkuZfUJiXg89qT3
         14rg==
X-Gm-Message-State: AC+VfDy7vWU19VFWDy3rkN3hSyhXjyBAHOLBwfZMItNenavkYZjFdA5N
        7X5V/Ex3wLv8GP5rwN6KmFSakg==
X-Google-Smtp-Source: ACHHUZ6bjWYBTMpRrAPby7ypNw9F2Y8h5TzOLAEgckqMuT2DBDthq2cl9Cee/Kq+S2Myj02uiWedNQ==
X-Received: by 2002:adf:eb88:0:b0:309:38f4:fb52 with SMTP id t8-20020adfeb88000000b0030938f4fb52mr2879010wrn.9.1686069662766;
        Tue, 06 Jun 2023 09:41:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id r1-20020a5d52c1000000b0030ae69920c9sm13043293wrv.53.2023.06.06.09.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:41:02 -0700 (PDT)
Message-ID: <54edd5a0-cb1c-0864-5617-66f29cb5aafb@linaro.org>
Date:   Tue, 6 Jun 2023 18:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/7] ACPI: thermal: Move symbol definitions to one
 place
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <21917932.EfDdHjke4D@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <21917932.EfDdHjke4D@kreacher>
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

On 04/06/2023 14:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move all of the symbol definitions to the initial part of the code so
> they all can be found in one place.
> 
> While at it, consolidate white space used in there.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

