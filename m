Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE62E6C56
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgL1Wzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 17:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgL1Vg5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 16:36:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF086C0613D6;
        Mon, 28 Dec 2020 13:36:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so559219wmz.0;
        Mon, 28 Dec 2020 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YHAv31qp/16efOwdB+fQqGsAagQD2Y+LO34KSznV4Rg=;
        b=XVJEE4443tNtSX9ZZyPo2QVDypcgctKGPngBDD4Ho64pNOIgYscOlBV60MhMSxWhD4
         JJA8xL77ZIMl+Y8O5INdC7qct9mWqjqDtCWqJx73JFQxX4y+2HYzxndiLeNKCzh07QOa
         TjtoJ7oRuNBeuw/qF1xrLdF73sDtR+LgFIXYE8YbFOIiEP04gtTHGsCasQdfNiKOqQE6
         mGZDZLHEy+HdLtCumX2CxRsVPUtNovu2uh7iNKQf9SCs130zEw+AqQqPmUhxn5tEkauZ
         m4dhxQaavJKjB9F5zaCtX7syg2dj5jPdDlwQ1/cKRxrwLIYlYI3W15WVCq12guK00pIm
         Q5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHAv31qp/16efOwdB+fQqGsAagQD2Y+LO34KSznV4Rg=;
        b=W5HlmNwCr/3Y+PBUI3tnWE+vZNluen4uhfixQWt2V6I9BnAJphhNBfzBYIhWl/DO9y
         0d2hXGe+QhdU3G+ZhtIBLRBig34GGRtB9HJGqtBVrMtIYZxSaIPZXp6/E8G6ZDLPfr5l
         m64vbYOWVGGlOyV54irbkPp7TVQQ4JcFDe3zjoeIMMZ6U6oY12VZxy+vTSOBJHH3eVIi
         a31I5p1NmWNbHdk6La29utODi9Kfkhh06dugOH3k0bjReD69uPCRVjpl9s1tIeitlxGb
         oOXTFwJUnQHqVEM/PMuvSJZgbISVn38KZqHQLNIZ39hs1gCixzS/cMcgEJeDIDDwvWk2
         vo6g==
X-Gm-Message-State: AOAM533qW6ZO/NH6Hj39aM1xc4wZk5imm2lSLXuHf0AJMCe9fzbRimNn
        7cprnkB0ZhkYhOo11jdbFEs=
X-Google-Smtp-Source: ABdhPJxR6XebnXJVSGq90TAT8Dh3I/nUgx46Nvb7RNCV/f98FfsdMmRNwciduPOvaFZBwjoYusQrug==
X-Received: by 2002:a7b:c198:: with SMTP id y24mr670964wmi.151.1609191375582;
        Mon, 28 Dec 2020 13:36:15 -0800 (PST)
Received: from [192.168.1.158] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id a14sm56165919wrn.3.2020.12.28.13.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 13:36:14 -0800 (PST)
Subject: Re: [PATCH v3 06/14] include: fwnode.h: Define format macros for
 ports and endpoints
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-7-djrscally@gmail.com>
 <20201228163024.GW26370@paasikivi.fi.intel.com>
 <20201228171150.GA26370@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <d5c489fb-5b6e-cc9f-2294-7bc7e3640362@gmail.com>
Date:   Mon, 28 Dec 2020 21:36:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228171150.GA26370@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari

On 28/12/2020 17:11, Sakari Ailus wrote:
> On Mon, Dec 28, 2020 at 06:30:24PM +0200, Sakari Ailus wrote:
>> Hi Daniel, Andy,
>>
>> On Thu, Dec 24, 2020 at 01:08:59AM +0000, Daniel Scally wrote:
>>> OF, ACPI and software_nodes all implement graphs including nodes for ports
>>> and endpoints. These are all intended to be named with a common schema,
>>> as "port@n" and "endpoint@n" where n is an unsigned int representing the
>>> index of the node. To ensure commonality across the subsystems, provide a
>>> set of macros to define the format.
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>>> ---
>>> Changes in v3
>>> 	- Patch introduced
>>>
>>>  include/linux/fwnode.h | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
>>> index 9506f8ec0974..52889efceb7d 100644
>>> --- a/include/linux/fwnode.h
>>> +++ b/include/linux/fwnode.h
>>> @@ -32,6 +32,19 @@ struct fwnode_endpoint {
>>>  	const struct fwnode_handle *local_fwnode;
>>>  };
>>>  
>>> +/*
>>> + * ports and endpoints defined in OF, ACPI and as software_nodes should all
>>> + * follow a common naming scheme; use these macros to ensure commonality across
>>> + * the subsystems.
>>> + *
>>> + * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoint@"
>>> + * sections of the naming scheme.
>>> + */
>>> +#define FWNODE_GRAPH_PORT_NAME_FORMAT		"port@%u"
>>> +#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN	5
>>> +#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT	"endpoint@%u"
>>> +#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN	9
>>> +
>>>  #define NR_FWNODE_REFERENCE_ARGS	8
>>
>> I'd keep such definitions local to the swnode implementation as neither
>> ACPI nor DT have an apparent need for them. They do use the naming, but
>> don't appear to format such strings.
> 
> Ah, I noticed these are used by the later patches. Please ignore that
> comment then.
> 
> But these are still definitions, so I'd use SWNODE prefix rather than
> FWNODE. That should also be reflected in the comment.

Fine by me; I shall change that.

> ACPI does not have a format port concept so the definitions that are being
> used can be said to be specific to Linux.
> 
