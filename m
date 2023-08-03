Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FAF76E997
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHCNJS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjHCNIw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 09:08:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9354EEA
        for <linux-acpi@vger.kernel.org>; Thu,  3 Aug 2023 06:07:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so9702445e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Aug 2023 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691067975; x=1691672775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=HE5cLu5IQzavix5nfCpMgiTvxlkyxUkJMK2jRocYbQCy2PnqnMsWC3NSRidxgGEo0Z
         KPr2l2DORIsicGEc50tzC0oyaABYDx17j3uWFBv4+3IaqCPlTQCY1XqHWr+mtjS/dwiI
         87HGWsIPQhQam5qqhPQfU6FWMSFq4VNCiE5Kr8gRN/TtAqeUzIIoWsMDgVhQZHu5l/a1
         j6env9DlHacs3vnUMw5kEOFYk0C/GYCCvWszU+N1FwTPt0+nyTFfwbyekbT6oAV76hXt
         7KNQVELTpfmy7jUH5CT6hxN7m/OaR0u714bmUl75x9Xr7HRETy3n85PKhjPQBpr3f8r+
         Hoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067975; x=1691672775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=CLsbBV09GwWAEXN31n7V6fMzVc4iA0BYuYkEwLMg2XUNu37ZY5CxrurNnWO8KhG8kT
         +meAG3SeKU3rR0PkOOsh6N5skKU1qFDOLnrJfAvfT5X3DzBYBlv3zSouOlbvlQMQVf1Y
         RRNRuDMnWs245U0JqwOFsKLR97Qpf40aQ7Q5n8m+N/ZFMDP6w4RWa2ML4QxoSTsU3zjq
         pUbX42H4u/WQkY/Z+YFU/tLho5MbKUWu/pHcoW2hRBNtZfz1pPkae4UFHSDcBS42yZ6G
         KhiJnyUAZCcpumxgiOANvnEgc497nWbB0xo4j54z/fDDVjjsgtobRQ3sxxuCHvDlH4gt
         bOIw==
X-Gm-Message-State: ABy/qLZCkmkNdAhY9Rr/i9LxW0ErqQX6WdQqlEX6cuh92iB4XAYY+o8v
        IpI/fCjO5THNnMR567nXd/y+1w==
X-Google-Smtp-Source: APBJJlG80gudR9LU0/3zq7coND676L3IK21c5s2iw2yBqdiqauL+wz/tpF8p/JXxwsJxejMflM9+qg==
X-Received: by 2002:a05:600c:2048:b0:3fe:2bb1:11ba with SMTP id p8-20020a05600c204800b003fe2bb111bamr6423174wmg.27.1691067974611;
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w11-20020a05600c014b00b003fc16ee2864sm4221824wmm.48.2023.08.03.06.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Message-ID: <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
Date:   Thu, 3 Aug 2023 15:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher>
 <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
 <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
 <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02/08/2023 18:48, Rafael J. Wysocki wrote:

[ ... ]

>> Let me check if I can do something on top of your series to move it in
>> the ACPI driver.
> 
> It doesn't need to be on top of my series, so if you have an idea,
> please just let me know what it is.
> 
> It can't be entirely in the ACPI driver AFAICS, though, because
> trips[i] need to be modified on updates and they belong to the core.
> Hence, the driver needs some help from the core to get to them.  It
> can be something like "this is my trip tag and please give me the
> address of the trip matching it" or similar, but it is needed, because
> the driver has to assume that the trip indices used by it initially
> may change.

May be I'm missing something but driver_ref does not seems to be used 
except when assigning it, no?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

