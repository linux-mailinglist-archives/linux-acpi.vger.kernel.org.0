Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DFD2E2269
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Dec 2020 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLWWYu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 17:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWWYu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Dec 2020 17:24:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3FFC061794;
        Wed, 23 Dec 2020 14:24:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y23so188201wmi.1;
        Wed, 23 Dec 2020 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sCveDTAqg2krVZsKdg4haeDPpG4bCY8xxdMqSu4hHV0=;
        b=SPXs4ihQVtEbUsfzq1Hqda/oybQY2OvK1F30H3bW7uhyexY2dCo/M5s+KEqAlT8DTW
         NnUQ9UXiunXMMi0M/eSQKDqEZEfiNBr1AbSwHWYkLlz8pczbU+5Tln/W4HkHt6nXHVOk
         JvqZjlFk2wtYTvfmArSUIGFqo7SjZZlF1AgW91N23aj+UeKxUYhqAFbtrP8F9jyQZIek
         6kmuBfpl9J1B8095HEd4jGDE13OPDjOv3FNwztMx/fZUtdr96EczLM8hw7yZE+s8g2/G
         gwubldFpGI2S/aB9kwz8INnewVxAaiIygY7VJk9yOHY3aXU0sz1TtfKcheVq1dFtJaeP
         UPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sCveDTAqg2krVZsKdg4haeDPpG4bCY8xxdMqSu4hHV0=;
        b=VijRwiKzVIdnv8U4pauT6KuJYwFpyLDQOZsLjbGH3btc6ecj8AO64wfrPUQsEst9bF
         IwQ0sngdS1S8f7gSBmnOaup+bwSkO2weR8vX4U9IPaybXCMb4s4i6vmfDQFCMwjYCpRP
         Y5mzVWWf2Qwss9zEmocp6XAJEWbG4zYQ2TgNLH4+JuIoIFAjK48vktaxtXaoAJjNtm53
         yRvtFUHxAuFEQTez7F3c/hm+H092JtF3vhfwrhAU3g00/L1OgkdQ6g9dEd4zSG9pvIBb
         /H4jhkTjklN9oFB+fa5eKel0Ww9v4t+I+vqfrcOvil2dzjsub8B322d+kZ4p9TWKqS02
         7WpQ==
X-Gm-Message-State: AOAM532akjqOdBtEkS5OVBFNGKIP64LodJRRRPV0AS9bgtw9pbLBAR13
        RT/knrVtaK2y2ufAOC36ZbQ=
X-Google-Smtp-Source: ABdhPJz0hRrU9c/emexZj08cKNt3M2dVcETfPsmlBzq1aTSLke8hhuX43Ushz9NCnDUdmU5bPhVtIw==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr1548175wmf.59.1608762248064;
        Wed, 23 Dec 2020 14:24:08 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id c20sm1217971wmb.38.2020.12.23.14.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 14:24:07 -0800 (PST)
Subject: Re: [PATCH v2 05/12] software_node: unregister software_nodes in
 reverse order
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-6-djrscally@gmail.com>
 <20201221092116.GG26370@paasikivi.fi.intel.com>
 <20201221112644.GJ4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <9fbd8234-6cc3-ac3c-7273-854e965a4794@gmail.com>
Date:   Wed, 23 Dec 2020 22:24:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221112644.GJ4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/12/2020 11:26, Andy Shevchenko wrote:
> On Mon, Dec 21, 2020 at 11:21:16AM +0200, Sakari Ailus wrote:
>> On Thu, Dec 17, 2020 at 11:43:30PM +0000, Daniel Scally wrote:
>>> To maintain consistency with software_node_unregister_nodes(), reverse
>>> the order in which the software_node_unregister_node_group() function
>>> unregisters nodes.
> 
> ...
> 
>>>  void software_node_unregister_node_group(const struct software_node **node_group)
>>>  {
>>> -	unsigned int i;
>>> +	unsigned int i = 0;
>>>  
>>>  	if (!node_group)
>>>  		return;
>>>  
>>> -	for (i = 0; node_group[i]; i++)
>>> +	while (node_group[i]->name)
>>
>> Why is this change made? node_group is a NULL-terminated array, and the
>> above accesses the name pointer on each entry before checking the entry is
>> non-NULL. Or do I miss something here?
> 
> I believe it's a copy'n'paste typo.

Careless copy and paste yeah, my bad. I was doing it for consistency but
really should've just changed the ordering; I'll just drop that part.
